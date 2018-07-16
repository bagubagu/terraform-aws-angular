// lambda-origin-request
// @ts-check

const path = require("path");
const { STATUS_CODES } = require("http");

exports.handler = (event, context, callback) => {
  const { request } = event.Records[0].cf;
  const parsedPath = path.parse(request.uri);

  const isAsset = /assets/.test(request.uri);
  const isStellarToml = /stellar\.toml/.test(request.uri);

  if (isStellarToml) {
    return callback(null, { ...request, uri: "/.well-known/stellar.toml" });
  }

  if (isAsset) {
    return callback(null, request);
  }

  if (parsedPath.ext === "") {
    return callback(null, { ...request, uri: "/index.html" });
  }

  return callback(null, request);
};

function redirectTo(uri) {
  return {
    status: "301",
    statusDescription: STATUS_CODES["301"],
    headers: {
      location: [{ key: "Location", value: uri }]
    }
  };
}
