FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
COPY ./app/.csproj /app
RUN dotnet add package Microsoft.EntityFrameworkCore && \
    dotnet add package Microsoft.EntityFrameworkCore.SqlServer && \
    dotnet add package Microsoft.EntityFrameworkCore.Design

COPY ./app/* /app
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "app.dll"]
CMD [""]