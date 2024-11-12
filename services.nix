{ config, pkgs, ... }:
{
  systemd = {
    user.services.hyprauthagent = {
      description = "Hyprland Authentication Agent";
      wantedBy = [ "hyprland-session.target" ];
      wants = [ "hyprland-session.target" ];
      after = [ "hyprland-session.target" ];

      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
	Restart = "on-failure";
      };
    };
  };
}
