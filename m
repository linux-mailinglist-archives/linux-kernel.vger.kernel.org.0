Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D0075B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGYXlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:41:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfGYXlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874688"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:16 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 12/40] soundwire: cadence_master: revisit interrupt settings
Date:   Thu, 25 Jul 2019 18:40:04 -0500
Message-Id: <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
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
 drivers/soundwire/cadence_master.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index bdc3ed844829..0f3b9c160b01 100644
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
 
@@ -689,6 +692,11 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
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
@@ -761,10 +769,21 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
 		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
+	/* enable detection of slave state changes */
 	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
-		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
-		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
-		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
+		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
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
+	/* now enable all of the above */
+	mask |= CDNS_MCP_INT_IRQ;
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-- 
2.20.1

