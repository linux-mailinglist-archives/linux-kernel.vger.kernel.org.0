Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5713BB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 09:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOIcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 03:32:20 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:59050 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAOIcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:32:20 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47yLD12sm5zKt;
        Wed, 15 Jan 2020 09:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579077137; bh=CyOYpjMbFYRps06iAvdOTu9pzJWERsOZ7fqHGUbYjEA=;
        h=Date:From:Subject:To:Cc:From;
        b=TJ3iw3nfQZSISn0+jxL3IjasNcIHaogv9GY4MSm/3PjKYshQQDXmGrr3dDTlIrWtt
         DipJMIBIsKx0Bb1pDWZW6rgMMqAvrskYFuqO/EBsry+Ex5SvUJKoMHJ9enauaVhC/r
         qQSsxSltSgfNolOFjCxFYmkMOBusQdWKbXb9Robp1g65UmzopjwQtjqNNCs/nKdm21
         z6BCLyriHCLIu8M/vBh9Knu5rNLFKSEivKunkDm29oOsf+rlig5d2DsfRE8tXJbJZt
         4mcpp+i9jzZzaiH2dC5Dz0mCHa99WEKGVHjYn6V7q+QesBdKMAIF7dNw/X88k1oVvO
         li4ArTVgrfVEQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Wed, 15 Jan 2020 09:32:16 +0100
Message-Id: <36180c2b31b154b482892d6c7a3c6d5f386a6a73.1579077085.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] mmc: sdhci: fix minimum clock rate for v3 controller
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

The code in sdhci_calc_clk() already chooses a correct SDCLK clock source.

Cc: stable@vger.kernel.org
Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 v2: extend commitmsg and add comment
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96609c961465..fde510c55c89 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3903,11 +3903,11 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
-		if (host->clk_mul) {
-			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
+		if (host->clk_mul)
 			max_clk = host->max_clk * host->clk_mul;
-		} else
-			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
+		/* minimal divided clock rate is always less than minimal
+		 * programmable clock rate */
+		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-- 
2.20.1

