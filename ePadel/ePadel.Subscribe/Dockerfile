# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ePadel.Subscribe/ePadel.Subscribe.csproj", "ePadel.Subscribe/"]
COPY ["ePadel.Model/ePadel.Model.csproj", "ePadel.Model/"]
RUN dotnet restore "ePadel.Subscribe/ePadel.Subscribe.csproj"
COPY . .
WORKDIR "/src/ePadel.Subscribe"
RUN dotnet build "ePadel.Subscribe.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ePadel.Subscribe.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ePadel.Subscribe.dll"]
