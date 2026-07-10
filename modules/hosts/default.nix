# Defines all hosts + users + homes.
{
  den.hosts.x86_64-linux.laptop.users.mckahz.classes = [
    "homeManager"
    "nixos"
  ];
  den.homes.x86_64-linux.mckahz = { };
  # Other hosts can also have user.
  # den.hosts.x86_64-linux.south = {
  #   users.mckahz = { };
  # };
}
