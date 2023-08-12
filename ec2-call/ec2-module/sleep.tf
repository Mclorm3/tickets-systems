resource "time_sleep" "wait_for_instance" {
  create_duration = "180s"

  depends_on = [aws_instance.my_elk_instance]
}

resource "time_sleep" "wait_for_s3" {
  create_duration = "10s"

  depends_on = [aws_instance.my_elk_instance]
}

resource "time_sleep" "wait_for_s3_bucket" {
  create_duration = "20s

  depends_on = [aws_instance.my_elk_instance]
}

