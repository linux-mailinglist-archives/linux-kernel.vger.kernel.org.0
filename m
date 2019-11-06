Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59754F213E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfKFV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 16:58:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34900 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfKFV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:58:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id r22so79454qtt.2;
        Wed, 06 Nov 2019 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M0ZJUUbPmqjYlKgGOECjrMYkLXgYqIQ7ceZ3CEBiA7A=;
        b=Xo2L6H2wxXhcRZTksxqGuxMdZXEsmYpb6HJTAX33hcMLWm0xMeoRZVlXVmNbEm9J8S
         SlNNxRn9+Yx85U09NszzJ/+vW7SOJN1Duo/HvDFEE+W4pIMlL1QY5Wjm0MXigoshXy85
         77+5TDv7gwCPqszVO2vYdUd0pwKkqvH2f8EAPKmCGYLPoS7SWSe7aVWFiGJMYpjWTwBN
         V37SnFa6vtTToYfIbCnl2YP/Q1jLov6fPf2Py06Vl/3+xnvcaBwzGxulXHCrcrZpSk8O
         Qf3aVxEvdnBZhFZAuNJSpiZWDPSeqceL71xt7YnldgtOGXvvymBVhPQN24W2kpNpScPV
         MuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=M0ZJUUbPmqjYlKgGOECjrMYkLXgYqIQ7ceZ3CEBiA7A=;
        b=JMRAn/erijW3P0j/X/MuL76CRQQxitZ3f1X9aOlqJgq4Rng+M3+g+w+0IwCrgdzXmC
         qtUgNdD/lpBCG9t0aT5NXw1SpolBHZfyCrqOHef18LcNiCks51ksPLjfozKYrFLTYLRC
         FBiyLlyzQkb83KxE8LFuYa4RzZK+9ROWiWgiwxUZ6PHmaVGOvLZtb+tbQ5ayfWwiCSJ+
         73xBg4S6Hvj9xf52mIx+iAk0ICjqpPii08BcrSYGE0xGdLgdh9LSfYe9OjJ7fOvj1gmD
         guMsWp00CGxlluHn1HbxXTuZyWtiyl140faLl92Lm1KUmUJxHVttyhZEYSWcMkgUuigL
         +oKA==
X-Gm-Message-State: APjAAAX/XNnO8UjDIJFqmh3fv388u+Hgyyd99uZKQlywTmiPcJP8QCMp
        f9clqrWA4EeNVGxc5A24JjQ=
X-Google-Smtp-Source: APXvYqwTHDQu8bjSy6vgGS4EI1yhdM7cOe1LYJaCZm0jDKYJfjr04Txcpt4ej9rYVJqEh1CY2CMPsg==
X-Received: by 2002:ac8:2598:: with SMTP id e24mr205635qte.189.1573077532046;
        Wed, 06 Nov 2019 13:58:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id h25sm53333qka.117.2019.11.06.13.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:58:51 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
Subject: [PATCH 4/5] blk-cgroup: reimplement basic IO stats using cgroup rstat
Date:   Wed,  6 Nov 2019 13:58:37 -0800
Message-Id: <20191106215838.3973497-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
References: <20191106215838.3973497-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-cgroup has been using blkg_rwstat to track basic IO stats.
Unfortunately, reading recursive stats scales badly as itinvolves
walking all descendants.  On systems with a huge number of cgroups
(dead or alive), this can lead to substantial CPU cost when reading IO
stats.

This patch reimplements basic IO stats using cgroup rstat which uses
more memory but makes recursive stat reading O(# descendants which
have been active since last reading) instead of O(# descendants).

* blk-cgroup core no longer uses sync/async stats.  Introduce new stat
  enums - BLKG_IOSTAT_{READ|WRITE|DISCARD}.

* Add blkg_iostat[_set] which encapsulates byte and io stats, last
  values for propagation delta calculation and u64_stats_sync for
  correctness on 32bit archs.

* Update the new percpu stat counters directly and implement
  blkcg_rstat_flush() to implement propagation.

* blkg_print_stat() can now bring the stats up to date by calling
  cgroup_rstat_flush() and print them instead of directly summing up
  all descendants.

* It now allocates 96 bytes per cpu.  It used to be 40 bytes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <dschatzberg@fb.com>
Cc: Daniel Xu <dlxu@fb.com>
---
 block/blk-cgroup.c         | 124 +++++++++++++++++++++++++++++--------
 include/linux/blk-cgroup.h |  48 ++++++++++++--
 2 files changed, 142 insertions(+), 30 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e23a21ba6d46..0b349f6a6a69 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -80,8 +80,7 @@ static void blkg_free(struct blkcg_gq *blkg)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
-	blkg_rwstat_exit(&blkg->stat_ios);
-	blkg_rwstat_exit(&blkg->stat_bytes);
+	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
 }
