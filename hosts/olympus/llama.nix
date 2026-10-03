{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    llama-cpp-cuda
  ];

  services.llama-swap = let
    llama-server = lib.getExe' pkgs.llama-cpp-cuda "llama-server";
  in {
    enable = true;
    settings = {
      healthCheckTimeout = 300;
      models = {
        "qwen3.5:9b" = {
          cmd = ''${llama-server} --host 127.0.0.1 --port ''${PORT}
            --hf-repo unsloth/Qwen3.5-9B-GGUF --hf-file Qwen3.5-9B-Q4_K_M.gguf
            --ctx-size 131072'';
        };
      };
    };
  };
}
