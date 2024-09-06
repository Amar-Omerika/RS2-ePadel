using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class finalone : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 9, 6, 13, 0, 46, 234, DateTimeKind.Local).AddTicks(843));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2024, 9, 6, 13, 0, 46, 234, DateTimeKind.Local).AddTicks(889));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2024, 9, 6, 13, 0, 46, 234, DateTimeKind.Local).AddTicks(894));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 26, 22, 12, 12, 433, DateTimeKind.Local).AddTicks(8940));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 26, 22, 12, 12, 433, DateTimeKind.Local).AddTicks(8979));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2024, 8, 26, 22, 12, 12, 433, DateTimeKind.Local).AddTicks(8983));
        }
    }
}
