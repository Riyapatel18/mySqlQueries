
--Find the second highest salary from an employee table.

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

--Find duplicate employee names.

SELECT employee_name, COUNT(*) AS count
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;

--Retrieve Top 3 Highest Salaries

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

--Find Employees Whose Salary is Greater Than Average Salary

SELECT employee_id, employee_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

--Count Employees Department Wise

SELECT department_id,
       COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

--Find Highest Salary in Each Department

SELECT department_id,
       MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id;

--using subquery

SELECT *
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

--Get employee names with department names.

SELECT e.employee_name,
       d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

--Find all employees even if department is missing.

SELECT e.employee_name,
       d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

--Find Total Sales Per Month

SELECT MONTH(order_date) AS month,
       SUM(sales_amount) AS total_sales
FROM sales
GROUP BY MONTH(order_date)
ORDER BY month;

--Find Customers Who Never Ordered

SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--Assign ranking to employees based on salary.

SELECT employee_name,
       salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS rank
FROM employees;

--Running Total Query

SELECT order_date,
       sales_amount,
       SUM(sales_amount)
       OVER(ORDER BY order_date) AS running_total
FROM sales;

--Find nth Highest Salary

SELECT salary
FROM (
    SELECT salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 3;

--Find Percentage Contribution

SELECT product_name,
       sales_amount,
       ROUND(
           sales_amount * 100.0 /
           SUM(sales_amount) OVER(),
           2
       ) AS percentage_contribution
FROM sales;

--SQL query to find departments whose total sales are greater than 50,000.

WITH department_sales AS (
    SELECT department_id,
           SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY department_id
)
SELECT *
FROM department_sales
WHERE total_sales > 50000;

--Find Daily Active Users

SELECT login_date,
       COUNT(DISTINCT user_id) AS active_users
FROM logins
GROUP BY login_date;

--Find Repeat Customers

SELECT customer_id,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

--Month-over-Month Growth

SELECT month,
       revenue,
       LAG(revenue) OVER(ORDER BY month) AS previous_month,
       revenue - LAG(revenue)
       OVER(ORDER BY month) AS growth
FROM monthly_sales;


