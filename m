Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11D7F955E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKLQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 11:17:12 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3594 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKLQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:17:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcadacf0000>; Tue, 12 Nov 2019 08:16:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 08:17:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Nov 2019 08:17:11 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 16:17:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 16:17:10 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.80]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcadb050001>; Tue, 12 Nov 2019 08:17:10 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <pgaikwad@nvidia.com>
CC:     <digetx@gmail.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] clk: tegra: clk-dfll: Fix to remove pm_runtime_irq_safe
Date:   Tue, 12 Nov 2019 08:17:06 -0800
Message-ID: <1573575426-31314-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573575426-31314-1-git-send-email-skomatineni@nvidia.com>
References: <1573575426-31314-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573575375; bh=1kImHFAkv5/eZtu8j/MuHOjPRhis0bCK9BPWFGyzm9I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=T45iDQWr39w7/FtEhbbXD/9RXM5zy1kb7D8SZOrDrzdSj8/UJzjvcqMLSS2Epch5B
         NfPLAjuDfkvdhwNAC9yH0rFT3N7NrbOkqQXzhhchCsLtWA6Lj4u4znN/wDqVV1Y3QB
         u3ErnpreNqvLzqGHEn9nIx9b7k8cyx8iGAMt2xrz1Jq0JvUwuLFYfncPjLy/Gbtgxq
         bJRAPqFOEDBSi4cgSsQYhDvEfbYFzSJxgNdrxxJKI61k2aCZyyG5CHfA3cXWsgdaNF
         H2Th+uXfGvj2BdiIX3iuVdwLolW/kbGoz+MYO4+hs7C9YuLpYzwAnHGZ36VZsq+2vi
         S8bMBIX85/xTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_irq_safe is not needed as interrupts are allowed during
suspend and resume. This was added mistakenly during dfll suspend
and resume support patch.

This patch includes fix to remove pm_runtime_irq_safe.

Also updated description of dfll_suspend argument.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index c051d92c2bbf..cfbaa90c7adb 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1487,7 +1487,6 @@ static int dfll_init(struct tegra_dfll *td)
 	td->last_unrounded_rate = 0;
 
 	pm_runtime_enable(td->dev);
-	pm_runtime_irq_safe(td->dev);
 	pm_runtime_get_sync(td->dev);
 
 	dfll_set_mode(td, DFLL_DISABLED);
@@ -1516,7 +1515,7 @@ static int dfll_init(struct tegra_dfll *td)
 
 /**
  * tegra_dfll_suspend - check DFLL is disabled
- * @dev: DFLL device *
+ * @dev: DFLL instance
  *
  * DFLL clock should be disabled by the CPUFreq driver. So, make
  * sure it is disabled and disable all clocks needed by the DFLL.
-- 
2.7.4

