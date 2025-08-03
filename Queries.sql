-- 1. Pricing Patterns

-- Average Price by Category
CREATE TABLE average_price_by_category as (
SELECT category, ROUND(AVG(Price), 2) as average_price
FROM amazon_products 
GROUP BY category)

-- Categories with the greatest price range
CREATE TABLE categories_price_range as (
SELECT category, MIN(price) as min_price,
MAX(price) as max_price, MAX(price) - MIN(price) as price_range
FROM amazon_products
GROUP BY category 
ORDER BY price_range DESC
LIMIT 5
)

-- 2. Rating and Review Analysis

-- Top performing categories 
CREATE TABLE top_performing_categories as (
SELECT category, AVG(rating) as average_rating, AVG(reviews_count) 
as average_review, ROUND(AVG(rating) * LOG(1 + AVG(reviews_count)), 2) as
weighted_score 
FROM amazon_products
GROUP BY category
ORDER BY ROUND(AVG(rating) * LOG(1 + AVG(reviews_count)), 2) desc 
LIMIT 10
)

--Categories with high average rating but low average review count  
CREATE TABLE underrated_categories as (
SELECT category, AVG(rating) as average_rating, AVG(reviews_count) 
as average_review, AVG(rating)/AVG(reviews_count)  as
weighted_score
FROM amazon_products
GROUP BY category
ORDER BY AVG(rating)/AVG(reviews_count) desc
LIMIT 10
)
-- Products with high ratings but low review counts by category 
CREATE TABLE underrated_products_by_category as (

with cte as (
SELECT category, product, rating, reviews_count, ROW_NUMBER() OVER(
PARTITION BY category
ORDER BY rating/reviews_count DESC
) as rn 
FROM amazon_products 
WHERE reviews_count >= 10
)
SELECT category, product, rating, reviews_count, rating/reviews_count as score
FROM cte 
WHERE rn <= 5

)

-- 3.	Brand Competitiveness

-- Which brands dominate categories 
CREATE TABLE top_brands_by_category as (

WITH cte as (
SELECT category, brand, AVG(rating) as average_rating, AVG(reviews_count) 
as average_review, ROUND(AVG(rating) * LOG(1 + AVG(reviews_count)), 2)  
as  weighted_score,
ROW_NUMBER() OVER (

PARTITION BY category
ORDER BY ROUND(AVG(rating) * LOG(1 + AVG(reviews_count)), 2) DESC 
) as rn 
FROM amazon_products 
GROUP BY category, brand 
)
SELECT category, brand, average_rating, average_review, weighted_score
FROM cte 
WHERE rn <= 5

)

