Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD8172B56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgB0Wcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:32:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:48642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbgB0Wca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="411194841"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 14:32:27 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 4/8] soundwire: intel_init: use EXPORT_SYMBOL_NS
Date:   Thu, 27 Feb 2020 16:32:02 -0600
Message-Id: <20200227223206.5020-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure all symbols in this soundwire-intel-init module are exported
with a namespace.

The MODULE_IMPORT_NS will be used in Intel/SOF HDaudio modules to be
posted in a separate series.

Namespaces are only introduced for the Intel parts of the SoundWire
code at this time, in future patches we should also add namespaces for
Cadence parts and the SoundWire core.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 88ad2a1637ad..01c8b390887b 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -163,7 +163,7 @@ void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
 
 	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
 }
-EXPORT_SYMBOL(sdw_intel_enable_irq);
+EXPORT_SYMBOL_NS(sdw_intel_enable_irq, SOUNDWIRE_INTEL_INIT);
 
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
@@ -355,7 +355,7 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
 
 	return sdw_intel_scan_controller(info);
 }
-EXPORT_SYMBOL(sdw_intel_acpi_scan);
+EXPORT_SYMBOL_NS(sdw_intel_acpi_scan, SOUNDWIRE_INTEL_INIT);
 
 /**
  * sdw_intel_probe() - SoundWire Intel probe routine
@@ -370,7 +370,7 @@ struct sdw_intel_ctx
 {
 	return sdw_intel_probe_controller(res);
 }
-EXPORT_SYMBOL(sdw_intel_probe);
+EXPORT_SYMBOL_NS(sdw_intel_probe, SOUNDWIRE_INTEL_INIT);
 
 /**
  * sdw_intel_startup() - SoundWire Intel startup
@@ -381,7 +381,7 @@ int sdw_intel_startup(struct sdw_intel_ctx *ctx)
 {
 	return sdw_intel_startup_controller(ctx);
 }
-EXPORT_SYMBOL(sdw_intel_startup);
+EXPORT_SYMBOL_NS(sdw_intel_startup, SOUNDWIRE_INTEL_INIT);
 /**
  * sdw_intel_exit() - SoundWire Intel exit
  * @ctx: SoundWire context allocated in the probe
@@ -393,7 +393,7 @@ void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 	sdw_intel_cleanup(ctx);
 	kfree(ctx);
 }
-EXPORT_SYMBOL(sdw_intel_exit);
+EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Intel Soundwire Init Library");
-- 
2.20.1

