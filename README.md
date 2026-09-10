<p align="center">
  <strong>幻盘（Huanri Portable）</strong>
</p>
<p align="center">
  <strong>把常驻 AI 分身装进 U 盘：插上任意电脑，人设、记忆、通道都跟着走，双击就能跟你说话。</strong>
</p>

<p align="center">
  <a href="docs/快速上手.md">📖 快速上手</a> ·
  <a href="docs/定价.md">💰 定价</a> ·
  <a href="#english">English</a>
</p>

> [!IMPORTANT]
> 这不是一个要「安装到系统里」的软件。整个 `portable/` 目录就是你的分身家当，
> 拷进 U 盘、跑一次 `setup`、双击 `start`，它就一直在线。
> 所有配置、记忆、会话都落在 U 盘的 `data/` 里——**拔盘不留痕，换盘跟人走**。

---

## 三步开始

1. 把 `portable/` 整个拷进 U 盘。
2. **Windows** 双击 `setup.bat` / **macOS·Linux** 跑 `./setup.sh`（装运行时，一次）。
3. 双击 `start.bat` / 跑 `./start.sh`，按向导填模型 Key 和通道，你的分身就上线了。

📺 图文版见 [docs/快速上手.md](docs/快速上手.md)。

## 你得到什么

| 你得到什么 | 为什么重要 |
| --- | --- |
| **常驻**，不是问答机器人 | 它一直在线，接在你常用的聊天工具上，有脾气有记忆，不是「问一句答一句」 |
| **随身** | 整台分身的家当都在 U 盘的 `data/`，换电脑插上还是它 |
| **跟人走，不留痕** | 配置/记忆/会话全在盘里，拔盘主机上干干净净 |
| **多通道** | QQ / Telegram / Discord / 微信 / 飞书 / 邮件… 插上就能接 |
| **像你** | 一份 `persona.md` 写清楚性格和边界，它说话就像你 |
| **本地优先** | 数据不上传，你的记忆只在你自己的盘上 |

## 平台支持

| 平台 | 状态 |
| --- | --- |
| Windows | ✅ 双击即用 |
| macOS | ✅ `./setup.sh` + `./start.sh` |
| Linux | ✅ 同上（进阶：可做成可启动 U 盘） |

## 技术底座

技术核心是开源的 [Hermes Agent](https://github.com/NousResearch/hermes-agent)（MIT）。
幻盘做的是它外面那一层：**便携化（U 盘骨架 + setup/start）、配置跟人走（HERMES_HOME）、
开箱即用（向导）、多通道接入**。
Hermes 本体你不用管，`setup` 时自动装好。

---

## 💰 定价

一句话：**软件免费开源，U 盘收个成本价，真正持续赚钱的是模型额度和落地服务。**
U 盘是钩子、软件是信任、token 是现金流、落地是大单。详见 [docs/定价.md](docs/定价.md)。

---

<a id="english"></a>
## English

**Huanri Portable — put a resident AI avatar on a USB drive.** Plug it into any
computer and your AI's persona, memory, and chat channels come with it —
double-click and it's online.

The core is the open-source [Hermes Agent](https://github.com/NousResearch/hermes-agent).
Huanri wraps it in a portable skeleton: copy `portable/` onto a USB stick,
run `setup` once, double-click `start`, fill in your model key + a channel, done.
Everything (config, memory, sessions, persona) lives on the drive —
**no trace left behind when you unplug.**

- **Windows** · double-click `setup.bat` / `start.bat`
- **macOS / Linux** · `./setup.sh` then `./start.sh`

License: [MIT](LICENSE).
