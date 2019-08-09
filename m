Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5E87E69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436822AbfHIPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:47:17 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:54980 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436807AbfHIPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:47:17 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d35 with ME
        id n3nC2000S0Dzhgk033nCfu; Fri, 09 Aug 2019 17:47:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Aug 2019 17:47:14 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, David.Francis@amd.com,
        mario.kleiner.de@gmail.com, Bhawanpreet.Lakha@amd.com,
        Anthony.Koo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amd/display: Fix a typo - amdpgu_dm --> amdgpu_dm
Date:   Fri,  9 Aug 2019 17:46:16 +0200
Message-Id: <20190809154616.25479-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be 'amdgpu_dm', not 'amdpgu_dm'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 332ac9d985f2..1ccd0e4d459f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -836,7 +836,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 
 /**
  * dm_hw_init() - Initialize DC device
- * @handle: The base driver device containing the amdpgu_dm device.
+ * @handle: The base driver device containing the amdgpu_dm device.
  *
  * Initialize the &struct amdgpu_display_manager device. This involves calling
  * the initializers of each DM component, then populating the struct with them.
@@ -866,7 +866,7 @@ static int dm_hw_init(void *handle)
 
 /**
  * dm_hw_fini() - Teardown DC device
- * @handle: The base driver device containing the amdpgu_dm device.
+ * @handle: The base driver device containing the amdgpu_dm device.
  *
  * Teardown components within &struct amdgpu_display_manager that require
  * cleanup. This involves cleaning up the DRM device, DC, and any modules that
-- 
2.20.1

