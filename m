Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF147BD83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfGaJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 05:42:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34503 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfGaJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so39741560lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v7z7ajZA/7PTXrhjZs6VqtjiMZLl1a67tEOrwubYq4s=;
        b=ybbiv/RImcNU4Fqc9kuj8H/NPe29x3DFXuaZvRQY2+bSdu+iocqkX2956BDOeIqaBz
         g0H4WaGyYlvOHm9G1htI8BoBEd48vr97Se6vmFofagSsfEsjNhFzd+Edrx8NMzca0YDt
         3JrD4sBq1QoXOszosxGezunupUaGnxNhbDP0jAbh6cFY12CLh9E0D2D7Az3rSfL9AINU
         qBt5wdiaX5TaeE6JtXn1Fwe9jMqPB8HU1vxMChCZRm9SuxWczPdzSf4aLXj73weHnk8p
         f7c10wEHS9B9CtQoMqLUIkg8/ZWFkxKrZpR+GaLoyk/Wy5V/VBZEe3Dea4bHQRBS1RfJ
         yz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v7z7ajZA/7PTXrhjZs6VqtjiMZLl1a67tEOrwubYq4s=;
        b=cRBH96Y1lu3qIfXnfpe0oO0Mh0yXRnpR4x09UUqePu/J8//VPTa1qetksnJ8mAgLrb
         bGSfM8cUU5XHz95syisXtuhl8T7yIrpjuh5koUvVhqLm9tbJCeIMzCXN7ujSBLTIJuPq
         b9Q9Cmyxq/NAxkgoz+KPMYwwOUTM2H0f06HVYTWLc3H3Jq/csr5LeNtexYhAFGkEuwct
         mVJlFTnfwKXqhzY1qD+r+ar1SXy64sothPDqnNNtHHIfmLWOo/cRecLW20UqmlcOhmeF
         2v8KFBffPG8MIOF449L2xln+kRvyL8bBpqGnUbJIrHPu5zdJW4niKwcZhYjqhSyDKL8T
         eL+A==
X-Gm-Message-State: APjAAAWh6FRqoDWzTs7Y2pTzxzw+A8/UiJ/C4BtE/LPoGdpngqCzDadW
        6OYmtD3wNBSdRg/yhMQpDrY=
X-Google-Smtp-Source: APXvYqzBwa3xMg6hLpa/Rg8cx7rVH9hNI0OFAG2oKzhFJek17W4ynYrq8+zEww6dmKRUS4AsIcUSUw==
X-Received: by 2002:ac2:5636:: with SMTP id b22mr2734827lff.2.1564566135872;
        Wed, 31 Jul 2019 02:42:15 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:15 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 2/4] lightnvm: move metadata mapping to lower level driver
Date:   Wed, 31 Jul 2019 11:41:34 +0200
Message-Id: <1564566096-28756-3-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that blk_rq_map_kern can map both kmem and vmem, move
internal metadata mapping down to the lower level driver.

Signed-off-by: Hans Holmberg <hans@owltronix.com>
---
 drivers/lightnvm/core.c          |  16 +++---
 drivers/lightnvm/pblk-core.c     | 113 +++++----------------------------------
 drivers/lightnvm/pblk-read.c     |  22 ++------
 drivers/lightnvm/pblk-recovery.c |  39 ++------------
 drivers/lightnvm/pblk-write.c    |  20 ++-----
 drivers/lightnvm/pblk.h          |   8 +--
 drivers/nvme/host/lightnvm.c     |  20 +++++--
 include/linux/lightnvm.h         |   6 +--
 8 files changed, 54 insertions(+), 190 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 01d098fb96ac..3cd03582a2ed 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -731,7 +731,7 @@ static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
 	return flags;
 }
 
-int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
+int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd, void *buf)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	int ret;
@@ -745,7 +745,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 	rqd->flags = nvm_set_flags(&tgt_dev->geo, rqd);
 
 	/* In case of error, fail with right address format */
-	ret = dev->ops->submit_io(dev, rqd);
+	ret = dev->ops->submit_io(dev, rqd, buf);
 	if (ret)
 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 	return ret;
@@ -759,7 +759,8 @@ static void nvm_sync_end_io(struct nvm_rq *rqd)
 	complete(waiting);
 }
 
-static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd)
+static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd,
+			      void *buf)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
@@ -767,7 +768,7 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd)
 	rqd->end_io = nvm_sync_end_io;
 	rqd->private = &wait;
 
-	ret = dev->ops->submit_io(dev, rqd);
+	ret = dev->ops->submit_io(dev, rqd, buf);
 	if (ret)
 		return ret;
 
@@ -776,7 +777,8 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return 0;
 }
 
-int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
+int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
+		       void *buf)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	int ret;
@@ -789,7 +791,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 	rqd->dev = tgt_dev;
 	rqd->flags = nvm_set_flags(&tgt_dev->geo, rqd);
 
