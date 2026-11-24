# 📚 Asahi Brewery Cyberattack Analysis — Documentation

> Tài liệu phân tích chi tiết vụ tấn công ransomware Qilin vào Asahi Group Holdings (09/2025)

---

## 📑 Document Index

| # | Document | Description |
| :--- | :--- | :--- |
| 1 | [Attack Chain & MITRE ATT&CK](attack-chain-and-mitre.md) | Phân tích chuỗi tấn công 5 giai đoạn, mapping MITRE ATT&CK, CIA Triad |
| 2 | [Risk Assessment](risk-assessment.md) | Đánh giá rủi ro (5×5 Risk Matrix), NIST CSF 2.0 Gap Analysis, Business Impact |
| 3 | [Proposed Infrastructure](proposed-infrastructure.md) | Kiến trúc bảo mật đề xuất Defense-in-Depth 5 lớp, so sánh trước/sau |
| 4 | [Lab Environment](lab-environment.md) | Mô tả môi trường lab VMware, bằng chứng từ demo video, topology |
| 5 | [VMware Workstation Setup](vmware-workstation-setup.md) | Hướng dẫn thiết lập môi trường lab VMware từ đầu |
| 6 | [Recovery & Limitations](recovery-and-limitations.md) | Phân tích quá trình khôi phục của Asahi, hạn chế nghiên cứu, hướng phát triển |
| 7 | [Upload Guide](upload-guide.md) | Hướng dẫn đẩy project lên GitHub, xử lý file lớn (Git LFS) |

## 📊 Original Documents

| Document | Format | Description |
| :--- | :--- | :--- |
| [Presentation Slides](ASAHI_BREWERY_CYBERATTACK_Slides.pdf) | PDF | 30+ slides thuyết trình đầy đủ phân tích |
| [Full Technical Report](Bao_Cao_ASAHI_BREWERY_CYBERATTACK.docx) | DOCX | Báo cáo kỹ thuật 40 trang (Tiếng Việt) |

## 🎥 Demo

| Resource | Location | Description |
| :--- | :--- | :--- |
| Lab Demo Video | [`demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) | 1 phút 41 giây — Full demo Spear-Phishing → C2 → Ransomware |
| Lab Walkthrough | [`lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md) | Hướng dẫn tái dựng từng bước |
| Metasploit Script | [`lab-simulation/handler.rc`](../lab-simulation/handler.rc) | Resource script cho multi-handler |

### Bằng chứng hiển thị trong demo

Video demo dài khoảng 1 phút 41 giây, độ phân giải 1780 × 1080 pixel, 30 khung hình mỗi giây.

| Hạng mục | Quan sát |
| :--- | :--- |
| Nền tảng ảo hóa | VMware Workstation |
| Máy ảo 1 | Kali Linux |
| Máy ảo 2 | Windows 10 x64 |

Các chi tiết cấu hình chưa thu hồi không được mô tả là bằng chứng quan sát trực tiếp.

---

## 🏫 Academic Context

| | Details |
| :--- | :--- |
| **Trường** | Đại học Công nghệ TP. HCM (HUTECH) |
| **Môn học** | An toàn thông tin / Phân tích sự cố an ninh mạng |
| **GVHD** | Ths. Phan Đình Duy Thông |
| **Nhóm** | Tiêu Hoàng Phúc · Nguyễn Nam Trường · Nguyễn Phú Đạt |
| **Lớp** | 22DTHA1 — Ngành: CNTT / Chuyên ngành: An ninh mạng |
| **Năm** | 2026 |
