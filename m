Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7C151CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBDO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:59:12 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:46564 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgBDO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:59:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0EA6D27E10DF;
        Tue,  4 Feb 2020 15:59:11 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XjChVko_WBR6; Tue,  4 Feb 2020 15:59:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C4BA227E09CB;
        Tue,  4 Feb 2020 15:59:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C4BA227E09CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1580828350;
        bh=LYboxO+eGgeaPP+5xSVoFyM/DMglJmskvLywsMeS+6s=;
        h=From:To:Date:Message-Id;
        b=jezB30oAuRSITs+9Ea8xCL9S+F11Xzjk/kHO4rldIpD/92uL7maRAhk4Nb8mIfbFE
         ssOtBtQWNULScoWvdbJZFZNc5kIjhY9ahcpBsTy5m+clPgNifgd96+E23p6RkST6tk
         8aRdzYgzK1sAE5v4y4vtlW62+gqKWSKTDG06esIQ=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kjv5ZIbr3A-7; Tue,  4 Feb 2020 15:59:10 +0100 (CET)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id B144C27E02DE;
        Tue,  4 Feb 2020 15:59:10 +0100 (CET)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH] remoteproc: Replace trailing commas with semicolons
Date:   Tue,  4 Feb 2020 15:58:53 +0100
Message-Id: <20200204145853.29056-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace two misplaced trailing commas by semicolons.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/remoteproc/remoteproc_virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 8c07cb2ca8ba..d58c6565f51d 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -376,8 +376,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 		ret = -ENOMEM;
 		goto out;
 	}
-	vdev->id.device	= id,
-	vdev->config = &rproc_virtio_config_ops,
+	vdev->id.device	= id;
+	vdev->config = &rproc_virtio_config_ops;
 	vdev->dev.parent = dev;
 	vdev->dev.release = rproc_virtio_dev_release;
 
-- 
2.15.0.276.g89ea799

