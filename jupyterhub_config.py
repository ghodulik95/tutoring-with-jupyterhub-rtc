# ============================================================
# JupyterHub configuration for RTC with LocalAuthenticator
# ============================================================

# Use JupyterLab as the default interface
# Start JupyterLab by default
#c.Spawner.cmd = ["jupyter", "lab"]
#c.Spawner.default_url = "/lab"

c.Spawner.cmd = ["jupyter-labhub"]
c.Spawner.default_url = "/lab"
# Hook to add ~/.local/bin dynamically to PATH
def add_local_bin(spawner):
    user_home = f"/home/{spawner.user.name}/.local/bin"
    old_path = spawner.env.get("PATH", "/usr/local/bin:/usr/bin:/bin")
    spawner.env["PATH"] = f"{user_home}:{old_path}"

c.Spawner.pre_spawn_hook = add_local_bin

c.Authenticator.admin_users = {"geo"}
c.Authenticator.allowed_users = {"geo", "johnc"}
c.LocalAuthenticator.create_system_users = True
c.JupyterHub.admin_access = True

# NOTE: Upon first run and after adding new users, you must:
#  1. Go into bash: docker exec -it jupyterhub-rtc bash
#  2. Set password: passwd <username>
