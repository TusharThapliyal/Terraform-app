resource "aws_key_pair" "aws_auth" {
  key_name   = "jenkins_demo"
  public_key = file("~/.ssh/jenkins_demo.pub")
}
