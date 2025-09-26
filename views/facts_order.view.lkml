# The name of this view in Looker is "Facts Order"
view: facts_order {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ps_sales_demo.facts_order` ;;
  drill_fields: [order_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }
  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Channel" in Explore.

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  measure: count {
    type: count
    drill_fields: [order_id]
  }

  # --- FIX: MOVED THESE MEASURES INSIDE THE VIEW BLOCK ---
  measure: total_revenue {
    type: sum
    label: "Total Revenue"
    description: "The sum of revenue from all orders."
    value_format_name: usd
    sql: ${revenue} ;;
  }

  measure: order_count {
    type: count
    label: "Order Count"
    description: "The total number of orders."
  }
} # The view's closing brace should be here, at the very end.
