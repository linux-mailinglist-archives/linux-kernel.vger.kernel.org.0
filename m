Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9455F120249
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfLPKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:25:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbfLPKZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:25:17 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 509CC379E4694F3806BA;
        Mon, 16 Dec 2019 18:25:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:25:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] drm/ast: make the symbol 'ast_primary_plane_helper_atomic_update' static
Date:   Mon, 16 Dec 2019 18:20:45 +0800
Message-ID: <1576491645-18795-1-git-send-email-zhongjiang@huawei.com>
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

drivers/gpu/drm/ast/ast_mode.c:563:6: warning: symbol 'ast_primary_plane_helper_atomic_update' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index cde1cae..44b598d 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -560,7 +560,7 @@ static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
-void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
+static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
 					    struct drm_plane_state *old_state)
 {
 	struct ast_private *ast = plane->dev->dev_private;
-- 
1.7.12.4

