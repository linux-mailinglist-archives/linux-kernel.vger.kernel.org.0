Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0D120229
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLPKSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:18:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbfLPKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:18:32 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B33825244AC7199523B4;
        Mon, 16 Dec 2019 18:18:25 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:18:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <kraxel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH] drm/ast: Make the symbol 'ast_mode_config_mode_valid' static
Date:   Mon, 16 Dec 2019 18:13:56 +0800
Message-ID: <1576491236-18352-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning.

drivers/gpu/drm/ast/ast_main.c:391:22: warning: symbol 'ast_mode_config_mode_valid' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/ast/ast_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index b79f484..f0d2082 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -388,8 +388,8 @@ static int ast_get_dram_info(struct drm_device *dev)
 	return 0;
 }
 
-enum drm_mode_status ast_mode_config_mode_valid(struct drm_device *dev,
-						const struct drm_display_mode *mode)
+static enum drm_mode_status ast_mode_config_mode_valid(struct drm_device *dev,
+				       const struct drm_display_mode *mode)
 {
 	static const unsigned long max_bpp = 4; /* DRM_FORMAT_XRGBA8888 */
 
-- 
1.7.12.4

