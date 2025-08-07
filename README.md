# Amazon-Products-Dashboard
Dataset Source: https://github.com/luminati-io/eCommerce-dataset-samples/blob/main/amazon-products.csv

Tools used: Excel Power Query, SQL(PostgreSQL), Microsoft Power BI 

## Process

### Objective 
- Obtain product insights
- Pricing(in USD) Patterns, Rating & Review Analysis, Brand Competitiveness

### 1. Data Cleaning in Power Query
Before Cleaning: Messy data, currency not standardised, categories unclear...

<img width="400" height="150" alt="image" src="https://github.com/user-attachments/assets/97761f4a-bb2b-491b-9113-cb0dea087154" />


Cleaning in Power Query:

<img width="400" height="150" alt="image" src="https://github.com/user-attachments/assets/f24bc662-ab7d-4b18-a9f3-6fe4a40690b7" />


After Cleaning:

<img width="400" height="150" alt="image" src="https://github.com/user-attachments/assets/bc76b1ae-204f-4548-b7e8-da3c2dd41a10" />


### 2. Querying with PostgreSQL
Wrote a script(Queries.sql) to obtain various tables:

- Average price by category
- Categories with greatest price range
- Top performing categories
- Categories with high average rating but low review count
- Products with high rating but low review count by category
- Top performing brands by category 

Note on metrics used: 
- Metric for High Rating & Low Review Count: rating/reviews_count
- Metric for top performance takes into account both the rating and review count:
AVG(rating) * LOG(1 + AVG(reviews_count))

### 3. Building Dashboard with Power BI
File: amazon_products_dashboard.pbix


Visuals: Bar/Column Charts, Treemaps, Tables, Area Chart, Slicers

<img width="350" height="200" alt="image" src="https://github.com/user-attachments/assets/de1f116c-5030-46ed-a8a4-966564d9e609" />

### 4. Insights and Conclusions 
- Push more marketing opportunities towards underrated categories/products & top performers
- Office Products, Automotive... etc have greatest price range -> opportunity to alter marketing tactics according to price tiers
- Musical Instruments, Motorcycle and Powersports... etc have highest average price -> reflects their higher production costs and perceived value by customers/potential willingness to pay a premium 
