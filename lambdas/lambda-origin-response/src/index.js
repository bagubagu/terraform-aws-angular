// origin-response
// @ts-check

exports.handler = (event, context, callback) => {
  const { request, response } = event.Records[0].cf;
  const headers = response.headers;

  if (response.status >= 400 && response.status <= 599) {
    const redirect_path = `/index.html`;

    response.status = 302;
    response.statusDescription = "Found";

    /* Drop the body, as it is not required for redirects */
    response.body = "";
    response.headers["location"] = [{ key: "Location", value: redirect_path }];
  }

  return callback(null, response);
};
