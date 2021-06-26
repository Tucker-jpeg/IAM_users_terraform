/*
To create a single IAM user in Terraform create an aws_iam_user resource block and give it a name.
If we only need to create one user, this is a relatively simple step.
*/

resource "aws_iam_user" "demouser" {
    name = "tuckerdemo"
}

