## Aturan Arsitektur

- lib/domain DILARANG mengimpor package:flutter atau apa pun dari lib/data.
- Aturan bisnis dan validasi ditempatkan di domain, tidak pernah di widget.
- State pada Riverpod selalu DIGANTI (state = [...]), tidak pernah dimodifikasi (state.add(...)).
- Setiap perubahan pada domain wajib disertai unit test.