Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62EDBC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504307AbfJRFGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:06:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504043AbfJRFGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:06:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F20BB516FE4D8C20BE4A;
        Fri, 18 Oct 2019 11:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 09/33] drbd: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:26 +0800
Message-ID: <20191018031850.48498-9-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/drbd/drbd_nl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 5d52a2d32155..de2f94d0103a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -268,19 +268,18 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 	/* some more paranoia, if the request was over-determined */
 	if (adm_ctx->device && adm_ctx->resource &&
 	    adm_ctx->device->resource != adm_ctx->resource) {
-		pr_warning("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
-				adm_ctx->minor, adm_ctx->resource->name,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
+			adm_ctx->minor, adm_ctx->resource->name,
+			adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists in different resource");
 		return ERR_INVALID_REQUEST;
 	}
 	if (adm_ctx->device &&
 	    adm_ctx->volume != VOLUME_UNSPECIFIED &&
 	    adm_ctx->volume != adm_ctx->device->vnr) {
-		pr_warning("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
-				adm_ctx->minor, adm_ctx->volume,
-				adm_ctx->device->vnr,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
+			adm_ctx->minor, adm_ctx->volume,
+			adm_ctx->device->vnr, adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists as different volume");
 		return ERR_INVALID_REQUEST;
 	}
-- 
2.20.1

