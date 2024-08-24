using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class addlocationfieldtorezervacije : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Lokacija",
                table: "Rezervacije",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 21, 23, 26, 46, 595, DateTimeKind.Local).AddTicks(9291));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 21, 23, 26, 46, 595, DateTimeKind.Local).AddTicks(9334));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 21, 23, 26, 46, 595, DateTimeKind.Local).AddTicks(9338));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Lokacija",
                table: "Rezervacije");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2846));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2914));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2923));
        }
    }
}
