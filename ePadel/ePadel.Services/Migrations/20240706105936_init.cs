using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "PaymentMethod",
                table: "Rezervacije",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                columns: new[] { "BrojReketa", "Cijena", "DatumKreiranja", "DatumRezervacije", "PaymentMethod", "PotrebnaReketa", "RezervacijaStatus", "VrijemeRezervacije" },
                values: new object[] { 0, 20, new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2846), "2024-09-09", "cash", "Ne", null, "12:00-13:00" });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "RezervacijaID", "BrojReketa", "Cijena", "DatumKreiranja", "DatumRezervacije", "KorisnikID", "PaymentMethod", "PotrebnaReketa", "RezervacijaStatus", "TerenID", "VrijemeRezervacije" },
                values: new object[] { 2, 0, 30, new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2914), "2024-09-10", 2, "cash", "Ne", null, 2, "12:00-13:00" });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "RezervacijaID", "BrojReketa", "Cijena", "DatumKreiranja", "DatumRezervacije", "KorisnikID", "PaymentMethod", "PotrebnaReketa", "RezervacijaStatus", "TerenID", "VrijemeRezervacije" },
                values: new object[] { 3, 0, 30, new DateTime(2024, 7, 6, 12, 59, 35, 495, DateTimeKind.Local).AddTicks(2923), "2024-09-11", 2, "cash", "Ne", null, 3, "12:00-13:00" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 3);

            migrationBuilder.DropColumn(
                name: "PaymentMethod",
                table: "Rezervacije");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                columns: new[] { "BrojReketa", "Cijena", "DatumKreiranja", "DatumRezervacije", "PotrebnaReketa", "RezervacijaStatus", "VrijemeRezervacije" },
                values: new object[] { null, null, new DateTime(2024, 7, 6, 12, 4, 56, 425, DateTimeKind.Local).AddTicks(8236), null, null, "Aktivna", null });
        }
    }
}
