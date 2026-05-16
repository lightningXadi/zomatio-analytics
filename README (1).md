# Zomato Analytics Dashboard

A real-time, interactive analytics dashboard built with vanilla HTML/CSS/JS, powered by a **Supabase PostgreSQL** backend and deployed as a static site on **GitHub Pages** — zero frameworks, zero build tools, zero server.

**[Live Demo →](https://lightningxadi.github.io/zomato-analytics/)**

---

## Preview

> Add a screenshot: `![Dashboard Preview](screenshot.png)`

---

## What This Project Does

This dashboard pulls live Zomato restaurant and order data from Supabase using the PostgREST REST API and visualizes it entirely client-side using Chart.js. It covers ~1,000 Bangalore restaurants across multiple areas, cuisine types, and restaurant categories.

---

## Features

| Feature | Details |
|---|---|
| Key Metrics | Total restaurants, orders, avg rating, cuisine count — animated count-up on load |
| Peak Order Hours | 24-hour bar chart with dinner/lunch peaks highlighted |
| Restaurant by Type | Doughnut chart — Casual Dining, Café, Quick Bites, etc. |
| Top Cuisines by Rating | Horizontal bar, min. 5 restaurants per cuisine |
| Delivery Time by Type | Fastest to slowest restaurant types by avg delivery mins |
| Top 12 Restaurants | Ranked card grid by average rating |
| Online Order Stats | Acceptance rate with animated progress bar |
| Top Areas by Rating | Best-rated Bangalore localities |
| Restaurant Table | 100 rows, live search by name, area, or cuisine |
| Skeleton Loaders | Shimmer placeholders while data fetches |
| Styled Tooltips | Dark-themed Chart.js tooltips matching the UI |
| Refresh Button | Reloads all data and re-renders charts without page reload |
| Responsive | Works on mobile, tablet, and desktop |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3, Vanilla JavaScript (ES2020) |
| Charts | Chart.js 4.4.1 |
| Database | Supabase (PostgreSQL) |
| API | Supabase PostgREST |
| Fonts | Google Fonts — Sora, Outfit |
| Hosting | GitHub Pages |

---

## Database Schema

Three tables, created via `create_tables.sql`:

### `restaurants`
| Column | Type | Description |
|---|---|---|
| `restaurant_id` | SERIAL PK | Auto-incrementing ID |
| `name` | VARCHAR(100) | Restaurant name |
| `area` | VARCHAR(50) | Locality in Bangalore |
| `city` | VARCHAR(50) | City (Bangalore) |
| `cuisine` | VARCHAR(50) | Cuisine type |
| `avg_rating` | DECIMAL(3,2) | Average rating (1.0 – 5.0) |
| `total_votes` | INTEGER | Total number of ratings |
| `avg_cost_for_two` | INTEGER | Average cost for two (₹) |
| `restaurant_type` | VARCHAR(50) | Category (Casual Dining, Café, etc.) |
| `online_order` | BOOLEAN | Accepts online orders |

### `orders`
| Column | Type | Description |
|---|---|---|
| `order_id` | SERIAL PK | Auto-incrementing ID |
| `restaurant_id` | INTEGER FK | References `restaurants` |
| `order_date` | TIMESTAMP | Date and time of order |
| `delivery_time_mins` | INTEGER | Delivery time in minutes |
| `order_amount` | DECIMAL(10,2) | Order value in ₹ |
| `order_hour` | INTEGER | Hour of day (0–23) |

### `reviews`
| Column | Type | Description |
|---|---|---|
| `review_id` | SERIAL PK | Auto-incrementing ID |
| `restaurant_id` | INTEGER FK | References `restaurants` |
| `rating` | DECIMAL(3,2) | Individual review rating |
| `review_date` | DATE | Date of review |

---

## Project Structure

```
zomato-analytics/
├── index.html                  # Full dashboard — HTML, CSS, JS in one file
├── create_tables.sql           # Table definitions (run this first)
├── supabase_1_restaurants.sql  # Restaurant INSERT data
├── supabase_2_orders.sql       # Orders INSERT data
├── supabase_3_reviews.sql      # Reviews INSERT data
├── insert_data.sql             # Combined full dataset (~5,000 restaurant rows)
├── analysis_queries.sql        # All SQL queries powering the dashboard
└── README.md
```

---

## Setup — Run it Yourself

### 1. Create a Supabase project
Go to [supabase.com](https://supabase.com), create a free project, and note your **Project URL** and **anon public key** (Settings → API Keys → Legacy → anon public).

### 2. Create the tables
Open the **SQL Editor** in your Supabase dashboard and run `create_tables.sql`.

### 3. Load the data
Run the insert files in order:
```
supabase_1_restaurants.sql   ← run first
supabase_2_orders.sql        ← run second
supabase_3_reviews.sql       ← run third
```
Or run `insert_data.sql` for the full combined dataset in one shot.

### 4. Disable Row Level Security
```sql
ALTER TABLE restaurants DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE reviews DISABLE ROW LEVEL SECURITY;
```

### 5. Update credentials in `index.html`
```js
const SUPABASE_URL = 'https://your-project-id.supabase.co';
const SUPABASE_KEY = 'your-anon-public-key';
```

### 6. Deploy to GitHub Pages
Push to GitHub → repo Settings → Pages → Source: main branch, root folder → Save.

Your dashboard will be live at `https://yourusername.github.io/repo-name/`

---

## SQL Analysis Highlights

The `analysis_queries.sql` file contains the core analytical queries powering the dashboard:

- **Window Functions** — `RANK()` and `DENSE_RANK()` to rank restaurants within cuisine and area partitions
- **Aggregations** — `AVG`, `COUNT`, `SUM`, `MAX` grouped by hour, area, cuisine, and restaurant type
- **Joins** — `orders` joined with `restaurants` to calculate avg delivery time and order value per restaurant type
- **CASE statements** — Classifying order hours into meal periods (Breakfast, Lunch, Snacks, Dinner, Late Night)
- **HAVING clauses** — Filtering groups with minimum restaurant counts for statistically meaningful averages

---

## Dataset

Based on the [Zomato Bangalore Restaurants dataset](https://www.kaggle.com/datasets/himanshupoddar/zomato-bangalore-restaurants) from Kaggle, cleaned and loaded into Supabase PostgreSQL.

Covers restaurants across Banashankari, Basavanagudi, Jayanagar, BTM, JP Nagar, Koramangala, Indiranagar, and more.

---

## Author

**lightningXadi** · Built as a data analytics + full-stack portfolio project · [GitHub](https://github.com/lightningxadi)
