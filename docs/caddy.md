Here's a nicely formatted version of your Caddy installation & basic configuration guide:

# Installing and Configuring Caddy on Debian/Ubuntu

## Step 1: Install Caddy (Official Cloudsmith Repository Method)

```bash
# Install prerequisite packages
sudo apt update
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

# Add Caddy's official GPG key
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | \
  sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

# Add Caddy repository
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | \
  sudo tee /etc/apt/sources.list.d/caddy-stable.list

# Update package list and install Caddy
sudo apt update
sudo apt install caddy
```

## Step 2: Basic Configuration (HTTP → Reverse Proxy)

Edit the main Caddy configuration file:

```bash
sudo vim /etc/caddy/Caddyfile
```

Basic example – proxy to an app running on port 3000:

```caddy
:80 {
    reverse_proxy localhost:3000
}
```

Apply changes:

```bash
sudo systemctl restart caddy
```

## Step 3: Production Setup with HTTPS (Recommended)

1. **Set up your domain**  
   Create a domain in **AWS Route 53** (or your DNS provider) and point it to your server's public IP address (A record).

2. Update the Caddyfile with your real domain:

```bash
sudo vim /etc/caddy/Caddyfile
```

```caddy
mydomain.com {
    reverse_proxy localhost:3000
}
```

Or even shorter (Caddy will automatically get & renew Let's Encrypt certificate):

```caddy
mydomain.com
```

3. Restart Caddy to apply changes and obtain SSL certificate:

```bash
sudo systemctl restart caddy
```

Caddy will now:

- Automatically obtain and renew **free HTTPS/SSL** certificate from Let's Encrypt
- Redirect all HTTP traffic to HTTPS
- Serve your application securely

## Quick Status & Log Commands

```bash
# Check status
sudo systemctl status caddy

# See real-time logs
sudo journalctl -u caddy -f

# Validate config syntax
sudo caddy validate --config /etc/caddy/Caddyfile
```

That's it!  
Your app should now be available securely at `https://mydomain.com` 🎉