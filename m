Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB1394F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfFGS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:56:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pmFDxSsRk1M8bfZ7S6JeBiIYyY9t9gaet+YP0uTnnHE=; b=c5mRiADSYebox16EqWTDJjfXpT
        hPKcy1AtQ/hlVeRzKd/Dt9jAuZ4YT24Y/f2SLOAZfrSiJaImTsYcIysl9xD+13OYzax5dA2J9EFei
        yGB63v8JuDSIHACpfSD1ujr3epcThKrTFg1d1Wfnj1vy8HeGxUtkJzju66ofeabZsFgY0cZbCR7dG
        FYBwqrIHPPY1VGC6jdWiilYhDmpmmfR+LSujReyO/Y31ZFaPr9kmlCDeuF7trNEotlyk2jMUPaDhC
        J5OaGFghBQabWLpIXciC7ufRo5ifqCInKKup1ZXc23WeY0AL97MLjkTDe6BwhDgavyEKLiCctc5nY
        NPs9GEBw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sY-Jj; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Eu-D9; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v3 08/20] docs: zh_CN: avoid duplicate citation references
Date:   Fri,  7 Jun 2019 15:54:24 -0300
Message-Id: <3c26852c46db3a56cb5f42765db0cc5c64334986.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/process/management-style.rst:35: WARNING: duplicate label decisions, other instance in     Documentation/translations/zh_CN/process/management-style.rst
    Documentation/process/programming-language.rst:37: WARNING: duplicate citation c-language, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:38: WARNING: duplicate citation gcc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:39: WARNING: duplicate citation clang, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:40: WARNING: duplicate citation icc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:41: WARNING: duplicate citation gcc-c-dialect-options, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:42: WARNING: duplicate citation gnu-extensions, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:43: WARNING: duplicate citation gcc-attribute-syntax, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:44: WARNING: duplicate citation n2049, other instance in     Documentation/translations/zh_CN/process/programming-language.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../zh_CN/process/management-style.rst        |  4 +-
 .../zh_CN/process/programming-language.rst    | 59 ++++++++++++++-----
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/management-style.rst b/Documentation/translations/zh_CN/process/management-style.rst
index a181fa56d19e..c6a5bb285797 100644
--- a/Documentation/translations/zh_CN/process/management-style.rst
+++ b/Documentation/translations/zh_CN/process/management-style.rst
@@ -28,7 +28,7 @@ Linux内核管理风格
 
 不管怎样，这里是：
 
-.. _decisions:
+.. _cn_decisions:
 
 1）决策
 -------
@@ -108,7 +108,7 @@ Linux内核管理风格
 但是，为了做好作为内核管理者的准备，最好记住不要烧掉任何桥梁，不要轰炸任何
 无辜的村民，也不要疏远太多的内核开发人员。事实证明，疏远人是相当容易的，而
 亲近一个疏远的人是很难的。因此，“疏远”立即属于“不可逆”的范畴，并根据
-:ref:`decisions` 成为绝不可以做的事情。
+:ref:`cn_decisions` 成为绝不可以做的事情。
 
 这里只有几个简单的规则：
 
diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 51fd4ef48ea1..2a47a1d2ec20 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -8,21 +8,21 @@
 程序设计语言
 ============
 
-内核是用C语言 [c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [gcc]_
-在 ``-std=gnu89`` [gcc-c-dialect-options]_ 下编译的：ISO C90的 GNU 方言（
+内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
+在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C90的 GNU 方言（
 包括一些C99特性）
 
-这种方言包含对语言 [gnu-extensions]_ 的许多扩展，当然，它们许多都在内核中使用。
+这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
 
-对于一些体系结构，有一些使用 ``clang`` [clang]_ 和 ``icc`` [icc]_ 编译内核
+对于一些体系结构，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 编译内核
 的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
 
 属性
 ----
 
-在整个内核中使用的一个常见扩展是属性（attributes） [gcc-attribute-syntax]_
+在整个内核中使用的一个常见扩展是属性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
 属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
-重大的语法更改（例如添加新关键字） [n2049]_
+重大的语法更改（例如添加新关键字） :ref:`n2049 <cn_n2049>`
 
 在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
 即使其速度较慢或执行的编译时检查/诊断次数不够）
@@ -31,11 +31,42 @@
 ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
 请参阅 ``include/linux/compiler_attributes.h``
 
-.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
-.. [gcc] https://gcc.gnu.org
-.. [clang] https://clang.llvm.org
-.. [icc] https://software.intel.com/en-us/c-compilers
-.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
-.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
-.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
-.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+.. _cn_c-language:
+
+c-language
+   http://www.open-std.org/jtc1/sc22/wg14/www/standards
+
+.. _cn_gcc:
+
+gcc
+   https://gcc.gnu.org
+
+.. _cn_clang:
+
+clang
+   https://clang.llvm.org
+
+.. _cn_icc:
+
+icc
+   https://software.intel.com/en-us/c-compilers
+
+.. _cn_gcc-c-dialect-options:
+
+c-dialect-options
+   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+
+.. _cn_gnu-extensions:
+
+gnu-extensions
+   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+
+.. _cn_gcc-attribute-syntax:
+
+gcc-attribute-syntax
+   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+
+.. _cn_n2049:
+
+n2049
+   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
-- 
2.21.0

