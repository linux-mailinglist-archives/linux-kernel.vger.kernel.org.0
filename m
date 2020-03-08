Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC85217D2DD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 10:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 05:26:47 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:23968 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCHJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:26:46 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d18 with ME
        id BlSf220010scBcy03lSf0d; Sun, 08 Mar 2020 10:26:44 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Mar 2020 10:26:44 +0100
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, Bhawanpreet.Lakha@amd.com,
        mario.kleiner.de@gmail.com, David.Francis@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu/display: Fix an error handling path in 'dm_update_crtc_state()'
Date:   Sun,  8 Mar 2020 10:26:37 +0100
Message-Id: <20200308092637.8194-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dc_stream_release()' may be called twice. Once here, and once below in the
error handling path if we branch to the 'fail' label.

Set 'new_stream' to NULL, once released to avoid the duplicated release
function call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Maybe the 'goto fail' at line 7745 should be turned into a 'return ret'
instead. Could be clearer.

No Fixes tag provided because I've not been able to dig deep enough in the
git history.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97c1b01c0fc1..9d7773a77c4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7704,8 +7704,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 skip_modeset:
 	/* Release extra reference */
-	if (new_stream)
-		 dc_stream_release(new_stream);
+	if (new_stream) {
+		dc_stream_release(new_stream);
+		new_stream = NULL;
+	}
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.20.1

