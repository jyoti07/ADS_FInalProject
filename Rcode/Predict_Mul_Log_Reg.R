install.packages("RCurl")
install.packages("rjson")

library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()


req = list(
  
  Inputs = list(
    
    
    "input1" = list(
      "ColumnNames" = list("DATE", "TIME", "STREETNAME"),
      "Values" = list( list( "4/30/2016", "21:00", "TREMONT ST" ),  list( "5/2/2016", "8:00", "WESTLAND AVE" )  )
    )                ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "tq8Bi7E93dxhU2FIg26yCys3+TbdBkZWRho/0J0Mnre6JlAQUaAXk0D1xwwfyCeeMH2GUBKKkMUIjW3U79MsPw==" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/7a42d134b6c64c51b80b0f36259de4c0/services/0856063ef4d5485281a494ad9e05efe2/execute?api-version=2.0&details=true",
            httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
            postfields=body,
            writefunction = h$update,
            headerfunction = hdr$update,
            verbose = TRUE
)

headers = hdr$value()
httpStatus = headers["status"]
if (httpStatus >= 400)
{
  print(paste("The request failed with status code:", httpStatus, sep=" "))
  
  # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
  print(headers)
}

print("Result:")
result = h$value()
print(fromJSON(result))

