Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8D10A66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEAP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 11:58:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfEAP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115730"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:32 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 14/22] soundwire: intel_init: fix alignment issues
Date:   Wed,  1 May 2019 10:57:37 -0500
Message-Id: <20190501155745.21806-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index e0f2903101c7..9ad6045720c4 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -69,7 +69,7 @@ static struct sdw_intel_ctx
 	/* Found controller, find links supported */
 	count = 0;
 	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
-				  "mipi-sdw-master-count", &count, 1);
+					    "mipi-sdw-master-count", &count, 1);
 
 	/* Don't fail on error, continue and use hw value */
 	if (ret) {
@@ -87,7 +87,7 @@ static struct sdw_intel_ctx
 	/* Check count is within bounds */
 	if (count > SDW_MAX_LINKS) {
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
-						count, SDW_MAX_LINKS);
+			count, SDW_MAX_LINKS);
 		return NULL;
 	}
 
@@ -147,7 +147,7 @@ static struct sdw_intel_ctx
 }
 
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
-					void *cdata, void **return_value)
+				     void *cdata, void **return_value)
 {
 	struct sdw_intel_res *res = cdata;
 	struct acpi_device *adev;
@@ -174,9 +174,9 @@ void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-					parent_handle, 1,
-					sdw_intel_acpi_cb,
-					NULL, res, NULL);
+				     parent_handle, 1,
+				     sdw_intel_acpi_cb,
+				     NULL, res, NULL);
 	if (ACPI_FAILURE(status))
 		return NULL;
 
-- 
2.17.1

