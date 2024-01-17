// TODO!
// store settings here !

// Try to fetch data as little as possible. I/O operation are expensive AS FUCK


class CSharedPrefs {
  static CSharedPrefs? _instance;

  CSharedPrefs._();

  factory CSharedPrefs() {
    _instance ??= CSharedPrefs._();
    return _instance!;
  }

}