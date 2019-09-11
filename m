Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A180AF897
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfIKJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 05:12:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfIKJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:12:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i7yfr-0004Aq-NU; Wed, 11 Sep 2019 09:12:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/selftests: fix spelling mistake "misssing" -> "missing"
Date:   Wed, 11 Sep 2019 10:12:27 +0100
Message-Id: <20190911091227.5710-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/selftests/test-drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
index 74d5561a862b..2d29ea6f92e2 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
@@ -126,7 +126,7 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 		 .handles = { 1, 1, 0 }, .pitches = { MAX_WIDTH, MAX_WIDTH - 1, 0 },
 	}
 },
-{ .buffer_created = 0, .name = "NV12 Invalid modifier/misssing DRM_MODE_FB_MODIFIERS flag",
+{ .buffer_created = 0, .name = "NV12 Invalid modifier/missing DRM_MODE_FB_MODIFIERS flag",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_NV12,
 		 .handles = { 1, 1, 0 }, .modifier = { DRM_FORMAT_MOD_SAMSUNG_64_32_TILE, 0, 0 },
 		 .pitches = { MAX_WIDTH, MAX_WIDTH, 0 },
-- 
2.20.1

