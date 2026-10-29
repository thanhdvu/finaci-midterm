# Wallet 5.7.5 — bản tổng hợp khảo sát app tham chiếu

**Tổng hợp hiện trạng để trình bày với giảng viên · cập nhật 29/10/2026**  
Ngày quan sát: **28/10/2026 (KST)** · Thiết bị: iPhone · Phiên bản app theo xác nhận của người dùng: **5.7.5**  
Model: **iPhone 14 Pro Max**. Người dùng cho biết iOS đang ở bản mới nhất; số phiên bản cụ thể chưa ghi nhận.

## 1. Mục đích và phạm vi

Wallet by BudgetBakers được chọn làm app tham chiếu cho finaci. Việc khảo sát tập trung vào cách Wallet giúp người dùng theo dõi nhiều nguồn tiền, ghi giao dịch, lập kế hoạch dòng tiền, và kết nối tài khoản. Các ảnh là ảnh chụp ứng dụng thật trên iPhone của sinh viên; chưa nhập thông tin đăng nhập ngân hàng và chưa thử kết nối thật.

Finaci hướng tới global netizens quản lý tiền qua biên giới và nhiều currency. Prototype dùng một use case cụ thể: du học sinh Việt Nam tại Hàn Quốc nhận thu nhập ở Việt Nam, lương làm thêm tại Hàn Quốc và tiền gia đình gửi. Case này giúp quan sát flow Wallet trong tình huống thực tế; không giới hạn tệp sản phẩm ở nhóm sinh viên này và không chứng minh mọi global netizens gặp cùng vấn đề.

## 2. Các flow đã khảo sát

