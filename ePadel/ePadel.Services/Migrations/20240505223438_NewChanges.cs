using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class NewChanges : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2024, 5, 6, 0, 34, 37, 389, DateTimeKind.Local).AddTicks(1788));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 5, 6, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 25, 21, 47, 56, 989, DateTimeKind.Local).AddTicks(8172));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2023, 12, 25, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
