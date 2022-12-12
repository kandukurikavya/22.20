connection: "looker-dcl-data"

# include all the views
include: "/views/**/*.view"

datagroup: kavyakandukuri_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kavyakandukuri_default_datagroup

explore: employee_master {}

explore: products {}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: inventory_items_vijaya {
  join: products {
    type: left_outer
    sql_on: ${inventory_items_vijaya.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: product_sheets {
  join: products {
    type: left_outer
    sql_on: ${product_sheets.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}
explore: sql_runner_query {}
explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
