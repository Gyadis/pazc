<img width="1171" height="674" alt="image" src="https://github.com/user-attachments/assets/a67cdca3-2c1e-4d84-a8e8-65b230e51f07" /># pazc
### Diagram:
<img width="1171" height="674" alt="image" src="https://github.com/user-attachments/assets/cf06a6eb-db07-4144-bc41-1e78f2895038" />


===============================================

### Prepojenie databázových tabuliek s GUI okna

1. **`MainDashboard.fxml` (Hlavné okno)**
   * **Záložka „Servisné požiadavky“:**

     `ServiceRequest` — načítanie zoznamu požiadaviek a ich stavov.

     `User` — zobrazenie mena zákazníka (`customerId`) a priradeného zamestnanca (`employeeId`).

     `Device` — zobrazenie informácií o opravovanom zariadení (`deviceId`).
   * **Záložka „Sklad náhradných dielov“:**

     `SparePart` — načítanie zoznamu dielov, ich množstva (`quantity`) a cien.
   * **Záložka „Zákazníci a zariadenia“:**

     `User` — zobrazenie zoznamu používateľov s rolou `CUSTOMER`.

     `Device` — zobrazenie zariadení priradených k jednotlivým zákazníkom (`userId`).

2. **`RequestEdit.fxml` (Modálne okno detailu požiadavky)**

   `ServiceRequest` — úprava stavu (`status`), diagnostiky (`diagnosis`), priradenia zamestnanca (`employeeId`) a finálnej ceny (`finalPrice`).

   `RequestPart` — pridávanie a odoberanie použitých dielov pre danú požiadavku (`requestId`).

   `SparePart` — načítanie dostupných dielov zo skladu a aktualizácia ich množstva pri použití.

3. **`NewRequest.fxml` (Modálne okno novej požiadavky)**

   `ServiceRequest` — vytvorenie nového záznamu v databáze.

   `User` — výber existujúceho zákazníka (`customerId`) alebo vytvorenie nového.





```mermaid
erDiagram
    USER ||--o{ DEVICE : "owns (1:N)"
    USER ||--o{ SERVICE_REQUEST : "creates/handles (1:N)"
    DEVICE ||--o{ SERVICE_REQUEST : "repaired in (1:N)"
    SERVICE_REQUEST ||--o{ REQUEST_PART : "uses (1:N)"
    SPARE_PART ||--o{ REQUEST_PART : "used in (1:N)"
    SERVICE_REQUEST ||--o{ PAYMENT : "paid by (1:N)"

    USER {
        int id PK
        string firstName
        string lastName
        string phone
        string role
    }
    DEVICE {
        int id PK
        int userId FK
        string manufacturer
        string model
    }
    SERVICE_REQUEST {
        int id PK
        int customerId FK
        int employeeId FK
        int deviceId FK
        string status
        decimal finalPrice
    }
    SPARE_PART {
        int id PK
        string name
        int quantity
        decimal sellingPrice
    }
    REQUEST_PART {
        int id PK
        int requestId FK
        int sparePartId FK
        int quantity
    }
    PAYMENT {
        int id PK
        int requestId FK
        decimal amount
        string paymentMethod
    }
```
   `Device` — výber zariadenia (`deviceId`) priradeného k zákazníkovi alebo zaevidovanie nového zariadenia.

4. **`PaymentDialog.fxml` (Modálne okno platby)**
   
   `Payment` — vytvorenie nového záznamu o platbe (`amount`, `paymentMethod`, `paymentDate`).
