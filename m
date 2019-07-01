Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53786494E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 00:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfFQWLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 18:11:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33980 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFQWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:11:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so4751414plt.1;
        Mon, 17 Jun 2019 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=470HXzuWWndUIvDjd8YDkOfADh+SPCvxxBbRCAgfY5o=;
        b=iXevDhzZu3jZHvo3RDUU4pNdAnX8b0t4cbdJ8upw8Rt3XHFmOuMFv40j83BHpOW/v6
         OvDjz2Q8tF8YNGenahEJO9EtqtuJhU1OGSyB3PscGTt88p8MhInqLCT3rp2VLPhDlmuD
         fiNcxPmWb+QS7RGTWeOqxkipU8jOn9SeXeh8cN1i/G31EiLMcjPjBfoQZ+81HhFxPQux
         lVZ6QFhZEEKOxJm4VKJOau6n5/iWQzA3+UYkXFJxLNHE5oWMZMD4Mv3xQdgVkc4QhU4q
         jHPF2Ib2dYHr95CV5o1WrAJtMV53u6M+jekjFw3ybhK0j7gK0UghcYs/zjH60ze30TFD
         oF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=470HXzuWWndUIvDjd8YDkOfADh+SPCvxxBbRCAgfY5o=;
        b=B6mlwHGLjpkeAC9cZVutkZGT9TL91OBgHkaQk2yjVDwsf5yeNEou0Ay4XN7FT0LJXm
         JCG7FFmJwvLkyobk4jSdlNYwCoFiEZSJcwbxx5uJbGwfx/bOT2KpwQ6ZQ7DJEeckrHgs
         bIBzKMn/PFGoiNk6LbfEurM+1B9ZU2KA4batBXvxdpIae61DUBIUmBstGDZFmb0HA2L8
         +md01Cw6jHaoB/WCyI8oq1iVCnbjswfasX5TYd9Rx72yqQeWZGzZYiamsPj95cJqJwvR
         XdcpdlDQmVv+VxXN/EzzS3V+zYHqZMHXUA0EZlvSuDgo9SY5m5YGU4bwtKuLRh/uFIFo
         iofg==
X-Gm-Message-State: APjAAAUVnDgkhiKfaYCRBiWvly1dfb587CffTJD4x9HuS4rz7W+t5y3Q
        Czkm395lBnrG6lPyVzYIXdk=
X-Google-Smtp-Source: APXvYqwp71SY8mJh+r6YgZRTEE2ftVVoPwHdHVtASONmSwrQ4h5e6wl9kaENMEQwTADjKzzbvAMc7A==
X-Received: by 2002:a17:902:7249:: with SMTP id c9mr3904755pll.25.1560809503214;
        Mon, 17 Jun 2019 15:11:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s129sm12551020pfb.186.2019.06.17.15.11.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:11:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Florian Fainelli <f.fainelli@gmail.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, rob@landley.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
        geert@linux-m68k.org, andre.przywara@arm.com,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        ryabinin.a.a@gmail.com
Subject: [PATCH v6 1/6] ARM: Add TTBR operator for kasan_init
Date:   Mon, 17 Jun 2019 15:11:29 -0700
Message-Id: <20190617221134.9930-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617221134.9930-1-f.fainelli@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abbott Liu <liuwenliang@huawei.com>

The purpose of this patch is to provide set_ttbr0/get_ttbr0 to
kasan_init function. The definitions of cp15 registers should be in
arch/arm/include/asm/cp15.h rather than arch/arm/include/asm/kvm_hyp.h,
so move them.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cp15.h    | 106 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/kvm_hyp.h |  54 -----------------
 arch/arm/kvm/hyp/cp15-sr.c     |  12 ++--
 arch/arm/kvm/hyp/switch.c      |   6 +-
 4 files changed, 115 insertions(+), 63 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index d2453e2d3f1f..0b0ac5170ee7 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -3,6 +3,7 @@
 #define __ASM_ARM_CP15_H
 
 #include <asm/barrier.h>
