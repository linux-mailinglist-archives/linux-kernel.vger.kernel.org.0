Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B72182478
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgCKWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:10:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgCKWKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550556"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:41 -0700
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
Subject: [PATCH 2/7] soundwire: intel: reuse code for wait loops to set/clear bits
Date:   Wed, 11 Mar 2020 17:10:21 -0500
Message-Id: <20200311221026.18174-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor code and use same routines on set/clear

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 45 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 28a8563c4e0f..1a3b828b03a1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -134,40 +134,33 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
 	writew(value, base + offset);
 }
 
+static int intel_wait_bit(void __iomem *base, int offset, u32 mask, u32 target)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	do {
+		reg_read = readl(base + offset);
+		if ((reg_read & mask) == target)
+			return 0;
+
+		timeout--;
+		udelay(50);
+	} while (timeout != 0);
+
+	return -EAGAIN;
+}
+
 static int intel_clear_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (!(reg_read & mask))
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, 0);
 }
 
 static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (reg_read & mask)
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, mask);
 }
 
 /*
-- 
2.20.1