-	ret = nvm_submit_io_wait(dev, rqd);
+	ret = nvm_submit_io_wait(dev, rqd, buf);
 
 	return ret;
 }
@@ -816,7 +818,7 @@ static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq *rqd)
 	rqd->dev = NULL;
 	rqd->flags = nvm_set_flags(&dev->geo, rqd);
 
-	return nvm_submit_io_wait(dev, rqd);
+	return nvm_submit_io_wait(dev, rqd, NULL);
 }
 
 static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index f546e6f28b8a..a58d3c84a3f2 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -507,7 +507,7 @@ void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write)
 	pblk->sec_per_write = sec_per_write;
 }
 
-int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
+int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
@@ -518,7 +518,7 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 #endif
 
-	return nvm_submit_io(dev, rqd);
+	return nvm_submit_io(dev, rqd, buf);
 }
 
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
@@ -541,7 +541,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
 	}
 }
 
-int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
+int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void *buf)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	int ret;
@@ -553,7 +553,7 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 #endif
 
-	ret = nvm_submit_io_sync(dev, rqd);
+	ret = nvm_submit_io_sync(dev, rqd, buf);
 
 	if (trace_pblk_chunk_state_enabled() && !ret &&
 	    rqd->opcode == NVM_OP_PWRITE)
@@ -562,65 +562,19 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return ret;
 }
 
-int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+static int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd,
+				   void *buf)
 {
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int ret;
 
 	pblk_down_chunk(pblk, ppa_list[0]);
-	ret = pblk_submit_io_sync(pblk, rqd);
+	ret = pblk_submit_io_sync(pblk, rqd, buf);
 	pblk_up_chunk(pblk, ppa_list[0]);
 
 	return ret;
 }
 
-static void pblk_bio_map_addr_endio(struct bio *bio)
-{
-	bio_put(bio);
-}
-
-struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
-			      unsigned int nr_secs, unsigned int len,
-			      int alloc_type, gfp_t gfp_mask)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	void *kaddr = data;
-	struct page *page;
-	struct bio *bio;
-	int i, ret;
-
-	if (alloc_type == PBLK_KMALLOC_META)
-		return bio_map_kern(dev->q, kaddr, len, gfp_mask);
-
-	bio = bio_kmalloc(gfp_mask, nr_secs);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < nr_secs; i++) {
-		page = vmalloc_to_page(kaddr);
-		if (!page) {
-			pblk_err(pblk, "could not map vmalloc bio\n");
-			bio_put(bio);
-			bio = ERR_PTR(-ENOMEM);
-			goto out;
-		}
-
-		ret = bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, 0);
-		if (ret != PAGE_SIZE) {
-			pblk_err(pblk, "could not add page to bio\n");
-			bio_put(bio);
-			bio = ERR_PTR(-ENOMEM);
-			goto out;
-		}
-
-		kaddr += PAGE_SIZE;
-	}
-
-	bio->bi_end_io = pblk_bio_map_addr_endio;
-out:
-	return bio;
-}
-
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
 		   unsigned long secs_to_flush, bool skip_meta)
 {
@@ -722,9 +676,7 @@ u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
 
 int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct bio *bio;
 	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	u64 paddr = pblk_line_smeta_start(pblk, line);
@@ -736,16 +688,6 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	if (ret)
 		return ret;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		ret = PTR_ERR(bio);
-		goto clear_rqd;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-
-	rqd.bio = bio;
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = lm->smeta_sec;
 	rqd.is_seq = 1;
@@ -754,10 +696,9 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	for (i = 0; i < lm->smeta_sec; i++, paddr++)
 		ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync(pblk, &rqd, line->smeta);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
-		bio_put(bio);
 		goto clear_rqd;
 	}
 
@@ -776,9 +717,7 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 				 u64 paddr)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct bio *bio;
 	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
@@ -791,16 +730,6 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	if (ret)
 		return ret;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		ret = PTR_ERR(bio);
-		goto clear_rqd;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-
-	rqd.bio = bio;
 	rqd.opcode = NVM_OP_PWRITE;
 	rqd.nr_ppas = lm->smeta_sec;
 	rqd.is_seq = 1;
@@ -814,10 +743,9 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 		meta->lba = lba_list[paddr] = addr_empty;
 	}
 
-	ret = pblk_submit_io_sync_sem(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd, line->smeta);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
-		bio_put(bio);
 		goto clear_rqd;
 	}
 
@@ -838,10 +766,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	void *ppa_list_buf, *meta_list;
-	struct bio *bio;
 	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	u64 paddr = line->emeta_ssec;
@@ -867,17 +793,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	rq_len = rq_ppas * geo->csecs;
 
