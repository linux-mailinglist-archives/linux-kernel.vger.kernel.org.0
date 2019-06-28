Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B211A59A01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfF1MGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:06:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF1MGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:06:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 1F45D289C5D
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v4 2/2] Revert "drm/vblank: Do not update vblank count if interrupts are already disabled."
Date:   Fri, 28 Jun 2019 13:05:32 +0100
Message-Id: <fc4a6e587e4570227f67a82f2d0e9520934e717e.1561722822.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1561722822.git.bob.beckett@collabora.com>
References: <cover.1561722822.git.bob.beckett@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupts are already disabled, then the timestamp for the vblank
does not get updated, causing a stale timestamp to be reported to
userland while disabling crtcs.

This reverts commit 68036b08b91bc491ccc308f902616a570a49227c.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/drm_vblank.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 7dabb2bdb733..aeb9734d7799 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -371,25 +371,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
 	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
 
 	/*
-	 * Update vblank count and disable vblank interrupts only if the
-	 * interrupts were enabled. This avoids calling the ->disable_vblank()
-	 * operation in atomic context with the hardware potentially runtime
-	 * suspended.
+	 * Only disable vblank interrupts if they're enabled. This avoids
+	 * calling the ->disable_vblank() operation in atomic context with the
+	 * hardware potentially runtime suspended.
 	 */
-	if (!vblank->enabled)
-		goto out;
+	if (vblank->enabled) {
+		__disable_vblank(dev, pipe);
+		vblank->enabled = false;
+	}
 
 	/*
-	 * Update the count and timestamp to maintain the
+	 * Always update the count and timestamp to maintain the
 	 * appearance that the counter has been ticking all along until
 	 * this time. This makes the count account for the entire time
 	 * between drm_crtc_vblank_on() and drm_crtc_vblank_off().
 	 */
 	drm_update_vblank_count(dev, pipe, false);
-	__disable_vblank(dev, pipe);
-	vblank->enabled = false;
 
-out:
 	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
 }
 
-- 
2.18.0

