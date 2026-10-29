# Đánh giá bộ nộp finaci theo góc nhìn người chấm

Ngày 29/10/2026. Đây là đánh giá mô phỏng dựa trên đề, template và tài liệu lớp; không phải điểm chính thức của giáo sư.

## Kết luận

Bộ bài có đủ các nhóm đầu ra chính và có thể chuẩn bị nộp. Cấu trúc theo template thực tế của lớp và phạm vi UI-only đã được đối chiếu. Không nên nói “đúng 100% và chắc chắn đủ điểm”: bằng chứng nghiên cứu vẫn có giới hạn và phần trình bày chưa được quan sát.

Deck có 31 trang gồm bìa, nội dung chính, Q&A và B1–B5. Số trang tăng do thêm phần Flutter và nhân bản phụ lục theo từng nguyên tắc/màn như chỉ dẫn trong mẫu. Đây là bản điều chỉnh template, không phải bản sao nguyên xi từng trang của file gốc. Màu và bìa đã đổi theo Finaci.

## Đối chiếu yêu cầu và format

| Hạng mục | Kết luận | Bằng chứng và giới hạn |
|---|---|---|
| Phân tích Wallet | Đạt đầu ra | Ảnh thật, phiên bản, điểm mạnh nối Nielsen; tách quan sát và giả thuyết. Số iOS cụ thể/vị trí dùng chưa ghi. |
| Điểm sao và review | Đạt đầu ra | 20 review có ngày, sao, nguồn/khu vực, ẩn tác giả và phân loại; histogram có ảnh gốc. Mẫu nhiều vùng và có review cũ, không đại diện mọi người dùng hiện tại. |
| App summary một trang | Đạt | Mục tiêu, đối tượng/persona, vấn đề và giá trị v2. VND–KRW là dữ liệu prototype cho một trường hợp. |
| User Journey | Đúng khung, còn giới hạn | Sáu bước Wallet, ảnh/review và các dòng mở rộng. Outlook không có review trực tiếp; cảm xúc là AI ước lượng được cho phép, không phải đo trực tiếp. |
| Fishbone và 5 Why | Đúng khung | Sáu góc nhìn và một ưu tiên. Why 3–5 là giả thuyết UX, không chứng minh nguyên nhân kỹ thuật Wallet. |
| Screen plan và guide | Đạt | A/B/C/D có element ID, widget, tên nghiệp vụ, thông tin/thứ tự, P-number và lý do, convenience, guide và STATE. |
| Self argument | Đủ cấu trúc | Bốn vấn đề có luận điểm, phản biện, sửa/giữ, căn cứ và trước/sau. Phần trợ lý bổ sung được ghi rõ; người trình bày phải tự hiểu và bảo vệ lựa chọn. |
| Flutter | Đạt phạm vi đã kiểm tra | Widget cơ bản, Navigator/TabBar/BottomSheet, GET local, loading/error/empty/retry và responsive. Không có lưu, AI hay thuật toán tài chính thật. |
| Slide/PDF | Đạt bộ nộp | Bìa đã căn lại; các bảng theo mẫu lớp. Phụ lục dày nên cần zoom đúng bằng chứng, không đọc cả bảng khi chiếu. |
| Video | Đạt | MP4 60 giây nằm trong PPTX ở slide 10. PDF có poster/link, không phát video nhúng. |
| Code, docs, README | Đạt | Repo có Flutter, db.json, hướng dẫn chạy/demo, guide, principle cards, prompt-log, self argument và tự đánh giá. |
| Vercel | Đạt kỹ thuật | Web/API cùng project, truy cập công khai, GET trả JSON, request ghi bị từ chối. Đề xuất +5; điểm cộng cuối do thầy áp dụng. |
| Trình bày và LMS | Người dùng chưa thực hiện | Đã có script/Q&A; chưa rehearsal thực tế 6 phút và chưa xác nhận submit LMS. |

## Góc nhìn về hình thức và mức độ hiểu bài

Điểm thuyết phục là trải nghiệm Wallet cụ thể, có lý do bỏ Bank Sync khỏi trọng tâm, giữ ưu điểm Wallet và sửa ví dụ tài chính sai logic. Bìa và font giúp bài nhất quán nhưng không chứng minh người làm hiểu bài.

Điểm dễ tạo cảm giác phụ thuộc AI là nhiều thuật ngữ và bảng. Nếu chỉ đọc bảng hoặc không giải thích được tradeoff, bài vẫn thiếu dấu ấn cá nhân. Script mới nói về quá trình chọn và lý do, thay vì đọc từng dòng slide.

Sản phẩm đa quốc gia/đa tiền tệ chưa đồng nghĩa đã kiểm chứng nhiều thị trường. Giao diện có năm lựa chọn tiền mẫu; dữ liệu VND–KRW là một persona. Không được trình bày rằng mọi quốc gia, ngân hàng hay tỷ giá đều đã hỗ trợ thật.

## Rubric tham khảo

| Lĩnh vực | Mức tự đánh giá | Lý do chưa trọn điểm |
|---|---|---|
| Kế hoạch 40 | 35/40 | Review đa vùng/cũ, thiếu review Outlook trực tiếp; cảm xúc chưa đo và 5 Why còn giả thuyết. |
| Tự lập luận 20 | 17/20 | Có cấu trúc và căn cứ. Quan điểm trợ lý soạn thêm không thay thế khả năng tự phản biện khi bị hỏi. |
| Flutter 25 | 23/25 | Đủ kỹ thuật chính, bám guide; là prototype có chủ đích, chưa có usability test. |
| Trình bày 15 | Chưa chấm thực hiện | 11/15 chỉ là dự kiến chuẩn bị. Phải nghe nói, xem demo và Q&A mới chấm được. |
| Vercel | Đề xuất +5 | Có bằng chứng kỹ thuật; không cộng nhầm bonus cache/thiết bị của bài tuần. |

Phần nội dung/triển khai hiện tự đánh giá 75/85. Nếu trình bày được 11/15 và thầy chấp nhận +5 thì tổng là 91. Đây là phép tính tham khảo, không phải lời hứa điểm.

## Ba câu cần tự trả lời

1. Vì sao review phàn nàn Sync nhiều mà chọn Outlook? Vì trải nghiệm trực tiếp, khả năng cải thiện UI và phạm vi môn; không gọi nó là vấn đề lớn nhất của mọi người.
2. App toàn cầu mà dữ liệu chỉ VND/KRW? Đây là bộ dữ liệu minh họa. Quick Add có thêm USD/EUR/JPY nhưng chưa chứng minh phù hợp mọi thị trường.
3. Dự báo đáng tin không? Là kết quả tĩnh với giả định và khoản loại trừ. Lương 25/2 trễ đến 4/3 vượt ngày mục tiêu 28/2 nên hai kết quả khác nhau.

## Script và nộp bài

Script tiếng Hàn là bản nói tự nhiên, có hành động chỉ tay/phát video và Q&A. Video 60 giây đã tính trong mục tiêu 6 phút. Đây chưa phải thời gian rehearsal; người nói chậm cần tập và rút ví dụ nếu quá giờ.

Upload PDF trong 01_NOP_LEN_LMS và dán GitHub URL theo ô LMS. PPTX, video và script trong 02_THUYET_TRINH dùng để tập/trình bày; audit trong 03_TU_KIEM_TRA dùng tự rà. Không cần upload toàn bộ ZIP nếu LMS chỉ yêu cầu PDF và URL.

Hạn theo đề: trước 15:00 ngày 29/10/2026, giờ Hàn Quốc. Sau khi bấm nộp cần kiểm tra xác nhận của LMS.
