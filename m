Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70C17E8EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCITnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:43:46 -0400
Received: from v6.sk ([167.172.42.174]:34700 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:46 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D131261308;
        Mon,  9 Mar 2020 19:43:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 11/17] dt-bindings: marvell,mmp2: Add clock ids for the GPU clocks
Date:   Mon,  9 Mar 2020 20:42:48 +0100
Message-Id: <20200309194254.29009-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP2 has a single GC860 core while MMP3 has a GC2000 and a GC300.
On both platforms there's an AXI bus interface clock that's common for
all GPUs and each GPU core has a separate clock.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 include/dt-bindings/clock/marvell,mmp2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 22006392b411b..dd5067bd92f22 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -77,6 +77,11 @@
 #define MMP2_CLK_DISP0_LCDC		120
 #define MMP2_CLK_USBHSIC0		121
 #define MMP2_CLK_USBHSIC1		122
+#define MMP2_CLK_GPU_BUS		123
+#define MMP3_CLK_GPU_BUS		MMP2_CLK_GPU_BUS
+#define MMP2_CLK_GPU_3D			124
+#define MMP3_CLK_GPU_3D			MMP2_CLK_GPU_3D
+#define MMP3_CLK_GPU_2D			125
 
 #define MMP2_NR_CLKS			200
 #endif
-- 
2.25.1

