Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27F9B40AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfIPS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 14:57:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:50422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbfIPS54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:57:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="216307627"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2019 11:57:54 -0700
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
Subject: [PATCH 1/2] soundwire: intel: add missing headers for cross-compilation
Date:   Mon, 16 Sep 2019 13:57:38 -0500
Message-Id: <20190916185739.32184-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
References: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl/writel and ioread32 are used without the relevant headers, fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c      | 1 +
 drivers/soundwire/intel_init.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index f1e38a293967..bcc5077b2814 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index b74c2f144962..d488c44fcbae 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/iomap.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/soundwire/sdw_intel.h>
-- 
2.20.1

