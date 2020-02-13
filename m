Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715FC15BE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 13:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgBMMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 07:01:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:01:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8D7602950AB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/mediatek: Update the fb property mtk_plane_atomic_async_update
Date:   Thu, 13 Feb 2020 13:01:03 +0100
Message-Id: <20200213120103.823501-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 920fffcc8912 ("drm/mediatek: update cursors by using async atomic
update") added support to async updates of cursors by using the new atomic
interface for that. Unfortunately, introduced two issues. The first one is
that since then, the drm_atomic_helper_async_commit triggers a WARNING due
current fb is not the new fb. The second one, is that we get a black screen
connecting the external display on Elm device and another WARNING due vblank
wait timed out.

Swap the fb in mtk_plane_atomic_async_update to fix both issues.

Fixes: 920fffcc8912 ("drm/mediatek: update cursors by using async atomic update")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 914cc7619cd7..7eb10115e72a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -116,6 +116,7 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
 	plane->state->src_h = new_state->src_h;
 	plane->state->src_w = new_state->src_w;
 	state->pending.async_dirty = true;
+	swap(plane->state->fb, new_state->fb);
 
 	mtk_drm_crtc_async_update(new_state->crtc, plane, new_state);
 }
-- 
2.25.0

