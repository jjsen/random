variable "up_time" {
  default = "08:00"
}

variable "down_time" {
  default = "18:00"
}

variable "days_of_week" {
  default = "Monday,Tuesday,Wednesday,Thursday,Friday"
}


locals {
  # Convert time to regex variable in format HH:MM
  up_time_regex = replace(var.up_time, "/(\d{2}):(\d{2})/", "$1:$2")

  # Convert time to regex variable in format HH:MM
  down_time_regex = replace(var.down_time, "/(\d{2}):(\d{2})/", "$1:$2")

  # Convert days of the week to regex variable in format 1|2|3|4|5|6|7
  days_of_week_regex = replace(var.days_of_week, "/(\w+)/", "${index(["1","2","3","4","5","6","7"], lower("$1"))}")

  # Combine the time and days of the week regex variables to create the cron job value
  up_cron_job_value = "${split(",", days_of_week_regex)[0]} ${split(",", days_of_week_regex)[1]} ${up_time_regex} * * ${split(",", days_of_week_regex)[2]}-${split(",", days_of_week_regex)[6]}"
  down_cron_job_value = "${split(",", days_of_week_regex)[0]} ${split(",", days_of_week_regex)[1]} ${down_time_regex} * * ${split(",", days_of_week_regex)[2]}-${split(",", days_of_week_regex)[6]}"
}
