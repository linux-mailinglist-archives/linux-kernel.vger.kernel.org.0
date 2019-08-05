Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20B8170F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfHEK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 06:29:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHEK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:29:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1huaFI-0006WD-Vn; Mon, 05 Aug 2019 10:29:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amd/powerplay: remove redundant duplicated return check
Date:   Mon,  5 Aug 2019 11:29:40 +0100
Message-Id: <20190805102940.26024-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check on ret is duplicated in two places, it is redundant code.
Remove it.

Addresses-Coverity: ("Logically dead code")
Fixes: b94afb61cdae ("drm/amd/powerplay: honor hw limit on fetching metrics data for navi10")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d62c2784b102..b272c8dc8f79 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -941,8 +941,6 @@ static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
 	ret = navi10_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
-	if (ret)
-		return ret;
 
 	*value = metrics.AverageSocketPower << 8;
 
@@ -1001,8 +999,6 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 	ret = navi10_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
-	if (ret)
-		return ret;
 
 	*speed = metrics.CurrFanSpeed;
 
-- 
2.20.1

