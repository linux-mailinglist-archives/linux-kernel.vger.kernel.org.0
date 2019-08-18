Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFC91656
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfHRLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 07:12:32 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:60958 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 07:12:32 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 07:12:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=s74AHHwTnA/+WJp96G
        w0YVTuKNK7lccVWLSkhgvB1Bw=; b=HegFC1yW08FraW1wF0HD5TwtlokahrHsOQ
        51xHzIPSOG/vHls08d46r4NGFjU/x7YoIIeyZMLmnmPOP6MyfXenZaqnx8y/ZpWl
        aq+ycyDsHgCKBQUbvFdgSBi+c7ukHAugncxMC1OEOqSXCgLO1D2cV7spbTO6pRK2
        Za9kqYaRQ=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgCX_bEPL1ld_aopAQ--.427S3;
        Sun, 18 Aug 2019 18:57:22 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] block: fix a mismatched alloc free in bio_alloc_bioset
Date:   Sun, 18 Aug 2019 18:57:17 +0800
Message-Id: <1566125837-17543-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgCX_bEPL1ld_aopAQ--.427S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4xGF43JF4fCF4DJw1UJrb_yoW3XFX_Ka
        1jgFs7GF1kXFW7CasFkrW8Ar109rWfGr48uFnxt343Xry5WFn3ZwnFqr95Wrs3CrWxuFy5
        Z395W3W5tr17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1UKs5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBURIVclaD4CilgwAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kmalloc is called to allocate memory if bs is NULL.
However, mempool_free is used to release the memory chunk even if bs is
NULL in the error hanlding code. This patch checks bs and use the
correct function to release memory.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 block/bio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7..c5f5238 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -515,7 +515,10 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 	return bio;
 
 err_free:
-	mempool_free(p, &bs->bio_pool);
+	if (!bs)
+		kfree(p);
+	else
+		mempool_free(p, &bs->bio_pool);
 	return NULL;
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
-- 
2.7.4

