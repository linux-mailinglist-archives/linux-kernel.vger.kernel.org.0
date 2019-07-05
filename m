Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7A60795
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGEOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 10:14:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:10831 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGEOOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:14:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="166547303"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2019 07:14:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 3/5] intel_th: msu: Get rid of the window size limit
Date:   Fri,  5 Jul 2019 17:14:23 +0300
Message-Id: <20190705141425.19894-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705141425.19894-1-alexander.shishkin@linux.intel.com>
References: <20190705141425.19894-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the window size is limited to the maximum number of sg entries
in one table. This is because the code addresses individual blocks within
the window by their numeric index. In reality, though, the blocks most
often are iterated through sequentially. By rewriting the logic to use sg
pointers instead of block indices we loose the necessity to dereference
them directly and gain the ability to use multiple chained tables if
necessary.

Get rid of the limitation by replacing index-based block accesses with
sequential block accesses.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 139 +++++++++++++++----------------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 08413e6a075f..a6c0eb09c515 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -95,8 +95,8 @@ struct msc_iter {
 	struct msc_window	*start_win;
 	struct msc_window	*win;
 	unsigned long		offset;
-	int			start_block;
-	int			block;
+	struct scatterlist	*start_block;
+	struct scatterlist	*block;
 	unsigned int		block_off;
 	unsigned int		wrap_count;
 	unsigned int		eof;
@@ -269,28 +269,25 @@ static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
 	return false;
 }
 
-static inline struct msc_block_desc *
-msc_win_block(struct msc_window *win, unsigned int block)
+static inline struct scatterlist *msc_win_base_sg(struct msc_window *win)
 {
-	return sg_virt(&win->sgt->sgl[block]);
+	return win->sgt->sgl;
 }
 
-static inline size_t
-msc_win_actual_bsz(struct msc_window *win, unsigned int block)
+static inline struct msc_block_desc *msc_win_base(struct msc_window *win)
 {
-	return win->sgt->sgl[block].length;
+	return sg_virt(msc_win_base_sg(win));
 }
 
-static inline dma_addr_t
-msc_win_baddr(struct msc_window *win, unsigned int block)
+static inline dma_addr_t msc_win_base_dma(struct msc_window *win)
 {
-	return sg_dma_address(&win->sgt->sgl[block]);
+	return sg_dma_address(msc_win_base_sg(win));
 }
 
 static inline unsigned long
-msc_win_bpfn(struct msc_window *win, unsigned int block)
+msc_win_base_pfn(struct msc_window *win)
 {
-	return msc_win_baddr(win, block) >> PAGE_SHIFT;
+	return PFN_DOWN(msc_win_base_dma(win));
 }
 
 /**
@@ -320,11 +317,12 @@ static struct msc_window *msc_next_window(struct msc_window *win)
 
 static size_t msc_win_total_sz(struct msc_window *win)
 {
+	struct scatterlist *sg;
 	unsigned int blk;
 	size_t size = 0;
 
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		struct msc_block_desc *bdesc = msc_win_block(win, blk);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_wrapped(bdesc))
 			return win->nr_blocks << PAGE_SHIFT;
@@ -365,7 +363,7 @@ msc_find_window(struct msc *msc, struct sg_table *sgt, bool nonempty)
 			found++;
 
 		/* skip the empty ones */
-		if (nonempty && msc_block_is_empty(msc_win_block(win, 0)))
+		if (nonempty && msc_block_is_empty(msc_win_base(win)))
 			continue;
 
 		if (found)
@@ -399,44 +397,38 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 }
 
 /**
- * msc_win_oldest_block() - locate the oldest block in a given window
+ * msc_win_oldest_sg() - locate the oldest block in a given window
  * @win:	window to look at
  *
  * Return:	index of the block with the oldest data
  */
-static unsigned int msc_win_oldest_block(struct msc_window *win)
+static struct scatterlist *msc_win_oldest_sg(struct msc_window *win)
 {
 	unsigned int blk;
-	struct msc_block_desc *bdesc = msc_win_block(win, 0);
+	struct scatterlist *sg;
+	struct msc_block_desc *bdesc = msc_win_base(win);
 
 	/* without wrapping, first block is the oldest */
 	if (!msc_block_wrapped(bdesc))
-		return 0;
+		return msc_win_base_sg(win);
 
 	/*
 	 * with wrapping, last written block contains both the newest and the
 	 * oldest data for this window.
 	 */
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		bdesc = msc_win_block(win, blk);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_last_written(bdesc))
-			return blk;
+			return sg;
 	}
 
