Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD971943
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfGWNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:32:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52948 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGWNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:32:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hputv-0007Ip-Bg; Tue, 23 Jul 2019 13:32:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: remove duplicated comparison
Date:   Tue, 23 Jul 2019 14:32:19 +0100
Message-Id: <20190723133219.27877-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of surface_pitch is duplicated and hence one of these
comparisons is redundant and can be removed.  Remove it.

Addresses-Coverity: ("Same on both sides")
Fixes: 12e2b2d4c65f ("drm/amd/display: add dcc programming for dual plane")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 94f126d2331c..168f4a7dffdf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1379,7 +1379,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 	}
 
 	if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
-			|| u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
 			|| u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
 		update_flags->bits.plane_size_change = 1;
 		elevate_update_type(&update_type, UPDATE_TYPE_MED);
-- 
2.20.1

