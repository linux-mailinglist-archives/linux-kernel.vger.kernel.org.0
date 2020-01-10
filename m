Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2A1378C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgAJV5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:57:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgAJV5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:57:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218782780"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:38 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 1/6] soundwire: cadence_master: filter out bad interrupts
Date:   Fri, 10 Jan 2020 15:57:26 -0600
Message-Id: <20200110215731.30747-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If somehow we read the interrupt status while the IP is not powered
the result is probably undefined or 0xffffffff. We do know that some
of the bits are reserved and read as zero, so use as a filter to
discard invalid configurations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fed21e2b2277..a0ec21b64d42 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -74,6 +74,7 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_INTMASK			0x48
 
 #define CDNS_MCP_INT_IRQ			BIT(31)
+#define CDNS_MCP_INT_RESERVED1			GENMASK(30, 17)
 #define CDNS_MCP_INT_WAKEUP			BIT(16)
 #define CDNS_MCP_INT_SLAVE_RSVD			BIT(15)
 #define CDNS_MCP_INT_SLAVE_ALERT		BIT(14)
@@ -85,10 +86,12 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_INT_DATA_CLASH			BIT(9)
 #define CDNS_MCP_INT_PARITY			BIT(8)
 #define CDNS_MCP_INT_CMD_ERR			BIT(7)
+#define CDNS_MCP_INT_RESERVED2			GENMASK(6, 4)
 #define CDNS_MCP_INT_RX_NE			BIT(3)
 #define CDNS_MCP_INT_RX_WL			BIT(2)
 #define CDNS_MCP_INT_TXE			BIT(1)
 #define CDNS_MCP_INT_TXF			BIT(0)
+#define CDNS_MCP_INT_RESERVED (CDNS_MCP_INT_RESERVED1 | CDNS_MCP_INT_RESERVED2)
 
 #define CDNS_MCP_INTSET				0x4C
 
@@ -705,6 +708,10 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 
 	int_status = cdns_readl(cdns, CDNS_MCP_INTSTAT);
 
+	/* check for reserved values read as zero */
+	if (int_status & CDNS_MCP_INT_RESERVED)
+		return IRQ_NONE;
+
 	if (!(int_status & CDNS_MCP_INT_IRQ))
 		return IRQ_NONE;
 
-- 
2.20.1

