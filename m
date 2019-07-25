Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3512B75B84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGYXn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:43:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfGYXlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874676"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:13 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 10/40] soundwire: cadence_master: remove useless wrapper
Date:   Thu, 25 Jul 2019 18:40:02 -0500
Message-Id: <20190725234032.21152-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've removed the update config, there's no need for a wrapper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index eb46cf651d62..e85e49340986 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -749,7 +749,12 @@ EXPORT_SYMBOL(sdw_cdns_thread);
 /*
  * init routines
  */
-static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
+
+/**
+ * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 {
 	u32 mask;
 
@@ -767,17 +772,6 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	return 0;
 }
-
-/**
- * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
- * @cdns: Cadence instance
- */
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
-{
-	_cdns_enable_interrupt(cdns);
-
-	return 0;
-}
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
 static int cdns_allocate_pdi(struct sdw_cdns *cdns,
-- 
2.20.1

