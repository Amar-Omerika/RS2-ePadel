using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class addreporticlass : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Reporti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UkupnaZaradaTerena = table.Column<int>(type: "int", nullable: false),
                    BrojRezervacijeTerena = table.Column<int>(type: "int", nullable: false),
                    UkupanBrojKorisnika = table.Column<int>(type: "int", nullable: false),
                    UkupnaZaradaSistema = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reporti", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reporti_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 6, 12, 4, 56, 425, DateTimeKind.Local).AddTicks(8236));

            migrationBuilder.CreateIndex(
                name: "IX_Reporti_KorisnikId",
                table: "Reporti",
                column: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Reporti");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 5, 14, 45, 19, 340, DateTimeKind.Local).AddTicks(4252));
        }
    }
}
