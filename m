Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C10F1298
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfKFJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 04:44:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50647 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfKFJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:44:11 -0500
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3BBEE240016;
        Wed,  6 Nov 2019 09:44:09 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] drm/gma500: Add missing call to allow enabling vblank on psb/cdv
Date:   Wed,  6 Nov 2019 10:43:59 +0100
Message-Id: <20191106094400.445834-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a missing call to drm_crtc_vblank_on to the common DPMS helper
(used by poulsbo and cedartrail), which is called in the CRTC enable path.

With that call, it becomes possible to enable vblank when needed.
It is already balanced by a drm_crtc_vblank_off call in the helper.

Other platforms (oaktrail and medfield) use a dedicated DPMS helper that
does not have the proper vblank on/off hooks. They are not added in this
commit due to lack of hardware to test it with.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/gma500/gma_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index e20ccb5d10fd..bc07ae2a9a1d 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -255,6 +255,8 @@ void gma_crtc_dpms(struct drm_crtc *crtc, int mode)
 		/* Give the overlay scaler a chance to enable
 		 * if it's on this pipe */
 		/* psb_intel_crtc_dpms_video(crtc, true); TODO */
+
+		drm_crtc_vblank_on(crtc);
 		break;
 	case DRM_MODE_DPMS_OFF:
 		if (!gma_crtc->active)
-- 
2.23.0

