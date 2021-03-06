FROM microsoft/dotnet:1.0.5-sdk

COPY . /app
WORKDIR /app
RUN dotnet restore -s https://dotnet.myget.org/F/aspnetcore-dev/api/v3/index.json -s https://api.nuget.org/v3/index.json

WORKDIR /app/ASC.Tests
RUN dotnet test

WORKDIR /app
RUN dotnet build

EXPOSE 5000/tcp
ENV ASPNETCORE_URLS http://*:5000
ENV ASPNETCORE_ENVIRONMENT Production

WORKDIR /app/ASC.Web
ENTRYPOINT dotnet run