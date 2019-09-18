Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0FB63ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfIRM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 08:59:31 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:48916 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfIRM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:59:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CA0663F51E;
        Wed, 18 Sep 2019 14:59:28 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="r9L3bfmr";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ie7I6TOX5u-9; Wed, 18 Sep 2019 14:59:28 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id BB6063F549;
        Wed, 18 Sep 2019 14:59:24 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4918A36031D;
        Wed, 18 Sep 2019 14:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568811564; bh=R7so/IGdQQ1rwaSJyPiZqti40YJDt90potOk+4jpddE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9L3bfmr6V+Rgk+/d++uKtKktRO+85SKrG+zpdhKK0NyALMkfvZMsfWA/Um/9pYwK
         7VFgVgxC2m/jU3T7YWAAfbhU5mkr0pA5iNJI/yTmKf+nxfpjl7ZzcPR/Lb9LevLQTF
         9zn1OzTI2iY4ewmuPOSaceriTaNSK4UajXVjU6Uw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/7] drm/ttm: Remove explicit typecasts of vm_private_data
Date:   Wed, 18 Sep 2019 14:59:09 +0200
Message-Id: <20190918125914.38497-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918125914.38497-1-thomas_os@shipmail.org>
References: <20190918125914.38497-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The explicit typcasts are meaningless, so remove them.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 76eedb963693..8963546bf245 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -109,8 +109,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
 static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
-	    vma->vm_private_data;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
 	struct ttm_bo_device *bdev = bo->bdev;
 	unsigned long page_offset;
 	unsigned long page_last;
@@ -302,8 +301,7 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 
 static void ttm_bo_vm_open(struct vm_area_struct *vma)
 {
-	struct ttm_buffer_object *bo =
-	    (struct ttm_buffer_object *)vma->vm_private_data;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
 
 	WARN_ON(bo->bdev->dev_mapping != vma->vm_file->f_mapping);
 
@@ -312,7 +310,7 @@ static void ttm_bo_vm_open(struct vm_area_struct *vma)
 
 static void ttm_bo_vm_close(struct vm_area_struct *vma)
 {
-	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)vma->vm_private_data;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
 
 	ttm_bo_put(bo);
 	vma->vm_private_data = NULL;
-- 
2.20.1

