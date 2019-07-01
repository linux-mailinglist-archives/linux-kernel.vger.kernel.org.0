Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0E59D85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfF1OKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 10:10:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:10:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgrXl-0004cj-Pu; Fri, 28 Jun 2019 14:08:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: fix off-by-one comparison on a WARN_ON message
Date:   Fri, 28 Jun 2019 15:08:01 +0100
Message-Id: <20190628140801.31937-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The WARN_ON is currently throwing a warning when i is 65 or higher which
is off by one. It should be 64 or higher (64 queues from 0..63 inclusive),
so fix this off-by-one comparison.

Fixes: 849aca9f9c03 ("drm/amdgpu: Move common code to amdgpu_gfx.c")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 74066e1466f7..c8d106c59e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -501,7 +501,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		/* This situation may be hit in the future if a new HW
 		 * generation exposes more than 64 queues. If so, the
 		 * definition of queue_mask needs updating */
-		if (WARN_ON(i > (sizeof(queue_mask)*8))) {
+		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
 			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
 			break;
 		}
-- 
2.20.1

