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
        public virtual DbSet<KorisničkePreferencije> KorisničkePreferencijes { get; set; } = null!;
        public virtual DbSet<RezervacijaStatusi> RezervacijaStatusis { get; set; } = null!;
        public virtual DbSet<Rezervacije> Rezervacijes { get; set; } = null!;
        public virtual DbSet<Tereni> Terenis { get; set; } = null!;
        public virtual DbSet<TerminStatusi> TerminStatusis { get; set; } = null!;
        public virtual DbSet<Termini> Terminis { get; set; } = null!;
        public virtual DbSet<TipTerena> TipTerenas { get; set; } = null!;
        public virtual DbSet<Uloga> Ulogas { get; set; } = null!;
        public virtual DbSet<PlatiTermin> PlatiTermins { get; set; } = null!;
        public virtual DbSet<Feedback> Feedbacks { get; set; } = null!;



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

            modelBuilder.Entity<KorisničkePreferencije>(entity =>
            {
                entity.HasKey(e => e.KorisnikId)
                    .HasName("PK__Korisnič__80B06D61102DA75F");

                entity.ToTable("KorisničkePreferencije");

                entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

                entity.Property(e => e.MaksimalnaCena).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.TipTerenaId).HasColumnName("TipTerenaID");

                entity.HasOne(d => d.TipTerena)
                    .WithMany(p => p.KorisničkePreferencijes)
                    .HasForeignKey(d => d.TipTerenaId)
                    .HasConstraintName("FK__Korisničk__TipTe__412EB0B6");
            });



           

            modelBuilder.Entity<RezervacijaStatusi>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("PK__Rezervac__C8EE20437885A79B");

                entity.ToTable("RezervacijaStatusi");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");
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

                entity.Property(e => e.TerminId).HasColumnName("TerminID");

                entity.HasOne(d => d.Teren)
                    .WithMany(p => p.Rezervacijes)
                    .HasForeignKey(d => d.TerenId)
                    .HasConstraintName("FK__Rezervaci__Teren__33D4B598");

                entity.HasOne(d => d.Termin)
                    .WithMany(p => p.Rezervacijes)
                    .HasForeignKey(d => d.TerminId)
                    .HasConstraintName("FK__Rezervaci__Termi__34C8D9D1");
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

            modelBuilder.Entity<TerminStatusi>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("PK__TerminSt__C8EE20434FDF98E6");

                entity.ToTable("TerminStatusi");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");
            });

            modelBuilder.Entity<Termini>(entity =>
            {
                entity.HasKey(e => e.TerminId)
                    .HasName("PK__Termini__42126CB556013045");

                entity.ToTable("Termini");

                entity.Property(e => e.TerminId).HasColumnName("TerminID");

                entity.Property(e => e.Datum).HasColumnType("date");
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