+#include <linux/stringify.h>
 
 /*
  * CR1 bits (CP#15 CR1)
@@ -70,8 +71,113 @@
 
 #define CNTVCT				__ACCESS_CP15_64(1, c14)
 
+#define TTBR0_32	__ACCESS_CP15(c2, 0, c0, 0)
+#define TTBR1_32	__ACCESS_CP15(c2, 0, c0, 1)
+#define PAR_32		__ACCESS_CP15(c7, 0, c4, 0)
+#define TTBR0_64	__ACCESS_CP15_64(0, c2)
+#define TTBR1_64	__ACCESS_CP15_64(1, c2)
+#define PAR_64		__ACCESS_CP15_64(0, c7)
+#define VTTBR		__ACCESS_CP15_64(6, c2)
+#define CNTP_CVAL      __ACCESS_CP15_64(2, c14)
+#define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
+#define CNTVOFF		__ACCESS_CP15_64(4, c14)
+
+#define MIDR		__ACCESS_CP15(c0, 0, c0, 0)
+#define CSSELR		__ACCESS_CP15(c0, 2, c0, 0)
+#define VPIDR		__ACCESS_CP15(c0, 4, c0, 0)
+#define VMPIDR		__ACCESS_CP15(c0, 4, c0, 5)
+#define SCTLR		__ACCESS_CP15(c1, 0, c0, 0)
+#define CPACR		__ACCESS_CP15(c1, 0, c0, 2)
+#define HCR		__ACCESS_CP15(c1, 4, c1, 0)
+#define HDCR		__ACCESS_CP15(c1, 4, c1, 1)
+#define HCPTR		__ACCESS_CP15(c1, 4, c1, 2)
+#define HSTR		__ACCESS_CP15(c1, 4, c1, 3)
+#define TTBCR		__ACCESS_CP15(c2, 0, c0, 2)
+#define HTCR		__ACCESS_CP15(c2, 4, c0, 2)
+#define VTCR		__ACCESS_CP15(c2, 4, c1, 2)
+#define DACR		__ACCESS_CP15(c3, 0, c0, 0)
+#define DFSR		__ACCESS_CP15(c5, 0, c0, 0)
+#define IFSR		__ACCESS_CP15(c5, 0, c0, 1)
+#define ADFSR		__ACCESS_CP15(c5, 0, c1, 0)
+#define AIFSR		__ACCESS_CP15(c5, 0, c1, 1)
+#define HSR		__ACCESS_CP15(c5, 4, c2, 0)
+#define DFAR		__ACCESS_CP15(c6, 0, c0, 0)
+#define IFAR		__ACCESS_CP15(c6, 0, c0, 2)
+#define HDFAR		__ACCESS_CP15(c6, 4, c0, 0)
+#define HIFAR		__ACCESS_CP15(c6, 4, c0, 2)
+#define HPFAR		__ACCESS_CP15(c6, 4, c0, 4)
+#define ICIALLUIS	__ACCESS_CP15(c7, 0, c1, 0)
+#define BPIALLIS	__ACCESS_CP15(c7, 0, c1, 6)
+#define ICIMVAU		__ACCESS_CP15(c7, 0, c5, 1)
+#define ATS1CPR		__ACCESS_CP15(c7, 0, c8, 0)
+#define TLBIALLIS	__ACCESS_CP15(c8, 0, c3, 0)
+#define TLBIALL		__ACCESS_CP15(c8, 0, c7, 0)
+#define TLBIALLNSNHIS	__ACCESS_CP15(c8, 4, c3, 4)
+#define PRRR		__ACCESS_CP15(c10, 0, c2, 0)
+#define NMRR		__ACCESS_CP15(c10, 0, c2, 1)
+#define AMAIR0		__ACCESS_CP15(c10, 0, c3, 0)
+#define AMAIR1		__ACCESS_CP15(c10, 0, c3, 1)
+#define VBAR		__ACCESS_CP15(c12, 0, c0, 0)
+#define CID		__ACCESS_CP15(c13, 0, c0, 1)
+#define TID_URW		__ACCESS_CP15(c13, 0, c0, 2)
+#define TID_URO		__ACCESS_CP15(c13, 0, c0, 3)
+#define TID_PRIV	__ACCESS_CP15(c13, 0, c0, 4)
+#define HTPIDR		__ACCESS_CP15(c13, 4, c0, 2)
+#define CNTKCTL		__ACCESS_CP15(c14, 0, c1, 0)
+#define CNTP_CTL	__ACCESS_CP15(c14, 0, c2, 1)
+#define CNTV_CTL	__ACCESS_CP15(c14, 0, c3, 1)
+#define CNTHCTL		__ACCESS_CP15(c14, 4, c1, 0)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
+static inline void set_par(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, PAR_64);
+	else
+		write_sysreg(val, PAR_32);
+}
+
+static inline u64 get_par(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(PAR_64);
+	else
+		return read_sysreg(PAR_32);
+}
+
+static inline void set_ttbr0(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, TTBR0_64);
+	else
+		write_sysreg(val, TTBR0_32);
+}
+
+static inline u64 get_ttbr0(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(TTBR0_64);
+	else
+		return read_sysreg(TTBR0_32);
+}
+
+static inline void set_ttbr1(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, TTBR1_64);
+	else
+		write_sysreg(val, TTBR1_32);
+}
+
+static inline u64 get_ttbr1(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(TTBR1_64);
+	else
+		return read_sysreg(TTBR1_32);
+}
+
 static inline unsigned long get_cr(void)
 {
 	unsigned long val;
diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 87bcd18df8d5..484d35e5bb36 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -36,60 +36,6 @@
 	__val;							\
 })
 
-#define TTBR0		__ACCESS_CP15_64(0, c2)
-#define TTBR1		__ACCESS_CP15_64(1, c2)
-#define VTTBR		__ACCESS_CP15_64(6, c2)
-#define PAR		__ACCESS_CP15_64(0, c7)
-#define CNTP_CVAL	__ACCESS_CP15_64(2, c14)
-#define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
-#define CNTVOFF		__ACCESS_CP15_64(4, c14)
-
-#define MIDR		__ACCESS_CP15(c0, 0, c0, 0)
-#define CSSELR		__ACCESS_CP15(c0, 2, c0, 0)
-#define VPIDR		__ACCESS_CP15(c0, 4, c0, 0)
-#define VMPIDR		__ACCESS_CP15(c0, 4, c0, 5)
-#define SCTLR		__ACCESS_CP15(c1, 0, c0, 0)
-#define CPACR		__ACCESS_CP15(c1, 0, c0, 2)
-#define HCR		__ACCESS_CP15(c1, 4, c1, 0)
-#define HDCR		__ACCESS_CP15(c1, 4, c1, 1)
-#define HCPTR		__ACCESS_CP15(c1, 4, c1, 2)
-#define HSTR		__ACCESS_CP15(c1, 4, c1, 3)
-#define TTBCR		__ACCESS_CP15(c2, 0, c0, 2)
-#define HTCR		__ACCESS_CP15(c2, 4, c0, 2)
-#define VTCR		__ACCESS_CP15(c2, 4, c1, 2)
-#define DACR		__ACCESS_CP15(c3, 0, c0, 0)
-#define DFSR		__ACCESS_CP15(c5, 0, c0, 0)
-#define IFSR		__ACCESS_CP15(c5, 0, c0, 1)
-#define ADFSR		__ACCESS_CP15(c5, 0, c1, 0)
-#define AIFSR		__ACCESS_CP15(c5, 0, c1, 1)
-#define HSR		__ACCESS_CP15(c5, 4, c2, 0)
-#define DFAR		__ACCESS_CP15(c6, 0, c0, 0)
-#define IFAR		__ACCESS_CP15(c6, 0, c0, 2)
-#define HDFAR		__ACCESS_CP15(c6, 4, c0, 0)
-#define HIFAR		__ACCESS_CP15(c6, 4, c0, 2)
-#define HPFAR		__ACCESS_CP15(c6, 4, c0, 4)
-#define ICIALLUIS	__ACCESS_CP15(c7, 0, c1, 0)
-#define BPIALLIS	__ACCESS_CP15(c7, 0, c1, 6)
-#define ICIMVAU		__ACCESS_CP15(c7, 0, c5, 1)
-#define ATS1CPR		__ACCESS_CP15(c7, 0, c8, 0)
-#define TLBIALLIS	__ACCESS_CP15(c8, 0, c3, 0)
-#define TLBIALL		__ACCESS_CP15(c8, 0, c7, 0)
-#define TLBIALLNSNHIS	__ACCESS_CP15(c8, 4, c3, 4)
-#define PRRR		__ACCESS_CP15(c10, 0, c2, 0)
-#define NMRR		__ACCESS_CP15(c10, 0, c2, 1)
-#define AMAIR0		__ACCESS_CP15(c10, 0, c3, 0)
-#define AMAIR1		__ACCESS_CP15(c10, 0, c3, 1)
-#define VBAR		__ACCESS_CP15(c12, 0, c0, 0)
-#define CID		__ACCESS_CP15(c13, 0, c0, 1)
-#define TID_URW		__ACCESS_CP15(c13, 0, c0, 2)
-#define TID_URO		__ACCESS_CP15(c13, 0, c0, 3)
-#define TID_PRIV	__ACCESS_CP15(c13, 0, c0, 4)
-#define HTPIDR		__ACCESS_CP15(c13, 4, c0, 2)
-#define CNTKCTL		__ACCESS_CP15(c14, 0, c1, 0)
-#define CNTP_CTL	__ACCESS_CP15(c14, 0, c2, 1)
-#define CNTV_CTL	__ACCESS_CP15(c14, 0, c3, 1)
-#define CNTHCTL		__ACCESS_CP15(c14, 4, c1, 0)
-
 #define VFP_FPEXC	__ACCESS_VFP(FPEXC)
 
 /* AArch64 compatibility macros, only for the timer so far */
