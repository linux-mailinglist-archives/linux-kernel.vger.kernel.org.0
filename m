Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038BB485A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfFQOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:37:33 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:39724 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:37:32 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id RqdV2000T3XaVaC01qdVHV; Mon, 17 Jun 2019 16:37:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcslF-0002J3-Jg; Mon, 17 Jun 2019 16:37:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcslF-0001IY-IN; Mon, 17 Jun 2019 16:37:29 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/amd/display: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:37:28 +0200
Message-Id: <20190617143728.4949-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/amd/display/modules/power/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
index 87851f892a52d372..9d1b22d35ece9136 100644
--- a/drivers/gpu/drm/amd/display/modules/power/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
@@ -28,4 +28,4 @@ MOD_POWER = power_helpers.o
 AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
 #$(info ************  DAL POWER MODULE MAKEFILE ************)
 
-AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
\ No newline at end of file
+AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
-- 
2.17.1

