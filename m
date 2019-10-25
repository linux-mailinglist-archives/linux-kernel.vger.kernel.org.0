Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FAE4B45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440331AbfJYMlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:41:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43005 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440316AbfJYMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id z12so1614348lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnzA6aQXruBK5zutlaMU9dJhEnFtb3qy7bJEnC0xOZE=;
        b=Cyy3FKjng8WVA0R2DnsdiS3/MpxfC/qVI1aDq5v+8H46xcEVdoPfx9QBtJP8NDGRbB
         FRVRpEqJSLgYGKXARtpcCOP37bejyw+yi4avjRVMkWYNW6NDh4l5NchDqh9MuGxPvym8
         gLy6aoym54rECUtSb9JLSQvgWDptugfgQukGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnzA6aQXruBK5zutlaMU9dJhEnFtb3qy7bJEnC0xOZE=;
        b=CkgUfwTGyX8W51i8dJ38Q+aN/B3shl5uc45x9IKm9x6Rmhw9fpIbGfi2yaWFVG7SYh
         4gwIFjOaDY0dQlZJ2jtdRRGM1fLHQj7K8FRyWOKuNvSHyjl3Yz5EZTmQDEjJittlBp7s
         FQ0/iNHTrEHsVnRsu9J+CHaja3fVwAZ73u6jTpY/fK8ZInKq0xqpMDFqkunUgGpv+4ak
         QzR3RviyfbgTGtRDytuOyF4tnm+XQMIrj2VCVMxZ25pOT4jQtoj7HGjwBJrnb/CoIWRr
         zW1zc26Sowy6fxoLZ/b1tXaKj3+lhHa9vykW04g0ov8kiucZYXG4XwCtb1cIsBXEhLPm
         h+3A==
X-Gm-Message-State: APjAAAXJd8HZykXdZzGd3HvG1ld8nXJn6OyJjP9T36w9pcI8nAbh0Byz
        iQ8TNhkv9UVJAtPccA1Exlbsww==
X-Google-Smtp-Source: APXvYqz/of+5ewou6+2V23pYUNHaB4MnCopB7EepM2aJifVA3HsV5e+Vx4JlHUgsHNW7bA705hLIeQ==
X-Received: by 2002:a19:e058:: with SMTP id g24mr2665516lfj.8.1572007271901;
        Fri, 25 Oct 2019 05:41:11 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 07/23] soc: fsl: qe: merge qe_ic.h into qe_ic.c
Date:   Fri, 25 Oct 2019 14:40:42 +0200
Message-Id: <20191025124058.22580-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local qe_ic.h header is only used by qe_ic.c, so merge its
contents into the .c file. This is preparation for moving the driver
to drivers/irqchip/. It also avoids confusion between this header and
the one at include/soc/fsl/qe/qe_ic.h, which is included from a number
of places (qe_ic.c among others).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c |  91 ++++++++++++++++++++++++++++++-
 drivers/soc/fsl/qe/qe_ic.h | 108 -------------------------------------
 2 files changed, 90 insertions(+), 109 deletions(-)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index d420492b4c23..7b1870d2866a 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -26,7 +26,96 @@
 #include <asm/io.h>
 #include <soc/fsl/qe/qe_ic.h>
 