-	return 0;
+	return msc_win_base_sg(win);
 }
 
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
 {
-	return msc_win_block(iter->win, iter->block);
-}
-
-static void msc_iter_init(struct msc_iter *iter)
-{
-	memset(iter, 0, sizeof(*iter));
-	iter->start_block = -1;
-	iter->block = -1;
+	return sg_virt(iter->block);
 }
 
 static struct msc_iter *msc_iter_install(struct msc *msc)
@@ -461,7 +453,6 @@ static struct msc_iter *msc_iter_install(struct msc *msc)
 		goto unlock;
 	}
 
-	msc_iter_init(iter);
 	iter->msc = msc;
 
 	list_add_tail(&iter->entry, &msc->iter_list);
@@ -482,10 +473,10 @@ static void msc_iter_remove(struct msc_iter *iter, struct msc *msc)
 
 static void msc_iter_block_start(struct msc_iter *iter)
 {
-	if (iter->start_block != -1)
+	if (iter->start_block)
 		return;
 
-	iter->start_block = msc_win_oldest_block(iter->win);
+	iter->start_block = msc_win_oldest_sg(iter->win);
 	iter->block = iter->start_block;
 	iter->wrap_count = 0;
 
@@ -509,7 +500,7 @@ static int msc_iter_win_start(struct msc_iter *iter, struct msc *msc)
 		return -EINVAL;
 
 	iter->win = iter->start_win;
-	iter->start_block = -1;
+	iter->start_block = NULL;
 
 	msc_iter_block_start(iter);
 
@@ -519,7 +510,7 @@ static int msc_iter_win_start(struct msc_iter *iter, struct msc *msc)
 static int msc_iter_win_advance(struct msc_iter *iter)
 {
 	iter->win = msc_next_window(iter->win);
-	iter->start_block = -1;
+	iter->start_block = NULL;
 
 	if (iter->win == iter->start_win) {
 		iter->eof++;
@@ -549,8 +540,10 @@ static int msc_iter_block_advance(struct msc_iter *iter)
 		return msc_iter_win_advance(iter);
 
 	/* block advance */
-	if (++iter->block == iter->win->nr_segs)
-		iter->block = 0;
+	if (sg_is_last(iter->block))
+		iter->block = msc_win_base_sg(iter->win);
+	else
+		iter->block = sg_next(iter->block);
 
 	/* no wrapping, sanity check in case there is no last written block */
 	if (!iter->wrap_count && iter->block == iter->start_block)
@@ -655,14 +648,15 @@ msc_buffer_iterate(struct msc_iter *iter, size_t size, void *data,
 static void msc_buffer_clear_hw_header(struct msc *msc)
 {
 	struct msc_window *win;
+	struct scatterlist *sg;
 
 	list_for_each_entry(win, &msc->win_list, entry) {
 		unsigned int blk;
 		size_t hw_sz = sizeof(struct msc_block_desc) -
 			offsetof(struct msc_block_desc, hw_tag);
 
-		for (blk = 0; blk < win->nr_segs; blk++) {
-			struct msc_block_desc *bdesc = msc_win_block(win, blk);
+		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+			struct msc_block_desc *bdesc = sg_virt(sg);
 
 			memset(&bdesc->hw_tag, 0, hw_sz);
 		}
@@ -1005,10 +999,9 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 	return nr_segs;
 
 err_nomem:
-	for (i--; i >= 0; i--)
+	for_each_sg(win->sgt->sgl, sg_ptr, i, ret)
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
-				  msc_win_block(win, i),
-				  msc_win_baddr(win, i));
+				  sg_virt(sg_ptr), sg_dma_address(sg_ptr));
 
 	sg_free_table(win->sgt);
 
@@ -1018,20 +1011,26 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 #ifdef CONFIG_X86
 static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs)
 {
+	struct scatterlist *sg_ptr;
 	int i;
 
-	for (i = 0; i < nr_segs; i++)
+	for_each_sg(win->sgt->sgl, sg_ptr, nr_segs, i) {
 		/* Set the page as uncached */
-		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
+		set_memory_uc((unsigned long)sg_virt(sg_ptr),
+			      PFN_DOWN(sg_ptr->length));
+	}
 }
 
 static void msc_buffer_set_wb(struct msc_window *win)
 {
+	struct scatterlist *sg_ptr;
 	int i;
 
-	for (i = 0; i < win->nr_segs; i++)
+	for_each_sg(win->sgt->sgl, sg_ptr, win->nr_segs, i) {
 		/* Reset the page to write-back */
-		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
+		set_memory_wb((unsigned long)sg_virt(sg_ptr),
+			      PFN_DOWN(sg_ptr->length));
+	}
 }
 #else /* !X86 */
 static inline void
@@ -1057,13 +1056,6 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	if (!nr_blocks)
 		return 0;
 
-	/*
-	 * This limitation hold as long as we need random access to the
-	 * block. When that changes, this can go away.
-	 */
-	if (nr_blocks > SG_MAX_SINGLE_ALLOC)
-		return -EINVAL;
-
 	win = kzalloc(sizeof(*win), GFP_KERNEL);
 	if (!win)
 		return -ENOMEM;
@@ -1096,8 +1088,8 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	win->nr_blocks = nr_blocks;
 
 	if (list_empty(&msc->win_list)) {
-		msc->base = msc_win_block(win, 0);
-		msc->base_addr = msc_win_baddr(win, 0);
+		msc->base = msc_win_base(win);
+		msc->base_addr = msc_win_base_dma(win);
 		msc->cur_win = win;
 	}
 
@@ -1114,14 +1106,15 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 
 static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
+	struct scatterlist *sg;
 	int i;
 
-	for (i = 0; i < win->nr_segs; i++) {
-		struct page *page = sg_page(&win->sgt->sgl[i]);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
+		struct page *page = sg_page(sg);
 
 		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
-				  msc_win_block(win, i), msc_win_baddr(win, i));
+				  sg_virt(sg), sg_dma_address(sg));
 	}
 	sg_free_table(win->sgt);
 }
