using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore;

namespace ePadel.Services.Database
{
    public partial class IB190069_ePadelContext : DbContext
    {
        public IB190069_ePadelContext()
        {
        }

        public IB190069_ePadelContext(DbContextOptions<IB190069_ePadelContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Korisnik> Korisniks { get; set; } = null!;
        public virtual DbSet<KorisnikUloge> KorisnikUloges { get; set; } = null!;
        public virtual DbSet<Rezervacije> Rezervacijes { get; set; } = null!;
        public virtual DbSet<Tereni> Terenis { get; set; } = null!;
        public virtual DbSet<TipTerena> TipTerenas { get; set; } = null!;
        public virtual DbSet<Uloga> Ulogas { get; set; } = null!;
        public virtual DbSet<PlatiTermin> PlatiTermins { get; set; } = null!;
        public virtual DbSet<Feedback> Feedbacks { get; set; } = null!;
        public virtual DbSet<Obavijesti> Obavijestis { get; set; } = null!;
        public virtual DbSet<Partneri> Partneris { get; set; } = null!;



        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=DESKTOP-94KPL6Q\\VISIOT;Database=IB190069_ePadel;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Korisnik>(entity =>
            {
                entity.ToTable("Korisnik");
                entity.Property(e => e.Spol).HasConversion<int>();
            });

            modelBuilder.Entity<KorisnikUloge>(entity =>
            {
                entity.ToTable("KorisnikUloge");

                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.KorisnikUloges)
                    .HasForeignKey(d => d.KorisnikId)
                    .HasConstraintName("FK__KorisnikU__Koris__29572725");

                entity.HasOne(d => d.Uloga)
                    .WithMany(p => p.KorisnikUloges)
                    .HasForeignKey(d => d.UlogaId)
                    .HasConstraintName("FK__KorisnikU__Uloga__286302EC");
            });


            modelBuilder.Entity<Rezervacije>(entity =>
            {
                entity.HasKey(e => e.RezervacijaId)
                    .HasName("PK__Rezervac__CABA44FDC98EB446");

                entity.ToTable("Rezervacije");

                entity.Property(e => e.RezervacijaId).HasColumnName("RezervacijaID");

                entity.Property(e => e.DatumRezervacije).HasColumnType("nvarchar(255)");

                entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

                entity.Property(e => e.TerenId).HasColumnName("TerenID");

            });

            modelBuilder.Entity<Tereni>(entity =>
            {
                entity.HasKey(e => e.TerenId)
                    .HasName("PK__Tereni__203D9C3BFA9E8DA5");

                entity.ToTable("Tereni");

                entity.Property(e => e.TerenId).HasColumnName("TerenID");

                entity.Property(e => e.Cijena).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.TipTerenaId).HasColumnName("TipTerenaID");
 
            });

            modelBuilder.Entity<TipTerena>(entity =>
            {
                entity.ToTable("TipTerena");

                entity.Property(e => e.TipTerenaId).HasColumnName("TipTerenaID");
            });

            modelBuilder.Entity<Uloga>(entity =>
            {
                entity.ToTable("Uloga");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
