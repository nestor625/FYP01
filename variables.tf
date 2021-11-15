variable "aws_region" {
  default = "ap-northeast-1"
}

variable "cluster-name" {
  default = "nestor-eks-fyp"
  type    = string
}




#aws eks --region ap-northeast-1 update-kubeconfig --name nestor-eks-fyp
#kubectl exec --stdin --tty wordpress-mysql-58cfbf484f-dfmm2 -- /bin/bash
#mysql -r root -p
#set global show_compatibility_56=1;
#show global variables like '%ssl%';