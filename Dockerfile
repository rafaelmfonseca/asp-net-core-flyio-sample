# Use the offical dotnet core image to build the app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR ./app

# Copy code to the image
COPY [".", "."]

# Restore dependencies
RUN dotnet restore
# Build the app
RUN dotnet publish -c Release -o release

# Start a new dotnet core image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0 as runtime
WORKDIR ./app

# Copy the app from the build to the runtime image
COPY --from=build /app/release ./

EXPOSE 8080
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
ENTRYPOINT [ "dotnet", "asp-net-core-flyio-sample.dll"]