# Bước 3 — User Journey hiện trạng của Wallet

**Phạm vi:** phân tích hành trình hiện có trong Wallet iOS 5.7.5 bằng các màn hình người dùng đã chụp. Đây chưa phải flow Finaci v2. Finaci chỉ xuất hiện ở bốn dòng mở rộng như cơ hội cải tiến.

## Mục tiêu hành trình

**Use case nghiên cứu Wallet:** một du học sinh Việt Nam ở Hàn Quốc muốn xem tình hình tiền KRW/VND, nhập khoản thu/chi định kỳ và hiểu số dư sắp tới có thể thay đổi ra sao trước khi lập kế hoạch. Đây là persona cụ thể để khảo sát app tham chiếu, không phải toàn bộ tệp mục tiêu global netizens của Finaci.

**Cách dựng thứ tự:** người dùng đã thử các flow riêng. Thứ tự Dashboard → Currency/Sync → Quick Add → Planned Payments → Budgets → Statistics/Outlook được dùng như luồng cơ bản sau đăng nhập để trình bày Journey; đây là luồng phân tích được tái dựng, không phải nhật ký một phiên thao tác liên tục.

![Wallet QANDA-style user journey in Korean: review signals, stage-linked evidence cards, and the matching app screens](wallet-user-journey-board-ko.png)

**Cách đọc:** đường xanh/cam tóm tắt review tích cực/tiêu cực theo từng chặng như mẫu QANDA; đây không phải điểm cảm xúc hay kết quả kiểm thử. Card ghi review liên quan; hàng ảnh bên dưới là màn Wallet người dùng đã chụp. Biểu mẫu W05/W06 đầy đủ trường vẫn được giữ riêng tại `wallet-user-journey-worksheet-ko.png` để đối chiếu với bài trên lớp.

**Phân biệt bằng chứng:** màn hình là quan sát trực tiếp trên Wallet iPhone 5.7.5; review R01–R20 là phản hồi công khai từ nhiều vùng/nền tảng; trải nghiệm “muốn xem Planned Payments trong Outlook thì phải nhập lại vì hai flow không liên thông” do người dùng trực tiếp xác nhận. Review nhiều vùng không đại diện riêng cho du học sinh Việt/Hàn. Cảm xúc tổng hợp theo review là tín hiệu định tính, không phải đo usability. Vì các flow được thử riêng, không suy ra thời lượng, địa điểm hay cảm xúc của một phiên liền mạch.

## Hành trình qua các màn Wallet (mở thành 6 bước theo mẫu W05/W06)

### 1. Mở Dashboard để xem tiền hiện có

**Mục tiêu chặng:** nhìn số dư và nguồn tiền hiện có trước khi lập kế hoạch.

**Màn hình:** Dashboard có account grid và Balance Trend; Settings → Currencies cho thấy KRW là base currency, VND đã được thêm.

![Wallet Dashboard, số dư đã che](screenshots/journey/wallet-dashboard-redacted.jpg)

**Review gắn chặng:** R03 · 5★ · 2026-06-29 · Apple US/iOS muốn thấy rõ “how much money we are starting the month with”. R12 · 4★ · 2024-03-24 · Apple US/iOS khen Dashboard/Statistics và nhập tay nhiều tiền tệ. Đây là một phản hồi về visibility và một phản hồi tích cực; không review nào nói riêng về tài chính du học sinh.

### 2. Cấu hình tiền tệ và chọn cách thêm tài khoản

**Mục tiêu chặng:** giữ các nguồn tiền theo đúng currency và xem có thể nối ngân hàng hay phải nhập tay.

**Màn hình:** KRW base, VND trong Currencies. Bank Sync yêu cầu chọn quốc gia; ảnh của người dùng ghi nhận country list không có Việt Nam và South Korea chỉ hiện ba lựa chọn sau “Show all banks”: BUXFER, HSBC Offshore Banking, Wise. Chưa thử kết nối thật.

![Wallet Currencies](screenshots/journey/wallet-currencies.jpg)

![Danh sách ngân hàng sau khi chọn South Korea](screenshots/journey/wallet-bank-list.jpg)

