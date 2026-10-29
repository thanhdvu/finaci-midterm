# Audit theo góc nhìn người chấm

Ngày29/10/2026. Đây là đánh giá mô phỏng, không phải điểm của giáo sư.

| Mặt đánh giá | Nhận xét thẳng |
|---|---|
| Đúng đề | Đã có8bước, tài liệu, Flutter, JSON GET, trạng thái, responsive, PDF, repo và demo. Phải giữ rõ UI-only trong phần nói. |
| Hình thức | Bìa mới đồng bộ Finaci, các bảng theo lớp có cấu trúc. Phụ lục vẫn dày và cần zoom; không đọc hết khi chiếu. Chữ nhỏ trong review/screenshot là vật chứng, nên dùng phần tóm tắt khi trình bày. |
| Logic sản phẩm | Global là đối tượng sản phẩm. VND/KRW là kịch bản, không phải thị trường duy nhất. Chưa có nghiên cứu chứng minh tính phù hợp cho mọi quốc gia. |
| Chất lượng bằng chứng | Có20review, ảnh gốc, metadata và triage. Điểm yếu: mẫu nhiều vùng và nhiều review cũ; Outlook tái nhập dựa vào một trải nghiệm cá nhân, không có review trực tiếp. |
| Journey/5Why | Đúng khung lớp và giải thích hai loại low point. Cảm xúc không được đo trực tiếp; Why3–5 là giả thuyết nên không thể nhận trọn điểm nghiên cứu thực nghiệm. |
| Lập luận | Có lựa chọn và phản luận cụ thể. Phần bổ sung được trợ lý soạn theo ủy quyền không thay thế việc người trình bày tự hiểu và bảo vệ quyết định. |
| Flutter | Widget, GET, trạng thái và layout bám lớp. Việc đổi ký hiệu tiền chỉ là biểu diễn; không có thuật toán tài chính. Các tab ngoài phạm vi có phản hồi demo, không phải app hoàn chỉnh. |
| Video | Nhúng MP4 trong PPTX; PDF có poster và link. Video là bằng chứng chạy UI, không chứng minh usability tốt hơn. |
| Cảm giác người thật làm | Có dấu vết thử app và sửa scope cụ thể. Không thể xác định tác giả qua font hoặc thiết kế. Nếu chỉ đọc bảng hoặc không giải thích được tradeoff thì bài vẫn có cảm giác phụ thuộc AI. |

## Rubric

| Hạng mục | Ước lượng có căn cứ |
|---|---:|
| Kế hoạch40 | 34–36 |
| Tự lập luận20 | 15–17 |
| Flutter25 | 22–24 |
| Trình bày15 | Chưa chấm thực hiện; khả năng10–13 nếu rehearsal và trả lời tốt |
| Vercel | Đạt điều kiện kỹ thuật đề xuất+5; quyền quyết định thuộc thầy |

Mốc tự đánh giá86+5=91 là mức chuẩn bị tham khảo. Không có cơ sở hứa điểm91; điểm trình bày và khả năng bảo vệ quyết định chưa được quan sát.

## Ba câu giáo sư có khả năng xoáy vào

1. Tại sao chọn Outlook trong khi review phàn nàn Sync nhiều hơn? Trả lời bằng trải nghiệm trực tiếp, khả năng cải thiện UI và phạm vi môn; đừng nói nó là vấn đề lớn nhất của mọi người.
2. App toàn cầu mà chỉ có VND/KRW? Nêu rõ phân biệt đối tượng sản phẩm với bộ dữ liệu demo. Không cần giả vờ đã kiểm chứng thêm thị trường.
3. Dự báo có đáng tin không? Giải thích giả định, khoản loại trừ và kịch bản vượt ngày mục tiêu. Đây là prototype biểu đạt kế hoạch, không phải kết quả tài chính được bảo đảm.
