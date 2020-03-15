Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC5185F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgCOSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 14:38:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:32057 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgCOSiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:38:09 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gSqL3yx5zrZ;
        Sun, 15 Mar 2020 19:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584297486; bh=s7oB26JS9ZchdHzHcNTzzpWfgKOApt1VbPLehPvmx58=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=iffeNw84c2ikZH0h+Mj+NePUWa4Xiog47wfp/vkFGUGFjHhMTPegLcVrEOz3BCFcy
         fBOkPPmKO3stjGK9gPhtHSTeSVvXdzaqc/oMlr+t5G2WXFB7/1qOf+/nM9FkUkiins
         9A0mwpE/rEAlS6ysvQEs9RjokFT8cP708kT1vMaHj1/cXcwJaRyyXEIYykPZ4BfQKh
         5IJxuWnRrEhZ8qQc5HViQP2UvCAydxMS0qWe2jPForXnyjT3U4twAdrxNubzMxNDBH
         h4v5+GOM9Em1xj9wCMQ2yjq0saxpcTuEtRUmsS5/yxqp+xNvCYrzp68LBTGplaoqd1
         yNckkPGiF8kTQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 19:38:06 +0100
Message-Id: <590024802c809b02d93cb849e16a62f01963532a.1584296940.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1584296940.git.mirq-linux@rere.qmqm.pl>
References: <cover.1584296940.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/3] clk: at91: sama5d2: allow setting all PMC clock parents
 via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to have clocks accessible via phandle to select them
as peripheral clock parent using assigned-clock-parents in DT.
PLLACK and AUDIOPLLCK were missing for sama5d2. Add them.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/clk/at91/sama5d2.c       | 6 +++++-
 include/dt-bindings/clock/at91.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index ae5e83cadb3d..b3fa2291ccd8 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -166,7 +166,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama5d2_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
+	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
 					nck(sama5d2_systemck),
 					nck(sama5d2_periph32ck),
 					nck(sama5d2_gck), 3);
@@ -202,6 +202,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d2_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
 					      "mainck");
 	if (IS_ERR(hw))
@@ -217,6 +219,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d2_pmc->chws[PMC_AUDIOPLLCK] = hw;
+
 	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index c3f4aa6a2d29..e57362e98129 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -21,6 +21,8 @@
 #define PMC_MCK2		4
 #define PMC_I2S0_MUX		5
 #define PMC_I2S1_MUX		6
+#define PMC_PLLACK		7
+#define PMC_AUDIOPLLCK		8
 
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-- 
2.20.1