**Review gắn chặng:** R12 · 4★ · 2024-03-24 · Apple US/iOS nêu thiếu một số ngân hàng; R17 · 5★ · 2026-09-01 · Apple UK/iOS khen hiển thị đa tiền tệ nhưng muốn biết giao dịch ngoại tệ đang chờ và lý do chưa đồng bộ. Đây là phản hồi ở thị trường khác; độ phủ ngân hàng phụ thuộc khu vực và đối tác.

**Điểm thấp theo mẫu review:** các phàn nàn về kết nối/độ chính xác dữ liệu tập trung ở R06 (1★), R09 (1★), R10 (2★), R18 (1★), R20 (2★). Chúng được gắn ở bước tài khoản/đồng bộ như tín hiệu review; khác vùng, một số đã cũ, và chưa chứng minh lỗi còn tồn tại trên iOS 5.7.5.

### 3. Ghi giao dịch bằng Quick Add

**Mục tiêu chặng:** ghi một khoản Expense, Income hoặc Transfer với đúng account, category, currency và ngày.

**Màn hình:** Quick Add có Expense, Income, Transfer và các trường account/category/currency.

![Wallet Quick Add](screenshots/journey/wallet-quick-add.jpg)

**Review gắn chặng:** R11 · 5★ · 2023-03-06 · Apple US/iOS khen biểu đồ nhưng thấy nhập tay tốn thời gian. R13 · 1★ · 2026-08-29 · Google Play US query/Android gọi UI là khó hiểu và nêu vấn đề nhập/tùy chỉnh ngân hàng. R13 khác nền tảng, không xem là lỗi đã xác nhận trên iOS.

### 4. Xem các khoản thu/chi dự kiến trong Planned Payments

**Mục tiêu chặng:** xem khoản đã khai báo, ngày dự kiến và currency trước khi hiểu số dư tương lai.

**Màn hình:** danh sách Planned Payments có các khoản định kỳ và bộ lọc All/Income/Expense.

![Wallet Planned Payments, số tiền đã che](screenshots/journey/wallet-planned-payments-redacted.jpg)

**Review gắn chặng:** R05 · 3★ · 2026-05-13 · Apple US/iOS nói không nhận push cho khoản sắp thanh toán. R19 · 5★ · 2026-03-31 · Apple UK/iOS đề nghị xem lịch thu/chi theo ngày. Đây là phản hồi về nhắc/lịch, không trực tiếp xác nhận trải nghiệm Outlook.

### 5. Đặt ngân sách theo kỳ

**Mục tiêu chặng:** đặt hạn mức chi tiêu và xem mức sử dụng.

**Màn hình:** Budgets cho chọn Weekly, Monthly, Yearly hoặc One-Time và theo dõi theo category. Trong lần trải nghiệm, người dùng báo kỳ tháng mặc định từ ngày 1 đến cuối tháng và không chỉnh được ngày bắt đầu; bắt đầu sử dụng giữa tháng không khớp chu kỳ mong muốn. Đây là trải nghiệm trực tiếp, nhưng chưa có review trong mẫu nói cụ thể về ngày bắt đầu ngân sách.

![Wallet Budgets, số liệu đã che](screenshots/journey/wallet-budget-redacted.jpg)

**Review gắn chặng:** R16 · 5★ · 2026-08-24 · Apple UK/iOS khen app linh hoạt cho ngân sách và nhiều nguồn thu. R15 · 5★ · 2026-04-01 · Google Play US/Android nói có quá nhiều lựa chọn khiến một số việc đơn giản rườm rà; khác nền tảng và không nhắc riêng chu kỳ ngân sách.

### 6. Mở Statistics/Outlook để hiểu số dư tương lai

**Mục tiêu chặng:** sau khi nhập khoản định kỳ, đọc được tình hình tiền ở một mốc tương lai để tự quyết định kế hoạch.

**Màn hình:** Statistics có các thẻ Balance, Spending, Cash Flow, Outlook. Người dùng xác nhận Planned Payments được theo dõi riêng; muốn xem khoản đó trong Outlook thì phải nhập lại vì hai flow không liên thông. Ảnh thẻ OUTLOOK ₩0.00 là bằng chứng màn hình tại thời điểm chụp, không tự nó giải thích cơ chế dữ liệu.

