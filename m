Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0226AA11BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfH2G1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 02:27:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36963 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2G1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:27:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so2143427wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KytG/7ymtFjDfAwGsiRAdcQCUZ/+jD07+aAcotArQAM=;
        b=F/6PpjySuPHO3Vr9pJbSHRO8eFA76qOZDoN+BIsD25VHDwsqT4l7APHSnI+ns0V1mt
         xb+V0irdZafTDreUDZrgDPZJViG0japf/Tq1/yL1BsK5KwXZP4gDzMhyWmumnbKHUesu
         n+CsBpVJA2gjEhkDVC4nSckyeJSZTujLCYRMb7RtrbLqCi1KKmoFplhR6wgScRiLeNm5
         OLZdGwtvOsQY9/Ar6SP0dWSYeM7eFlJhi2f5n5G2F2SVQtaurQx8g5dCt9djeGbVRoGe
         mJQ3sHflXbMd55+/rH+/aYPKyOw/wAqLx0J5o8LC2ogC1Puc9ZDzfC7uPC7NQjr7DAip
         wJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KytG/7ymtFjDfAwGsiRAdcQCUZ/+jD07+aAcotArQAM=;
        b=nylYY5p/YG91i0AXsx3bh6xPs2RzdK9g+fKggZUjXFO8rQW2pmbGW9ZDpCUgu5eiC6
         4r0OACwl+4vWccjsbR/A+0/56CRESM/VtYDEDC8F3nSYE9+xVeaOaYkxL4iKXKqmHBDz
         NH5bKvXreBZtup4oZwc+1UbU0PiH+o8mSAFhaeo8tc32HJQBBGvd/nwV6awVtjRqPE/C
         6nxvn3ik0kILDXd1QE49ia7CtXTYZYBU0rH/OLWR5IxFiJoDx7DTUWcDQqDB07Wpox/2
         UPeC8z4JQ7+aFWLsbNYwswxRZ2hnmvIC6EizEjPZgzALx11xlU4u2FJLY/NmKU6UVTap
         PWBA==
X-Gm-Message-State: APjAAAU18gr0YIL7hyd6MuEllrbOoiiqWVz+xpftamqkp6egSzZFe9rj
        DO/t7iHWxOROiyUmx2nXWyk=
X-Google-Smtp-Source: APXvYqzv88pWkKrssjgISe1F1+aut5Zg+6TquaOWUXCZ2Bm7vgCSCNnrgxZhLfuIfdh0BkswyrsoSA==
X-Received: by 2002:adf:f801:: with SMTP id s1mr9347320wrp.320.1567060020018;
        Wed, 28 Aug 2019 23:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c201sm3095530wmd.33.2019.08.28.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 23:26:59 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
Date:   Wed, 28 Aug 2019 23:26:35 -0700
Message-Id: <20190829062635.45609-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
with clang:

arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
softirq.c:(.text+0x504): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
softirq.c:(.text+0x58c): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
softirq.c:(.text+0x6c8): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
softirq.c:(.text+0x75c): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
softirq.c:(.text+0x840): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow

clang can emit a working mcount symbol, __gnu_mcount_nc, when
'-meabi gnu' is passed to it. Until r369147 in LLVM, this was
broken and caused the kernel not to boot because the calling
convention was not correct. Now that it is fixed, add this to
the command line when clang is 10.0.0 or newer so everything
works properly.

Link: https://github.com/ClangBuiltLinux/linux/issues/35
Link: https://bugs.llvm.org/show_bug.cgi?id=33845
Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c3624ca6c0bc..7b5a26a866fc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
+ifeq ($(CONFIG_CC_IS_CLANG),y)
+ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
+CFLAGS_ABI	+=-meabi gnu
+endif
+endif
+
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
-- 
2.23.0

