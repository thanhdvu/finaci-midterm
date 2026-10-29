# Bước 2 — Tóm tắt app finaci

**Trạng thái:** Phạm vi và hướng UX đã chốt; diễn đạt hoàn thiện theo ủy quyền L046 · **Cập nhật:** 29/10/2026

## finaci là gì

**finaci (피나시)** hướng tới global netizens cần theo dõi và lập kế hoạch tài chính cá nhân khi thu nhập, chi phí và tài khoản trải qua nhiều quốc gia hoặc tiền tệ. Thay vì chỉ lưu từng giao dịch, app hướng tới giúp người dùng hiểu số dư và khoản thu/chi sắp tới ảnh hưởng thế nào đến kế hoạch tài chính có thời hạn.

**Danh mục:** Tài chính  
**Giá trị cốt lõi v2:** “Nhìn một bức tranh dòng tiền đa tiền tệ và khoản thu/chi sắp tới để biết kế hoạch tài chính có đang đi đúng hướng hay không.”

## Topic Definition Card — đúng 4 trường trong mẫu W07

| Trường của mẫu | finaci |
|---|---|
| **Đại diện người dùng** | Global netizen quản lý tiền qua nhiều quốc gia/tiền tệ; prototype minh họa một du học sinh Việt Nam ở Hàn Quốc có thu nhập VND, KRW và hỗ trợ gia đình. |
| **Tình huống sử dụng** | Trên iPhone, người dùng muốn kiểm tra các khoản thu/chi định kỳ đã biết để hiểu số dư có thể thay đổi ra sao trước một mục tiêu có hạn chót. |
| **3 nhiệm vụ cốt lõi** | 1) Xem các số dư KRW/VND cùng nhau; 2) xem khoản thu/chi định kỳ trên dòng thời gian; 3) xem tình huống thu nhập đến trễ ảnh hưởng thế nào tới kế hoạch mục tiêu. |
| **Tiêu chí thành công** | Người dùng có thể chỉ ra số dư hiện tại và số dư dự kiến tại mốc đã chọn, thấy các khoản nào được tính, và biết khoản phát sinh chưa được tính. |

Nội dung được AI sắp xếp từ lời kể và lựa chọn của sinh viên, hoàn thiện theo ủy quyền hiện tại; không phải kết quả phỏng vấn độc lập hay dữ liệu survey. Mẫu W07 dùng Topic Card 4 trường này làm bước đệm cho tóm tắt app 1 trang.

**Quan hệ với app tham chiếu:** Finaci có thể giữ các điểm mạnh kiểu Wallet như dashboard, đa tiền tệ và khoản thu/chi định kỳ, đồng thời cải thiện những điểm yếu liên quan trực tiếp đến bài toán dòng tiền tương lai. Đây là hướng định vị, không phải tuyên bố prototype sẽ sửa được mọi vấn đề trong 20 review; bài giữa kỳ đã chọn ưu tiên tái sử dụng Planned Payments trong Outlook, với P07 chính/P06 phụ.

## Mục tiêu

Giúp người dùng gom thông tin tài chính ở nhiều currency vào một luồng lập kế hoạch dễ hiểu, để cân nhắc mục tiêu cần đạt trước một ngày cụ thể. App có thể cho xem số tiền hiện có, các khoản thu/chi đã lên kế hoạch và phần tiến độ mục tiêu trong cùng một ngữ cảnh.

Trong prototype giữa kỳ, các con số và phản hồi AI là dữ liệu minh họa đã chuẩn bị trước. Prototype không kết nối ngân hàng, không lưu giao dịch và không tính toán tư vấn tài chính thật.

## Người dùng mục tiêu

**Tệp mục tiêu rộng:** global netizens quản lý tiền qua biên giới, nhiều nguồn thu/chi, tài khoản hoặc currency. Đây là định hướng sản phẩm; hiện chưa có nghiên cứu đủ rộng để khẳng định mọi nhóm global netizens có cùng nhu cầu.

**Persona/use case của prototype:** du học sinh Việt Nam sống tại Hàn Quốc, có thể nhận thu nhập remote ở Việt Nam bằng VND, lương làm thêm ở Hàn bằng KRW và hỗ trợ gia đình. Use case này giúp minh họa nhu cầu cụ thể; không giới hạn đối tượng Finaci ở sinh viên Việt Nam tại Hàn.

### Persona của prototype

**Du học sinh Việt Nam tại Hàn Quốc** · dùng iPhone · quản lý tiền liên quan đến Việt Nam và Hàn Quốc · muốn biết tình hình dòng tiền có hỗ trợ một mục tiêu theo hạn chót hay không.

