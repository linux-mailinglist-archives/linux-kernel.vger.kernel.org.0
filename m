Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2350A7AED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfIDFrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 01:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF4EE81DE3;
        Wed,  4 Sep 2019 05:47:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12B5660610;
        Wed,  4 Sep 2019 05:47:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3FFA831EBC; Wed,  4 Sep 2019 07:47:41 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/7] drm/vram: use drm_gem_ttm_print_info
Date:   Wed,  4 Sep 2019 07:47:36 +0200
Message-Id: <20190904054740.20817-4-kraxel@redhat.com>
In-Reply-To: <20190904054740.20817-1-kraxel@redhat.com>
References: <20190904054740.20817-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 04 Sep 2019 05:47:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 4 +++-
 drivers/gpu/drm/Kconfig               | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fd751078bae1..71552f757b4a 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_mode.h>
@@ -633,5 +634,6 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
 	.pin	= drm_gem_vram_object_pin,
 	.unpin	= drm_gem_vram_object_unpin,
 	.vmap	= drm_gem_vram_object_vmap,
-	.vunmap	= drm_gem_vram_object_vunmap
+	.vunmap	= drm_gem_vram_object_vunmap,
+	.print_info = drm_gem_ttm_print_info,
 };
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7b25519f95c..1be8ad30d8fe 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
 	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Helpers for VRAM memory management
 
-- 
2.18.1