![Wallet Statistics, số tiền đã che](screenshots/journey/wallet-statistics-redacted.jpg)

**Review gắn chặng:** R11 · 5★ · 2023-03-06 · Apple US/iOS khen biểu đồ/so sánh thu chi; R03 · 5★ · 2026-06-29 · Apple US/iOS muốn thấy rõ số dư đầu tháng. Đây là tín hiệu lân cận về cách hiểu dòng tiền; **R01–R20 không có review trực tiếp về Outlook hoặc mô phỏng từ khoản định kỳ**.

**Điểm rối cá nhân đã xác nhận:** dữ liệu Planned Payments không xuất hiện trong Outlook; muốn xem ở đó phải nhập lại. Đây là trải nghiệm người dùng, không được gán thành kết luận của review.

**Kết thúc tác vụ hiện trạng:** trong các màn Wallet đã khảo sát không thấy Goals; Wallet Help Center ghi Goals chưa khả dụng trên iOS. Vì vậy hành trình hiện tại không hoàn tất việc lập mục tiêu có hạn ngay trong Wallet iOS. Đây là khoảng trống chức năng theo nền tảng, không phải lỗi giao diện được suy ra chỉ từ ảnh More.

## Đường cảm xúc và review low point

- **Low point theo mẫu review:** bước 2, account linking/sync/data accuracy, nơi có năm review 1–2★ liên quan lỗi kết nối, giao dịch trùng hoặc sai số dư. Đây là tín hiệu từ mẫu đa vùng/nền tảng, không khẳng định trải nghiệm cá nhân của người dùng hay lỗi hiện hành.
- **Low point trong trải nghiệm người dùng:** bước 6, Planned Payments và Outlook không liên thông; người dùng phải nhập khoản lần nữa để dùng ở Outlook. Đây là lời kể trực tiếp; không có review trực tiếp tương ứng.
- Không gộp hai nguồn trên thành một đường cong cảm xúc có vẻ như đã đo bằng khảo sát. Board chú giải riêng để tránh gây hiểu nhầm.

## Bốn dòng mở rộng theo mẫu W05/W06 — theo từng bước; hướng v2, không phải màn Wallet

Mẫu W05/W06 yêu cầu bảng theo bước: **단계 · 위치 · 사용 기기 · AI 기회 · 어긴 원칙 · 필요 데이터 · 감정 -2~+2**. Bảng dưới giữ dữ liệu cá nhân và suy luận riêng; địa điểm thực tế chưa được ghi nhận; đây không phải biến gây trở ngại chính của tác vụ này. P07 chính/P06 phụ ở bước 6 đã được người dùng chọn; các nguyên tắc ở bước khác là tiêu chí phân tích, không phải mọi lỗi Wallet đã được xác nhận.

