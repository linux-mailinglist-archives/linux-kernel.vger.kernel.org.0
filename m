Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07081A647
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 04:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfEKCSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 22:18:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728194AbfEKCSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:18:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B88A99C3A03DAD11F8E;
        Sat, 11 May 2019 10:18:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sat, 11 May 2019
 10:18:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <fatemeh.darbehani@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amd/display: Make two functions static
Date:   Sat, 11 May 2019 10:17:37 +0800
Message-ID: <20190511021737.8796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_clk_mgr.c:260:5:
 warning: symbol 'dcn10_set_dispclk' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_clk_mgr.c:286:5:
 warning: symbol 'dcn10_set_dprefclk' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
index 9f2ffce..ae8c40c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
@@ -257,7 +257,8 @@ static void dcn1_update_clocks(struct clk_mgr *clk_mgr,
 #define VBIOSSMC_MSG_SetDispclkFreq           0x4
 #define VBIOSSMC_MSG_SetDprefclkFreq          0x5
 
-int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base, int requested_dispclk_khz)
+static int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base,
+			     int requested_dispclk_khz)
 {
 	int actual_dispclk_set_khz = -1;
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr_base);
@@ -283,7 +284,7 @@ int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base, int requested_dispclk_khz)
 
 }
 
-int dcn10_set_dprefclk(struct clk_mgr *clk_mgr_base)
+static int dcn10_set_dprefclk(struct clk_mgr *clk_mgr_base)
 {
 	int actual_dprefclk_set_khz = -1;
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr_base);
-- 
2.7.4


