# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ePadel/ePadel.Subscriber/ePadel.Subscriber.csproj", "ePadel.Subscriber/"]
COPY ["ePadel/ePadel.Model/ePadel.Model.csproj", "ePadel.Model/"]
RUN dotnet restore "ePadel.Subscriber/ePadel.Subscriber.csproj"
COPY . .
WORKDIR "/src/ePadel.Subscriber"
RUN dotnet build "ePadel.Subscriber.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ePadel.Subscriber.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ePadel.Subscriber.dll"]
