{self, keys, ...}: {
  users.users.tiny = {
    isNormalUser = true;
    description = "Tiny user";
    extraGroups = ["networkmanager" "wheel" "video"];
    openssh.authorizedKeys.keys = keys;
    initialHashedPassword = "";
  };
}