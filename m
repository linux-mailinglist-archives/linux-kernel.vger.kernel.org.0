Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3317E8F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCIToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:44:05 -0400
Received: from v6.sk ([167.172.42.174]:34774 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCIToF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:44:05 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id A23BF61313;
        Mon,  9 Mar 2020 19:44:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 16/17] clk: mmp2: Add clock for fifth SD HCI on MMP3
Date:   Mon,  9 Mar 2020 20:42:53 +0100
Message-Id: <20200309194254.29009-17-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one extra SDHCI on MMP3, used by the internal SD card on OLPC
XO-4. Add a clock for it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 drivers/clk/mmp/clk-of-mmp2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 0057a53905d8b..8769860fab640 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -49,6 +49,7 @@
 #define APMU_SDH1	0x58
 #define APMU_SDH2	0xe8
 #define APMU_SDH3	0xec
+#define APMU_SDH4	0x15c
 #define APMU_USB	0x5c
 #define APMU_DISP0	0x4c
 #define APMU_DISP1	0x110
@@ -332,6 +333,7 @@ static struct mmp_param_gate_clk mmp2_apmu_gate_clks[] = {
 };
 
 static struct mmp_param_gate_clk mmp3_apmu_gate_clks[] = {
+	{MMP3_CLK_SDH4, "sdh4_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH4, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP3_CLK_GPU_3D, "gpu_3d_clk", "gpu_3d_div", CLK_SET_RATE_PARENT, APMU_GPU, 0x5, 0x5, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
 	{MMP3_CLK_GPU_2D, "gpu_2d_clk", "gpu_2d_div", CLK_SET_RATE_PARENT, APMU_GPU, 0x1c0000, 0x1c0000, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
 };
-- 
2.25.1

