Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744DD15726B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 11:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBJKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 05:04:19 -0500
Received: from srv1.deutnet.info ([116.203.153.70]:47860 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgBJKER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
         bh=3Ciuxvpq/QgkL4EE+nmSla5AVI07VMG5GvViEqviaBw=; b=QXIKRKzj2jZBrINaRH8wb1ds4
        UIxerPh66Uh6wFQdEZiNV3dKXxyxFrmM9fEbA6tahtn/+Vf+3JdbCvwJAjN8iO/UQFF3w5eQk6IiG
        aY5G3SZnYK3ZPlpn45BXw9owc8jcWPclOsTOkVT9cIBLahyw0QtuezPjLvpvIN+NHYqe7yVYRDlWe
        t2ma5N8D/Gxdt3nwNjqJXRas64gu9f6kMBIjymL6CEjOcOciVFwAwhR0kDe9ouVTEri+0UiyqACwW
        HGDivztK3FRW9Io0dEBMsbpQrgzJaBDK7czmbY+pXjhXNyjNvHfqZ5Wg7vqLY4P1Ff6iCsKzpAYGE
        f6QbYeVEw==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15Ma-0007ft-1d; Mon, 10 Feb 2020 10:28:20 +0100
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15MZ-00DSp5-N2; Mon, 10 Feb 2020 10:28:19 +0100
From:   agriveaux@deutnet.info
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agriveaux@deutnet.info
Subject: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
Date:   Mon, 10 Feb 2020 10:27:36 +0100
Message-Id: <20200210092736.3208998-2-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210092736.3208998-1-agriveaux@deutnet.info>
References: <20200210092736.3208998-1-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre GRIVEAUX <agriveaux@deutnet.info>

Add Inet 86V Rev 2 support, based upon Inet 86VS.

Missing things:
- Accelerometer (MXC6225X)
- Touchpanel (Sitronix SL1536)
- Nand (29F32G08CBACA)
- Camera (HCWY0308)
---
 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts

diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
new file mode 100644
index 000000000000..e73abb9a1e32
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 Alexandre Griveaux <agriveaux@deutnet.info>
+ *
+ * Minimal dts file for the iNet 86V
+ */
+
+/dts-v1/;
+
+#include "sun5i-a13.dtsi"
+#include "sun5i-reference-design-tablet.dtsi"
+
+/ {
+	model = "iNET 86V Rev 02";
+	compatible = "inet,86v-rev2", "allwinner,sun5i-a13";
+
+};
-- 
2.20.1

