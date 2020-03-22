Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4A18E78A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 09:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVIVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 04:21:45 -0400
Received: from out28-146.mail.aliyun.com ([115.124.28.146]:49614 "EHLO
        out28-146.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:21:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3074599|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.00550743-0.000411465-0.994081;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3MM99h_1584865287;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3MM99h_1584865287)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 22 Mar 2020 16:21:38 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 3/6] dt-bindings: clock: Add X1830 bindings.
Date:   Sun, 22 Mar 2020 16:20:59 +0800
Message-Id: <1584865262-25297-5-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock bindings for the X1830 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
    to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
    the old mailbox is in an unstable state.
    
    v2->v3:
    Adjust order from [3/5] in v2 to [4/5] in v3.
    
    v3->v4:
    Adjust order from [4/5] in v3 to [3/4] in v4.
    
    v4->v5:
    Rebase on top of kernel 5.6-rc1.
    
    v5->v6:
    Add missing part of X1830's CGU.

 .../devicetree/bindings/clock/ingenic,cgu.txt      |  1 +
 include/dt-bindings/clock/x1830-cgu.h              | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.txt b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
index 75598e6..74bfc57 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
@@ -12,6 +12,7 @@ Required properties:
   * ingenic,jz4770-cgu
   * ingenic,jz4780-cgu
   * ingenic,x1000-cgu
+  * ingenic,x1830-cgu
 - reg : The address & length of the CGU registers.
 - clocks : List of phandle & clock specifiers for clocks external to the CGU.
   Two such external clocks should be specified - first the external crystal
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
new file mode 100644
index 00000000..f605a7b
--- /dev/null
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,x1830-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the x1830 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_X1830_CGU_H__
+#define __DT_BINDINGS_CLOCK_X1830_CGU_H__
+
+#define X1830_CLK_EXCLK			0
+#define X1830_CLK_RTCLK			1
+#define X1830_CLK_APLL			2
+#define X1830_CLK_MPLL			3
+#define X1830_CLK_EPLL			4
+#define X1830_CLK_VPLL			5
+#define X1830_CLK_SCLKA			6
+#define X1830_CLK_CPUMUX		7
+#define X1830_CLK_CPU			8
+#define X1830_CLK_L2CACHE		9
+#define X1830_CLK_AHB0			10
+#define X1830_CLK_AHB2PMUX		11
+#define X1830_CLK_AHB2			12
+#define X1830_CLK_PCLK			13
+#define X1830_CLK_DDR			14
+#define X1830_CLK_MAC			15
+#define X1830_CLK_LCD			16
+#define X1830_CLK_MSCMUX		17
+#define X1830_CLK_MSC0			18
+#define X1830_CLK_MSC1			19
+#define X1830_CLK_SSIPLL		20
+#define X1830_CLK_SSIPLL_DIV2	21
+#define X1830_CLK_SSIMUX		22
+#define X1830_CLK_EMC			23
+#define X1830_CLK_EFUSE			24
+#define X1830_CLK_OTG			25
+#define X1830_CLK_SSI0			26
+#define X1830_CLK_SMB0			27
+#define X1830_CLK_SMB1			28
+#define X1830_CLK_SMB2			29
+#define X1830_CLK_UART0			30
+#define X1830_CLK_UART1			31
+#define X1830_CLK_SSI1			32
+#define X1830_CLK_SFC			33
+#define X1830_CLK_PDMA			34
+#define X1830_CLK_DTRNG			35
+#define X1830_CLK_OST			36
+
+#endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.7.4

