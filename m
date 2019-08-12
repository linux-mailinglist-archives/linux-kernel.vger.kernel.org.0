Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8935E8AAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHLW4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 18:56:16 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:31449 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfHLW4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:56:16 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 22:56:15 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x7CMuEUf030811
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 18:56:14 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x7CMuCUF030810;
        Mon, 12 Aug 2019 18:56:12 -0400
Date:   Mon, 12 Aug 2019 18:56:11 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal clock
 setup
Message-ID: <20190812225611.GA30758@people.danlj.org>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
setup as part of the internal clock setup as described in 3.2.1 Internal
Clock Setup Sequence of SD Host Controller Simplified Specification
Version 4.20.  This changes the timeouts to the new specification of
150ms for each step and is documented as safe for "prior versions which
do not support PLL Enable."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..9106ebc7a422 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
@@ -1653,6 +1653,29 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 		udelay(10);
 	}
 
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
+		clk |= SDHCI_CLOCK_PLL_EN;
+		clk &= ~SDHCI_CLOCK_INT_STABLE;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		/* Wait max 150 ms */
+		timeout = ktime_add_ms(ktime_get(), 150);
+		while (1) {
+			bool timedout = ktime_after(ktime_get(), timeout);
+
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			if (clk & SDHCI_CLOCK_INT_STABLE)
+				break;
+			if (timedout) {
+				pr_err("%s: PLL clock never stabilised.\n",
+				       mmc_hostname(host->mmc));
+				sdhci_dumpregs(host);
+				return;
+			}
+			udelay(10);
+		}
+	}
+
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb..72601a4d2e95 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -114,6 +114,7 @@
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
 #define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_PLL_EN	0x0008
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
 
