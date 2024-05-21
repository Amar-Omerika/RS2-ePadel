using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class RemoveOcjeneModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Ocijene");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2024, 5, 21, 22, 5, 15, 521, DateTimeKind.Local).AddTicks(465));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 5, 21, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Ocijene",
                columns: table => new
                {
                    OcijeneID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RezervacijaID = table.Column<int>(type: "int", nullable: true),
                    Komentar = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Ocijena = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocijene", x => x.OcijeneID);
                    table.ForeignKey(
                        name: "FK__Ocijene__Rezerva__3A81B327",
                        column: x => x.RezervacijaID,
                        principalTable: "Rezervacije",
                        principalColumn: "RezervacijaID");
                });

            migrationBuilder.InsertData(
                table: "Ocijene",
                columns: new[] { "OcijeneID", "Komentar", "Ocijena", "RezervacijaID" },
                values: new object[] { 1, "Ocijena 5", 5, 1 });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2024, 5, 19, 18, 57, 34, 637, DateTimeKind.Local).AddTicks(4506));

            migrationBuilder.UpdateData(
                table: "Termini",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "Datum",
                value: new DateTime(2024, 5, 19, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.CreateIndex(
                name: "IX_Ocijene_RezervacijaID",
                table: "Ocijene",
                column: "RezervacijaID");
        }
    }
}