@@ -146,7 +145,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 				   gfp_t gfp_mask)
 {
 	struct blkcg_gq *blkg;
-	int i;
+	int i, cpu;
 
 	/* alloc and init base part */
 	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, q->node);
@@ -156,8 +155,8 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
 		goto err_free;
 
-	if (blkg_rwstat_init(&blkg->stat_bytes, gfp_mask) ||
-	    blkg_rwstat_init(&blkg->stat_ios, gfp_mask))
+	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
+	if (!blkg->iostat_cpu)
 		goto err_free;
 
 	blkg->q = q;
@@ -167,6 +166,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 	blkg->blkcg = blkcg;
 
+	u64_stats_init(&blkg->iostat.sync);
+	for_each_possible_cpu(cpu)
+		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
+
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
@@ -393,7 +396,6 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
-	struct blkcg_gq *parent = blkg->parent;
 	int i;
 
 	lockdep_assert_held(&blkg->q->queue_lock);
@@ -410,11 +412,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 			pol->pd_offline_fn(blkg->pd[i]);
 	}
 
-	if (parent) {
-		blkg_rwstat_add_aux(&parent->stat_bytes, &blkg->stat_bytes);
-		blkg_rwstat_add_aux(&parent->stat_ios, &blkg->stat_ios);
-	}
-
 	blkg->online = false;
 
 	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
@@ -464,7 +461,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
-	int i;
+	int i, cpu;
 
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
@@ -475,8 +472,12 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * anyway.  If you get hit by a race, retry.
 	 */
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		blkg_rwstat_reset(&blkg->stat_bytes);
-		blkg_rwstat_reset(&blkg->stat_ios);
+		for_each_possible_cpu(cpu) {
+			struct blkg_iostat_set *bis =
+				per_cpu_ptr(blkg->iostat_cpu, cpu);
+			memset(bis, 0, sizeof(*bis));
+		}
+		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -838,16 +839,18 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct blkcg_gq *blkg;
 
+	cgroup_rstat_flush(blkcg->css.cgroup);
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct blkg_iostat_set *bis = &blkg->iostat;
 		const char *dname;
 		char *buf;
-		struct blkg_rwstat_sample rwstat;
 		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
 		int i;
 		bool has_stats = false;
+		unsigned seq;
 
 		spin_lock_irq(&blkg->q->queue_lock);
 
@@ -866,17 +869,16 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		 */
 		off += scnprintf(buf+off, size-off, "%s ", dname);
 