diff --git a/arch/arm/kvm/hyp/cp15-sr.c b/arch/arm/kvm/hyp/cp15-sr.c
index 8bf895ec6e04..efbbd2e8927f 100644
--- a/arch/arm/kvm/hyp/cp15-sr.c
+++ b/arch/arm/kvm/hyp/cp15-sr.c
@@ -30,8 +30,8 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 	ctxt->cp15[c0_CSSELR]		= read_sysreg(CSSELR);
 	ctxt->cp15[c1_SCTLR]		= read_sysreg(SCTLR);
 	ctxt->cp15[c1_CPACR]		= read_sysreg(CPACR);
-	*cp15_64(ctxt, c2_TTBR0)	= read_sysreg(TTBR0);
-	*cp15_64(ctxt, c2_TTBR1)	= read_sysreg(TTBR1);
+	*cp15_64(ctxt, c2_TTBR0)	= read_sysreg(TTBR0_64);
+	*cp15_64(ctxt, c2_TTBR1)	= read_sysreg(TTBR1_64);
 	ctxt->cp15[c2_TTBCR]		= read_sysreg(TTBCR);
 	ctxt->cp15[c3_DACR]		= read_sysreg(DACR);
 	ctxt->cp15[c5_DFSR]		= read_sysreg(DFSR);
