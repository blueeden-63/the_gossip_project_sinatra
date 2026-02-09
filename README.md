# The Gossip Project — Sinatra (CSV persistence)

A simple Ruby/Sinatra web app to create and browse “gossips” (short messages) from **The Hacking Project** curriculum.
This version replaces terminal `puts/gets.chomp` interactions with HTML views, and stores data in a lightweight **CSV file**.

---

## Features

- **Home page** (`/`) lists all gossips from the database
- **Create a gossip** via a form (`/gossips/new/`)
- **Show page** for each gossip (`/gossips/:id/`)
- (Optional extensions)
  - **Edit a gossip** (`/gossips/:id/edit/`)
  - **Comments** per gossip

---

## Tech stack

- Ruby
- Sinatra
- ERB templates
- Rack (`config.ru`)
- CSV file as a small “database”
- (Recommended) `rerun` for auto-reloading during development

---

## Project structure (MVC-ish)

```
the_gossip_project_sinatra/
├── Gemfile
├── Gemfile.lock
├── config.ru
├── db/
│   └── gossip.csv
└── lib/
    ├── controller.rb
    ├── gossip.rb
    └── views/
        ├── index.erb
        ├── new_gossip.erb
        └── show.erb
```

> Your exact set of views may differ depending on how far you went (edit/comments, etc.).

---

## Getting started

### 1) Prerequisites

- Ruby installed (a modern version is fine; follow your course requirements)
- Bundler (`gem install bundler` if needed)

### 2) Install dependencies

From the project root:

```bash
bundle install
```

If you use hot reload:

```bash
bundle add rerun
# or: gem install rerun
```

### 3) Initialize the database (CSV)

Create the database folder and CSV file if they don’t exist:

```bash
mkdir -p db
touch db/gossip.csv
```

---

## Running the app

### Option A — standard Rack server

```bash
bundle exec rackup -p 4567
```

Open:

- `http://localhost:4567`

### Option B — auto-reload on file changes (recommended)

```bash
bundle exec rerun rackup -p 4567
```

---

## Main routes

| Method | Path                | Purpose |
|-------:|---------------------|---------|
| GET    | `/`                 | List all gossips |
| GET    | `/gossips/new/`      | Display “new gossip” form |
| POST   | `/gossips/new/`      | Create a gossip from form params, then redirect |
| GET    | `/gossips/:id/`      | Show one gossip by id (1-based index from CSV) |

If you implemented “edit”:

| Method | Path                      | Purpose |
|-------:|---------------------------|---------|
| GET    | `/gossips/:id/edit/`       | Display edit form |
| POST   | `/gossips/:id/edit/`       | Update an existing gossip |

---

## How persistence works (CSV)

Gossips are stored in `db/gossip.csv`, typically as:

```
author,content
```

Example row:

```
José,Josiane is not nice
```

### Typical model API

- `Gossip.new(author, content).save` → appends a row to the CSV
- `Gossip.all` → returns an array of `Gossip` objects
- `Gossip.find(id)` → returns one `Gossip` by its index (implementation varies)

> With CSV persistence, updates and comments are possible but become awkward quickly.
> This is intentional: the goal is to understand the plumbing before moving to SQL/ActiveRecord.

---

## Usage

1. Go to the home page: `http://localhost:4567/`
2. Click **Create a gossip** to open the form
3. Submit the form → you’re redirected back to `/`
4. Click a gossip link to view its show page

---

## Development tips

- If routes don’t reflect your changes, restart the server (or use `rerun`).
- When debugging form submissions, print `params` in your POST route.
- Keep controller code focused on routing and rendering; put data logic in the model.

---

## Possible improvements

- Add validations (non-empty author/content)
- Add flash messages (success/error)
- Edit & delete gossips
- Comments stored per gossip (CSV/JSON) or, better, migrate to SQL

---

## License

Educational project — use freely for learning.
