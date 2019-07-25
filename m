Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF775B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGYXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:41:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfGYXlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874684"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:15 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 11/40] soundwire: cadence_master: simplify bus clash interrupt clear
Date:   Thu, 25 Jul 2019 18:40:03 -0500
Message-Id: <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus clash interrupts are generated when the status is one, and
also cleared by writing a one. It's overkill/useless to use an OR when
the bit is already set.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e85e49340986..bdc3ed844829 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -692,7 +692,6 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
 		/* Slave is driving bit slot during control word */
 		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
-		int_status |= CDNS_MCP_INT_CTRL_CLASH;
 	}
 
 	if (int_status & CDNS_MCP_INT_DATA_CLASH) {
@@ -701,7 +700,6 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 		 * ownership of data bits or Slave gone bonkers
 		 */
 		dev_err_ratelimited(cdns->dev, "Bus clash for data word\n");
-		int_status |= CDNS_MCP_INT_DATA_CLASH;
 	}
 
 	if (int_status & CDNS_MCP_INT_SLAVE_MASK) {
-- 
2.20.1