| Flow | Đường đi / nội dung quan sát | Bằng chứng và điều có thể kết luận |
|---|---|---|
| Dashboard và tài khoản | Dashboard hiển thị lưới tài khoản, Balance Trend, Top Expenses và Last Records; có thêm tài khoản và Settings. | Ảnh `dashboard*.jpg`. Thấy các tài khoản/Widget được tổ chức tại trang tổng quan; không kết luận mức dễ hiểu chỉ từ ảnh. |
| Đa tiền tệ | Settings → Currencies; KRW là Base currency, VND nằm trong danh sách; cập nhật tỷ giá đang tắt tại thời điểm chụp. Dashboard hiển thị tài khoản theo đơn vị tiền riêng. | `currencies.jpg`, `dashboard2.jpg`. Wallet có cấu hình KRW/VND; ảnh chưa chứng minh tỷ giá áp dụng hay cách quy đổi tổng số dư. |
| Thêm giao dịch / mẫu | Add Record cho Expense, Income, Transfer; có Account, Category, Date & Time, Amount/Currency và chi tiết. Templates có tên, account, category, amount, type, currency, payee và các trường khác. | `quick add*.jpg`. Ghi nhận thông tin và lựa chọn được yêu cầu; chưa đo số bước hoàn thành nhiệm vụ hay thời gian thao tác. |
| Khoản dự kiến | Planning → Planned Payments; danh sách có các khoản thu/chi định kỳ và ngày kế tiếp. Form thêm khoản có Income/Expense, tên, tài khoản, danh mục, xác nhận. | `planning&budgeting2.jpg`, `planning&budgeting3.jpg`. Có thể ghi nhận thu/chi dự kiến và định kỳ; ảnh không chứng minh Wallet tự thực hiện giao dịch. |
| Ngân sách | Planning → Budgets; có chọn kỳ (weekly/monthly/yearly/one-time), mức chi theo danh mục, tổng đã dùng và còn lại. | `planning&budgeting.jpg`, `planning&budgeting1.jpg`, `planning&budgeting4.jpg`. Đây là công cụ giới hạn/theo dõi chi tiêu, khác với mục tiêu tích lũy có số tiền và ngày cần đạt. |
| Statistics / Outlook | Có Balance, Spending, Cash Flow, Outlook, Credit và Reports–Income. Người dùng báo Planned Payments đang theo dõi riêng; muốn thấy số đó trong Outlook thì phải nhập lại vì hai phần không liên thông. | `stat.jpg` và trải nghiệm trực tiếp. Đây là friction thao tác của một người dùng đã xác nhận; chưa phải kiểm thử usability có mẫu hoặc kết luận chung cho mọi người dùng. |
| Bank Sync | Tạo Checking Account → các cách theo dõi gồm Bank Sync (Recommended), Apple Pay Integration, Manual Entry, Import Files; Bank Sync yêu cầu chọn quốc gia rồi chọn tổ chức. | `sync bank.jpg`, `sync bank (3).jpg`, `sync bank (2).jpg`. App đặt sync làm lựa chọn nổi bật nhưng vẫn có nhập tay. |
| Lựa chọn kết nối Hàn Quốc | Sau “Show all banks” với South Korea, màn hình hiển thị BUXFER (Checking Account), HSBC Offshore Banking (Checking Account), Wise / former Transferwise (Checking Account, Savings Account). | `all banks ở hàn.jpg`. Ảnh xác nhận ba lựa chọn hiển thị trong lần khảo sát. Không gọi cả ba là ngân hàng nội địa Hàn phổ biến; ảnh không xác nhận khả năng kết nối thành công. |
| Mục tiêu tiết kiệm | Không tìm thấy Goals trong các flow iPhone đã thử. Wallet Help Center mô tả tạo Goals trên Android và ghi iOS “Not available”. | Ảnh `more.jpg` + [Wallet Help Center — Setting up Goals](https://support.budgetbakers.com/hc/en-us/articles/7181571852690-Setting-up-Goals). Đây là khác biệt nền tảng theo tài liệu hiện tại; không suy rộng rằng Android không có Goals. |

## 3. Những nhận định chính từ trải nghiệm

### A. Wallet có nền tảng theo dõi đa tiền tệ

Wallet cho phép đặt KRW làm tiền tệ gốc và thêm VND; tài khoản có thể giữ đơn vị tiền riêng. Vì vậy, vấn đề của finaci **không nên trình bày là Wallet hoàn toàn không hỗ trợ đa tiền tệ**. Câu hỏi thiết kế có căn cứ hơn là liệu số dư, dòng tiền dự kiến và tiến độ mục tiêu có được ghép thành một kế hoạch rõ ràng cho người dùng có thu nhập/chi phí ở hai quốc gia hay không.

### B. Bank Sync nổi bật, nhưng độ phủ với persona cần được xem xét

Wallet gắn nhãn Bank Sync là Recommended. Theo trải nghiệm của sinh viên, Việt Nam không có trong country list. Ảnh danh sách sau khi chọn South Korea cho thấy ba lựa chọn: BUXFER, HSBC Offshore Banking và Wise. Với persona có nguồn tiền ở Việt Nam và Hàn Quốc, độ phủ kết nối này có thể không khớp với các tài khoản họ cần theo dõi, làm tăng nhu cầu cân nhắc nhập tay.

Đây là **bằng chứng về trải nghiệm country/bank selection của một người dùng trên iPhone 5.7.5**, chưa phải thống kê độ phủ ở mọi phiên bản/khu vực, cũng không cho biết số người dùng bị ảnh hưởng. “Có thể khiến ít người thuộc persona dùng được Bank Sync” là diễn giải UX, không phải con số người dùng.

### C. Có khoản dự kiến và ngân sách, nhưng Goals không khả dụng trên iOS

Planned Payments giúp ghi thu/chi dự kiến; Budgets theo dõi giới hạn chi theo kỳ/danh mục. Hai flow này hữu ích cho quản lý dòng tiền, nhưng khác mục tiêu tiết kiệm như “đến ngày X cần tích lũy Y”. Wallet Help Center hiện ghi Goals không khả dụng trên iOS, dù có hướng dẫn Goals cho Android. Điều này là một khoảng trống phù hợp để cân nhắc trong ý tưởng finaci, mục tiêu đã được chọn làm thẻ phụ trong v2 (L038), không thay vấn đề ưu tiên là nhập lặp Outlook.

### D. Dữ liệu và công cụ đã có nhưng trải nghiệm báo khó nối hai phần

Wallet có Dashboard, Statistics, Planned Payments, Budgets, giao dịch và đa tiền tệ. Người dùng trực tiếp xác nhận Planned Payments được theo dõi riêng; muốn xem trong Outlook thì phải nhập lại vì hai phần không liên thông. Đây là friction thao tác cá nhân đã có lời xác nhận, chưa phải kết quả usability test đại diện. Người dùng đã chọn P07 (hiệu quả/linh hoạt thao tác) làm nguyên tắc chính cho nhập lặp, P06 (nhận biết thay vì phải nhớ) làm nguyên tắc phụ cho việc nhận ra dữ liệu đã có. Không suy ra lỗi ở tất cả tài khoản Wallet.

## 4. Bằng chứng nào là loại nào

| Loại | Nội dung hiện có | Cách trình bày đúng |
|---|---|---|
| Quan sát trực tiếp | 21 ảnh Wallet trên iPhone; UI và các lựa chọn hiển thị trong lần khảo sát. | Ghi phiên bản/ngày, đường đi, mô tả điều nhìn thấy; không suy ra xử lý phía sau. |
| Báo cáo của sinh viên | Việt Nam vắng trong country list; South Korea có ba lựa chọn sau “Show all banks”; Planned Payments và Outlook ở hai nơi khiến việc nối thông tin khó. | Dẫn là trải nghiệm cá nhân; ảnh xác nhận lựa chọn ngân hàng và màn hình, lời kể xác nhận độ khó nối hai flow. |
| Tài liệu chính thức | Help Center ghi Goals không khả dụng trên iOS; có hướng dẫn trên Android. | Dẫn nguồn Wallet, ngày truy cập; giới hạn theo nền tảng. |
| Review công khai | R01–R20 ở `wallet-review-notes.md`, lấy từ Apple KR/US/UK và Google Play US query. | Ghi ngày, sao, nền tảng/khu vực; mẫu thuận tiện đa vùng, không đại diện cho người dùng Hàn hay Việt. |
| Hồi tưởng nghiên cứu hackathon | Người dùng kể đã hỏi miệng khoảng 5–7 người bạn nhưng không có ghi chép. | Chỉ ghi là bối cảnh/hồi tưởng; không tạo tỉ lệ, trích dẫn hay khẳng định survey. |
| Diễn giải / giả thuyết | Người dùng có thể chưa biết liệu các nguồn thu/chi KRW/VND có đủ để đạt mục tiêu học phí trước hạn, dù đã ghi số dư và khoản dự kiến. | Gắn nhãn giả thuyết cần kiểm chứng; không trình bày như kết luận từ review hay số liệu thị trường. |

## 5. Trọng tâm đã chốt — tái sử dụng khoản dự kiến trong dòng tiền

> **Người có nguồn thu/chi bằng KRW và VND có thể ghi số dư, khoản dự kiến và ngân sách trong Wallet, nhưng các flow đã khảo sát chưa cho thấy một bức tranh tương lai nối số tiền đa tiền tệ, khoản sắp vào/ra và mục tiêu tài chính. Người dùng có thể phải tự tổng hợp để quyết định còn bao nhiêu khả dụng và mục tiêu có đi đúng tiến độ không.**

Đây là **trọng tâm đã được người dùng chốt** ở L029–L035, không phải kết luận đại diện cho mọi người dùng. Người dùng đã tự kể việc lập kế hoạch tổng thể bị rối khi đối chiếu thu nhập VND, lương KRW và hỗ trợ gia đình; đó là bằng chứng trải nghiệm cá nhân. Ảnh cho thấy công cụ nằm ở Dashboard, Currencies, Planned Payments, Budgets và Statistics; ảnh tĩnh được bổ sung bằng lời xác nhận về nhập lặp; vẫn chưa xác minh cơ chế dữ liệu nội bộ. Căn cứ:

1. Người dùng trực tiếp kể khó lập kế hoạch tổng thể khi phải đối chiếu thu nhập VND, lương KRW và hỗ trợ gia đình; muốn công cụ giúp ra quyết định tài chính dựa trên tracking, không chỉ lưu log.
2. Ảnh Wallet cho thấy KRW base + VND và các công cụ Dashboard, Planned Payments, Budgets, Statistics ở các flow riêng.
3. Help Center chính thức ghi Goals không khả dụng trên iOS; đây là giới hạn theo nền tảng, không phải kết luận Wallet không có Goals trên Android hoặc không có công cụ planning nào.
4. Reviews R03 (số dư đầu tháng), R05 (khoản đến hạn), R11 (biểu đồ/nhập tay), R12 (đa tiền tệ/ngân hàng), R17 (giao dịch FX/sync) hỗ trợ nhu cầu lân cận về visibility, hiệu quả và cash flow. Mẫu R01–R20 không có review trực tiếp về mục tiêu học phí hay một mục tiêu tiết kiệm cụ thể.

**Phạm vi đã triển khai:** A hiển thị tài khoản KRW/VND, trạng thái hiện tại/dự kiến, khoản được tính và thẻ mục tiêu phụ. B trình bày cùng các khoản định kỳ theo ngày với tab 7 ngày/30 ngày/đến mục tiêu. C là kịch bản lương trễ đã viết sẵn; D là Quick Add không lưu từ dấu + chung. Không triển khai tạo mục tiêu hay tính toán tài chính thật. Học phí là use case minh họa, có thể đổi thành quỹ dự phòng hoặc khoản lớn khác.

Bank Sync coverage vẫn là phát hiện phụ; không gộp vào flow v2 chính vì thiếu nhà cung cấp và lập kế hoạch tương lai là hai vấn đề khác nhau. Lý do ưu tiên, lựa chọn mục tiêu và phản biện đã ghi ở `docs/셀프논증.md`; bổ sung mới L046 ghi rõ là trợ lý soạn theo ủy quyền hiện tại.

## 6. Nội dung trình bày ngắn với giảng viên

> “Em khảo sát Wallet 5.7.5 trên iPhone qua Dashboard, Currencies, Quick Add, Planned Payments, Budgets, Statistics và Bank Sync. Wallet có KRW/VND, ghi nhận khoản dự kiến và báo cáo. Từ trải nghiệm của em khi quản lý thu nhập ở Việt Nam và Hàn Quốc, em muốn xem các dữ liệu đó có giúp người dùng nhìn bức tranh dòng tiền tương lai để ra quyết định cho một mục tiêu hay không. Học phí chỉ là use case em dùng để minh họa; mục tiêu có thể là khoản lớn hoặc quỹ dự phòng khác. Review hỗ trợ các nhu cầu lân cận như số dư, khoản đến hạn, nhập liệu và đa tiền tệ, chứ không trực tiếp xác nhận một mục tiêu cụ thể.”

## 7. Giới hạn bằng chứng được giữ trong bản nộp

- Người dùng xác nhận đã thử hầu hết flow, nhưng chưa có nhật ký từng bước/thời gian/cảm xúc. Có nhớ khả năng giới hạn khi xem chi tiết record/history nhưng chưa chắc đúng tên hoặc trạng thái gói; cần kiểm tra lại trước khi đưa vào phân tích.
- Model iPhone đã xác nhận là iPhone 14 Pro Max; người dùng nói đang dùng iOS mới nhất nhưng chưa rõ số phiên bản cụ thể. Phiên bản Wallet 5.7.5 do sinh viên xác nhận.
- Chưa thử kết nối ngân hàng thật; không nhập thông tin đăng nhập cho bài giữa kỳ.
- Country list không có Việt Nam là trải nghiệm được sinh viên báo cáo; ảnh được gửi thể hiện South Korea đang chọn, không phải toàn bộ danh sách quốc gia.
- Danh sách Hàn cho thấy ba lựa chọn trong màn hình đã chụp; không kết luận về mức phổ biến hoặc danh sách của mọi thị trường/tài khoản.
- Bản ảnh phân tích công khai đã che số dư ở `docs/screenshots/journey/wallet-dashboard-redacted.jpg`, Planned Payments/Budgets/Statistics; không xem số dư gốc là dữ liệu mẫu Finaci.
- Trọng tâm, P07/P06, mục tiêu phụ, ngày mục tiêu và Quick Add đã được chốt. Những Why sau và hiệu quả dự kiến vẫn là phân tích cần kiểm chứng, không phải quan sát nội bộ Wallet hay kết quả người dùng thử Finaci.

## 8. Bằng chứng tham chiếu

- Phân tích UI/UX theo 10 heuristic Nielsen và các câu hỏi kiểm chứng: `docs/wallet-ux-heuristic-audit.md`.
- Review và phân loại: `docs/wallet-review-notes.md`.
- Lịch sử yêu cầu/phản biện đã diễn ra: `docs/prompt-log.md`.
- Ảnh được chọn và che thông tin để nộp: `docs/screenshots/journey/`. Tên ảnh gốc trong bảng flow ghi lại nguồn người dùng gửi; bản sử dụng trong deck/repo là các ảnh evidence đã chuẩn hóa ở thư mục này.
- Mẫu review, giới hạn và nguồn store: xem bảng R01–R20 trong ghi chú review.
