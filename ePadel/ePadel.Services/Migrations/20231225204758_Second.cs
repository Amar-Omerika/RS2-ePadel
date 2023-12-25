using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class Second : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PlatiTermins",
                columns: table => new
                {
                    PlatiTerminId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<int>(type: "int", nullable: false),
                    DatumKupovine = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PaymentIntentId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Placena = table.Column<bool>(type: "bit", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    TerminId = table.Column<int>(type: "int", nullable: true),
                    TerenId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PlatiTermins", x => x.PlatiTerminId);
                    table.ForeignKey(
                        name: "FK_PlatiTermins_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_PlatiTermins_Tereni_TerenId",
                        column: x => x.TerenId,
                        principalTable: "Tereni",
                        principalColumn: "TerenID");
                    table.ForeignKey(
                        name: "FK_PlatiTermins_Termini_TerminId",
                        column: x => x.TerminId,
                        principalTable: "Termini",
                        principalColumn: "TerminID");
                });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 25, 21, 47, 56, 989, DateTimeKind.Local).AddTicks(8172));

            migrationBuilder.CreateIndex(
                name: "IX_PlatiTermins_KorisnikId",
                table: "PlatiTermins",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_PlatiTermins_TerenId",
                table: "PlatiTermins",
                column: "TerenId");

            migrationBuilder.CreateIndex(
                name: "IX_PlatiTermins_TerminId",
                table: "PlatiTermins",
                column: "TerminId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PlatiTermins");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 25, 21, 11, 53, 550, DateTimeKind.Local).AddTicks(4422));
        }
    }
}
