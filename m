Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2E13B9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEDSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:39:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfEDSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id y10so1330997lji.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYwHQ2X3rT02Ej641hQcq7tjr/KklV4bmMZeSVyac78=;
        b=SOriDqNAH5VLFvxx7N4JXXfl2T6EpjkE8EMdIhYIjUxuwBYDL3msMMSGUmc+JlAFIT
         KQr8VuO/sHzJKKEulF2xVr3GKqaY7aeWTLN89Wl9tI8jSxu9HCmU3IXx1UwyS+k4n1Zi
         /vTkgBgnqXt3T4hXr87iMA/ajBLMqvnI9/rpy8xqeWJdSNaRa9qKcaVScb5WGn7rpsyY
         0ND/tAyfL/pygNP8Q4Cqiyo6meGN94cW/oEivd92n3UoICBJmMRHIfQhlpVFfNXGHjYl
         RGes7FxV74wH6/VbKjrqlfnz7XF7WYJfCbJpYqHJyZcnxGuysmIO8Lrwu+p25JO5mB7b
         HbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYwHQ2X3rT02Ej641hQcq7tjr/KklV4bmMZeSVyac78=;
        b=oSrRc9XCGJzjFWTyEX6TS5+BmmYzW60ecHRvC2CrumHBdZEjI+PpoTVEGM51y5gbUG
         w3CAofkbuK3Alq1Pj/gkRnSOL/Gs4n8Qe6LizgCfJikoeTYGIsbgFekeM/LBgggIjHGf
         Wq8Cjl0OsPCawGE+ynQGdvSCwhOVlD41AXMhGaS3fI6bSbzIwvuJRKaxkQZcFjCRubZb
         yrnHSlId2SAr2rhYP85Akr7PSIz/D7R00MU3EXXs1Nmedc/qVtrgw5DdxWZ5T6jA2783
         DdYCyD+5YP5VRs+SHHLToR3A7AlYSdhb7aB6e3gQ03D6RpQKgRb8I2ymRVRBAAN0Lhp5
         SfWw==
X-Gm-Message-State: APjAAAUfOf0NJmnzuDemjerd6KIDaMBf8YlJVrriMFVPDW+GscPLajZ2
        dVhI02RS8LWElMlOnkt59wqzQL2aRwcJfg==
X-Google-Smtp-Source: APXvYqz5KXUCenSI2WKzsyrKVHs7PN/wfKmUEmDTgzrGmggfQukGbq81CS/UUPaupTq/8bXnHCpWjg==
X-Received: by 2002:a2e:9350:: with SMTP id m16mr8666038ljh.38.1556995131157;
        Sat, 04 May 2019 11:38:51 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:50 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 25/26] lightnvm: pblk: simplify partial read path
Date:   Sat,  4 May 2019 20:38:10 +0200
Message-Id: <20190504183811.18725-26-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

This patch changes the approach to handling partial read path.

In old approach merging of data from round buffer and drive was fully
made by drive. This had some disadvantages - code was complex and
relies on bio internals, so it was hard to maintain and was strongly
dependent on bio changes.

In new approach most of the handling is done mostly by block layer
functions such as bio_split(), bio_chain() and generic_make request()
and generally is less complex and easier to maintain. Below some more
details of the new approach.

When read bio arrives, it is cloned for pblk internal purposes. All
the L2P mapping, which includes copying data from round buffer to bio
and thus bio_advance() calls is done on the cloned bio, so the original
bio is untouched. If we found that we have partial read case, we
still have original bio untouched, so we can split it and continue to
process only first part of it in current context, when the rest will be
called as separate bio request which is passed to generic_make_request()
for further processing.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c |  13 +-
 drivers/lightnvm/pblk-rb.c   |  11 +-
 drivers/lightnvm/pblk-read.c | 339 +++++++++--------------------------
 drivers/lightnvm/pblk.h      |  18 +-
 4 files changed, 100 insertions(+), 281 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 73be3a0311ff..07270ba1e95f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -2147,8 +2147,8 @@ void pblk_update_map_dev(struct pblk *pblk, sector_t lba,
 	spin_unlock(&pblk->trans_lock);
 }
 