| Bước | Vị trí | Thiết bị | Cơ hội AI / Finaci v2 | Nguyên tắc cần kiểm tra | Dữ liệu cần | Cảm xúc nháp* |
|---|---|---|---|---|---|---:|
| 1. Dashboard | Chưa ghi nhận | iPhone · Wallet 5.7.5 | Giải thích số dư nhiều currency trong một ngữ cảnh | P01: phân biệt số dư hiện tại/quy đổi | Số dư theo account, currency, timestamp và giả định tỷ giá | **0 (ước lượng AI đã được người dùng chấp thuận; thiếu nhận xét riêng)** |
| 2. Currency/Sync | Chưa ghi nhận | iPhone · Wallet 5.7.5 | Hướng dẫn nhập tay khi không có kết nối phù hợp; AI không thay thế partnership | P09: thông báo/khôi phục; chỉ xem xét v2 | Quốc gia, nguồn tiền, currency, phương thức nhập | **-1 (AI ước lượng từ độ phủ Việt Nam/Hàn Quốc đã quan sát)** |
| 3. Quick Add | Chưa ghi nhận | iPhone · Wallet 5.7.5 | Chuyển lời nói/tự nhiên thành nháp giao dịch | P07: hiệu quả nhập liệu | Số tiền, currency, loại giao dịch, ngày, category | **0 (ước lượng AI đã được người dùng chấp thuận; thiếu nhận xét riêng)** |
| 4. Planned Payments | Chưa ghi nhận | iPhone · Wallet 5.7.5 | Giải thích dòng tiền dự kiến từ khoản lặp đã nhập | P01: phân biệt khoản dự kiến với thực tế | Khoản lặp, số tiền, kỳ, ngày đến hạn, currency | **0 (AI ước lượng; khó khăn được kể nằm ở Outlook)** |
| 5. Budgets | Chưa ghi nhận | iPhone · Wallet 5.7.5 | Giải thích mục tiêu cần dành bao nhiêu theo thời hạn | P06: giúp nhận biết thay vì tự nhớ/tính | Hạn mức, thời kỳ, ngày bắt đầu, chi thực tế | **-1 (AI ước lượng từ việc không chỉnh được ngày bắt đầu tháng)** |
| 6. Statistics/Outlook | Chưa ghi nhận | iPhone 14 Pro Max · Wallet 5.7.5 | So sánh kịch bản lương trễ bằng phản hồi soạn sẵn | P07: tránh nhập lặp; P06 phụ: khoản đã có cần được nhận biết ở Outlook | Số dư, khoản đã biết, mốc dự báo, giả định tỷ giá, kịch bản | **-2 (AI ước lượng từ khó hiểu, phải tự nối/tính và nhập lại)** |

\* Dãy điểm trên là **ước lượng của AI từ bằng chứng trải nghiệm người dùng đã kể**, theo yêu cầu người dùng cho AI chấm nháp; người dùng đã xem và đồng ý giữ bản nháp. Đây không phải câu trả lời cảm xúc trực tiếp hay tự chấm của người dùng. Các điểm 0 là thiếu nhận xét cụ thể, không có nghĩa người dùng đã nói “bình thường”. Không dùng review stars thay cho cảm xúc cá nhân. Low point theo cụm review là bước 2; khó khăn do người dùng trực tiếp nêu nằm ở bước 6. Hai nguồn được giữ riêng.

## Nguồn và mức chắc chắn

- **Quan sát trực tiếp:** 21 ảnh Wallet iPhone 5.7.5 do người dùng gửi ngày 2026-10-28; người dùng đã thử hầu hết flow riêng. Màn hình cho thấy giao diện, không chứng minh mọi hành vi; model là iPhone 14 Pro Max, iOS mới nhất tại thời điểm chụp nhưng chưa ghi số phiên bản.
- **Trải nghiệm do người dùng kể:** Planned Payments phải nhập lại để dùng ở Outlook; kỳ ngân sách tháng không chỉnh được ngày bắt đầu.
- **Review công khai:** R01–R20 trong `docs/wallet-review-notes.md`, mẫu nhiều khu vực và nền tảng; ghi rõ ngày/sao/nguồn.
- **AI/Finaci:** chỉ là cơ hội mở rộng ở bốn dòng cuối. Không có concept screen Finaci nào nằm trong hành trình Wallet hiện trạng.

## Căn cứ khóa cách làm

W05/W06 LAB A yêu cầu 6 bước trở lên và bảng mở rộng theo bước; Fishbone/5 Why phải bắt đầu từ một bước low point. W07 ①-3 yêu cầu gắn review theo bước và nêu low point dựa trên lượng review phàn nàn. Vì vậy tài liệu này lấy Wallet hiện trạng; ý tưởng Finaci chỉ xuất hiện ở các hàng mở rộng và phần summary/v2. Bản hiện tại ghi riêng low point theo review (bước 2) và khó khăn người dùng trực tiếp nêu (bước 6); Fishbone đang nối với bước 6 theo lời kể trực tiếp. Quyết định đã chốt ở L035 và tự luận 1: giữ bước 2 làm low point theo review, chọn bước 6 cho Fishbone vì đây là khó khăn tác vụ trực tiếp, phù hợp sửa ở mức UI. Không đổi review low point thành Outlook để làm đẹp mạch kể. L046 ghi nhận việc hoàn thiện diễn giải này.
