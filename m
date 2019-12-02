Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C763110E8C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLBK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 05:29:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:57574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfLBK3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B2BCB220;
        Mon,  2 Dec 2019 10:29:23 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: realtek: rtd1395: Add Realtek Lion Skin EVB
Date:   Mon,  2 Dec 2019 11:29:10 +0100
Message-Id: <20191202102910.26916-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
References: <20191202102910.26916-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree for Realtek RTD1395 SoC Lion Skin evaluation board.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/realtek/Makefile             |  1 +
 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts | 36 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index f614080b5e27..54bd02d11c02 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -9,5 +9,6 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts b/arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts
new file mode 100644
index 000000000000..83f9b536cdea
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1395.dtsi"
+
+/ {
+	compatible = "realtek,lion-skin", "realtek,rtd1395";
+	model = "Realtek Lion Skin EVB";
+
+	memory@2f000 {
+		device_type = "memory";
+		reg = <0x2f000 0x3ffd1000>; /* boot ROM to 1 GiB or 2 GiB */
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+/* debug console (J1) */
+&uart0 {
+	status = "okay";
+};
+
+/* M.2 slot (CON1) */
+&uart1 {
+	status = "disabled";
+};
-- 
2.16.4

