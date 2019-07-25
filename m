Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74A175B75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGYXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:42:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfGYXly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874844"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:52 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 34/40] soundwire: intel: ignore disabled links for suspend/resume
Date:   Thu, 25 Jul 2019 18:40:26 -0500
Message-Id: <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1477c35f616f..a976480d6f36 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1161,6 +1161,12 @@ static int intel_suspend(struct device *dev)
 
 	sdw = dev_get_drvdata(dev);
 
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			sdw->cdns.bus.link_id);
+		return 0;
+	}
+
 	ret = intel_link_power_down(sdw);
 	if (ret) {
 		dev_err(dev, "Link power down failed: %d", ret);
@@ -1179,6 +1185,12 @@ static int intel_resume(struct device *dev)
 
 	sdw = dev_get_drvdata(dev);
 
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			sdw->cdns.bus.link_id);
+		return 0;
+	}
+
 	ret = intel_init(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d", __func__, ret);
-- 
2.20.1

