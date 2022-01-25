# The name of this view in Looker is "Test Table"
view: test_table {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `test_dmitry.test_table`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Game Length" in Explore.

  dimension: game_length {
    type: number
    sql: ${TABLE}.Game_Length ;;
  }

  dimension: game_number {
    type: number
    sql: ${TABLE}.Game_Number ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_game_number {
    type: sum
    sql: ${game_number} ;;
  }

  measure: average_game_number {
    type: average
    sql: ${game_number} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
