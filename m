Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271E8169262
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 00:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBVXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 18:51:56 -0500
Received: from vps.xff.cz ([195.181.215.36]:34404 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgBVXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582415514; bh=1rcpmynqM7XOcznUMag08uGqQJH2xF0Ib2wJScD9GqI=;
        h=From:To:Cc:Subject:Date:From;
        b=NxCqPrLepYANmyQmbImPr18oCLahsuqGsJptFoegS9suts6yf1pU9ZTLEr8mWAmX6
         HjBRc9FYbdfsLeqmH/8S6pjkLvuvg30Oni/6kgIR089nqzWsx8PrXfTkvAXpBouB9v
         CR6Igj9KNu7iD0emEIBOwagzXelNw5Y9dFlA68Fc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org (open list:DRM DRIVER FOR ASPEED BMC GFX),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT)
Subject: [PATCH] drm: aspeed: Fix GENMASK misuse
Date:   Sun, 23 Feb 2020 00:51:52 +0100
Message-Id: <20200222235152.242816-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments to GENMASK should be msb >= lsb.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
I just grepped the whole kernel tree for GENMASK argument order issues,
and this is one of the three that popped up. No testing was done.

 drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index a10358bb61ec4..095ea03e5833c 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
 /* CTRL2 */
 #define CRT_CTRL_DAC_EN			BIT(0)
 #define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
-#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
+#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(31, 20)
 
 /* CRT_HORIZ0 */
 #define CRT_H_TOTAL(x)			(x)
-- 
2.25.1

