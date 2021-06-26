/*
There are different ways to create multiple IAM users.
We could copy and paste the resource block from our first user and give the subsequent blocks new names. However, this causes repetition of code and can be very inefficient for creating many users, as we would need to manually adjust the name for each user.
The count meta-argument can be used to copy and create a resource as many times as you define. In this case, 3.
*/
/*
resource "aws_iam_user" "demo" {
  count = 3
  name = "tuckerdemo"
}
*/
/*
The problem with using count in this way is that all 3 of the users would have the same name, “tuckerdemo”.
Using count.index after the name will give a distinct index number corresponding to each iteration of the resource block.
*/
/*
resource "aws_iam_user" "demo" {
  count = 3
  name = "tuckerdemo.${count.index}"
}
*/
/*
If our users need unique names that do not start the same and end with a number, this method will not be appropriate without further customization.
A list of unique usernames can be added to a variable in a separate file and then referenced in our resource block.
Let’s create a username variable.

For the following code, the length function will return a value of 3, for the 3 users in the username list.
The element function will return the single name in the username list associated with the distinct index number of the count argument ([0]=”tucker”, [1]=”annie”, [2]=”josh”).
*/

resource "aws_iam_user" "demo" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}

/*
If we wanted to have an output of the arn of all the user we create, we can do that with an output file.
Create an output block for “user_arn”.
The “*” in the value line will indicate to output the arn for all of the aws_iam_user’s.
If you only want to output a specific user’s arn, change the “*” to that users index number in the list (0, 1, 2, etc.).
*/
/*
output "user_arn" {
  value = aws_iam_user.demo.*.arn
}
*/
/*
If a resource or module block includes a for_each argument whose value is a map or a set of strings, Terraform will create one instance for each member of that map or set.
In this case we use it for a set of strings, made up of the usernames.
*/
/*
resource "aws_iam_user" "example" {
  for_each = toset(["tucker", "annie", "josh"])
  name     = each.value
}

*/
