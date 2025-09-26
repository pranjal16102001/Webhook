# Define the database connection to be used for this model.
connection: "ps_bigquery_sales_connection"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: sales_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sales_model_default_datagroup
#Hello_github
# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Sales Model"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.


explore: facts_order {
  label: "Sales Analysis"
  description: "Explore sales revenue, products, and customer trends."

  join: dim_customers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${facts_order.customer_id} = ${dim_customers.id} ;;
  }

  join: dim_products {
    type: left_outer
    relationship: many_to_one
    # We cast the product_id to a STRING to match the type in dim_products
    sql_on: ${facts_order.product_id} = ${dim_products.id} ;;
  }
}
