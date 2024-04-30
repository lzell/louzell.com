## Rails 7 Notes  
  
### Custom validations  
  
    validate do  
        errors.add(:some_field, 'Error message') unless my_condition  
    end  
  
Or  
  
    validate :something_custom  
  
    private  
    def something_custom  
      if my_condition  
        errors.add(:some_field, "Error message")  
      end  
    end  
  
  
### Rails Turbo Frame gotchas  
  
1. In the action that I'm serving the partial page contents from, remember to skip layout rendering:  
  
    def my_action  
        # Define my_action.html.erb and populate it with partial contents  
        render :layout => false  
    end  
  
2. In the UI element that kicks off the fetch of partial content, specify the turbo frame to update:  
  
    <%= turbo_frame_tag "frame-to-update" do %>  
        Placeholder  
    <% end %>  
  
    <%= link_to 'Update partial contents', my_action_path, data: {turbo_method: :get, turbo_frame: "frame-to-update" } %>  
  
Or, without rails form helpers:  
  
    <turbo-frame id="frame-to-update">  
        Placeholder  
    </turbo-frame>  
  
    <a data-turbo-method="get" data-turbo-frame="frame-to-update" href="<%= my_action_path %>">Update partial contents</a>  
  
  
### See all rake tasks  
  
    rails --tasks  
  
### Update rails  
- Install the rails gem for the latest release here: https://rubyonrails.org/category/releases  
- Modify my app's `Gemfile` to use the latest version  
- Run `rails app:update`  
- Follow the guidance in `config/initializers/new_framework_default*`  
  
### Get state of model before last save  
  
Use the `after_save` hook. Say the model has an attribute called `name`,  
inside the hook use `name_before_last_save` to get the previous value.  
  
### Tail puma log in production (AL2023)  
  
    journalctl -fu puma  
  
### Do not db:rollback in production  
  
I have accidentally rolled back farther than intended, and then I have a production data fill on my hands.  
Instead, make sure I use `STEP=1`. Or better yet be explicit with:  
  
    rake db:migrate:down VERSION=20240303...  
  
Then, to go the other direction:  
  
    rake db:migrate:up VERSION=20240303...  
  
Or:  
  
    rake db:migrate:redo VERSION=20240303...  
  
  
### How to see the status of production migrations  
  
    RAILS_ENV=production ./bin/rails db:migrate:status  
  
### Where is migration status stored in mysql?  
  
The `schema_migrations` table:  
  
    MariaDB [aiproxy_production]> select * from schema_migrations;  
  
  
### How to run a migration in code  
  
Careful with this. It will not modify the `schema_migrations` table:  
  
    ./bin/rails c --environment=production  
    require "./db/migrate/20240303150054_create_dynamo_tokens_table.rb"  
    CreateDynamoTokensTable.new.down  
  
  
### Where is the validation API defined?  
  
    activemodel-7.0.7/lib/active_model/validations/validates.rb line 106  
  
### How to view active record errors  
  
    my_model.errors.full_messages  
  
### How to force quit puma in dev  
  
Occassionally I find myself needing to do this:  
  
    rm aiproxy/dashboard/tmp/pids/server.pid  
    pkill puma  
  
If that doesn't work, try:  
  
    lsof -i :3000  
    :: find the ruby process  
    kill -9 <id>  
  
Or  
      
    ps aux | grep puma | grep -v grep | awk '{print $2}' | xargs kill  
  
  
  
### How to clean up default rails routes  
  
Follow these instructions to get rid of all the `/rails/conductor/action_mailbox` routes:  
https://www.youtube.com/watch?v=IDsYWrsmO9g  
  
### How to clear cache  
  
Run `rails tmp:clear` and remove everything in `public/assets`  
  
  
### (hack to include routes in activerecord model)  
  
    class Router  
      include Rails.application.routes.url_helpers  
  
      def self.default_url_options  
        ActionMailer::Base.default_url_options  
      end  
    end  
  
    Then use `Router.new.my_model_url(@my_model)`  
  
Source: https://stackoverflow.com/a/54542949/143447  
  
### (rails destroy confirmations)  
  
Button:  
  
    <%= button_to "Delete", @my_model, form: { data: { turbo_confirm: "Are you sure?" } }, method: :delete %>  
  
Link:  
  
    <%= link_to "Delete", my_path, data: {turbo_method: :delete, turbo_confirm: 'Are you sure?'} %>  
  
### (render text)  
`render :text` is no longer a thing. Use `render plain: "hi"` instead  
  
### (testing locally on mobile)   
Start the server with `./bin/rails s -b 0.0.0.0`  
Use the following to get my 192.168 IP:  
  
    ifconfig | grep 'inet '  
  
