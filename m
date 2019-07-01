Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0928179
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfEWPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 11:43:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39956 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfEWPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:43:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id h13so4754147lfc.7;
        Thu, 23 May 2019 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rt3kwZULHGK/PKpRtUuWwLsPHH34ElZ4GD2j3IDRk3w=;
        b=Hkjw+CLdxGJTm9Z8TgeKtXuB+lk9hwmn56w1P9kQ1TjBzO/54IowI+CxZ4O+7rneJF
         903dKrkD1WEoZmWa6s1OSNTrL8SOE2pecIejBepyYvLwCy8wDopHP3fW4/gy/8AUDzCI
         03e0aSidNY2gH1B5TSBqOQv6WCUmj7R3fvTPq5xmPnWxQajt8R/iWUTNgJ91Msd1GkDL
         SC0pcRVwbVkHSx3vfCX4yQ4EGcpG8apUdnEgIBI2QAyr1vWDHtnPWIQOW4Obk4RbFQji
         rB9KBRejUnh+7h4rEAHbROzC9xJc7U4k2EHBBPUi+F4jJG1OfP9sWAr9TlXN5Osj46tC
         OL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rt3kwZULHGK/PKpRtUuWwLsPHH34ElZ4GD2j3IDRk3w=;
        b=KZBWjk7UAN3slK6S+9Q5cGvLY4j3QwnZWoz0CKR2oRB/JattrZ9l/vcQJH291iwB1+
         FXDTCHK4wa0+tJzO6HyYxOW6tDqTiFGi0x9BGPI4riW2yFIrYK0Q7vaNIZwlPQQDVo9A
         BU0ssthE4FqFsPFQnwgkD2VDSNEsB6J5ANqJNzfzYcieoLnkJhbt6GjsdAOWFVZTHWd6
         tWgxomcGFuw03KwSkGgG+TvIzlWkRQ3B1EPXTKndYkDZirC8vwy0JDLVUy6jrx+SVXhR
         aEYOVpPfkTPYazxoEpnjw+hdE015mh6/vM8lqEcgSDhQfDM/mBfxrAxHtGC1iIiQQLPq
         JJuQ==
X-Gm-Message-State: APjAAAVKziHckJzrYcwStcSWIi9i2qd/r+OBywxah4rrjVZEpqUnZAix
        jfTf0zu8P5d2feh0F1Ac+ppXAg10
X-Google-Smtp-Source: APXvYqx/ipqLQ/Gvk7k00swJjRnoH5BJnzcsLzG0x4+LWZwEAVMhPXWH+WMw2vABjusmZ3xoN9tkgg==
X-Received: by 2002:ac2:4111:: with SMTP id b17mr5751476lfi.31.1558626202089;
        Thu, 23 May 2019 08:43:22 -0700 (PDT)
Received: from localhost.localdomain (mm-89-92-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.92.89])
        by smtp.gmail.com with ESMTPSA id p10sm2450147ljh.50.2019.05.23.08.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:43:21 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] blk-core: Remove blk_end_request*() declarations
Date:   Thu, 23 May 2019 18:43:11 +0300
Message-Id: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Commit a1ce35fa49852db60fc6e268 ("block: remove dead elevator code")
deleted blk_end_request() and friends, but some declaration are still
left. Purge them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c       |  2 +-
 include/linux/blkdev.h | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..48ba4783437f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1393,7 +1393,7 @@ EXPORT_SYMBOL_GPL(blk_steal_bios);
  *
  *     This special helper function is only for request stacking drivers
  *     (e.g. request-based dm) so that they can handle partial completion.
- *     Actual device drivers should use blk_end_request instead.
+ *     Actual device drivers should use blk_mq_end_request instead.
  *
  *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
  *     %false return from this function.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aafeb923e7b..d069b5e2a295 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1021,21 +1021,9 @@ void blk_steal_bios(struct bio_list *list, struct request *rq);
  *
  * blk_update_request() completes given number of bytes and updates
  * the request without completing it.
- *
- * blk_end_request() and friends.  __blk_end_request() must be called
- * with the request queue spinlock acquired.
- *
- * Several drivers define their own end_request and call
- * blk_end_request() for parts of the original function.
- * This prevents code duplication in drivers.
  */
 extern bool blk_update_request(struct request *rq, blk_status_t error,
 			       unsigned int nr_bytes);
-extern void blk_end_request_all(struct request *rq, blk_status_t error);
-extern bool __blk_end_request(struct request *rq, blk_status_t error,
-			      unsigned int nr_bytes);
-extern void __blk_end_request_all(struct request *rq, blk_status_t error);
-extern bool __blk_end_request_cur(struct request *rq, blk_status_t error);
 
 extern void __blk_complete_request(struct request *);
 extern void blk_abort_request(struct request *);
-- 
2.21.0

