Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2793AF1E66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfKFTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:14:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:4046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732548AbfKFTO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:14:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:14:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="402465861"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 11:14:24 -0800
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
Subject: [PATCH v2 14/14] soundwire: intel_init: add implementation of sdw_intel_enable_irq()
Date:   Wed,  6 Nov 2019 13:13:58 -0600
Message-Id: <20191106191358.5712-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
References: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is required to enable all interrupts across all links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 42f7ae034bea..14ffe9ce2929 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -137,6 +137,30 @@ sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 	return 0;
 }
 
+#define HDA_DSP_REG_ADSPIC2             (0x10)
+#define HDA_DSP_REG_ADSPIS2             (0x14)
+#define HDA_DSP_REG_ADSPIC2_SNDW        BIT(5)
+
+/**
+ * sdw_intel_enable_irq() - enable/disable Intel SoundWire IRQ
+ * @mmio_base: The mmio base of the control register
+ * @enable: true if enable
+ */
+void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
+{
+	u32 val;
+
+	val = readl(mmio_base + HDA_DSP_REG_ADSPIC2);
+
+	if (enable)
+		val |= HDA_DSP_REG_ADSPIC2_SNDW;
+	else
+		val &= ~HDA_DSP_REG_ADSPIC2_SNDW;
+
+	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
+}
+EXPORT_SYMBOL(sdw_intel_enable_irq);
+
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
 {
-- 
2.20.1

