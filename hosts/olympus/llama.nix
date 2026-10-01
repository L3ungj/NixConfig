{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    llama-cpp-cuda
  ];

  services.llama-swap = let
    llama-server = lib.getExe' pkgs.llama-cpp-cuda "llama-server";
  in {
    enable = true;
    settings = {
      models = {
        "qwen3.6:35b-a3b" = {
          cmd = ''${llama-server} --host 127.0.0.1 --port ''${PORT}
            --hf-repo unsloth/Qwen3.6-35B-A3B-GGUF --hf-file Qwen3.6-35B-A3B-UD-Q4_K_M.gguf
            --ctx-size 131072'';
        };
      };
    };
  };
}
