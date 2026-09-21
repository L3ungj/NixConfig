{config, ...}: {
  sops = {
    defaultSopsFile = ./secrets.yaml;
    # TODO: change location?
    age.keyFile = "/home/kazu/.config/sops/age/keys.txt";

    secrets = {
      ollama_api_key = {
        sopsFile = ./secrets.yaml;
      };
      sageask_env = {
        sopsFile = ./secrets.yaml;
      };
    };
  };
}
