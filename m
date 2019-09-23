Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0935CBB46F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394395AbfIWMyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 08:54:04 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:39930 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392215AbfIWMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:54:04 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.236])
        by regular1.263xmail.com (Postfix) with ESMTP id 30BDF275;
        Mon, 23 Sep 2019 20:53:55 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17988T139868132738816S1569243231409431_;
        Mon, 23 Sep 2019 20:53:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <454a4a62b894b008478819c2497f3d21>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 32/36] drm/mcde: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:53:46 +0800
Message-Id: <1569243230-183568-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
References: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/mcde/mcde_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 751454a..da2a3db 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -168,7 +168,7 @@ static int mcde_display_check(struct drm_simple_display_pipe *pipe,
 		 * There's no pitch register, the mode's hdisplay
 		 * controls this.
 		 */
-		if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0]) {
+		if (fb->pitches[0] != mode->hdisplay * fb->format->bpp[0] / 8) {
 			DRM_DEBUG_KMS("can't handle pitches\n");
 			return -EINVAL;
 		}
@@ -823,7 +823,7 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 	u32 formatter_ppl = mode->hdisplay; /* pixels per line */
 	u32 formatter_lpf = mode->vdisplay; /* lines per frame */
 	int pkt_size, fifo_wtrmrk;
-	int cpp = fb->format->cpp[0];
+	int cpp = fb->format->bpp[0] / 8;
 	int formatter_cpp;
 	struct drm_format_name_buf tmp;
 	u32 formatter_frame;
-- 
2.7.4



