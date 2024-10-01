extends RichTextLabel

var ip_address : String

func _ready():
    for address in IP.get_local_addresses():
        print(address)
    var ip = resolve_ip()
    self.text = '[pulse]Aneu a\nhttp://%s:8081\namb els mòbils![/pulse]' % ip


func resolve_ip():

    if OS.has_feature("windows"):
        if OS.has_environment("COMPUTERNAME"):
          ip_address =  IP.resolve_hostname(str(OS.has_environment("COMPUTERNAME")), IP.TYPE_IPV4)
    elif OS.has_feature("x11") or OS.has_feature('linux') or OS.has_environment('macos'):
        if OS.has_environment("HOSTNAME"):
          ip_address =  IP.resolve_hostname(str(OS.has_environment("HOSTNAME")), IP.TYPE_IPV4)
        else:
            var output = []
            var exit_code = OS.execute('hostname',['-I'], output)
            prints(exit_code, output)
            ip_address = str(output[0]).strip_edges()
    elif OS.has_feature("OSX"):
        if OS.has_environment("HOSTNAME"):
            ip_address =  IP.resolve_hostname(str(OS.has_environment("HOSTNAME")), IP.TYPE_IPV4)

    return ip_address
