{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    llama-cpp-rocm
  ];

  services.llama-swap = let
    llama-server = lib.getExe' pkgs.llama-cpp-rocm "llama-server";
  in {
    enable = true;
    settings = {
      models = {
        "qwen3.6-35b-a3b" = {
          cmd = ''${llama-server} --host 127.0.0.1 --port ''${PORT}
            --hf-repo unsloth/Qwen3.6-35B-A3B-GGUF --hf-file Qwen3.6-35B-A3B-UD-Q4_K_M.gguf
            --ctx-size 131072'';
        };
        "gemma4-12b" = {
          cmd = ''${llama-server} --host 127.0.0.1 --port ''${PORT}
            --hf-repo unsloth/gemma-4-12b-it-GGUF --hf-file gemma-4-12b-it-Q4_K_M.gguf
            --ctx-size 131072'';
        };
      };
    };
  };
}