@@ -40,7 +40,7 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 	ctxt->cp15[c5_AIFSR]		= read_sysreg(AIFSR);
 	ctxt->cp15[c6_DFAR]		= read_sysreg(DFAR);
 	ctxt->cp15[c6_IFAR]		= read_sysreg(IFAR);
-	*cp15_64(ctxt, c7_PAR)		= read_sysreg(PAR);
+	*cp15_64(ctxt, c7_PAR)		= read_sysreg(PAR_64);
 	ctxt->cp15[c10_PRRR]		= read_sysreg(PRRR);
 	ctxt->cp15[c10_NMRR]		= read_sysreg(NMRR);
 	ctxt->cp15[c10_AMAIR0]		= read_sysreg(AMAIR0);
@@ -59,8 +59,8 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->cp15[c0_CSSELR],	CSSELR);
 	write_sysreg(ctxt->cp15[c1_SCTLR],	SCTLR);
 	write_sysreg(ctxt->cp15[c1_CPACR],	CPACR);
-	write_sysreg(*cp15_64(ctxt, c2_TTBR0),	TTBR0);
-	write_sysreg(*cp15_64(ctxt, c2_TTBR1),	TTBR1);
+	write_sysreg(*cp15_64(ctxt, c2_TTBR0),	TTBR0_64);
+	write_sysreg(*cp15_64(ctxt, c2_TTBR1),	TTBR1_64);
 	write_sysreg(ctxt->cp15[c2_TTBCR],	TTBCR);
 	write_sysreg(ctxt->cp15[c3_DACR],	DACR);
 	write_sysreg(ctxt->cp15[c5_DFSR],	DFSR);
@@ -69,7 +69,7 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->cp15[c5_AIFSR],	AIFSR);
 	write_sysreg(ctxt->cp15[c6_DFAR],	DFAR);
 	write_sysreg(ctxt->cp15[c6_IFAR],	IFAR);
-	write_sysreg(*cp15_64(ctxt, c7_PAR),	PAR);
+	write_sysreg(*cp15_64(ctxt, c7_PAR),	PAR_64);
 	write_sysreg(ctxt->cp15[c10_PRRR],	PRRR);
 	write_sysreg(ctxt->cp15[c10_NMRR],	NMRR);
 	write_sysreg(ctxt->cp15[c10_AMAIR0],	AMAIR0);
diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 3b058a5d7c5f..be8c8ba0e4b7 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -134,12 +134,12 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 	if (!(hsr & HSR_DABT_S1PTW) && (hsr & HSR_FSC_TYPE) == FSC_PERM) {
 		u64 par, tmp;
 
-		par = read_sysreg(PAR);
+		par = read_sysreg(PAR_64);
 		write_sysreg(far, ATS1CPR);
 		isb();
 
-		tmp = read_sysreg(PAR);
-		write_sysreg(par, PAR);
+		tmp = read_sysreg(PAR_64);
+		write_sysreg(par, PAR_64);
 
 		if (unlikely(tmp & 1))
 			return false; /* Translation failed, back to guest */
-- 
2.17.1

