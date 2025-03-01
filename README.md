# Bambu Farm Docker Setup

This repository contains Docker configuration files for running Bambu Farm, a web-based application for monitoring multiple Bambu Lab printers.

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/bambu-farm-docker.git
   cd bambu-farm-docker
   ```

2. Copy the environment template and edit it with your printer details:
   ```
   cp .env.template .env
   nano .env
   ```
   
   Make sure to update the following values:
   - `bambu.printers.printer1.device-id` - Your printer's serial number
   - `bambu.printers.printer1.access-code` - Your printer's access code
   - `bambu.printers.printer1.ip` - Your printer's IP address
   - `bambu.printers.printer1.model` - Your printer model (a1, a1mini, p1p, p1s, x1c)

3. Create the data directory:
   ```
   mkdir -p data
   ```

4. Start the containers:
   ```
   docker-compose up -d
   ```

5. Access the web interface at http://localhost:8080
   - Default login: `admin` / `admin`

## Features

- Monitor multiple Bambu Lab printers
- Upload and print .3mf files
- Remote camera view
- Send custom GCode
- Batch printing (for P1S and X1C)
- Dark mode
- User authentication with different access levels

## Configuration Options

### Adding Multiple Printers

To add more printers, add additional sections to your `.env` file:

```
bambu.printers.printer1.device-id=PRINTER1_SERIAL
bambu.printers.printer1.access-code=PRINTER1_ACCESSCODE
bambu.printers.printer1.ip=PRINTER1_IP
bambu.printers.printer1.model=p1p

bambu.printers.printer2.device-id=PRINTER2_SERIAL
bambu.printers.printer2.access-code=PRINTER2_ACCESSCODE
bambu.printers.printer2.ip=PRINTER2_IP
bambu.printers.printer2.model=x1c
```

### Using Cloud Mode

If you're having issues with the latest firmware that blocks printing via MQTT unless in LAN mode, you can enable cloud mode:

```
bambu.cloud.enabled=true
bambu.cloud.username=u_12345
bambu.cloud.token=YOUR_ACCESS_TOKEN
```

See the original README for instructions on how to obtain your cloud username and token.

### LiveView Support (for X1C)

To enable LiveView for X1C cameras:

1. Uncomment the `bambu-liveview` service in `docker-compose.yml`
2. Add these settings to your `.env` file:
   ```
   bambu.live-view-url=http://bambu-liveview:8090/
   bambu.printers.printer1.stream.live-view=true
   ```

## Persistence

All data is stored in the `./data` directory which is mounted as a volume in the container. This includes:
- Application logs
- Uploaded files

## Security Considerations

- Change the default admin password in the `.env` file
- For better security, use bcrypt-encrypted passwords:
  ```
  bambu.users.admin.password=$2a$12$GtP15HEGIhqNdeKh2tFguOAg92B3cPdCh91rj7hklM7aSOuTMh1DC
  ```
  You can generate bcrypt passwords using online tools like https://bcrypt-generator.com/

## Troubleshooting

- **Check logs**: `docker-compose logs -f bambu-farm`
- **Container won't start**: Make sure your `.env` file contains the minimum required configuration
- **Can't connect to printer**: Verify the IP address and make sure the printer is on the same network
- **X1C file upload issues**: The Bouncy Castle option should be enabled by default in this setup
- **"Cannot print with latest firmware"**: Either downgrade the firmware or enable cloud mode

## License

This Docker setup is provided under the same license as the original Bambu Farm project.

## Credits

- Bambu Farm project: https://github.com/TFyre/bambu-farm
