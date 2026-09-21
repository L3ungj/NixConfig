{config, ...}: {
  sops = {
    defaultSopsFile = ./secrets.yaml;
    # TODO: change location?
    age.keyFile = "/home/kazu/.config/sops/age/keys.txt";

    secrets = {
      wifi_env = {
        sopsFile = ./secrets.yaml;
      };
    };
  };
}
