# testflea.nvim 🪰

Jump like a flea — but into your tests, not someone’s head!  

![Flea Mascot](./assets/mascot.jpeg)

**testflea.nvim** is a tiny Neovim plugin that gives you a fast way to jump between **source files** and their corresponding **test files**, especially when your repo stores them in different directories (e.g., `src/` and `tests/`).  

---

## ✨ Features

- Super-fast jump from **source → test** file.
- Keeps a simple and predictable mapping between `src/` and `tests/`.
- Lightweight and fun — no fleas harmed. 🐾  

Example:  
```
src/some\_package/some\_file.py
tests/some\_package/test\_some\_file.py
```

With `testflea.nvim`, you can instantly jump from `src/some_package/some_file.py`  
➡️ `tests/some_package/test_some_file.py`.

---

## ⌨️ Usage

By default, press:

```

<leader>ft
OR


````

…and you’re in the test file! 🎉  

---

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  {
    "mangin/test-flea.nvim",
    opts = {
      src_directory = "src",
      tests_directory = "tests",
      debug = true,
    },
  }
}
````

---

## ⚡ Philosophy

Because sometimes finding your tests shouldn’t feel like a wild goose chase.
With **testflea.nvim**, you hop straight where you need to be — just like a flea.

---

## 📝 License

MIT
