connection: "looker-dcl-data"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
