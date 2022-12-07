view: product_sheets {
  sql_table_name: `orders.product_sheets`
    ;;

  dimension: custom_grouping {
    type: string
    sql: ${TABLE}.custom_grouping ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name, products.item_name, products.id]
  }
}
