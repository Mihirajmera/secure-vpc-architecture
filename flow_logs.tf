resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/${local.project_name}/flow-logs"
  retention_in_days = 14

  tags = merge(local.tags, {
    Name = "${local.project_name}-vpc-flow-logs"
  })
}

data "aws_iam_policy_document" "vpc_flow_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "vpc_flow_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      aws_cloudwatch_log_group.vpc_flow_logs.arn,
      "${aws_cloudwatch_log_group.vpc_flow_logs.arn}:*"
    ]
  }
}

resource "aws_iam_role" "vpc_flow_role" {
  name               = "${local.project_name}-vpc-flow-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_assume.json
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name   = "${local.project_name}-vpc-flow-policy"
  role   = aws_iam_role.vpc_flow_role.id
  policy = data.aws_iam_policy_document.vpc_flow_policy.json
}

resource "aws_flow_log" "vpc" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.vpc_flow_role.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${local.project_name}-vpc-flow-log"
  })
}


