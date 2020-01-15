Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B213BCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 10:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgAOJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 04:54:41 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:16904 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgAOJyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:54:41 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47yN325rrnzKt;
        Wed, 15 Jan 2020 10:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579082079; bh=sxzTUCMMAQefhnz1DPOUyOGPD2XGl5ktWwEOSWo2bj0=;
        h=Date:From:Subject:To:Cc:From;
        b=ZNbq1c+dvSJrUfpTUQARYgA/3BdK/p9VWUQ5x7c26GOuNwgV2bxpSM1IVh+7WR0UQ
         nybo0PAh9YgsqOn8/gbbI3KP/ry+fzXciSnBOexUrl2+S/Hi7s7lxNh3PC40jbUVAA
         Tc/zIKWvbWpg7grk68YUNjZbrF2joZ44RLisH+UkM9dia7SLSBgEthcfbJdGwIFw7w
         vBdStuSe8RTWe/gogkupioXUUFFUpGCWjfPB1aMItwtCxA78kKLaSn0dG8yTEuugjG
         vhuf2Dj0aTJzgZfzGZ9WqdVBJoEfVW2TnbdRzQNxxN9wHRt3hXLXkjo9r2U++hC/6x
         P3sBiy1pP4veA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Wed, 15 Jan 2020 10:54:35 +0100
Message-Id: <ffb489519a446caffe7a0a05c4b9372bd52397bb.1579082031.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] mmc: sdhci: fix minimum clock rate for v3 controller
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SDHCIv3+ with programmable clock mode, minimal clock frequency is
still base clock / max(divider). Minimal programmable clock frequency is
always greater than minimal divided clock frequency. Without this patch,
SDHCI uses out-of-spec initial frequency when multiplier is big enough:

mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
[for 480 MHz source clock divided by 1024]

The code in sdhci_calc_clk() already chooses a correct SDCLK clock mode.

Cc: stable@vger.kernel.org
Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 v3: commitmsg/comment rewording
 v2: extend commitmsg and add comment
---
 drivers/mmc/host/sdhci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96609c961465..24fb6d710de6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3903,11 +3903,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
-		if (host->clk_mul) {
-			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
+		if (host->clk_mul)
 			max_clk = host->max_clk * host->clk_mul;
-		} else
-			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
+		/*
+		 * Divided Clock Mode minimum clock rate is always less than
+		 * Programmable Clock Mode minimum clock rate.
+		 */
+		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-- 
2.20.1