-		blkg_rwstat_recursive_sum(blkg, NULL,
-				offsetof(struct blkcg_gq, stat_bytes), &rwstat);
-		rbytes = rwstat.cnt[BLKG_RWSTAT_READ];
-		wbytes = rwstat.cnt[BLKG_RWSTAT_WRITE];
-		dbytes = rwstat.cnt[BLKG_RWSTAT_DISCARD];
+		do {
+			seq = u64_stats_fetch_begin(&bis->sync);
 
-		blkg_rwstat_recursive_sum(blkg, NULL,
-					offsetof(struct blkcg_gq, stat_ios), &rwstat);
-		rios = rwstat.cnt[BLKG_RWSTAT_READ];
-		wios = rwstat.cnt[BLKG_RWSTAT_WRITE];
-		dios = rwstat.cnt[BLKG_RWSTAT_DISCARD];
+			rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
+			wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
+			dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
+			rios = bis->cur.ios[BLKG_IOSTAT_READ];
+			wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
+			dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
+		} while (u64_stats_fetch_retry(&bis->sync, seq));
 
 		if (rbytes || wbytes || rios || wios) {
 			has_stats = true;
@@ -1212,6 +1214,77 @@ static int blkcg_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
+static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] = src->bytes[i];
+		dst->ios[i] = src->ios[i];
+	}
+}
+
+static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] += src->bytes[i];
+		dst->ios[i] += src->ios[i];
+	}
+}
+
+static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] -= src->bytes[i];
+		dst->ios[i] -= src->ios[i];
+	}
+}
+
+static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct blkcg_gq *parent = blkg->parent;
+		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
+		struct blkg_iostat cur, delta;
+		unsigned seq;
+
+		/* fetch the current per-cpu values */
+		do {
+			seq = u64_stats_fetch_begin(&bisc->sync);
+			blkg_iostat_set(&cur, &bisc->cur);
+		} while (u64_stats_fetch_retry(&bisc->sync, seq));
+
+		/* propagate percpu delta to global */
+		u64_stats_update_begin(&blkg->iostat.sync);
+		blkg_iostat_set(&delta, &cur);
+		blkg_iostat_sub(&delta, &bisc->last);
+		blkg_iostat_add(&blkg->iostat.cur, &delta);
+		blkg_iostat_add(&bisc->last, &delta);
+		u64_stats_update_end(&blkg->iostat.sync);
+
+		/* propagate global delta to parent */
+		if (parent) {
+			u64_stats_update_begin(&parent->iostat.sync);
+			blkg_iostat_set(&delta, &blkg->iostat.cur);
+			blkg_iostat_sub(&delta, &blkg->iostat.last);
+			blkg_iostat_add(&parent->iostat.cur, &delta);
+			blkg_iostat_add(&blkg->iostat.last, &delta);
+			u64_stats_update_end(&parent->iostat.sync);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
 {
 	int i;
@@ -1244,6 +1317,7 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
 	.can_attach = blkcg_can_attach,
+	.css_rstat_flush = blkcg_rstat_flush,
 	.bind = blkcg_bind,
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 914ce55fa8c2..867ab391e409 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -15,7 +15,9 @@
  */
 
 #include <linux/cgroup.h>
+#include <linux/percpu.h>
 #include <linux/percpu_counter.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/seq_file.h>
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
@@ -31,6 +33,14 @@
 
 #ifdef CONFIG_BLK_CGROUP
 
+enum blkg_iostat_type {
+	BLKG_IOSTAT_READ,
+	BLKG_IOSTAT_WRITE,
+	BLKG_IOSTAT_DISCARD,
+
+	BLKG_IOSTAT_NR,
+};
+
 enum blkg_rwstat_type {
 	BLKG_RWSTAT_READ,
 	BLKG_RWSTAT_WRITE,
@@ -61,6 +71,17 @@ struct blkcg {
 #endif
 };
 
+struct blkg_iostat {
+	u64				bytes[BLKG_IOSTAT_NR];
+	u64				ios[BLKG_IOSTAT_NR];
+};
+
+struct blkg_iostat_set {
+	struct u64_stats_sync		sync;
+	struct blkg_iostat		cur;
+	struct blkg_iostat		last;
+};
+
 /*
  * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
  * recursive.  Used to carry stats of dead children.
@@ -127,8 +148,8 @@ struct blkcg_gq {
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
 
-	struct blkg_rwstat		stat_bytes;
-	struct blkg_rwstat		stat_ios;
+	struct blkg_iostat_set __percpu	*iostat_cpu;
+	struct blkg_iostat_set		iostat;
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
@@ -740,15 +761,32 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	throtl = blk_throtl_bio(q, blkg, bio);
 
 	if (!throtl) {
+		struct blkg_iostat_set *bis;
+		int rwd, cpu;
+
+		if (op_is_discard(bio->bi_opf))
+			rwd = BLKG_IOSTAT_DISCARD;
+		else if (op_is_write(bio->bi_opf))
+			rwd = BLKG_IOSTAT_WRITE;
+		else
+			rwd = BLKG_IOSTAT_READ;
+
+		cpu = get_cpu();
+		bis = per_cpu_ptr(blkg->iostat_cpu, cpu);
+		u64_stats_update_begin(&bis->sync);
+
 		/*
 		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
 		 * is a split bio and we would have already accounted for the
 		 * size of the bio.
 		 */
 		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
-			blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
-					bio->bi_iter.bi_size);
-		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
+			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		bis->cur.ios[rwd]++;
+
+		u64_stats_update_end(&bis->sync);
+		cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
+		put_cpu();
 	}
 
 	blkcg_bio_issue_init(bio);
-- 
2.17.1