-void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
-			 sector_t blba, int nr_secs)
+int pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
+			 sector_t blba, int nr_secs, bool *from_cache)
 {
 	int i;
 
@@ -2162,10 +2162,19 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
 			struct pblk_line *line = pblk_ppa_to_line(pblk, ppa);
 
+			if (i > 0 && *from_cache)
+				break;
+			*from_cache = false;
+
 			kref_get(&line->ref);
+		} else {
+			if (i > 0 && !*from_cache)
+				break;
+			*from_cache = true;
 		}
 	}
 	spin_unlock(&pblk->trans_lock);
+	return i;
 }
 
 void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 35550148b5e8..5abb1705b039 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -642,7 +642,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
  * be directed to disk.
  */
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			struct ppa_addr ppa, int bio_iter, bool advanced_bio)
+			struct ppa_addr ppa)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entry;
@@ -673,15 +673,6 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
 		ret = 0;
 		goto out;
 	}
-
-	/* Only advance the bio if it hasn't been advanced already. If advanced,
-	 * this bio is at least a partial bio (i.e., it has partially been
-	 * filled with data from the cache). If part of the data resides on the
-	 * media, we will read later on
-	 */
-	if (unlikely(!advanced_bio))
-		bio_advance(bio, bio_iter * PBLK_EXPOSED_PAGE_SIZE);
-
 	data = bio_data(bio);
 	memcpy(data, entry->data, rb->seg_size);
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f5f155d540e2..d98ea392fe33 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -26,8 +26,7 @@
  * issued.
  */
 static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
-				sector_t lba, struct ppa_addr ppa,
-				int bio_iter, bool advanced_bio)
+				sector_t lba, struct ppa_addr ppa)
 {
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	/* Callers must ensure that the ppa points to a cache address */
@@ -35,73 +34,75 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 	BUG_ON(!pblk_addr_in_cache(ppa));
 #endif
 
-	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa,
-						bio_iter, advanced_bio);
+	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa);
 }
 
