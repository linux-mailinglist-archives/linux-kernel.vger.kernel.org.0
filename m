Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800FC18210A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgCKSmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 14:42:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730936AbgCKSlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:41:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776247"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 06/16] soundwire: cadence: fix a io timeout issue in S3 test
Date:   Wed, 11 Mar 2020 13:41:18 -0500
Message-Id: <20200311184128.4212-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

After system resumes from S3, io timeout occurs when setting one
unused master on Comet Lake platform. In this case, the master is
reset to default state, and FIFOLEVEL is reset to default value,
but msg_count used for tracing FIFOLEVEL is still with old value,
so FIFOLEVEL will not be set if a new msg FIFO usage is equal to
the old msg_count.

This patch updates msg_count to default value of FIFOLEVEL when
resetting master.

Tested on Comet Lake platform.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 1ec537b2789f..02f18ce6b7e7 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1068,6 +1068,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
 
+	/* reset msg_count to default value of FIFOLEVEL */
+	cdns->msg_count = cdns_readl(cdns, CDNS_MCP_FIFOLEVEL);
+
 	/* flush command FIFOs */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_RST,
 		     CDNS_MCP_CONTROL_CMD_RST);
-- 
2.20.1

