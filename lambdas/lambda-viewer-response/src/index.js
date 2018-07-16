// lambda-add-cors-to-stellar-toml
// @ts-check

exports.handler = (event, context, callback) => {
  const { request, response } = event.Records[0].cf;
  const headers = response.headers;

  const isStellarToml = /stellar\.toml/.test(request.uri);

  if (isStellarToml) {
    headers["access-control-allow-origin"] = [
      { key: "Access-Control-Allow-Origin", value: "*" }
    ];

    headers["content-type"] = [
      { key: "content-type", value: "application/toml" }
    ];
  }

  return callback(null, response);
};
