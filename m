Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188D4A405F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfH3WRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 18:17:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:56363 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfH3WQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:16:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CCA92D8808;
        Sat, 31 Aug 2019 00:08:58 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UjwqMr34hL8Q; Sat, 31 Aug 2019 00:08:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 000D2D87EF;
        Sat, 31 Aug 2019 00:08:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KuOF9qKz-Zny; Sat, 31 Aug 2019 00:08:03 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8626BD87F0;
        Sat, 31 Aug 2019 00:07:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "To : Olof Johansson" <olof@lixom.net>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 12/16] ARM: mmp: add SMP support
Date:   Sat, 31 Aug 2019 00:07:39 +0200
Message-Id: <20190830220743.439670-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830220743.439670-1-lkundrak@v3.sk>
References: <20190830220743.439670-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used to bring up the second core on MMP3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- Wrap secondary_startup with __pa_symbol(), instead of
  SW_BRANCH_VIRT_ADDR.

Changes since v1:
- Wrap SW_BRANCH_VIRT_ADDR with __pa_symbol()

 arch/arm/mach-mmp/Makefile  |  3 +++
 arch/arm/mach-mmp/platsmp.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/mach-mmp/platsmp.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 322c1c97dc900..7b3a7f979eece 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -22,6 +22,9 @@ ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+=3D pm-pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+=3D pm-mmp2.o
 endif
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_MACH_MMP3_DT)	+=3D platsmp.o
+endif
=20
 # board support
 obj-$(CONFIG_MACH_ASPENITE)	+=3D aspenite.o
diff --git a/arch/arm/mach-mmp/platsmp.c b/arch/arm/mach-mmp/platsmp.c
new file mode 100644
index 0000000000000..c99405469bb4b
--- /dev/null
+++ b/arch/arm/mach-mmp/platsmp.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+#include <linux/io.h>
+#include <asm/smp_scu.h>
+#include <asm/smp.h>
+#include "addr-map.h"
+
+#define SW_BRANCH_VIRT_ADDR	CIU_REG(0x24)
+
+static int mmp3_boot_secondary(unsigned int cpu, struct task_struct *idl=
e)
+{
+	/*
+	 * Apparently, the boot ROM on the second core spins on this
+	 * register becoming non-zero and then jumps to the address written
+	 * there. No IPIs involved.
+	 */
+	__raw_writel(__pa_symbol(secondary_startup), SW_BRANCH_VIRT_ADDR);
+	return 0;
+}
+
+static void mmp3_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(SCU_VIRT_BASE);
+}
+
+static const struct smp_operations mmp3_smp_ops __initconst =3D {
+	.smp_prepare_cpus	=3D mmp3_smp_prepare_cpus,
+	.smp_boot_secondary	=3D mmp3_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(mmp3_smp, "marvell,mmp3-smp", &mmp3_smp_ops);
--=20
2.21.0