-static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
+static int pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 struct bio *bio, sector_t blba,
-				 unsigned long *read_bitmap)
+				 bool *from_cache)
 {
 	void *meta_list = rqd->meta_list;
-	struct ppa_addr ppas[NVM_MAX_VLBA];
-	int nr_secs = rqd->nr_ppas;
-	bool advanced_bio = false;
-	int i, j = 0;
+	int nr_secs, i;
 
-	pblk_lookup_l2p_seq(pblk, ppas, blba, nr_secs);
+retry:
+	nr_secs = pblk_lookup_l2p_seq(pblk, rqd->ppa_list, blba, rqd->nr_ppas,
+					from_cache);
+
+	if (!*from_cache)
+		goto end;
 
 	for (i = 0; i < nr_secs; i++) {
-		struct ppa_addr p = ppas[i];
 		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
 		sector_t lba = blba + i;
 
-retry:
-		if (pblk_ppa_empty(p)) {
+		if (pblk_ppa_empty(rqd->ppa_list[i])) {
 			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
-			WARN_ON(test_and_set_bit(i, read_bitmap));
 			meta->lba = addr_empty;
-
-			if (unlikely(!advanced_bio)) {
-				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
-				advanced_bio = true;
+		} else if (pblk_addr_in_cache(rqd->ppa_list[i])) {
+			/*
+			 * Try to read from write buffer. The address is later
+			 * checked on the write buffer to prevent retrieving
+			 * overwritten data.
+			 */
+			if (!pblk_read_from_cache(pblk, bio, lba,
+							rqd->ppa_list[i])) {
+				if (i == 0) {
+					/*
+					 * We didn't call with bio_advance()
+					 * yet, so we can just retry.
+					 */
+					goto retry;
+				} else {
+					/*
+					 * We already call bio_advance()
+					 * so we cannot retry and we need
+					 * to quit that function in order
+					 * to allow caller to handle the bio
+					 * splitting in the current sector
+					 * position.
+					 */
+					nr_secs = i;
+					goto end;
+				}
 			}
-
-			goto next;
-		}
-
-		/* Try to read from write buffer. The address is later checked
-		 * on the write buffer to prevent retrieving overwritten data.
-		 */
-		if (pblk_addr_in_cache(p)) {
-			if (!pblk_read_from_cache(pblk, bio, lba, p, i,
-								advanced_bio)) {
-				pblk_lookup_l2p_seq(pblk, &p, lba, 1);
-				goto retry;
-			}
-			WARN_ON(test_and_set_bit(i, read_bitmap));
 			meta->lba = cpu_to_le64(lba);
-			advanced_bio = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
 #endif
-		} else {
-			/* Read from media non-cached sectors */
-			rqd->ppa_list[j++] = p;
 		}
-
-next:
-		if (advanced_bio)
-			bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
+		bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
 	}
 
+end:
 	if (pblk_io_aligned(pblk, nr_secs))
 		rqd->is_seq = 1;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(nr_secs, &pblk->inflight_reads);
 #endif
+
+	return nr_secs;
 }
 
 
@@ -197,9 +198,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		pblk_log_read_err(pblk, rqd);
 
 	pblk_read_check_seq(pblk, rqd, r_ctx->lba);
-
-	if (int_bio)
-		bio_put(int_bio);
+	bio_put(int_bio);
 
 	if (put_line)
 		pblk_rq_to_line_put(pblk, rqd);
@@ -223,183 +222,13 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
-static void pblk_end_partial_read(struct nvm_rq *rqd)
-{
-	struct pblk *pblk = rqd->private;
-	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
-	struct pblk_pr_ctx *pr_ctx = r_ctx->private;
-	struct pblk_sec_meta *meta;
-	struct bio *new_bio = rqd->bio;
-	struct bio *bio = pr_ctx->orig_bio;
-	void *meta_list = rqd->meta_list;
-	unsigned long *read_bitmap = pr_ctx->bitmap;
-	struct bvec_iter orig_iter = BVEC_ITER_ALL_INIT;
-	struct bvec_iter new_iter = BVEC_ITER_ALL_INIT;
-	int nr_secs = pr_ctx->orig_nr_secs;
-	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-	void *src_p, *dst_p;
-	int bit, i;
-
-	if (unlikely(nr_holes == 1)) {
-		struct ppa_addr ppa;
-
-		ppa = rqd->ppa_addr;
-		rqd->ppa_list = pr_ctx->ppa_ptr;
-		rqd->dma_ppa_list = pr_ctx->dma_ppa_list;
-		rqd->ppa_list[0] = ppa;
-	}
-
-	for (i = 0; i < nr_secs; i++) {
-		meta = pblk_get_meta(pblk, meta_list, i);
-		pr_ctx->lba_list_media[i] = le64_to_cpu(meta->lba);
-		meta->lba = cpu_to_le64(pr_ctx->lba_list_mem[i]);
-	}
-
-	/* Fill the holes in the original bio */
-	i = 0;
-	for (bit = 0; bit < nr_secs; bit++) {
-		if (!test_bit(bit, read_bitmap)) {
-			struct bio_vec dst_bv, src_bv;
-			struct pblk_line *line;
-
-			line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
-			kref_put(&line->ref, pblk_line_put);
-
-			meta = pblk_get_meta(pblk, meta_list, bit);
-			meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
-
-			dst_bv = bio_iter_iovec(bio, orig_iter);
-			src_bv = bio_iter_iovec(new_bio, new_iter);
-
-			src_p = kmap_atomic(src_bv.bv_page);
-			dst_p = kmap_atomic(dst_bv.bv_page);
-
-			memcpy(dst_p + dst_bv.bv_offset,
-				src_p + src_bv.bv_offset,
-				PBLK_EXPOSED_PAGE_SIZE);
-
-			kunmap_atomic(src_p);
-			kunmap_atomic(dst_p);
-
-			flush_dcache_page(dst_bv.bv_page);
-			mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
-
-			bio_advance_iter(new_bio, &new_iter,
-					PBLK_EXPOSED_PAGE_SIZE);
-			i++;
-		}
-		bio_advance_iter(bio, &orig_iter, PBLK_EXPOSED_PAGE_SIZE);
-	}
-
-	bio_put(new_bio);
-	kfree(pr_ctx);
-
-	/* restore original request */
-	rqd->bio = NULL;
-	rqd->nr_ppas = nr_secs;
-
-	pblk_end_user_read(bio, rqd->error);
-	__pblk_end_io_read(pblk, rqd, false);
-}
-
-static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
-			    unsigned int bio_init_idx,
-			    unsigned long *read_bitmap,
-			    int nr_holes)
-{
-	void *meta_list = rqd->meta_list;
-	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
-	struct pblk_pr_ctx *pr_ctx;
-	struct bio *new_bio, *bio = r_ctx->private;
-	int nr_secs = rqd->nr_ppas;
-	int i;
-
-	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
-
-	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
-		goto fail_bio_put;
-
-	if (nr_holes != new_bio->bi_vcnt) {
-		WARN_ONCE(1, "pblk: malformed bio\n");
-		goto fail_free_pages;
-	}
-
-	pr_ctx = kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
-	if (!pr_ctx)
-		goto fail_free_pages;
-
-	for (i = 0; i < nr_secs; i++) {
-		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
-
-		pr_ctx->lba_list_mem[i] = le64_to_cpu(meta->lba);
-	}
-
-	new_bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
-
-	rqd->bio = new_bio;
-	rqd->nr_ppas = nr_holes;
-
-	pr_ctx->orig_bio = bio;
-	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
-	pr_ctx->bio_init_idx = bio_init_idx;
-	pr_ctx->orig_nr_secs = nr_secs;
-	r_ctx->private = pr_ctx;
-
-	if (unlikely(nr_holes == 1)) {
-		pr_ctx->ppa_ptr = rqd->ppa_list;
-		pr_ctx->dma_ppa_list = rqd->dma_ppa_list;
-		rqd->ppa_addr = rqd->ppa_list[0];
-	}
-	return 0;
-
-fail_free_pages:
-	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
-fail_bio_put:
-	bio_put(new_bio);
-
-	return -ENOMEM;
-}
-
-static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
-				 unsigned int bio_init_idx,
-				 unsigned long *read_bitmap, int nr_secs)
-{
-	int nr_holes;
-	int ret;
-
-	nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-
-	if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
-				    nr_holes))
-		return NVM_IO_ERR;
-
-	rqd->end_io = pblk_end_partial_read;
-
-	ret = pblk_submit_io(pblk, rqd);
-	if (ret) {
-		bio_put(rqd->bio);
-		pblk_err(pblk, "partial read IO submission failed\n");
-		goto err;
-	}
-
-	return NVM_IO_OK;
-
-err:
-	pblk_err(pblk, "failed to perform partial read\n");
-
-	/* Free allocated pages in new bio */
-	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
-	return NVM_IO_ERR;
-}
-
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
-			 sector_t lba, unsigned long *read_bitmap)
+			 sector_t lba, bool *from_cache)
 {
 	struct pblk_sec_meta *meta = pblk_get_meta(pblk, rqd->meta_list, 0);
 	struct ppa_addr ppa;
 
-	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
+	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1, from_cache);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_inc(&pblk->inflight_reads);
@@ -409,7 +238,6 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 	if (pblk_ppa_empty(ppa)) {
 		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
-		WARN_ON(test_and_set_bit(0, read_bitmap));
 		meta->lba = addr_empty;
 		return;
 	}