Persona chỉ dùng thông tin người dùng đã kể. Chưa tự gán tên, tuổi, trường, mức thu nhập, thói quen chi tiêu hoặc mức độ thành thạo tài chính.

## Vấn đề cần giải quyết

Người tạo ý tưởng kể rằng mình nhận thu nhập remote tại Việt Nam, lương part-time tại Hàn Quốc và hỗ trợ gia đình; khi lập kế hoạch tổng thể, việc đối chiếu các nguồn tiền và tỷ giá gây rối. Các app theo dõi thuần túy giúp ghi giao dịch, nhưng người dùng muốn đi tiếp từ dữ liệu đã ghi tới quyết định về dòng tiền và mục tiêu.

Khảo sát Wallet 5.7.5 trên iPhone cho thấy app có cấu hình KRW/VND, Dashboard, Statistics, Planned Payments và Budgets. Ảnh chụp cho biết giao diện; lời xác nhận riêng của người dùng là phải nhập lại Planned Payments để xem trong Outlook. Không dùng ảnh tĩnh để tự suy ra cơ chế dữ liệu. Wallet Help Center ghi Goals không khả dụng trên iOS; đây là khoảng trống chức năng theo nền tảng, không phải bằng chứng rằng Wallet không có Goals trên Android.

**Vấn đề thiết kế đã chốt:** Người quản lý tài chính xuyên biên giới có thể phải tự ghép số dư và khoản thu/chi tương lai để hiểu kế hoạch tài chính có khả thi không. Prototype dùng case KRW/VND của du học sinh Việt ở Hàn để kiểm tra vấn đề này.

Đây là vấn đề được đề xuất từ trải nghiệm cá nhân và đối chiếu giao diện hiện tại. Review R01–R20 không trực tiếp xác nhận nhu cầu tiết kiệm cho học phí hay mục tiêu cụ thể; các review R03, R05, R11, R12 và R19 chỉ cung cấp tín hiệu lân cận về số dư, khoản đến hạn, nhập liệu, đa tiền tệ và lịch thu/chi.

## Phạm vi v2 trong prototype

1. Cho người dùng xem số dư theo account/currency và khoản thu/chi sắp tới trong một bức tranh dòng tiền.
2. Trình bày dự phóng theo mốc thời gian, nêu rõ khoản nào được tính và giả định nào được dùng.
3. Minh họa một tình huống thay đổi — chẳng hạn khoản thu đến trễ — bằng phản hồi AI soạn sẵn, giải thích ảnh hưởng có thể có tới kế hoạch.

Học phí là **một use case minh họa**, không phải giới hạn của app. Có thể thay bằng quỹ khẩn cấp hoặc một khoản chi lớn. Bank Sync coverage (Việt Nam vắng trong danh sách ở lần khảo sát; South Korea hiển thị ba lựa chọn sau “Show all banks”) là phát hiện phụ, chưa gộp vào giá trị v2 chính.

## Căn cứ và quyết định đã chốt

- **Trải nghiệm cá nhân:** người dùng mô tả các nguồn thu remote VND, part-time KRW và tiền gia đình gửi làm việc lập kế hoạch tổng thể rối.
- **Quan sát app:** `docs/wallet-observation-brief.md`, ảnh Wallet iPhone 5.7.5 ngày 28/10/2026.
- **Review:** `docs/wallet-review-notes.md`, R01–R20; mẫu nhiều vùng và nền tảng, không đại diện riêng cho du học sinh Việt/Hàn.
- **Giả thuyết thiết kế:** vấn đề nằm ở việc nối tracking với quyết định lập kế hoạch, không phải khẳng định Wallet không hỗ trợ đa tiền tệ.
- **Quyết định đã xác nhận:** ưu tiên nhập lặp Outlook (L029–L035); mục tiêu là thẻ phụ (L038); mặc định đến ngày mục tiêu (L039); flow A/B/C và Quick Add D (L040–L043). L046 bổ sung lập luận về cảnh báo dự phóng theo ủy quyền hiện tại.
- **Phạm vi thực tế:** A/B hiển thị dữ liệu GET cố định; C là tình huống thu nhập trễ đã viết sẵn; D là form UI không lưu. Không có flow tạo mục tiêu hay thực hiện giao dịch thật.
- **Tiêu chí chưa đo:** nhận biết hiện tại/dự kiến và các khoản được tính là tiêu chí thiết kế, chưa phải kết quả usability test.

