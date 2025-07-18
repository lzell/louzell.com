## Amazon SES setup  
  
### Sandbox note  
  
New accounts are in the SES sandbox.  
Go to [SES account dashboard](https://us-east-2.console.aws.amazon.com/ses/home?region=us-east-2#/account) to see if I'm still in the sandbox.  
  
### First time setup  
  
#### AWS console setup  
  
Be careful to start in the correct region (Ohio for aiproxy.pro):  
https://us-east-2.console.aws.amazon.com/ses/home?region=us-east-2#/account  
  
In the left sidebar go to `Configuration > Configuration sets`, then:  
  
- Create set  
  - Configuration set name: aiproxy  
  - Sending IP pool: default  
  - Reputation options: Enable reputation metrics  
  - Suppression settings: Account level  
  
In the left sidebar go to `Configuration > Identities`, then:  
  
- Create identity  
  - Identity type: Domain  
    - Domain: aiproxy.pro  
    - Assign a default configuration set: aiproxy  
    - Leave unchecked: Use a custom MAIL FROM domain  
  - Under the "Verify your domain" section, open the "Advanced DKIM settings" chevron  
    - Idenity type: Easy DKIM  
        - SKIM signing key length: `RSA_2048_BIT`  
        - Uncheck "Publish DNS records to Route53" (I'll punch them into cloudflare)  
    - SKIM signatuers: Enabled  
  - Tap 'Create'  
  - Copy DKIM DNS records into cloudflare  
  
Update: See the end of this doc for adding dmarc as well  
  
  
In the left sidebar, go to `SMTP settings > Create SMTP credentials`, then:  
  
 - User name: ses-smtp-user.aiproxy.20240209-162011  
 - Tap create  
 - On the next screen, copy the SMTP user name and SMTP password  
  
  
#### On my AL2023 box  
  
Ensure sendmail is installed:  
  
    yum install sendmail sendmail-cf mailx -y  
  
Edit `/etc/mail/authinfo` to contain:  
  
    AuthInfo:email-smtp.us-east-2.amazonaws.com "U:root" "I:<smpt-user>" "P:<smtp-pass>" "M:PLAIN"  
  
Edit `/etc/mail/access` to contain:  
  
    Connect:email-smtp.us-east-2.amazonaws.com RELAY  
  
Edit `/etc/mail/sendmail.mc` to comment out (otherwise cron jobs run as root will not email me).  
There is no practical security threat for commenting this out.  
Sendmail listens on port 25 and I don't have that exposed through security groups:  
  
    dnl # EXPOSED_USER(`root')dnl  
  
Edit `/etc/mail/sendmail.mc` to contain (change `aiproxy.pro`):  
  
    define(`SMART_HOST', `email-smtp.us-east-2.amazonaws.com')dnl  
    define(`RELAY_MAILER_ARGS', `TCP $h 587')dnl  
    define(`confAUTH_MECHANISMS', `LOGIN PLAIN')dnl  
    FEATURE(`authinfo', `hash -o /etc/mail/authinfo.db')dnl  
    MASQUERADE_AS(`aiproxy.pro')dnl  
    FEATURE(masquerade_envelope)dnl  
    FEATURE(masquerade_entire_domain)dnl  
    MAILER(smtp)dnl  
    MAILER(procmail)dnl  
  
Ensure sendmail is running:  
  
    systemctl start sendmail  
    systemctl status sendmail  
  
Send a test mail  
  
    echo "body" | mailx -s "subject" -S from="aiproxy support <support@aiproxy.pro>" my-verified-email@domain.tld  
  
  
## How to debug sendmail  
  
If emails aren't arriving, check the sendmail logs with:  
  
    systemctl status sendmail --full --no-pager | view -  
    :set nowrap  
  
Or tail the logs with:  
  
    journalctl -fu sendmail  
  
If the log is:  
  
    reply=554 Message rejected: Email address is not verified. The following identities failed the check in region US-EAST-2  
  
it's because the SES account is still in sandbox and I'm trying to send an email **to** an unverified email.  
Using domain-based verification is not enough to send sandbox emails, even if they are going *to that domain*.  
This is a bug in AWS; their [docs state](https://docs.aws.amazon.com/ses/latest/dg/request-production-access.html) that this should be possible:  
  
    | You can only send mail to verified email addresses and domains  
  
To fix, go to 'Left sidebar > Get set up > Verify email address > Create identity' and submit an email address.  
Tap through the email verification link and then try sending a test mail again.  
  
    echo "body" | mailx -s "subject" -S from="aiproxy support <support@aiproxy.pro>" my-verified-email@domain.tld  
  
  
### Other ways to test email sending:  
  
#### Send a test email using sendmail:  
  
    echo "Subject: test" | /usr/sbin/sendmail -vf lou@aiproxy.pro my-verified-email@domain.tld  
                                                  ^from           ^to  
#### Send a test email using aws-cli:   
  
    aws ses send-email --from support@aiproxy.pro --destination "ToAddresses=my-verified-email@domain.tld" --message "Subject={Data=Test Email,Charset=utf8},Body={Text={Data=This is a test email sent from Amazon SES.,Charset=utf8}}"  
  
#### Send a test email using SMTP interface:  
  
Base64 the SMTP user name and SMTP pass:  
  
    $ irb  
    > def base64_encode(str)  
    >   [str].pack('m').gsub(/\s+/, '')  
    > end  
  
    base64_encode(<smtp_user>)  
    base64_encode(<smtp_pass>)  
  
Use the results in the following template:  
  
    echo "EHLO aiproxy.pro  
    AUTH LOGIN  
    my_base64_encoded_smtp_user  
    my_base64_encoded_smtp_pass  
    MAIL FROM: support@aiproxy.pro  
    RCPT TO: my-verified-email@domain.tld  
    DATA  
    X-SES-CONFIGURATION-SET: aiproxy  
    From: "aiproxy support" <support@aiproxy.pro>  
    To: my-verified-email@domain.tld  
    Subject: Hello  
    World  
    .  
    QUIT  
    " > /etc/mail/email.txt  
  
Send the email:  
  
    openssl s_client -crlf -quiet -starttls smtp -connect email-smtp.us-east-2.amazonaws.com:587 < /etc/mail/email.txt  
  
## DMARC setup (this is for SES and fastmail)  
  
I added the following records for aiproxy.pro  
  
    type: TXT  
    Name: _dmarc  
    Content: "v=DMARC1; p=reject; rua=mailto:<snip>@dmarc-reports.cloudflare.net;"  
  
    type: TXT  
    Name: aiproxy.pro  
    Content: "v=spf1 include:spf.messagingengine.com include:amazonses.com -all"  
  
