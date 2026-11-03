# pazc
### Diagram:
<img width="1036" height="768" alt="photo_2026-11-03_20-10-13" src="https://github.com/user-attachments/assets/1bc100b5-71cd-40ee-8aa1-512dad87537f" />

===============================================

### Prepojenie databázových tabuliek s GUI okna

1. **`MainDashboard.fxml` (Hlavné okno)**
   **Záložka „Servisné požiadavky“:**
     `ServiceRequest` — načítanie zoznamu požiadaviek a ich stavov.
     `User` — zobrazenie mena zákazníka (`customerId`) a priradeného zamestnanca (`employeeId`).
     `Device` — zobrazenie informácií o opravovanom zariadení (`deviceId`).
   **Záložka „Sklad náhradných dielov“:**
     `SparePart` — načítanie zoznamu dielov, ich množstva (`quantity`) a cien.
   **Záložka „Zákazníci a zariadenia“:**
     `User` — zobrazenie zoznamu používateľov s rolou `CUSTOMER`.
     `Device` — zobrazenie zariadení priradených k jednotlivým zákazníkom (`userId`).

2. **`RequestEdit.fxml` (Modálne okno detailu požiadavky)**
     `ServiceRequest` — úprava stavu (`status`), diagnostiky (`diagnosis`), priradenia zamestnanca (`employeeId`) a finálnej ceny (`finalPrice`).
     `RequestPart` — pridávanie a odoberanie použitých dielov pre danú požiadavku (`requestId`).
     `SparePart` — načítanie dostupných dielov zo skladu a aktualizácia ich množstva pri použití.

3. **`NewRequest.fxml` (Modálne okno novej požiadavky)**
     `ServiceRequest` — vytvorenie nového záznamu v databáze.
     `User` — výber existujúceho zákazníka (`customerId`) alebo vytvorenie nového.
     `Device` — výber zariadenia (`deviceId`) priradeného k zákazníkovi alebo zaevidovanie nového zariadenia.

4. **`PaymentDialog.fxml` (Modálne okno platby)**
     `Payment` — vytvorenie nového záznamu o platbe (`amount`, `paymentMethod`, `paymentDate`).
     `ServiceRequest` — načítanie výslednej sumy požiadavky (`finalPrice`) a zmena stavu požiadavky po zaplatení.