Browse to 192.168.X.Y:3000  
  
### (turbo, link to helpers, delete method, post method, deprecated)  
This is no longer possible in Rails 7:  
  
    link_to "Remove something", my_path, method: :delete  
  
Instead, turbo must be used:  
  
    link_to "Remove something", my_path, data: { turbo_method: :delete }  
  
Or, use a form instead:  
  
    <%= button_to "Destroy", @my_model, method: :delete %>  
  
Or, write a `data-turbo-method` attribute on the html with the desired verb (post in this case):  
  
    <a data-turbo-method="post" href="/users?color=red">enter as red</a>  
  
### (debugging action cable javascript)  
  
    cd <my-proj>  
    vim "$(bundle show actioncable)/app/assets/javascripts/actioncable.esm.js"  
    :: restart rails server after making modifications!  
  
### (rails 7, test redis connection in production)  
  
    ./bin/rails c --environment=production  
    irb> r = Redis.new  
    irb> r.ping  
    => "PONG"  
  
### (rails 7, generator, add index, add column)  
Add an indexed column to the db with one generator:  
  
    rails g migration add_index_to_rooms uuid:string:index  
  
### (rails 7, debug web socket, firefox)  
View the ActionCable activity at Dev tools > Network > Tap on cable > WS tab > Response subtab  
  
### (rails 7, debug importmap)  
View importmap with:  
  
    ./bin/importmap json  
  
Keep playing with syntax in config/importmap.rb until `importmap json` shows the importmaps I expect.  
  
Pin an external dependency with:  
  
    ./bin/importmap pin <dep-name>  
  
  
### (rails 7, add jquery)  
Add to importmap:  
  
    ./bin/importmap pin jquery  
  
Modify application.js to include:  
  
    import jquery from "jquery"  
    window.$ = jquery  
    window.jQuery = jquery  
  
  
### (rails 7, styles, scaffolding, dhh demo)  
https://www.youtube.com/watch?v=mpWFrUwAN88  
  
Highlights:  
  
- Add this stylesheet to `application.html.erb`  
  
    \<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css"\>  
  
- Get a rich editor out of the box with `rails action_text:install`  
  - Works with drag and drop  
  
- Adding js deps is slick `./bin/importmap pin <package-name>`, at 10:50  
  - Can rely on CDN or download the dep with `--download`  
  
- Generator with foreign key, references, at 15:00  
  - rails g resource comment post:references content:text  
  
- Example of `form_with` for child resource at 17:25  
  - `form_with model: [post, Comment.new] do |form|`  
  
- Email previews from mailer (text and html) at 22:30  
  
- Hotwire intro starts at 25:00  
  - In a model, using `broadcasts_to :post` will automatically broadcast creates, updates, and destroys  
  
- Change from one db to another with `rails db:system:change --to=postgresql`  
  
### (rails 7, actioncable, websocket, per user)  
Set up the cable so that it streams to the current user:  
  
    // app/channels/application_cable/connection.rb  
    // Source: https://guides.rubyonrails.org/action_cable_overview.html  
    module ApplicationCable  
      class Connection < ActionCable::Connection::Base  
        include ActionController::Cookies  
        identified_by :current_user  
  
        def connect  
          self.current_user = find_verified_user  
        end  
  
        def disconnect  
          puts "#{self.class} Disconnected"  
        end  
  
        private  
          def find_verified_user  
            if verified_user = User.find_by_id(cookies.encrypted['_YOUR_APP_NAME_session']['user_id'])  
              verified_user  
            else  
              reject_unauthorized_connection  
            end  
          end  
      end  
    end  
  
  
    // my_channel.rb  
    class MyChannel < ApplicationCable::Channel  
        def subscribed  
          stream_for current_user  
        end  
        ...  
     end  
  
Send notifications to specific user:  
  
    // https://stackoverflow.com/a/43943322/143447  
    MyChannel.broadcast_to(user, { notification: 'Test message' })  
  
Get all cables for a specific user:  
  
    ActionCable.server.remote_connections.where(current_user: current_user)  
  
  
Question to experiment with:  
Is the web socket torn down when navigating between pages?  
  
URL helpers are not available by default in ActionCable.  
Use this:  
  
    class MyChannel < ApplicationCable::Channel  
      include Rails.application.routes.url_helpers  
  
  
### (rails, actioncable)  
Generator to create actions in a channel:  
  
    rails g channel <channel-name> <action-name>  
  
This modifies the import map at config/importmap.rb to add the actioncable dependency as an esm module,  
and modifies app/javascript/application to import everything under the app/javascript/channels dir.  
  
