# Build stage: use the full SDK to compile and publish
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore TheSevens.csproj
RUN dotnet publish TheSevens.csproj -c Release -o /app/publish

# Runtime stage: smaller image with just the ASP.NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TheSevens.dll"]
