Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE18D8F16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392654AbfJPLQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:16:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbfJPLQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:16:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EACCDA952248D822D464;
        Wed, 16 Oct 2019 19:16:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 19:15:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>,
        <Anthony.Koo@amd.com>, <Eric.Yang2@amd.com>, <Wenjing.Liu@amd.com>,
        <David.Francis@amd.com>, <nikola.cornij@amd.com>,
        <Chris.Park@amd.com>, <martin.leung@amd.com>,
        <david.galiffi@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Make dc_link_detect_helper static
Date:   Wed, 16 Oct 2019 19:15:41 +0800
Message-ID: <20191016111541.20208-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:746:6:
 warning: symbol 'dc_link_detect_helper' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fb18681..9350536 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -743,7 +743,8 @@ static bool wait_for_alt_mode(struct dc_link *link)
  * This does not create remote sinks but will trigger DM
  * to start MST detection if a branch is detected.
  */
-bool dc_link_detect_helper(struct dc_link *link, enum dc_detect_reason reason)
+static bool dc_link_detect_helper(struct dc_link *link,
+				  enum dc_detect_reason reason)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct display_sink_capability sink_caps = { 0 };
-- 
2.7.4


