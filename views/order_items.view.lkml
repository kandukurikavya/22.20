view: order_items {
  sql_table_name: `orders.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: returned_at {
    type: string
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id]
}

  measure: count1 {
    type: count_distinct
    #drill_fields: [id, inventory_items.id, orders.id]
    sql: ${order_id} ;;

html:
<head>
<title>Page Title</title>
</head>
<body>


<p>{{value}}</p>
<a href="/explore/thelook/order_items?fields=order_items.detail*&f[users.id]={{value}}"><button>Order History</button></a>
</body>
</html>

    ;;

  }
  }
