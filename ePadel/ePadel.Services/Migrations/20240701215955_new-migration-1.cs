using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePadel.Services.Migrations
{
    public partial class newmigration1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tereni_Ocjene_OcjeneId",
                table: "Tereni");

            migrationBuilder.DropIndex(
                name: "IX_Tereni_OcjeneId",
                table: "Tereni");

            migrationBuilder.AddColumn<int>(
                name: "TerenId",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 1, 23, 59, 54, 129, DateTimeKind.Local).AddTicks(1105));

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_TerenId",
                table: "Ocjene",
                column: "TerenId");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Tereni_TerenId",
                table: "Ocjene",
                column: "TerenId",
                principalTable: "Tereni",
                principalColumn: "TerenID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Tereni_TerenId",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_TerenId",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "TerenId",
                table: "Ocjene");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2024, 7, 1, 23, 15, 3, 103, DateTimeKind.Local).AddTicks(4381));

            migrationBuilder.CreateIndex(
                name: "IX_Tereni_OcjeneId",
                table: "Tereni",
                column: "OcjeneId");

            migrationBuilder.AddForeignKey(
                name: "FK_Tereni_Ocjene_OcjeneId",
                table: "Tereni",
                column: "OcjeneId",
                principalTable: "Ocjene",
                principalColumn: "OcjeneId");
        }
    }
}
