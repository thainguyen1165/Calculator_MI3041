# Chạy Numerical Calculator như app trên Windows

Project gốc là Flask web app. Các file này thêm lớp desktop wrapper bằng `pywebview`: app vẫn dùng giao diện HTML/CSS/JS hiện có, nhưng mở trong cửa sổ desktop riêng, không cần tự mở trình duyệt.

## Cách chạy thử dạng app

1. Cài Python 3.10 hoặc 3.11 cho Windows.
2. Mở thư mục project.
3. Bấm đúp `RUN_DESKTOP_TEST.bat`.
4. Nếu chạy thành công, app sẽ mở bằng cửa sổ riêng tên **Numerical Calculator**.

## Cách build ra app .exe

1. Bấm đúp `build_desktop_windows.bat`.
2. Đợi quá trình cài thư viện và đóng gói hoàn tất.
3. File chạy sẽ nằm tại:

```text
dist\Numerical Calculator\Numerical Calculator.exe
```

Bạn có thể tạo shortcut của file `.exe` này ra Desktop.

## Lưu ý

- Lần đầu build có thể lâu vì phải tải Flask, NumPy, SciPy, SymPy, pandas, pywebview và PyInstaller.
- Nên dùng dạng `--onedir` như file `.bat` này vì các thư viện khoa học như NumPy/SciPy khá nặng; dạng một file duy nhất thường mở chậm và dễ lỗi hơn.
- Khi gửi app cho máy khác, hãy gửi cả thư mục `dist\Numerical Calculator`, không chỉ gửi riêng file `.exe`.