-	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
-					l_mg->emeta_alloc_type, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		ret = PTR_ERR(bio);
-		goto free_rqd_dma;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-
-	rqd.bio = bio;
 	rqd.meta_list = meta_list;
 	rqd.ppa_list = ppa_list_buf;
 	rqd.dma_meta_list = dma_meta_list;
@@ -896,7 +811,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 		while (test_bit(pos, line->blk_bitmap)) {
 			paddr += min;
 			if (pblk_boundary_paddr_checks(pblk, paddr)) {
-				bio_put(bio);
 				ret = -EINTR;
 				goto free_rqd_dma;
 			}
@@ -906,7 +820,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
-			bio_put(bio);
 			ret = -EINTR;
 			goto free_rqd_dma;
 		}
@@ -915,10 +828,9 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 			ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync(pblk, &rqd, emeta_buf);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
-		bio_put(bio);
 		goto free_rqd_dma;
 	}
 
@@ -963,7 +875,7 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync(pblk, &rqd, NULL);
 	rqd.private = pblk;
 	__pblk_end_io_erase(pblk, &rqd);
 
@@ -1792,7 +1704,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
-	err = pblk_submit_io(pblk, rqd);
+	err = pblk_submit_io(pblk, rqd, NULL);
 	if (err) {
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
@@ -1923,7 +1835,6 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	unsigned int lba_list_size = lm->emeta_len[2];
 	struct pblk_w_err_gc *w_err_gc = line->w_err_gc;
 	struct pblk_emeta *emeta = line->emeta;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d98ea392fe33..d572d4559e4e 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -342,7 +342,7 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		bio_put(int_bio);
 		int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
 		goto split_retry;
-	} else if (pblk_submit_io(pblk, rqd)) {
+	} else if (pblk_submit_io(pblk, rqd, NULL)) {
 		/* Submitting IO to drive failed, let's report an error */
 		rqd->error = -ENODEV;
 		pblk_end_io_read(rqd);
@@ -419,7 +419,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct bio *bio;
 	struct nvm_rq rqd;
 	int data_len;
 	int ret = NVM_IO_OK;
@@ -447,25 +446,12 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 		goto out;
 
 	data_len = (gc_rq->secs_to_gc) * geo->csecs;
-	bio = pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, data_len,
-						PBLK_VMALLOC_META, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
-								PTR_ERR(bio));
-		ret = PTR_ERR(bio);
-		goto err_free_dma;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = gc_rq->secs_to_gc;
-	rqd.bio = bio;
 
-	if (pblk_submit_io_sync(pblk, &rqd)) {
+	if (pblk_submit_io_sync(pblk, &rqd, gc_rq->data)) {
 		ret = -EIO;
-		goto err_free_bio;
+		goto err_free_dma;
 	}
 
 	pblk_read_check_rand(pblk, &rqd, gc_rq->lba_list, gc_rq->nr_secs);
@@ -489,8 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 
-err_free_bio:
-	bio_put(bio);
 err_free_dma:
 	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index e6dda04de144..d5e210c3c5b7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -178,12 +178,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	void *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
-	struct bio *bio;
 	struct ppa_addr *ppa_list;
 	void *data;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	u64 w_ptr = line->cur_sec;
-	int left_line_ppas, rq_ppas, rq_len;
+	int left_line_ppas, rq_ppas;
 	int i, j;
 	int ret = 0;
 
@@ -212,28 +211,15 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 		goto fail_complete;
 	}
 
-	rq_len = rq_ppas * geo->csecs;
-
-	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
-						PBLK_VMALLOC_META, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		ret = PTR_ERR(bio);
-		goto fail_complete;
-	}
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
 
 	ret = pblk_alloc_rqd_meta(pblk, rqd);
 	if (ret) {
 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
-		bio_put(bio);
 		goto fail_complete;
 	}
 
-	rqd->bio = bio;
+	rqd->bio = NULL;
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->is_seq = 1;
 	rqd->nr_ppas = rq_ppas;
@@ -275,13 +261,12 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	kref_get(&pad_rq->ref);
 	pblk_down_chunk(pblk, ppa_list[0]);
 
-	ret = pblk_submit_io(pblk, rqd);
+	ret = pblk_submit_io(pblk, rqd, data);
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_chunk(pblk, ppa_list[0]);
 		kref_put(&pad_rq->ref, pblk_recov_complete);
 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
-		bio_put(bio);
 		goto fail_complete;
 	}
 
@@ -375,7 +360,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct ppa_addr *ppa_list;
 	void *meta_list;
 	struct nvm_rq *rqd;
-	struct bio *bio;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list;
@@ -407,15 +391,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	rq_len = rq_ppas * geo->csecs;
 
 retry_rq:
-	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-	bio_get(bio);
-
-	rqd->bio = bio;
+	rqd->bio = NULL;
 	rqd->opcode = NVM_OP_PREAD;
 	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
