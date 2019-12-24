Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4462129ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 09:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLXIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 03:14:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLXIO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:14:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C90B50C47FAF58CEBF8;
        Tue, 24 Dec 2019 16:14:26 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Dec 2019 16:14:23 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] drm/i915: use true,false for bool variable in intel_crt.c
Date:   Tue, 24 Dec 2019 16:15:15 +0800
Message-ID: <1577175315-93406-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/i915/display/intel_crt.c:1066:1-28: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/display/intel_crt.c:928:2-29: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/display/intel_crt.c:443:2-29: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_crt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index b2b1336..8596eef 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -440,7 +440,7 @@ static bool intel_ironlake_crt_detect_hotplug(struct drm_connector *connector)
 		bool turn_off_dac = HAS_PCH_SPLIT(dev_priv);
 		u32 save_adpa;

-		crt->force_hotplug_required = 0;
+		crt->force_hotplug_required = false;

 		save_adpa = adpa = I915_READ(crt->adpa_reg);
 		DRM_DEBUG_KMS("trigger hotplug detect cycle: adpa=0x%x\n", adpa);
@@ -925,7 +925,7 @@ void intel_crt_reset(struct drm_encoder *encoder)
 		POSTING_READ(crt->adpa_reg);

 		DRM_DEBUG_KMS("crt adpa set to 0x%x\n", adpa);
-		crt->force_hotplug_required = 1;
+		crt->force_hotplug_required = true;
 	}

 }
@@ -1063,7 +1063,7 @@ void intel_crt_init(struct drm_i915_private *dev_priv)
 	/*
 	 * Configure the automatic hotplug detection stuff
 	 */
-	crt->force_hotplug_required = 0;
+	crt->force_hotplug_required = false;

 	/*
 	 * TODO: find a proper way to discover whether we need to set the the
--
2.6.2

