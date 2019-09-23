Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96378BB468
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502073AbfIWMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 08:53:26 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:39844 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439638AbfIWMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:53:21 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.76])
        by regular1.263xmail.com (Postfix) with ESMTP id 56ED7252;
        Mon, 23 Sep 2019 20:53:16 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32757T140634167924480S1569243191006336_;
        Mon, 23 Sep 2019 20:53:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <52b64afd7198c0ece3c36d3dd94a73ec>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 29/36] drm/ingenic: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:53:02 +0800
Message-Id: <1569243189-183445-4-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243189-183445-1-git-send-email-hjc@rock-chips.com>
References: <1569243189-183445-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index ec32e1c..70ccec5 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -375,7 +375,7 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 
 	width = state->crtc->state->adjusted_mode.hdisplay;
 	height = state->crtc->state->adjusted_mode.vdisplay;
-	cpp = state->fb->format->cpp[plane->index];
+	cpp = state->fb->format->bpp[plane->index] / 8;
 
 	priv->dma_hwdesc->addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
 	priv->dma_hwdesc->cmd = width * height * cpp / 4;
-- 
2.7.4



