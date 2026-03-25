exports.handler = async (event, context) => {
  console.log("Hello Spacelift!");
  console.log("Event:", JSON.stringify(event, null, 2));
  console.log("Execution timestamp:", new Date().toISOString());
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello Spacelift!" })
  };
};
