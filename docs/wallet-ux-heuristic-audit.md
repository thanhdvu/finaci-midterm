# Wallet 5.7.5 — phân tích UI/UX theo Nielsen

**Mục đích:** bản heuristic review sơ bộ để nối các ảnh Wallet do sinh viên chụp với nguyên tắc trong môn. Đây không phải kết quả usability test và không khẳng định sinh viên đã gặp lỗi UX.

**Đối tượng quan sát:** Wallet by BudgetBakers trên iPhone, phiên bản 5.7.5 theo xác nhận của sinh viên; ảnh chụp ngày 28/10/2026 KST.  
**Căn cứ lý thuyết:** GAI3008-W06-2026-v1.2.0.pdf, Appendix A8, trang 46; đối chiếu tên P01–P10 trong `docs/디자인가이드.md` của template. Tóm tắt tên/nghĩa: P01 trạng thái hệ thống; P02 khớp thế giới thực; P03 quyền kiểm soát/tự do; P04 nhất quán/chuẩn; P05 phòng lỗi; P06 nhận biết thay vì nhớ; P07 linh hoạt/hiệu quả; P08 thẩm mỹ/tối giản; P09 nhận diện/chẩn đoán/khôi phục lỗi; P10 trợ giúp/tài liệu.

## Cách đọc kết quả

Heuristic review dùng nguyên tắc để tìm điểm mạnh và câu hỏi cần kiểm tra. Ảnh tĩnh cho biết thành phần, nhãn, thứ tự, lựa chọn và trạng thái đang hiển thị; chúng không cho biết người dùng có hiểu, có tìm thấy, thao tác nhanh hay kết nối thành công không. Vì sinh viên chưa báo cáo cảm giác “lấn cấn”, các cột “câu hỏi UX” dưới đây là giả thuyết cho bước tiếp theo, không phải kết luận pain point.

## Đối chiếu P01–P10

