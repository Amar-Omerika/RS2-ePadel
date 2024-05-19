using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class updatedDbContextForTerminModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CijenaPopusta",
                table: "Tereni",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Lokacija",
                table: "Tereni",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Popust",
                table: "Tereni",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2024, 5, 19, 18, 57, 34, 637, DateTimeKind.Local).AddTicks(4506));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CijenaPopusta",
                table: "Tereni");

            migrationBuilder.DropColumn(
                name: "Lokacija",
                table: "Tereni");

            migrationBuilder.DropColumn(
                name: "Popust",
                table: "Tereni");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2024, 5, 19, 18, 54, 24, 866, DateTimeKind.Local).AddTicks(4957));
        }
    }
}
