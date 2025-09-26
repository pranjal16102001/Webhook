# Filename: auto_deploy.dashboard.lkml

- dashboard: auto_deploy
  title: "Auto Deploy"
  layout: newspaper
  preferred_viewer: dashboards-next
  tile_size: 100

  filters:
  # You can define dashboard-wide filters here later

  elements:
  - name: sales_by_customer_state
    title: "Sales by Customer State"

    # This creates a horizontal bar chart.
    # To change this to a vertical column chart, simply change the line below to 'type: looker_column'
    type: looker_bar

    model: sales_model
    explore: facts_order
    query:
      dimensions: [dim_customers.state]
      measures: [facts_order.total_sale_price]
      sorts: [facts_order.total_sale_price desc]
      limit: 15
