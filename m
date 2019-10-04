Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290BDCB522
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfJDHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 03:38:17 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:48294 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbfJDHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:38:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DDA4A27E0F36;
        Fri,  4 Oct 2019 09:38:10 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rl8GD9ew8mil; Fri,  4 Oct 2019 09:38:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6454827E0E5F;
        Fri,  4 Oct 2019 09:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6454827E0E5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1570174690;
        bh=m0IZGO1OMSmC0Bn/Pt54UKIFEBspEgEXw7Mo4uN0eac=;
        h=From:To:Date:Message-Id;
        b=PuCs27ONIu4SzkrjDdamr5UXsC416N7uxh+ro8SjzcPwY8Q0E35FroLBlNGfa24Y2
         40hvcTd26Lu55u0dKJQQyDsrR5MjQDhdkYtkamfBjist8R+I+46RV+KSGg2gaI/mXz
         rCnUDqS5IBOZ3frv3wW6O7ReWPhV349FlOLH0FOE=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f-YyJ9MZVqKT; Fri,  4 Oct 2019 09:38:10 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 504D327E0E2E;
        Fri,  4 Oct 2019 09:38:10 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Clement Leger <cleger@kalray.eu>
Subject: [PATCH] remoteproc: Fix wrong rvring index computation
Date:   Fri,  4 Oct 2019 09:37:36 +0200
Message-Id: <20191004073736.8327-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Index of rvring is computed using pointer arithmetic. However, since
rvring->rvdev->vring is the base of the vring array, computation
of rvring idx should be reversed. It previously lead to writing at negative
indices in the resource table.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3c5fbbbfb0f1..ab7443874635 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -400,7 +400,7 @@ rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
 void rproc_free_vring(struct rproc_vring *rvring)
 {
 	struct rproc *rproc = rvring->rvdev->rproc;
-	int idx = rvring->rvdev->vring - rvring;
+	int idx = rvring - rvring->rvdev->vring;
 	struct fw_rsc_vdev *rsc;
 
 	idr_remove(&rproc->notifyids, rvring->notifyid);
-- 
2.15.0.276.g89ea799

