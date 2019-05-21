Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5625ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfEUXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 19:31:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8577 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a430001>; Tue, 21 May 2019 16:31:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450008>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 04/12] clk: tegra: add support for peripheral clock suspend and resume
Date:   Tue, 21 May 2019 16:31:15 -0700
Message-ID: <1558481483-22254-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481475; bh=+iPvMyLn/JYqmAaI1BVhkgnEnd4W1rNJMHzLydYPn4c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GEwewYHNIdvrJrqHvbYOXjy1ihjPohFnIH6iml3myO2uJDb/7N3/Zl+lo9BWekL0L
         a2ilKrB3kVxL4+8foPgV1Tp8iPsOj4vLvN7lwEBmUI0QKlGV3p5WbM6JBjQdCN45lj
         fN8UKqHGhdkRk+KtSRMRYf5nNcB1JDVqRn1RfutmDB//14NDdq6ZjnJNwLhaHpbfYz
         F1aIYb2enhev8VdZm5XnMy48zS7HF2jnXC0HGzAKQ8jjSHZJkNswIO312KWPaBCZU/
         1YRKGQ3X0zTztrXrXRhDKAkJ04Gpckz8q8KDCsJRsNC4+c6fVdImuMpeIGGFZF7nN6
         0cqB3op+y1Ntg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements peripheral clock context save and restore
to support system suspend and resume operation.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/tegra/clk.h |  3 ++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 6f2862eddad7..08b788766564 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -81,6 +81,10 @@ static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
 
+#ifdef CONFIG_PM_SLEEP
+static u32 *periph_ctx;
+#endif
+
 /* Handlers for SoC-specific reset lines */
 static int (*special_reset_assert)(unsigned long);
 static int (*special_reset_deassert)(unsigned long);
@@ -210,6 +214,65 @@ const struct tegra_clk_periph_regs *get_reg_bank(int clkid)
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
+void tegra_clk_periph_suspend(void __iomem *clk_base)
+{
+	int i, idx;
+
+	idx = 0;
+	for (i = 0; i < periph_banks; i++, idx++)
+		periph_ctx[idx] =
+			readl_relaxed(clk_base + periph_regs[i].rst_reg);
+
+	for (i = 0; i < periph_banks; i++, idx++)
+		periph_ctx[idx] =
+			readl_relaxed(clk_base + periph_regs[i].enb_reg);
+}
+
+void tegra_clk_periph_force_on(u32 *clks_on, int count, void __iomem *clk_base)
+{
+	int i;
+
+	WARN_ON(count != periph_banks);
+
+	for (i = 0; i < count; i++)
+		writel_relaxed(clks_on[i], clk_base + periph_regs[i].enb_reg);
+}
+
+void tegra_clk_periph_resume(void __iomem *clk_base)
+{
+	int i, idx;
+
+	idx = 0;
+	for (i = 0; i < periph_banks; i++, idx++)
+		writel_relaxed(periph_ctx[idx],
+			       clk_base + periph_regs[i].rst_reg);
+
+	/* ensure all resets have propagated */
+	fence_udelay(2, clk_base);
+	tegra_read_chipid();
+
+	for (i = 0; i < periph_banks; i++, idx++)
+		writel_relaxed(periph_ctx[idx],
+			       clk_base + periph_regs[i].enb_reg);
+
+	/* ensure all enables have propagated */
+	fence_udelay(2, clk_base);
+	tegra_read_chipid();
+}
+
+static int tegra_clk_suspend_ctx_init(int banks)
+{
+	int err = 0;
+
+	periph_ctx = kzalloc(2 * banks * sizeof(*periph_ctx), GFP_KERNEL);
+	if (!periph_ctx)
+		err = -ENOMEM;
+
+	return err;
+}
+#endif
+
 struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 {
 	clk_base = regs;
@@ -226,11 +289,20 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 	periph_banks = banks;
 
 	clks = kcalloc(num, sizeof(struct clk *), GFP_KERNEL);
-	if (!clks)
+	if (!clks) {
 		kfree(periph_clk_enb_refcnt);
+		return NULL;
+	}
 
 	clk_num = num;
 
+#ifdef CONFIG_PM_SLEEP
+	if (tegra_clk_suspend_ctx_init(banks)) {
+		kfree(periph_clk_enb_refcnt);
+		kfree(clks);
+		return NULL;
+	}
+#endif
 	return clks;
 }
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index c82633686820..ef444648fcb1 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -853,6 +853,9 @@ void tegra_clk_pll_out_resume(struct clk *clk, unsigned long rate);
 void tegra_clk_plle_tegra210_resume(struct clk *c);
 void tegra_clk_sync_state_pll(struct clk *c);
 void tegra_clk_sync_state_pll_out(struct clk *clk);
+void tegra_clk_periph_suspend(void __iomem *clk_base);
+void tegra_clk_periph_resume(void __iomem *clk_base);
+void tegra_clk_periph_force_on(u32 *clks_on, int count, void __iomem *clk_base);
 #endif
 
 
-- 
2.7.4