| Nguyên tắc | Bằng chứng từ flow Wallet | Đọc dưới góc nhìn UX | Trạng thái kết luận |
|---|---|---|---|
| **P01 — Hệ thống cho biết trạng thái hiện tại** | Budgets có Spent/Remains, tổng đã dùng, thanh tiến độ và nhãn trạng thái; Planned Payments hiển thị ngày đến hạn; Dashboard/Statistics có số dư và dòng tiền. | Có nhiều tín hiệu giúp theo dõi trạng thái. Với Bank Sync, ảnh cho thấy bước chọn nước/chọn tổ chức nhưng chưa khảo sát trạng thái đang kết nối, thành công hay thất bại. | Có bằng chứng thiết kế tích cực ở Budget/Planned Payments; trạng thái đồng bộ chưa đánh giá. |
| **P02 — Khớp cách người dùng hiểu thế giới thực** | Tài khoản có Cash, Checking, Credit card, Savings; giao dịch có Expense/Income/Transfer; KRW và VND; khoản dự kiến có tên, ngày và chu kỳ. | Cấu trúc gần với khái niệm tài chính quen thuộc. Màn hình tiếng Anh có thể là rào cản nếu persona muốn tiếng Việt/Hàn; chưa hỏi người dùng về ngôn ngữ hay thuật ngữ. | Cấu trúc khớp miền tài chính ở mức sơ bộ; ngôn ngữ là câu hỏi, chưa có lỗi được xác nhận. |
| **P03 — Quyền kiểm soát và đường thoát** | Các form có Cancel/Back; bottom navigation giữ các lối chính; chọn phương thức theo dõi có Bank Sync, Apple Pay, Manual Entry, Import Files. | Người dùng có nhiều đường đi và có lối quay lại. Chưa thử thao tác hủy giữa quá trình kết nối hoặc sau khi chọn nhầm tài khoản. | Có affordance quay lại/hủy nhìn thấy; kết quả kiểm tra luồng hủy chưa có. |
| **P04 — Nhất quán và theo chuẩn** | Bottom tabs lặp lại trên Dashboard, Planning, Statistics, More; màu xanh cho lựa chọn/nút điều hướng; mẫu form dùng hàng có icon, nhãn và chevron. | Mẫu điều hướng và điều khiển lặp lại giúp người dùng đoán vị trí. Cần kiểm tra liệu ngôn ngữ, tên mục và đơn vị tiền có nhất quán giữa các màn hình/khu vực không. | Ảnh cho thấy mẫu giao diện lặp lại; chưa phát hiện bất nhất cụ thể. |
| **P05 — Phòng lỗi trước khi xảy ra** | Add Record và Planned Payment đánh dấu một số trường Required; loại Expense/Income/Transfer được chọn riêng; tài khoản được hiển thị. | Trường bắt buộc và tách loại giao dịch có thể giảm thiếu dữ liệu/nhầm loại. Chưa kiểm tra cảnh báo số âm, sai tiền tệ, trùng khoản định kỳ, hoặc xác nhận trước thao tác có hậu quả. | Có một số rào chắn đầu vào; phạm vi phòng lỗi chưa được kiểm thử. |
| **P06 — Ưu tiên nhận biết thay vì phải nhớ** | Dashboard có tài khoản, Balance Trend, Top Expenses và Last Records; Planning cho thấy lịch khoản dự kiến; Budgets có Spent/Remains. | Dữ liệu được hiển thị ở từng phần. Việc Planned Payments không liên thông Outlook có thể buộc người dùng nhớ/đưa dữ liệu sang nơi khác; đây là hệ quả phụ của friction, không phải nguyên tắc chính đã chọn. | Có bằng chứng cho cấu trúc hiển thị riêng; P06 chỉ là nguyên tắc phụ cần cân nhắc, chưa kết luận vi phạm. |
| **P07 — Linh hoạt và hiệu quả sử dụng** | Quick Add; Templates; nhập tay; Bank Sync; Apple Pay; Import Files; Planned Payments và Outlook. Người dùng trực tiếp báo muốn thấy Planned Payment trong Outlook thì phải nhập lại vì hai phần không liên thông. | Trải nghiệm cá nhân cho thấy phải lặp thao tác để dùng dữ liệu ở hai flow. Đây là căn cứ trực tiếp hơn cho P07; chưa đo thời gian hoặc xác nhận đây là hành vi chung của các tài khoản/phiên bản khác. | P07 là nguyên tắc ứng viên chính cho friction đã xác nhận; cần gắn nhãn phạm vi là trải nghiệm của một người dùng. |
| **P08 — Tối giản, tập trung vào điều quan trọng** | Dashboard có nhiều widget và banner Premium; More có nhiều công cụ; form Add Record có nhiều trường/chi tiết. Bank list ảnh chụp hiển thị ba kết quả và nhiều khoảng trống. | Có thể tạo cạnh tranh thị giác giữa quảng bá Premium và thông tin tài chính, hoặc tăng tải nhận thức ở form. Nhưng khoảng trống trong danh sách không tự nó chứng minh lỗi, và màn hình có nhiều mục không đồng nghĩa khó dùng. | Đây là câu hỏi kiểm tra bằng nhiệm vụ/ưu tiên người dùng, chưa kết luận P08 bị vi phạm. |
| **P09 — Giải thích lỗi và giúp khôi phục** | Chưa có ảnh lỗi Bank Sync, mất mạng, không tìm thấy ngân hàng, hoặc dữ liệu đồng bộ sai trong bản 5.7.5. Review R06/R09/R10/R18/R20 từng đề cập sync/kết nối ở thời điểm/nền tảng khác nhau. | Cần quan sát app giải thích điều gì xảy ra khi quốc gia/ngân hàng không có, kết nối lỗi, hoặc giao dịch trùng; có giữ dữ liệu và hướng khôi phục không. Không áp review cũ/Android thành lỗi đã xác nhận trên iOS hiện tại. | Chưa đánh giá trực tiếp; review chỉ là tín hiệu nghiên cứu, có giới hạn nền tảng/thời gian. |
| **P10 — Trợ giúp và tài liệu** | Chọn Tracking Method có mô tả ngắn và nhãn Recommended cho Bank Sync; Help Center chính thức mô tả Goals Android và ghi iOS không khả dụng. | Mô tả ngắn hỗ trợ chọn phương thức. Câu hỏi là nếu quốc gia không có hoặc chỉ thấy ít lựa chọn, app có giải thích phạm vi hỗ trợ và nêu cách thay thế không; ảnh hiện tại chưa thấy phần giải thích đó. | Có mô tả trong màn chọn phương thức; trợ giúp đúng lúc cho trường hợp thiếu nhà cung cấp chưa quan sát được. |

## Điểm mạnh đang nhìn thấy

1. **Dashboard gom thông tin dễ nhận ra** — tài khoản, số dư và widget báo cáo hỗ trợ nhận biết tình hình (P06).
2. **Planning tách khoản dự kiến khỏi ngân sách** — ngày/kỳ khoản thu chi và mức chi theo danh mục có cấu trúc riêng, tránh bắt người dùng tự nhớ toàn bộ (P01/P06).
3. **Nhập liệu có nhiều đường** — Quick Add, template, sync, Apple Pay và nhập tay cho các cách dùng khác nhau (P03/P07).
4. **Một số đầu vào quan trọng được đánh dấu** — Required và lựa chọn loại giao dịch giúp người dùng biết cần bổ sung gì trước khi lưu (P01/P05).
5. **Có cấu hình KRW/VND** — xác nhận đa tiền tệ có trong app; không dùng “thiếu đa tiền tệ” làm kết luận về Wallet.

