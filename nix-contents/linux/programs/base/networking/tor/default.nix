{ pkgs, config, ... }:
{
  # Main Tor configuration
  services.tor = {
    enable = true;
    relay.enable = true;
  };

  # Snowflake
  services.snowflake-proxy = {
    enable = true;
  };
}