@@ -1167,6 +1160,7 @@ static void msc_buffer_relink(struct msc *msc)
 
 	/* call with msc::mutex locked */
 	list_for_each_entry(win, &msc->win_list, entry) {
+		struct scatterlist *sg;
 		unsigned int blk;
 		u32 sw_tag = 0;
 
@@ -1182,12 +1176,12 @@ static void msc_buffer_relink(struct msc *msc)
 			next_win = list_next_entry(win, entry);
 		}
 
-		for (blk = 0; blk < win->nr_segs; blk++) {
-			struct msc_block_desc *bdesc = msc_win_block(win, blk);
+		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+			struct msc_block_desc *bdesc = sg_virt(sg);
 
 			memset(bdesc, 0, sizeof(*bdesc));
 
-			bdesc->next_win = msc_win_bpfn(next_win, 0);
+			bdesc->next_win = msc_win_base_pfn(next_win);
 
 			/*
 			 * Similarly to last window, last block should point
@@ -1195,13 +1189,15 @@ static void msc_buffer_relink(struct msc *msc)
 			 */
 			if (blk == win->nr_segs - 1) {
 				sw_tag |= MSC_SW_TAG_LASTBLK;
-				bdesc->next_blk = msc_win_bpfn(win, 0);
+				bdesc->next_blk = msc_win_base_pfn(win);
 			} else {
-				bdesc->next_blk = msc_win_bpfn(win, blk + 1);
+				dma_addr_t addr = sg_dma_address(sg_next(sg));
+
+				bdesc->next_blk = PFN_DOWN(addr);
 			}
 
 			bdesc->sw_tag = sw_tag;
-			bdesc->block_sz = msc_win_actual_bsz(win, blk) / 64;
+			bdesc->block_sz = sg->length / 64;
 		}
 	}
 
@@ -1360,6 +1356,7 @@ static int msc_buffer_free_unless_used(struct msc *msc)
 static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 {
 	struct msc_window *win;
+	struct scatterlist *sg;
 	unsigned int blk;
 
 	if (msc->mode == MSC_MODE_SINGLE)
@@ -1374,9 +1371,9 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 found:
 	pgoff -= win->pgoff;
 
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		struct page *page = sg_page(&win->sgt->sgl[blk]);
-		size_t pgsz = PFN_DOWN(msc_win_actual_bsz(win, blk));
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct page *page = sg_page(sg);
+		size_t pgsz = PFN_DOWN(sg->length);
 
 		if (pgoff < pgsz)
 			return page + pgoff;
@@ -1680,8 +1677,8 @@ static void msc_win_switch(struct msc *msc)
 	else
 		msc->cur_win = list_next_entry(msc->cur_win, entry);
 
-	msc->base = msc_win_block(msc->cur_win, 0);
-	msc->base_addr = msc_win_baddr(msc->cur_win, 0);
+	msc->base = msc_win_base(msc->cur_win);
+	msc->base_addr = msc_win_base_dma(msc->cur_win);
 
 	intel_th_trace_switch(msc->thdev);
 }
-- 
2.20.1

