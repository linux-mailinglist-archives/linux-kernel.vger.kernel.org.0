Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3C172B25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgB0W1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:27:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16836 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgB0W0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842412; x=1614378412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHUEM7B8bQdVUOO+XqChXw4fxBDln7t5tGAkDnrQZUI=;
  b=a4EbtNIAQJ0hsha3z3gwgTUBoWHFjtkc4A3Tp0DmiUp7jTEbM2rMei/9
   QtzUpd8wOOI6HmME1DiKNrlblbqgvV4CFHwTK+NftwBw2ZmJdlT41uaxd
   8u6zvBG/RxdY9woiDbxxN8M/uoSkEYhrweJ+SPkrN4U03aD/8iSsdofMO
   0Kw35VT9AQPy3I0DtbPwddp0sm1fCeCfEbcujSoozYqcSgz3rCCQos/+a
   vsHqshysNWMotVWdT9CLbSeQxS/bTxIE/q82vZR99y7dT2lyZzEcLJ8NY
   LOBVTHqeX6K9MbK5OREtKC56OblwzktSstuGQBx+tdNArbRXkAVNp/11M
   g==;
IronPort-SDR: W/T68Ut15ZjZkGPFnd+OwM6wPaY/s0kVelz2lkowHAkysRHskHjGBeLfF1WV7+YAR2lssrIVJj
 ESmJdE7N8+Ey4dpihxgOv91B8/Ro2Eca/vg39+DmamqCv9Yqi0aYW1SvUW4ND8WqsOqa3b79yJ
 1dkUStIMlfRlQAgtQ6lE60eCiquC0Ks8iHD2Qml4ej8HDdAL0xS6K2pKQWHNnozyS7DdY32oq7
 qs+bpoMaB+/hn7iwlU4jCF6rg3AMerRDVBkyu9HTBqZgcaP4VSNzG3opMENcLhXoNhwo0Qq8vS
 faQ=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="131459856"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:26:51 +0800
IronPort-SDR: R8MTpoHkf6RcJ2TY9G2kRPMKZZVPKJFSt7LXFtke6A0WJd1lW/HZ3wW9AeoF6IwBZaxz7FzDXx
 UPVMiazfUJ6tHitywBtsuSq5+rZ59aK3S2P5/m1h1KfeADC7CMM8ocbmSVv6BWkAnrYhrgQWx/
 cV8y+9TNwfS+3wsL0UaPwyBKnF0t2U4OUEaosmnWpHQVJzWpVHjX6tljwRIHJgcVea5/5SY9Q0
 jwsUWg4GEW0OoVOXcVYNW7OCwbAT33P5aj3ftVey0XabCvBBm5iyddEuGDvDawJcW7ZcNt29vt
 GAz3wU2lxdkS5M8crcMO0C9I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:19:14 -0800
IronPort-SDR: YD6YeGhFTlMMzdBLGRQBddTkJ6fAkSTBalLAPGagkJGff3jvnk7ShMgdkHvtKi9lHv93MiTJbP
 FV0+/TE0pxagvgx828IfHnvvjOqvC2T8v+6Ty+CgZmCQXQSyiDRddCYok6zWKkRmESGV4x2Fw9
 mKVzPNX0rl/ZGJ1gk3abMm6UWic9LMlHkU0O7g25BCdLp9h4g/687VuCmXgx+ZO+Jn1OMi9Fr3
 zVwGYMMJ7kONZzI2JEyWWz0rQ6T787ZP9WDvADtR0PbT3QYUvWWcCI9gCmCRK3g2X/LVCoiIV1
 ulE=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2020 14:26:50 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [v1 PATCH 3/5] RISC-V: Define fixmap bindings for generic early ioremap support
Date:   Thu, 27 Feb 2020 14:26:42 -0800
Message-Id: <20200227222644.9468-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227222644.9468-1-atish.patra@wdc.com>
References: <20200227222644.9468-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI uses early IO or memory mappings for runtime services before
normal ioremap() is usable. This patch only adds minimum necessary
fixmap bindings and headers for generic ioremap support to work.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/fixmap.h | 21 ++++++++++++++++++++-
 arch/riscv/include/asm/io.h     |  1 +
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 27bfc7947e44..42c122170cfd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select GENERIC_EARLY_IOREMAP
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index ec0ca8c6ab64..517394390106 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += checksum.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += dma.h
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 42d2c42f3cc9..7a4beb7e29a3 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -25,9 +25,28 @@ enum fixed_addresses {
 #define FIX_FDT_SIZE	SZ_1M
 	FIX_FDT_END,
 	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+	FIX_EARLYCON_MEM_BASE,
+
 	FIX_PTE,
 	FIX_PMD,
-	FIX_EARLYCON_MEM_BASE,
+	/*
+	 * Make sure that it is 2MB aligned.
+	 */
+#define NR_FIX_SZ_2M	(SZ_2M / PAGE_SIZE)
+	FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
+
+	__end_of_permanent_fixed_addresses,
+	/*
+	 * Temporary boot-time mappings, used by early_ioremap(),
+	 * before ioremap() is functional.
+	 */
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define FIX_BTMAPS_SLOTS	7
+#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
+
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
+
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 0f477206a4ed..047f414b6948 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <asm/mmiowb.h>
 #include <asm/pgtable.h>
+#include <asm/early_ioremap.h>
 
 /*
  * MMIO access functions are separated out to break dependency cycles
-- 
2.24.0

