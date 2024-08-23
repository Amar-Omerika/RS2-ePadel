# RS2-ePadel

Seminarski rad iz predmeta Razvoj softvera II

ePadel je aplikacija za online rezervaciju i upravljanje terminima za padel. Aplikacija se sastoji od desktop dijela koji je namijenjen za administratore, te mobilnog dijela koji je namijenjen krajnjim korisnicima. Desktop dio služi za upravljanje terenima, korisnicima, kao i za pracenje statistike sistema, dok na mobilnom dijelu krajnji korisnici mogu pregledati dostupne termine, rezervirati ih, i online plaćati.

## Kredencijali

### Desktop aplikacija:

- **Korisničko ime:** TestAdmin
- **Lozinka:** password123

### Mobilna aplikacija:

- **Korisničko ime:** UserGuest
- **Lozinka:** userGuest123

### Testni podaci za Stripe:

- **Broj kartice:** 4242 4242 4242 4242
- **Datum:** Možete unijeti bilo koji datum u budućnosti
- **CVC:** Možete unijeti bilo koja 3 broja

## Pokretanje aplikacija

1.Nakon kloniranja repozitorija, otvoriti komandnu liniju, navigirati do foldera gdje je kloniran repozitorij te pokrenuti dockerizovani API i bazu komandom:docker-compose up --build


2.Mobilna aplikacija se pokrece otvaranjem foldera epadel_mobile u VSCode-u, te se pokrenu sljedece komande u terminalu: 
flutter pub get - za dobavljanje dependencies flutter run - za pokretanje aplikacije

3.Desktop aplikacija se pokrece otvaranjem foldera epadel_admin u VSCode-u, te se pokrenu sljedece komande u terminalu:
flutter pub get - za dobavljanje dependencies flutter run - za pokretanje aplikacije
