using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class UpdateKorisnikFields : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DominantnaRuka",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Spol",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 20, 21, 18, 18, 807, DateTimeKind.Local).AddTicks(4015));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2023, 12, 20, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DominantnaRuka",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "Spol",
                table: "Korisnik");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 19, 14, 35, 5, 432, DateTimeKind.Local).AddTicks(7618));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2023, 12, 19, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
