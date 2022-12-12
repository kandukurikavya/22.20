view: users {
  sql_table_name: `orders.users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  parameter: test {
    type: unquoted
    allowed_value: {

      value: "total"
    }
    allowed_value: {

      value: "average"
    }
  }

  measure: testing {
    type: number
    value_format: "0.00%"
    #value_format_name: decimal_2
    sql:
    {% if test._parameter_value == 'total' %}
     ${count}
    {% elsif test._parameter_value == 'city' %}
 ${city}
    {% else %}
      null
    {% endif %};;
    html:
    {% if test._parameter_value == 'totalcount' %}
      {{rendered_value}}
   {% elsif test._parameter_value == 'city' %}
      {{rendered_value}}
    {% else %}
      <font color="black">{{ rendered_value }}</font>
    {% endif %};;
  }
measure: sum_users {
  type: number
  sql:sum( ${traffic_source})/sum(${age}) ;;
}
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count]
  }

}
