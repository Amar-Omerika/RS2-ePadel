using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class AddedFeedback : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Koris__32E0915F",
                table: "Rezervacije");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1,
                columns: new[] { "BrTelefona", "Ime", "KorisnickoIme", "Prezime" },
                values: new object[] { null, "Admin", "Admin", "Admin" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 2,
                columns: new[] { "BrTelefona", "Email", "Ime", "KorisnickoIme", "Prezime" },
                values: new object[] { null, "amartapia@gmail.com", "Amar", "AmarTapia", "Omerika" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogeId",
                keyValue: 1,
                column: "UlogaId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogeId",
                keyValue: 2,
                column: "UlogaId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 1, 0, 48, 58, 289, DateTimeKind.Local).AddTicks(8966));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 7, 1, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Korisnik_KorisnikID",
                table: "Rezervacije",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Korisnik_KorisnikID",
                table: "Rezervacije");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1,
                columns: new[] { "BrTelefona", "Ime", "KorisnickoIme", "Prezime" },
                values: new object[] { "061-072-172", "Amar", "AmarTapia", "Omerika" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 2,
                columns: new[] { "BrTelefona", "Email", "Ime", "KorisnickoIme", "Prezime" },
                values: new object[] { "064-222-222", "admin@gmail.com", "Admin", "admin", "Admin" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogeId",
                keyValue: 1,
                column: "UlogaId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogeId",
                keyValue: 2,
                column: "UlogaId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 5, 23, 0, 17, 38, 563, DateTimeKind.Local).AddTicks(9218));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 5, 23, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Koris__32E0915F",
                table: "Rezervacije",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");
        }
    }
}
