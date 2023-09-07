### (turbo, link to helpers, delete method, deprecated)  
This is no longer possible in Rails 7:  
  
    link_to "Remove something", my_path, method: :delete  
  
Instead, turbo must be used:  
  
    link_to "Remove something", my_path, data: { turbo_method: :delete }  
  
Or, use a form instead.  
  
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
  
The master key is stored at (do not check this in!):  
  
    config/master.key  
  
In production, running this:  
  
    EDITOR="/usr/bin/vim" bin/rails credentials:edit  
  
chnages the file contents at config/credentials.yml.enc  
  
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
