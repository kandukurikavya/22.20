view: sql_runner_query {
  derived_table: {
    sql: SELECT * FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering, CASE WHEN z___min_rank = z___rank THEN 1 ELSE 0 END AS z__is_highest_ranked_cell FROM (
      SELECT *, MIN(z___rank) OVER (PARTITION BY CAST(orders_user_id AS STRING)) as z___min_rank FROM (
      SELECT *, RANK() OVER (ORDER BY CASE WHEN z__pivot_col_rank=1 THEN (CASE WHEN products_count IS NOT NULL THEN 0 ELSE 1 END) ELSE 2 END, CASE WHEN z__pivot_col_rank=1 THEN products_count ELSE NULL END DESC, products_count DESC, z__pivot_col_rank, orders_user_id) AS z___rank FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY CASE WHEN products_department IS NULL THEN 1 ELSE 0 END, products_department) AS z__pivot_col_rank FROM (
      SELECT
          products.department  AS products_department,
          orders.user_id  AS orders_user_id,
          COUNT(DISTINCT products.id ) AS products_count
      FROM `orders.order_items`
           AS order_items
      LEFT JOIN `orders.inventory_items`
           AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN `orders.orders`
           AS orders ON order_items.order_id = orders.id
      LEFT JOIN `orders.products`
           AS products ON inventory_items.product_id = products.id
      GROUP BY
          1,
          2) ww
      ) bb WHERE z__pivot_col_rank <= 16384
      ) aa
      ) xx
      ) zz
       WHERE (z__pivot_col_rank <= 50 OR z__is_highest_ranked_cell = 1) AND (z___pivot_row_rank <= 500 OR z__pivot_col_ordering = 1) ORDER BY z___pivot_row_rank
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_department {
    type: string
    sql: ${TABLE}.products_department ;;
  }

  dimension: orders_user_id {
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

  dimension: products_count {
    type: number
    sql: ${TABLE}.products_count ;;
  }

  dimension: z__pivot_col_rank {
    type: number
    sql: ${TABLE}.z__pivot_col_rank ;;
  }

  dimension: z___rank {
    type: number
    sql: ${TABLE}.z___rank ;;
  }

  dimension: z___min_rank {
    type: number
    sql: ${TABLE}.z___min_rank ;;
  }

  dimension: z___pivot_row_rank {
    type: number
    sql: ${TABLE}.z___pivot_row_rank ;;
  }

  dimension: z__pivot_col_ordering {
    type: number
    sql: ${TABLE}.z__pivot_col_ordering ;;
  }

  dimension: z__is_highest_ranked_cell {
    type: number
    sql: ${TABLE}.z__is_highest_ranked_cell ;;
  }

  set: detail {
    fields: [
      products_department,
      orders_user_id,
      products_count,
      z__pivot_col_rank,
      z___rank,
      z___min_rank,
      z___pivot_row_rank,
      z__pivot_col_ordering,
      z__is_highest_ranked_cell
    ]
  }
}
