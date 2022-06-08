{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      scan_timeout = 10;
      command_timeout = 0;
      add_newline = false;

      character = {
        success_symbol = "[\\$](bold green) ";
        error_symbol = "[\\$](bold red) ";
      };

      directory.disabled = false;

      git_branch = {
        format = "[$symbol$branch]($style) ";
        truncation_length = 10;
        truncation_symbol = "";
      };

      git_commit.disabled = true;

      git_state = {
          format = "[\($state( $progress_current of $progress_total)\)]($style) ";
          cherry_pick = "[🍒 PICKING](bold red)";
      };

      git_status = {
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        up_to_date = "✓";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++\($count\)](green)";
        renamed = "👅";
        deleted = "🗑";
      };

      nix_shell = {
        format = "[$symbol]($style) ";
      };

      python = {
        format = "[\${symbol}({version})]($style)";
        python_binary = ["python"];
      };

      rust = {
        format = "[$symbol($version)]($style) ";
        detect_extensions = [];
      };
    };
  };  
}
