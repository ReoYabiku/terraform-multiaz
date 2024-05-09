data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "session_manager" {
  name = "SessionManager"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

data "aws_iam_policy" "policy_ssm_managed_instance_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role = aws_iam_role.session_manager.name
  policy_arn = data.aws_iam_policy.policy_ssm_managed_instance_core.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.session_manager.name
}