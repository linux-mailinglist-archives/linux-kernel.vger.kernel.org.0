Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E526FCD00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfKNSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:17:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:36355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKNSRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123471"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:45 -0800
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
Subject: [PATCH v3 10/22] soundwire: intel: call helper to reset Slave states on resume
Date:   Thu, 14 Nov 2019 12:16:50 -0600
Message-Id: <20191114181702.22254-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps make sure they are all UNATTACHED and reset the state
machines.

At the moment we perform a bus reset both for resume and pm_resume,
this will be modified when clock-stop mode is supported

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b2bc99970245..e3741c3afe1c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1402,6 +1402,9 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/* make sure all Slaves are tagged as UNATTACHED */
+	sdw_clear_slave_status(&sdw->cdns.bus);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
@@ -1435,6 +1438,9 @@ static int intel_resume_runtime(struct device *dev)
 		return ret;
 	}
 
+	/* make sure all Slaves are tagged as UNATTACHED */
+	sdw_clear_slave_status(&sdw->cdns.bus);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
-- 
2.20.1

