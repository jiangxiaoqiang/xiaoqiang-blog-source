---
title: findbugs
tags:
---

#### Bug类型说明

Minimum priority to report：根据bug的优先权级别报告bug。

Malicious code vulnerability：恶意代码。

Dodgy code：高危代码。FindBugs团队认为该类型下的问题代码导致bug的可能性很高。

Bad practice：最佳实践反例。这种类别下的代码违反了公认的最佳实践标准，比如某个类实现了equals方法但未实现hashCode方法等。

Correctness：正确性。这种归类下的问题在某种情况下会导致bug，比如错误的强制类型转换等。

Internationalization：国际化。

Performance：性能。潜在性能问题

Security：安全。

Mutithreaded correctness：多线程的正确性。关注于同步和多线程问题。

