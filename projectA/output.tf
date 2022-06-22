output "no_of_web_servers" {
    description = "this is webservers......"
    //value = "${module.web_server.public_ip}-this is public ips of servers"
    value = module.web_server.author
  
}
