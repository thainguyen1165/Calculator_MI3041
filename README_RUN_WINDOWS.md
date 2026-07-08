# Cách chạy dự án trên Windows

## Cách dễ chạy nhất

1. Giải nén thư mục dự án.
2. Mở thư mục dự án.
3. Bấm đúp `RUN_APP.bat`.
4. Chờ cửa sổ CMD cài thư viện lần đầu. Sau đó app sẽ tự mở trên trình duyệt.

> Lưu ý: cửa sổ CMD phải được giữ mở trong lúc dùng app. Đóng CMD thì app sẽ tắt.

## Nếu muốn chạy dạng cửa sổ desktop

Bấm đúp `RUN_DESKTOP_APP.bat`.

Nếu cách desktop lỗi do `pywebview` hoặc WebView2, dùng `RUN_APP.bat` vì đây là bản ổn định hơn.

## Nếu hiện “Press any key to continue”

Dòng đó chỉ là CMD báo file `.bat` đã kết thúc. Hãy nhìn phần lỗi ngay phía trên nó:

- `Khong tim thay Python`: cài Python 3.10 hoặc 3.11, nhớ tick **Add Python to PATH**.
- `Cai thu vien that bai`: kiểm tra mạng Internet rồi chạy lại.
- Nếu đang dùng Python 3.13 mà lỗi thư viện khoa học, nên cài thêm Python 3.11.

## Build thành file `.exe`

1. Chạy `RUN_DESKTOP_APP.bat` trước để chắc chắn app chạy được.
2. Chạy `build_desktop_windows.bat`.
3. File `.exe` sẽ nằm trong:

```text
dist\Numerical Calculator\Numerical Calculator.exe
```

Khi gửi cho máy khác, gửi cả thư mục `dist\Numerical Calculator`, không gửi riêng file `.exe`.