@@ -445,10 +421,9 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 				addr_to_gen_ppa(pblk, paddr + j, line->id);
 	}
 
-	ret = pblk_submit_io_sync(pblk, rqd);
+	ret = pblk_submit_io_sync(pblk, rqd, data);
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		bio_put(bio);
 		return ret;
 	}
 
@@ -460,24 +435,20 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 		if (padded) {
 			pblk_log_read_err(pblk, rqd);
-			bio_put(bio);
 			return -EINTR;
 		}
 
 		pad_distance = pblk_pad_distance(pblk, line);
 		ret = pblk_recov_pad_line(pblk, line, pad_distance);
 		if (ret) {
-			bio_put(bio);
 			return ret;
 		}
 
 		padded = true;
-		bio_put(bio);
 		goto retry_rq;
 	}
 
 	pblk_get_packed_meta(pblk, rqd);
-	bio_put(bio);
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 4e63f9b5954c..b9a2aeba95ab 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -373,7 +373,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	struct pblk_emeta *emeta = meta_line->emeta;
 	struct ppa_addr *ppa_list;
 	struct pblk_g_ctx *m_ctx;
-	struct bio *bio;
 	struct nvm_rq *rqd;
 	void *data;
 	u64 paddr;
@@ -391,20 +390,9 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	rq_len = rq_ppas * geo->csecs;
 	data = ((void *)emeta->buf) + emeta->mem;
 
-	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
-					l_mg->emeta_alloc_type, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		pblk_err(pblk, "failed to map emeta io");
-		ret = PTR_ERR(bio);
-		goto fail_free_rqd;
-	}
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-	rqd->bio = bio;
-
 	ret = pblk_alloc_w_rq(pblk, rqd, rq_ppas, pblk_end_io_write_meta);
 	if (ret)
-		goto fail_free_bio;
+		goto fail_free_rqd;
 
 	ppa_list = nvm_rq_to_ppa_list(rqd);
 	for (i = 0; i < rqd->nr_ppas; ) {
@@ -423,7 +411,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 
 	pblk_down_chunk(pblk, ppa_list[0]);
 
-	ret = pblk_submit_io(pblk, rqd);
+	ret = pblk_submit_io(pblk, rqd, data);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		goto fail_rollback;
@@ -437,8 +425,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
 	spin_unlock(&l_mg->close_lock);
-fail_free_bio:
-	bio_put(bio);
 fail_free_rqd:
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 	return ret;
@@ -523,7 +509,7 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	meta_line = pblk_should_submit_meta_io(pblk, rqd);
 
 	/* Submit data write for current data line */
-	err = pblk_submit_io(pblk, rqd);
+	err = pblk_submit_io(pblk, rqd, NULL);
 	if (err) {
 		pblk_err(pblk, "data I/O submission failed: %d\n", err);
 		return NVM_IO_ERR;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a67855387f53..d515d3409a74 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -783,14 +783,10 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 					      struct ppa_addr ppa);
 void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
-int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
-int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
-int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf);
+int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void *buf);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
-struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
-			      unsigned int nr_secs, unsigned int len,
-			      int alloc_type, gfp_t gfp_mask);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d6f121452d5d..ec46693f6b64 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -667,11 +667,14 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 	return rq;
 }
 
-static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
+			      void *buf)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct request_queue *q = dev->q;
 	struct nvme_nvm_command *cmd;
 	struct request *rq;
+	int ret;
 
 	cmd = kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
 	if (!cmd)
@@ -679,8 +682,15 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	rq = nvme_nvm_alloc_request(q, rqd, cmd);
 	if (IS_ERR(rq)) {
-		kfree(cmd);
-		return PTR_ERR(rq);
+		ret = PTR_ERR(rq);
+		goto err_free_cmd;
+	}
+
+	if (buf) {
+		ret = blk_rq_map_kern(q, rq, buf, geo->csecs * rqd->nr_ppas,
+				GFP_KERNEL);
+		if (ret)
+			goto err_free_cmd;
 	}
 
 	rq->end_io_data = rqd;
@@ -688,6 +698,10 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
 
 	return 0;
+
+err_free_cmd:
+	kfree(cmd);
+	return ret;
 }
 
 static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8891647b24b1..ee8ec2e68055 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -88,7 +88,7 @@ typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
 typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
 							struct nvm_chk_meta *);
-typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
+typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *, void *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
@@ -680,8 +680,8 @@ extern int nvm_get_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr,
 			      int, struct nvm_chk_meta *);
 extern int nvm_set_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
-extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
-extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *);
+extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *, void *);
+extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *, void *);
 extern void nvm_end_io(struct nvm_rq *);
 
 #else /* CONFIG_NVM */
-- 
2.7.4