@@ -418,12 +246,11 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 	 * write buffer to prevent retrieving overwritten data.
 	 */
 	if (pblk_addr_in_cache(ppa)) {
-		if (!pblk_read_from_cache(pblk, bio, lba, ppa, 0, 1)) {
-			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
+		if (!pblk_read_from_cache(pblk, bio, lba, ppa)) {
+			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1, from_cache);
 			goto retry;
 		}
 
-		WARN_ON(test_and_set_bit(0, read_bitmap));
 		meta->lba = cpu_to_le64(lba);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -440,17 +267,14 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	struct request_queue *q = dev->q;
 	sector_t blba = pblk_get_lba(bio);
 	unsigned int nr_secs = pblk_get_secs(bio);
+	bool from_cache;
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
-	struct bio *int_bio;
-	unsigned int bio_init_idx;
-	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
+	struct bio *int_bio, *split_bio;
 
 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
 			      &pblk->disk->part0);
 
-	bitmap_zero(read_bitmap, nr_secs);
-
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
 
 	rqd->opcode = NVM_OP_PREAD;
@@ -462,11 +286,6 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	r_ctx->start_time = jiffies;
 	r_ctx->lba = blba;
 
-	/* Save the index for this bio's start. This is needed in case
-	 * we need to fill a partial read.
-	 */
-	bio_init_idx = pblk_get_bi_idx(bio);
-
 	if (pblk_alloc_rqd_meta(pblk, rqd)) {
 		bio_io_error(bio);
 		pblk_free_rqd(pblk, rqd, PBLK_READ);
@@ -475,46 +294,58 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 
 	/* Clone read bio to deal internally with:
 	 * -read errors when reading from drive
-	 * -bio_advance() calls during l2p lookup and cache reads
+	 * -bio_advance() calls during cache reads
 	 */
 	int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
 
 	if (nr_secs > 1)
-		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
+		nr_secs = pblk_read_ppalist_rq(pblk, rqd, int_bio, blba,
+						&from_cache);
 	else
-		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
+		pblk_read_rq(pblk, rqd, int_bio, blba, &from_cache);
 
+split_retry:
 	r_ctx->private = bio; /* original bio */
 	rqd->bio = int_bio; /* internal bio */
 
-	if (bitmap_full(read_bitmap, nr_secs)) {
+	if (from_cache && nr_secs == rqd->nr_ppas) {
+		/* All data was read from cache, we can complete the IO. */
 		pblk_end_user_read(bio, 0);
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
-		return;
-	}
-
-	if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
+	} else if (nr_secs != rqd->nr_ppas) {
 		/* The read bio request could be partially filled by the write
 		 * buffer, but there are some holes that need to be read from
-		 * the drive.
+		 * the drive. In order to handle this, we will use block layer
+		 * mechanism to split this request in to smaller ones and make
+		 * a chain of it.
+		 */
+		split_bio = bio_split(bio, nr_secs * NR_PHY_IN_LOG, GFP_KERNEL,
+					&pblk_bio_set);
+		bio_chain(split_bio, bio);
+		generic_make_request(bio);
+
+		/* New bio contains first N sectors of the previous one, so
+		 * we can continue to use existing rqd, but we need to shrink
+		 * the number of PPAs in it. New bio is also guaranteed that
+		 * it contains only either data from cache or from drive, newer
+		 * mix of them.
+		 */
+		bio = split_bio;
+		rqd->nr_ppas = nr_secs;
+		if (rqd->nr_ppas == 1)
+			rqd->ppa_addr = rqd->ppa_list[0];
+
+		/* Recreate int_bio - existing might have some needed internal
+		 * fields modified already.
 		 */
 		bio_put(int_bio);
-		rqd->bio = NULL;
-		if (pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
-					    nr_secs)) {
-			pblk_err(pblk, "read IO submission failed\n");
-			bio_io_error(bio);
-			__pblk_end_io_read(pblk, rqd, false);
-		}
-		return;
-	}
-
-	/* All sectors are to be read from the device */
-	if (pblk_submit_io(pblk, rqd)) {
-		pblk_err(pblk, "read IO submission failed\n");
-		bio_io_error(bio);
-		__pblk_end_io_read(pblk, rqd, false);
+		int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
+		goto split_retry;
+	} else if (pblk_submit_io(pblk, rqd)) {
+		/* Submitting IO to drive failed, let's report an error */
+		rqd->error = -ENODEV;
+		pblk_end_io_read(rqd);
 	}
 }
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 17ced12db7dd..a67855387f53 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -121,18 +121,6 @@ struct pblk_g_ctx {
 	u64 lba;
 };
 
-/* partial read context */
-struct pblk_pr_ctx {
-	struct bio *orig_bio;
-	DECLARE_BITMAP(bitmap, NVM_MAX_VLBA);
-	unsigned int orig_nr_secs;
-	unsigned int bio_init_idx;
-	void *ppa_ptr;
-	dma_addr_t dma_ppa_list;
-	u64 lba_list_mem[NVM_MAX_VLBA];
-	u64 lba_list_media[NVM_MAX_VLBA];
-};
-
 /* Pad context */
 struct pblk_pad_rq {
 	struct pblk *pblk;
@@ -759,7 +747,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 				 unsigned int pos, unsigned int nr_entries,
 				 unsigned int count);
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			struct ppa_addr ppa, int bio_iter, bool advanced_bio);
+			struct ppa_addr ppa);
 unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
@@ -859,8 +847,8 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa,
 		       struct pblk_line *gc_line, u64 paddr);
 void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 			  u64 *lba_list, int nr_secs);
-void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
-			 sector_t blba, int nr_secs);
+int pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
+			 sector_t blba, int nr_secs, bool *from_cache);
 void *pblk_get_meta_for_writes(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
 
-- 
2.19.1

