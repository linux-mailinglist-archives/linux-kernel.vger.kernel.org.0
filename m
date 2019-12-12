Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2475511C29D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 02:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfLLBpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 20:45:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:65192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfLLBpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:45:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 17:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="296446135"
Received: from gjang-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:30 -0800
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
Subject: [PATCH v5 11/11] soundwire: intel: add clock stop quirks
Date:   Wed, 11 Dec 2019 19:45:07 -0600
Message-Id: <20191212014507.28050-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to power rail dependencies, the SoundWire Master driver cannot
make decisions on its own when entering pm runtime suspend.

Add quirk mask for each link, so that the SOF parent driver can inform
the SoundWire master driver of the desired behavior:
a) leave clock on
b) power-off instead of clock stop
c) power-off if all devices cannot generate wakes
d) force bus reset on clock restart

Note that for now the interface with the SOF driver relies on a single
mask for all links. If needed, the interface might be modified at a
later point to provide more freedom. The code at the lower level does
not assume any commonality between links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 45fa6d93197f..93b83bdf8035 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -59,6 +59,40 @@ struct sdw_intel_acpi_info {
 
 struct sdw_intel_link_res;
 
+/* Intel clock-stop/pm_runtime quirk definitions */
+
+/*
+ * Force the clock to remain on during pm_runtime suspend. This might
+ * be needed if Slave devices do not have an alternate clock source or
+ * if the latency requirements are very strict.
+ */
+#define SDW_INTEL_CLK_STOP_NOT_ALLOWED		BIT(0)
+
+/*
+ * Stop the bus during pm_runtime suspend. If set, a complete bus
+ * reset and re-enumeration will be performed when the bus
+ * restarts. This mode shall not be used if Slave devices can generate
+ * in-band wakes.
+ */
+#define SDW_INTEL_CLK_STOP_TEARDOWN		BIT(1)
+
+/*
+ * Stop the bus during pm_suspend if Slaves are not wake capable
+ * (e.g. speaker amplifiers). The clock-stop mode is typically
+ * slightly higher power than when the IP is completely powered-off.
+ */
+#define SDW_INTEL_CLK_STOP_WAKE_CAPABLE_ONLY	BIT(2)
+
+/*
+ * Require a bus reset (and complete re-enumeration) when exiting
+ * clock stop modes. This may be needed if the controller power was
+ * turned off and all context lost. This quirk shall not be used if a
+ * Slave device needs to remain enumerated and keep its context,
+ * e.g. to provide the reasons for the wake, report acoustic events or
+ * pass a history buffer.
+ */
+#define SDW_INTEL_CLK_STOP_BUS_RESET		BIT(3)
+
 /**
  * struct sdw_intel_ctx - context allocated by the controller
  * driver probe
@@ -97,6 +131,8 @@ struct sdw_intel_ctx {
  * @link_mask: bit-wise mask listing links selected by the DSP driver
  * This mask may be a subset of the one reported by the controller since
  * machine-specific quirks are handled in the DSP driver.
+ * @clock_stop_quirks: mask array of possible behaviors requested by the
+ * DSP driver. The quirks are common for all links for now.
  */
 struct sdw_intel_res {
 	int count;
@@ -107,6 +143,7 @@ struct sdw_intel_res {
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
 	u32 link_mask;
+	u32 clock_stop_quirks;
 };
 
 /*
-- 
2.20.1

