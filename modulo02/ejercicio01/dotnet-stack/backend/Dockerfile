FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base
WORKDIR /app

FROM base AS builder
COPY ["*.csproj","*.csproj.user","./"]
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out

FROM base AS runtime
COPY --from=builder /app/out .
ARG BUILD_CONFIGURATION=Debug
ENV ASPNETCORE_ENVIRONMENT=Development
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "backend.dll"]
