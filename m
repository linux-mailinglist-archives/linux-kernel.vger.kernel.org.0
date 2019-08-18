Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8B91935
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 21:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHRTNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 15:13:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33794 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:13:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so1190024wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eItUq57lzuEyxOyGZwQoMhoYPdZi6IDY86pDynuNHFQ=;
        b=jOAP1YSP++R2gAWpAygJcBtWwWzNM+/grIpmaCngPE95Cx9uOWFNjBmToxIc42WCfT
         Jt24X3uoz17QrtrC7Leo/eZXwYzGQKSbwOyMFkaVgLOmM3IzezTEwI1hFO90xFYeylLb
         puqD5E5C4mw4qVyxowLvgnn1CIbJdXOd2lyD8i6zteoPxsXret2AH20kdZ2Xk2qBQTo5
         3XQcLLF8cEgcqqiIbUD1GL4bQpz3JYWvZn/zBqGHitiuid6jp+voBO9gS0Dl9Rd0AgPx
         35XyLyMeroXH0fD3y7oyep04pA+mrJPtRxRCzMbvmBBjnN3MZekt4xDMb4DMIZqIH0S+
         mkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eItUq57lzuEyxOyGZwQoMhoYPdZi6IDY86pDynuNHFQ=;
        b=rNsEz0x2q3axod5FJBaCMAmJrk6QBnpaOykkeZ6RCGPUrrjg9z/KZ/aEt61tOF9mME
         V0zJ1JVOI3CovJGYbXZdTMfoNHoPF4+mY9qf00HpKcbX6N8wxmvfl8gZWYsXGocfFtL8
         vFyx20z5jLwsKCmQESTkZp3yGvC0lLP9Rtj+F33sipMvJq28TT859Glp/zh9F90JIzHl
         8IwQm8Sf17H8jKwZFOABVf6XBmRvdOS7B0a01bRaARLYyAppjNtr65Wo6lXIYhw9JBs/
         +qPcMw7hmbnJnWDeIC6P9LDtXhGiDeOvdnWAUK/P4PKbr563hSVjCkYGL5Mt+DPBZN7Z
         Kszw==
X-Gm-Message-State: APjAAAXux62fLnEccgzVhwBqv/5JQk7jwZXg3sVu/9JcVjDHFLuDPVAn
        DF24DSE5UjGtV26XodpffsM=
X-Google-Smtp-Source: APXvYqxWsHGe/k20qP1luPVjPo9gxvf6E1ffTQMQA5wmY/d7ZHcq7uya7ADq0ed1SLYd1s5SX5sqJw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17481652wmk.90.1566155618001;
        Sun, 18 Aug 2019 12:13:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id e14sm8647033wme.35.2019.08.18.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 12:13:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] powerpc: Don't add -mabi= flags when building with Clang
Date:   Sun, 18 Aug 2019 12:13:21 -0700
Message-Id: <20190818191321.58185-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building pseries_defconfig, building vdso32 errors out:

  error: unknown target ABI 'elfv1'

Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
powerpc64le toolchain") added these flags to fix building GCC but
clang is multitargeted and does not need these flags. The ABI is
properly set based on the target triple, which is derived from
CROSS_COMPILE.

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0-rc2/clang/lib/Driver/ToolChains/Clang.cpp#L1782-L1804

-mcall-aixdesc is not an implemented flag in clang so it can be
safely excluded as well, see commit 238abecde8ad ("powerpc: Don't
use gcc specific options on clang").

pseries_defconfig successfully builds after this patch and
powernv_defconfig and ppc44x_defconfig don't regress.

Link: https://github.com/ClangBuiltLinux/linux/issues/240
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c345b79414a9..971b04bc753d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -93,11 +93,13 @@ MULTIPLEWORD	:= -mmultiple
 endif
 
 ifdef CONFIG_PPC64
+ifndef CONFIG_CC_IS_CLANG
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
+endif
 
 ifndef CONFIG_CC_IS_CLANG
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
@@ -144,6 +146,7 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
+ifndef CONFIG_CC_IS_CLANG
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
@@ -152,6 +155,7 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
+endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 
-- 
2.23.0