## Câu hỏi UX có thể kiểm tra tiếp — chưa phải pain point đã xác nhận

| Câu hỏi | Vì sao nên kiểm tra | Nhiệm vụ đơn giản để tự quan sát |
|---|---|---|
| Nếu country list không có Việt Nam, người dùng có hiểu phải chuyển sang nhập tay không? | Nối P01/P02/P10 với Bank Sync; có thể là vấn đề độ phủ sản phẩm hơn là lỗi thị giác. | Tạo Checking Account giả, đi tới chọn quốc gia, ghi lại người dùng đoán bước tiếp theo. Không kết nối thật. |
| Ba lựa chọn dưới South Korea có giúp người dùng nhận ra có tổ chức nào mình thực sự dùng không? | Nối tính phù hợp của nhà cung cấp với tác vụ persona; không suy ra phổ biến từ tên hiển thị. | Đọc tên/mô tả, ghi rõ có nhận ra ngân hàng của mình không và có biết tìm tiếp bằng Search không. |
| Từ KRW/VND, người dùng có biết tổng số dư đang quy đổi theo tỷ giá nào và khi nào cập nhật không? | Nối P01/P02/P06; trang Currencies hiện có base currency và toggle tỷ giá, nhưng ảnh chưa cho thấy tỷ giá/timestamp. | Mở chi tiết VND hoặc Currency Rates nếu có; ghi điều gì được hiển thị, không cần nhập số dư thật. |
| Người dùng có phân biệt ngân sách chi tiêu với mục tiêu tích lũy có ngày đích không? | Budgets và Planned Payments hiện có, nhưng Goals không khả dụng trên iOS theo Help Center. | Hỏi người dùng muốn tới hạn học phí thì họ sẽ bắt đầu ở đâu; ghi phản ứng thực tế, không gợi ý trước. |
| Khi ghi giao dịch bằng Quick Add, có hoàn thành nhanh hay bị bàn phím che trường cần dùng? | Nối P05/P07; ảnh có bàn phím số phủ phần dưới form, nhưng có thể cuộn. | Dùng dữ liệu giả tạo một khoản chi; ghi số lần chạm, cuộn và trường phải tìm. |
| Banner Premium có làm người dùng chú ý khỏi số dư hoặc kế hoạch không? | Câu hỏi về thứ bậc thị giác P08; ảnh cho thấy banner nổi bật nhưng không chứng minh tác động. | Yêu cầu người khác tìm số dư và khoản đến hạn trên Dashboard; quan sát họ nhìn vào đâu trước. |

## Phân biệt vấn đề usability với cơ hội sản phẩm

- **Usability issue** cần bằng chứng rằng người dùng khó tìm, khó hiểu, mắc lỗi hoặc không biết bước tiếp theo. Hiện sinh viên chưa kể đã gặp cảm giác vướng; không nên bịa ra để đủ bài.
- **Product coverage gap** là khả năng/hỗ trợ chưa phù hợp nhu cầu, ví dụ Việt Nam không xuất hiện trong country list đã kiểm tra hoặc Goals hiện không khả dụng trên iOS. Người dùng có thể hiểu giao diện nhưng vẫn không làm được việc mình cần.
- **Product opportunity** là cơ hội ghép các điểm mạnh hiện có — đa tiền tệ, tài khoản, Planned Payments, Budgets/Statistics — để hỗ trợ mục tiêu tài chính của persona. Cần chọn phạm vi cụ thể, không biến thành danh sách tính năng mới.

Vì vậy, hướng nghiên cứu hợp lý là chưa tuyên bố Wallet “khó dùng”; thay vào đó, kiểm tra mức phù hợp với tác vụ quản lý tài chính của persona và xem liệu vấn đề thuộc khả năng kết nối, cách trình bày thông tin, hay khả năng lập kế hoạch. Một heuristic review nêu câu hỏi và bằng chứng; kết luận cuối phải do sinh viên chọn sau khi đối chiếu review, trải nghiệm cá nhân và bài tập.

## Liên kết tài liệu

- Bản tổng hợp các flow: `docs/wallet-observation-brief.md`.
- Review R01–R20 và nguồn: `docs/wallet-review-notes.md`.
- Ghi chú phiên này: `docs/prompt-log.md`.
- Lý thuyết: `GAI3008-W06-2026-v1.2.0.pdf`, trang 46, Appendix A8 (tên 10 nguyên tắc); slide tuần 6 về UI/UX và heuristic evaluation.
