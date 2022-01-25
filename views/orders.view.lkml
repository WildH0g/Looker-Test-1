# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `test_dmitry.orders`
    ;;
  drill_fields: [order_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Country" in Explore.

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: item_type {
    type: string
    sql: ${TABLE}.Item_Type ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Order_Date ;;
  }

  dimension: order_priority {
    type: string
    sql: ${TABLE}.Order_Priority ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.Sales_Channel ;;
  }

  dimension_group: ship {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Ship_Date ;;
  }

  dimension: total_cost {
    type: number
    sql: ${TABLE}.Total_Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_total_cost {
    type: sum
    sql: ${total_cost} ;;
  }

  measure: average_total_cost {
    type: average
    sql: ${total_cost} ;;
  }

  dimension: total_profit {
    type: number
    sql: ${TABLE}.Total_Profit ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.Total_Revenue ;;
  }

  dimension: unit_cost {
    type: number
    sql: ${TABLE}.Unit_Cost ;;
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.Unit_Price ;;
  }

  dimension: units_sold {
    type: number
    sql: ${TABLE}.Units_Sold ;;
  }

  measure: count {
    type: count
    drill_fields: [order_id]
  }

  measure: total_margin {
    type: sum
    sql: ${total_revenue}-${total_profit} ;;
    value_format_name: eur
  }

  measure: average_cost {
    type: average
    sql: ${total_cost} ;;
    value_format_name: eur
  }

  measure: is_meat {
    type: count
    filters: [item_type: "Meat"]
  }

  measure: is_meat_percentage {
    type: number
    sql:  ${is_meat}/${count} ;;
    value_format_name: percent_2
  }
}
