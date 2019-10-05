Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB5CC9A2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJELcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 07:32:23 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:47834 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfJELcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:32:22 -0400
Received: from localhost.localdomain ([93.22.148.54])
        by mwinf5d13 with ME
        id 9nYA2100U1AfE5H03nYBUv; Sat, 05 Oct 2019 13:32:21 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Oct 2019 13:32:21 +0200
X-ME-IP: 93.22.148.54
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amd/display: Fix typo in some comments
Date:   Sat,  5 Oct 2019 13:32:05 +0200
Message-Id: <20191005113205.14601-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p and g are switched in 'amdpgu_dm'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92932d521d7f..b9c2e1a930ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1043,7 +1043,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 
 /**
  * dm_hw_init() - Initialize DC device
- * @handle: The base driver device containing the amdpgu_dm device.
+ * @handle: The base driver device containing the amdgpu_dm device.
  *
  * Initialize the &struct amdgpu_display_manager device. This involves calling
  * the initializers of each DM component, then populating the struct with them.
@@ -1073,7 +1073,7 @@ static int dm_hw_init(void *handle)
 
 /**
  * dm_hw_fini() - Teardown DC device
- * @handle: The base driver device containing the amdpgu_dm device.
+ * @handle: The base driver device containing the amdgpu_dm device.
  *
  * Teardown components within &struct amdgpu_display_manager that require
  * cleanup. This involves cleaning up the DRM device, DC, and any modules that
-- 
2.20.1

