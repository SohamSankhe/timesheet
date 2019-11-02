# Timesheet

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Sources:

* https://github.com/NatTuck/lens/

## Design choices:

I created a Users table which self-references for worker-manager relationship.  
There is a Tasks table which contains the job codes and their descriptions
The timesheets table references the user table for worker and manager.  
The timesheet table contains columns for task1..task8 and hours1..hours8  
This table is not exactly in 1 NF but I started off with this approach as proof of concept  
for the associations and ran out of time to normalize the table.
