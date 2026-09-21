{self, keys, ...}: {
  users.users.kazu = {
    isNormalUser = true;
    description = "Justin Leung";
    extraGroups = ["networkmanager" "wheel"];
    linger = true;
    openssh.authorizedKeys.keys = keys;
  };
}