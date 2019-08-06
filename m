Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F57828DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 02:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfHFAzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 20:55:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfHFAzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153123"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:31 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 03/17] soundwire: cadence_master: revisit interrupt settings
Date:   Mon,  5 Aug 2019 19:55:08 -0500
Message-Id: <20190806005522.22642-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding missing interrupt masks (parity, etc) and missing checks.
Clarify which masks are for which usage.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1c5f05ef27b..5d9729b4d634 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -76,9 +76,12 @@
 #define CDNS_MCP_INT_DPINT			BIT(11)
 #define CDNS_MCP_INT_CTRL_CLASH			BIT(10)
 #define CDNS_MCP_INT_DATA_CLASH			BIT(9)
+#define CDNS_MCP_INT_PARITY			BIT(8)
 #define CDNS_MCP_INT_CMD_ERR			BIT(7)
+#define CDNS_MCP_INT_RX_NE			BIT(3)
 #define CDNS_MCP_INT_RX_WL			BIT(2)
 #define CDNS_MCP_INT_TXE			BIT(1)
+#define CDNS_MCP_INT_TXF			BIT(0)
 
 #define CDNS_MCP_INTSET				0x4C
 
@@ -669,6 +672,11 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 		}
 	}
 
+	if (int_status & CDNS_MCP_INT_PARITY) {
+		/* Parity error detected by Master */
+		dev_err_ratelimited(cdns->dev, "Parity error\n");
+	}
+
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
 		/* Slave is driving bit slot during control word */
 		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
@@ -736,10 +744,23 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
 		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
-	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
-		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
-		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
-		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
+	/* enable detection of all slave state changes */
+	mask = CDNS_MCP_INT_SLAVE_MASK;
+
+	/* enable detection of bus issues */
+	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
+		CDNS_MCP_INT_PARITY;
+
+	/* no detection of port interrupts for now */
+
+	/* enable detection of RX fifo level */
+	mask |= CDNS_MCP_INT_RX_WL;
+
+	/*
+	 * CDNS_MCP_INT_IRQ needs to be set otherwise all previous
+	 * settings are irrelevant
+	 */
+	mask |= CDNS_MCP_INT_IRQ;
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-- 
2.20.1

