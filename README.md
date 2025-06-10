📢 The Gossip Project with THE HACKING PROJECT

Welcome to The Gossip Project — a lightweight Ruby web app built with Sinatra that lets you create, display, edit, and save gossips (potins) in a CSV file. Simple, fun, and handcrafted with ❤️.

-----

🚀 Features

    List all published gossips

    View gossip details

    Create new gossips through a form

    Edit existing gossips with a dedicated edit page

    Persist gossips in a CSV file (./db/gossip.csv)

-----

💻 Technologies Used

    Ruby 2.7+

    Sinatra — lightweight web framework

    CSV — flat file storage for gossips

    ERB — embedded Ruby templates for views

-----

📂 Project Structure

/db
  gossip.csv              # CSV database storing gossips

/views
  index.erb               # Lists all gossips
  show.erb                # Shows a single gossip detail
  new_gossip.erb          # Gossip creation form
  edit_gossip.erb         # Gossip edit form pre-filled

app.rb                   # Sinatra app (ApplicationController)
gossip.rb                # Gossip model class
config.ru                # Rack config for launching app
README.md                # This file

-----

📖 Key Files Explained

gossip.rb (Model)

    initialize — creates a gossip instance with author, content, and ID

    save — appends a new gossip to the CSV file

    .all — loads all gossips from the CSV

    .find(id) — finds a gossip by its ID

    .next_id — calculates the next available ID

    update — modifies a gossip and rewrites the entire CSV

app.rb (Controller)

Defines Sinatra routes for:

    / — displays the list of gossips

    /gossips/new/ — displays form to create new gossip + POST to save

    /gossips/:id — shows a specific gossip

    /gossips/:id/edit/ — form for editing a gossip

    POST /gossips/:id/edit/ — updates gossip and redirects

Views (.erb templates)

    index.erb — displays all gossips with links to details and edit page

    show.erb — shows detailed gossip info

    new_gossip.erb — form to add a new gossip

    edit_gossip.erb — form to edit existing gossip (pre-filled)

-----

🛠 Installation & Running the App

    Clone the repo:

git clone <your-repo-url>
cd the-gossip-project

    Install dependencies:

bundle install

    Run the Sinatra server:

With Rack:

rackup config.ru

    Open your browser and go to:

http://localhost:4567

-----

💡 Best Practices & Tips

    Use 'ab' mode to append new gossips (save)

    Use 'w' mode to overwrite CSV when updating (update)

    Ensure each gossip has a unique ID to avoid overwriting

    Validate form input server-side for better data integrity

    Secure POST routes with authentication and CSRF protection for production

-----

🧩 Future Enhancements

    Implement gossip deletion

    Create a more dynamic homepage

    Switch to a real database (SQLite, ActiveRecord)

    Add pagination for gossip listings

    Add user authentication

-----

👩‍💻 Author :Martine PINNA

    GitHub: Martine9670

    Discord: Martine PINNA