-#include "qe_ic.h"
+#define NR_QE_IC_INTS		64
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CRIPNR		0x08
+#define QEIC_CIPNR		0x0c
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CICNR		0x28
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CRICR		0x3c
+#define QEIC_CHIVEC		0x60
+
+/* Interrupt priority registers */
+#define CIPCC_SHIFT_PRI0	29
+#define CIPCC_SHIFT_PRI1	26
+#define CIPCC_SHIFT_PRI2	23
+#define CIPCC_SHIFT_PRI3	20
+#define CIPCC_SHIFT_PRI4	13
+#define CIPCC_SHIFT_PRI5	10
+#define CIPCC_SHIFT_PRI6	7
+#define CIPCC_SHIFT_PRI7	4
+
+/* CICR priority modes */
+#define CICR_GWCC		0x00040000
+#define CICR_GXCC		0x00020000
+#define CICR_GYCC		0x00010000
+#define CICR_GZCC		0x00080000
+#define CICR_GRTA		0x00200000
+#define CICR_GRTB		0x00400000
+#define CICR_HPIT_SHIFT		8
+#define CICR_HPIT_MASK		0x00000300
+#define CICR_HP_SHIFT		24
+#define CICR_HP_MASK		0x3f000000
+
+/* CICNR */
+#define CICNR_WCC1T_SHIFT	20
+#define CICNR_ZCC1T_SHIFT	28
+#define CICNR_YCC1T_SHIFT	12
+#define CICNR_XCC1T_SHIFT	4
+
+/* CRICR */
+#define CRICR_RTA1T_SHIFT	20
+#define CRICR_RTB1T_SHIFT	28
+
+/* Signal indicator */
+#define SIGNAL_MASK		3
+#define SIGNAL_HIGH		2
+#define SIGNAL_LOW		0
+
+struct qe_ic {
+	/* Control registers offset */
+	u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_domain *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	/* Location of this source at the QIMR register */
+	u32	mask;
+
+	/* Mask register offset */
+	u32	mask_reg;
+
+	/*
+	 * For grouped interrupts sources - the interrupt code as
+	 * appears at the group priority register
+	 */
+	u8	pri_code;
+
+	/* Group priority register offset */
+	u32	pri_reg;
+};
 
 static DEFINE_RAW_SPINLOCK(qe_ic_lock);
 
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 29b4d768e4a8..000000000000
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,108 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * drivers/soc/fsl/qe/qe_ic.h
- *
- * QUICC ENGINE Interrupt Controller Header
- *
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: Li Yang <leoli@freescale.com>
- * Based on code from Shlomi Gridish <gridish@freescale.com>
- */
-#ifndef _POWERPC_SYSDEV_QE_IC_H
-#define _POWERPC_SYSDEV_QE_IC_H
-
-#include <soc/fsl/qe/qe_ic.h>
-
-#define NR_QE_IC_INTS		64
-
-/* QE IC registers offset */
-#define QEIC_CICR		0x00
-#define QEIC_CIVEC		0x04
-#define QEIC_CRIPNR		0x08
-#define QEIC_CIPNR		0x0c
-#define QEIC_CIPXCC		0x10
-#define QEIC_CIPYCC		0x14
-#define QEIC_CIPWCC		0x18
-#define QEIC_CIPZCC		0x1c
-#define QEIC_CIMR		0x20
-#define QEIC_CRIMR		0x24
-#define QEIC_CICNR		0x28
-#define QEIC_CIPRTA		0x30
-#define QEIC_CIPRTB		0x34
-#define QEIC_CRICR		0x3c
-#define QEIC_CHIVEC		0x60
-
-/* Interrupt priority registers */
-#define CIPCC_SHIFT_PRI0	29
-#define CIPCC_SHIFT_PRI1	26
-#define CIPCC_SHIFT_PRI2	23
-#define CIPCC_SHIFT_PRI3	20
-#define CIPCC_SHIFT_PRI4	13
-#define CIPCC_SHIFT_PRI5	10
-#define CIPCC_SHIFT_PRI6	7
-#define CIPCC_SHIFT_PRI7	4
-
-/* CICR priority modes */
-#define CICR_GWCC		0x00040000
-#define CICR_GXCC		0x00020000
-#define CICR_GYCC		0x00010000
-#define CICR_GZCC		0x00080000
-#define CICR_GRTA		0x00200000
-#define CICR_GRTB		0x00400000
-#define CICR_HPIT_SHIFT		8
-#define CICR_HPIT_MASK		0x00000300
-#define CICR_HP_SHIFT		24
-#define CICR_HP_MASK		0x3f000000
-
-/* CICNR */
-#define CICNR_WCC1T_SHIFT	20
-#define CICNR_ZCC1T_SHIFT	28
-#define CICNR_YCC1T_SHIFT	12
-#define CICNR_XCC1T_SHIFT	4
-
-/* CRICR */
-#define CRICR_RTA1T_SHIFT	20
-#define CRICR_RTB1T_SHIFT	28
-
-/* Signal indicator */
-#define SIGNAL_MASK		3
-#define SIGNAL_HIGH		2
-#define SIGNAL_LOW		0
-
-struct qe_ic {
-	/* Control registers offset */
-	u32 __iomem *regs;
-
-	/* The remapper for this QEIC */
-	struct irq_domain *irqhost;
-
-	/* The "linux" controller struct */
-	struct irq_chip hc_irq;
-
-	/* VIRQ numbers of QE high/low irqs */
-	unsigned int virq_high;
-	unsigned int virq_low;
-};
-
-/*
- * QE interrupt controller internal structure
- */
-struct qe_ic_info {
-	/* Location of this source at the QIMR register */
-	u32	mask;
-
-	/* Mask register offset */
-	u32	mask_reg;
-
-	/*
-	 * For grouped interrupts sources - the interrupt code as
-	 * appears at the group priority register
-	 */
-	u8	pri_code;
-
-	/* Group priority register offset */
-	u32	pri_reg;
-};
-
-#endif /* _POWERPC_SYSDEV_QE_IC_H */
-- 
2.23.0

