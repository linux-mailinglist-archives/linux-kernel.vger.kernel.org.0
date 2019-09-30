Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626C1C2995
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 00:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfI3W2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 18:28:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbfI3W2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:28:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 96BCC28A81A
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v3 5/5] RFC: drm/atomic-helper: Reapply color transformation after resume
Date:   Mon, 30 Sep 2019 19:28:02 -0300
Message-Id: <20190930222802.32088-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190930222802.32088-1-ezequiel@collabora.com>
References: <20190930222802.32088-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms are not able to maintain the color transformation
state after a system suspend/resume cycle.

Set the colog_mgmt_changed flag so that CMM on the CRTCs in
the suspend state are reapplied after system resume.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
This is an RFC, and it's mostly based on Jacopo Mondi's work https://lkml.org/lkml/2019/9/6/498.

Changes from v2:
* New patch.
---
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index e41db0f202ca..518488125575 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3234,8 +3234,20 @@ int drm_atomic_helper_resume(struct drm_device *dev,
 			     struct drm_atomic_state *state)
 {
 	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	unsigned int i;
 	int err;
 
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		/*
+		 * Force re-enablement of CMM after system resume if any
+		 * of the DRM color transformation properties was set in
+		 * the state saved at system suspend time.
+		 */
+		if (crtc_state->gamma_lut)
+			crtc_state->color_mgmt_changed = true;
+	}
 	drm_mode_config_reset(dev);
 
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
-- 
2.22.0

