# dbt Training
Welcome to dbt training! 
This repository contains two projects:
- the Jaffle data to explore and understand the fundamentals of dbt
- the Shipments data to explore data modeling concepts in real world setting
- Lalala I am different

## Overview
This training session is designed to provide a comprehensive understanding 
of dbt, covering its core concepts and functionalities. You will 
learn how to use dbt to build and maintain data models, perform data 
transformations, and ensure data quality through rigorous testing and documentation.

## Working with the project

### 2. Click 'Code', then 'Codespaces, then 'Create codespace on main'.

![Create codespace on main](images/open-codespace.gif)

This will create a new `codespace`, a sandbox with everything you need for the training. 

Once the codespace is finished setting up, you will need to:
1. Change directory using the command `cd jaffle_shop_training` or `cd shipments` in the terminal
2. Update the `profiles.yml` file with your credentials:
    - Username & password: provided to you individually
    - Schema: `dbt_firstletterlastname` (eg. `dbt_lsheppard`)
3. Run `dbt debug` to test your credentials and connection

## Data Overview

### Jaffle data
The Jaffle data set will be used throughout this training. Jaffle data is a 
sample dataset that simulates a simple e-commerce store, including customers, 
orders, and payments. This dataset provides a practical context for learning 
and applying dbt concepts, making it easier to understand real-world applications of dbt.

### Shipments data
The Shipments Data represents transactional information related to the movement of goods, capturing details 
about shipments, customers, businesses, drivers, vehicles, and shipment types. The data is structured across 
several core tables, each containing important attributes that help track and analyze shipment performance, 
customer interactions, and business operations.

## Agenda - dbt Group Training

### 1. dbt Fundamentals
Introduction to the basics of dbt, including its purpose, key components, and 
how it integrates into the modern data stack. Concepts such as models, runs, builds and 
configurations will be explained.

### 2. Sources
Instructions on how to define and manage data sources in dbt. The session will 
cover the importance of sources, how to declare them in a dbt project, and best 
practices for managing source freshness.

### 3. Documentation
Exploration of how to document dbt models and projects effectively. The 
importance of maintaining documentation and using dbt's built-in documentation 
features to keep projects organized and understandable will be discussed.

### 4. Tests
Guidance on writing and running tests in dbt, including schema tests and data tests, 
to ensure transformations produce accurate results. Emphasis will be placed on the 
importance of testing for data integrity.

### 5. Macros and Jinja
Understanding the power of dbt macros and the Jinja templating language. The 
session will cover how to write reusable SQL snippets using macros and leverage 
Jinja to make dbt models more dynamic and flexible.

### 6. Materializations
Overview of different types of materializations in dbt, such as views, tables, 
and incremental models. Discussion on when and why to use each type, and how to 
configure them in a dbt project.

### 7. Incremental Models
Explanation of incremental models and their significance for efficient data processing. 
Instructions on how to set up and manage incremental models in dbt to process large 
datasets incrementally rather than reprocessing everything from scratch.