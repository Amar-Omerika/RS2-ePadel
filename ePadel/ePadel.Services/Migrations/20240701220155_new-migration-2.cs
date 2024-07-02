using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class newmigration2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "OcjeneId",
                table: "Tereni");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 2, 0, 1, 54, 477, DateTimeKind.Local).AddTicks(7058));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 7, 2, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OcjeneId",
                table: "Tereni",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 1, 23, 59, 54, 129, DateTimeKind.Local).AddTicks(1105));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 7, 1, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
