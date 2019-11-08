Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B54F511A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKHQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:29:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43679 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:29:50 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iT78s-0006ft-4s; Fri, 08 Nov 2019 16:29:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: remove redundant variable status
Date:   Fri,  8 Nov 2019 16:29:45 +0000
Message-Id: <20191108162945.180624-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable status is redundant, it is being initialized with a value
that is over-written later and this is being returned immediately
after the assignment.  Clean up the code by removing status and
just returning the value returned from the call to function
dc->hwss.dmdata_status_done.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 371d49e9b745..88a84bfaea6f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -565,7 +565,6 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 
 bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
 {
-	bool status = true;
 	struct pipe_ctx *pipe = NULL;
 	int i;
 
@@ -581,8 +580,7 @@ bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
 	if (i == MAX_PIPES)
 		return true;
 
-	status = dc->hwss.dmdata_status_done(pipe);
-	return status;
+	return dc->hwss.dmdata_status_done(pipe);
 }
 
 bool dc_stream_set_dynamic_metadata(struct dc *dc,
-- 
2.20.1