I can get a reference to a connected cable by  modifying `<channel-name>_channel.js` to contain:  
  
    window.myChannel = consumer.subscriptions.create("MyChannel", { ...  
  
Restart the rails server, refresh firefox, open dev tools (cmd+opt+i), tap network, tap WS.  
There will be a connected web socket.  
Open the console, I can send `<action-name>` with:  
  
    myChannel.<action-name>()  
  
For example, following the DHH tutorial for action cable, if I use the generator `rails g channel room speak`, I can:  
  
    myChannel.speak()  
  
  
Add an argument by modifying the `speak` definition in `room_channel.js`. E.g.  
  
    // room_channel.js  
    speak: function(message) {  
      return this.perform('speak', message);  
    }  
  
then on ruby side:  
  
    // room_channel.rb  
    def subscribed  
      stream_from "room_channel"  
    end  
  
    def speak(cable_data)  
      puts "Room channel received #{cable_data['message']}; echoing..."  
      ActionCable.server.broadcast 'room_channel', {message: cable_data['message']}  
    end  
  
and back on client:  
  
    // room_channel.js  
    received(data) {  
      alert(data['message'])  
    },  
  
finally, punching `myChannel.speak({message: "hello world"})` into the dev tools console should pop an alert message.  
  
There is also a bit of this vid (16:40) where he shows that UI can be updated from an async job using ActionCable. (background job, async job, actioncable, action cable)  
  
Source for Rails 5 ActionCable demo (DHH): https://www.youtube.com/watch?v=n0WUjGkDFS0  
My stackoverflow question: https://stackoverflow.com/questions/76964623/what-is-the-equivalent-of-app-cable-for-rails-7  
See `~/dev/actioncable_experiment`  
  
### (rails 7, hotwire)  
Clip from hotwire demo:  
"Turbo streams deliver page changes over web sockets or in response to form  
submissions using just html and a set of crud-like action tags. The tags let  
you append, prepend, or replace and remove any target dom element from the  
existing page. They're strictly limited to DOM changes though, no direct  
javascript invocations. If you need more than DOM change, connect a stimulus  
controller." minute 5 here: https://www.youtube.com/watch?v=eKY-QES1XQQ  
  
  
### (rails, stimulus)  
> You can think of it this way: just like the class attribute is a bridge connecting HTML to CSS, Stimulus’s data-controller attribute is a bridge connecting HTML to JavaScript.  
https://stimulus.hotwired.dev/handbook/introduction  
  
### (rails credentials, gotcha, caution)  
Do not try to set an environment variable for environment! This:  
  
    RAILS_ENV=development EDITOR='vim' bin/rails credentials:edit  
  
is not the same as this:  
  
    EDITOR='vim' bin/rails credentials:edit --environment=development  
  
### (rails credentials, store credentials)  
Edit credentials with:  
  
    rails credentials:edit --environment=development  
  
Environment credentials are stored at:  
  
    config/credentials/<environment>.yml.enc  
  
Environment credentials key is stored at (do not check this in!):  
  
    config/credentials/<environment>.key  
  
If I edit development credentials:  
  
    ./bin/rails credentials:edit --environment=development  
  
    stripe:  
      publishable_key: <snip>  
      secret_key: <snip>  
  
I can reference the secret at runtime with:  
  
    Rails.application.credentials.stripe.secret_key  
  
The master key is stored at (do not check this in!):  
  
    config/master.key  
  
Change master key: https://stackoverflow.com/a/59993704/143447  
  
In production, running this:  
  
    EDITOR="/usr/bin/vim" bin/rails credentials:edit  
  
changes the file contents at config/credentials.yml.enc  
  
I prefer not to use `credentials:edit` without an environment,  
instead relying upon `config/credentials/development.*` and `config credentials/production.*`  
  
### (rails credentials, debugging)  
If in production I get the error:   
  
    ArgumentError: Missing `secret_key_base` for 'production' environment, set this string with `bin/rails credentials:edit`  
  
Either create an env variable called `SECRET_KEY_BASE` or add `secret_key_base` to production.yml.enc with:  
  
    ./bin/rails credentials:edit --environment=production  
      
  
### (rails credentials in console)  
Rails.application.credentials.config  
  
### (rails credentials, how does this work, rake secret)  
I don't understand how this works.  
Why does `./bin/rake secret` dump a different secret to the console each time?  
Oh, it is not dumping `secret_key_base`, it is just spitting out a random string for use as a secret.  
See the task description with `rake -T secret`  
  
Read `./bin/rails credentials:help`  
In development and testing, `Rails.application.secrets.secret_key_base` is derived from the app name.  
In production, I add `secret_key_base` to production.yml.enc  
  
  
### (rails, error, localhost, add to hosts, https)  
To serve at https://localhost without host blocking,  
add config.hosts.clear to config/environments/development.rb  
