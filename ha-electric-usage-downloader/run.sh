#!/usr/bin/with-contenv bashio
EXTRACT_DAYS=$(bashio::config 'extract_days')
SMARTHUB_API_URL=$(bashio::config 'smarthub.api_url')
SMARTHUB_USERNAME=$(bashio::config 'smarthub.username')
SMARTHUB_PASSWORD=$(bashio::config 'smarthub.password')
SMARTHUB_ACCOUNT=$(bashio::config 'smarthub.account')
SMARTHUB_SERVICE_LOCATION=$(bashio::config 'smarthub.service_location')
INFLUXDB_HOST=$(bashio::config 'influxdb.host')
INFLUXDB_AUTH_TOKEN=$(bashio::config 'influxdb.auth_token')
INFLUXDB_DATABASE=$(bashio::config 'influxdb.database')
INFLUXDB_INSECURE=$(bashio::config 'influxdb.insecure')

# Define the content with interpolated variables
yaml_content=$(cat <<EOF
extract_days: $EXTRACT_DAYS
smarthub:
  api_url: $SMARTHUB_API_URL
  username: $SMARTHUB_USERNAME
  password: $SMARTHUB_PASSWORD
  account: $SMARTHUB_ACCOUNT
  service_location: $SMARTHUB_SERVICE_LOCATION
influxdb:
  host: $INFLUXDB_HOST
  auth_token: $INFLUXDB_AUTH_TOKEN
  database: $INFLUXDB_DATABASE
  insecure: $INFLUXDB_INSECURE
EOF
)

echo "$yaml_content" > /app/config.yaml

if [ ! -f /app/config.yaml ]; then
  bashio::log.fatal "Configuration not set."
  bashio::log.fatal

  bashio::exit.nok
else
  bashio::log.info "YAML file created successfully."
fi

/app/electric-usage-downloader --config /app/config.yaml

bashio::exit.ok "Electric usage downloaded successfully"