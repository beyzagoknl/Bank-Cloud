exports.handler = async (event) => {
  console.log("Request received", JSON.stringify(event));

  return {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      status: "ok",
      message: "NovaBank API is healthy",
      timestamp: new Date().toISOString()
    })
  };
};