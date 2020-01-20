Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF28142649
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 09:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgATI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 03:57:41 -0500
Received: from sonic314-21.consmr.mail.gq1.yahoo.com ([98.137.69.84]:46543
        "EHLO sonic314-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgATI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579510648; bh=0owMYed7lR2DbHghd/A0BDOJYE+mtYR+fvCs9yHxrQg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LS7aP323gaVps7fxkD5ZjDJM+xK9eErzFqnN9l8pEF90Th56Z3nVvgKyH65lgrKrkUv+dQ28eGJ6Ecj9lnHe3mk0gaYgAMWokpvYem9kZLLSzbRLcDE/PV/t/LTp6ZOY8bgw9brMrQdO94v6QA3he56rd5jkXxZw9EsWtWfinOE9FaEAqan+4uPZIfbyG+4OSm4ONtgGu6s9Qe78ifBG/1LVfQdO6RsvLmZPNYRqk1t/c2QNuQAIZg47ZNE2du1pGFihDv4PrVXEdWcXbW1pUfH9K3s5CIMJ2ATxQeNt+2F2mnPD/Hi/I8NqwBKAZL9H7Sp91cds91zQ4dD9ba4ckQ==
X-YMail-OSG: JDWqZz4VM1lwaHTwmnrJWP4tdP4FYDuQ5kWhkP7CRgmKPAXMRjlG95Kgg5UquZ6
 GxhGyrPvNV9pGIrPeP.vM9HVTkLttWN.abP0okPliAYsiJ9I0PSji7zVccpxg6s.zOzhX4R3xSd1
 QXPoPZeWLwnkWk5.l624OtYHsAg1wUheoaxPSZxkMg8lGRZNPaCz.vyI6JssbeP.nC2aT2ctK.pH
 gO3a_XBhQQ4EXH0Iw_C03fn8yIxV33CdBB60lwYIr96L.rcXgDZDnztce79mxw63i9UWH6Kyz0FH
 QqjooNJecZdo61rncxlns_QlJBjbk.2qjS15JK9VnK_O7s3EGw3.bmQ4peiaUQMTaKNPRIvreGLE
 Zecc65ZbANrmsxaxWtpHQjtzM0_Iqvh1.LEwCzLrrKDIvdHpExnYZee11Z3y3SoztEHb3eVURfss
 JEeAvQHMNgubSanI9aEEJDT1f3FrtS0XiEDJ.FKJi7KQ5Kblxl1ZGtX6x.NzoiKQgRxx0spLxC7a
 agQ6f1goJz0aODrTmul20vzr9iNSgxAqBmUgq2VqMMF9CWY73bYamx2wvJtEEOu7_vuN8v8nlIZo
 _fJ7NJAD2GLddQYWHUrHdfxtIS5uew220xqD4pwTYx.2BAXdCU67QEQofcmIFlG9HEf2GZXDTBDo
 EpDO0cgqDu89xFOhcSy0vHkomV.QFjUmbmniiptmO._x.QutwaGcOCisPz6ivGPFwOL03eNyc4tc
 OFCM4xG8bQmf3dgQ02zmEVZWQ7YDodg8K0hd_jOAuwoeVcQO1Bb3k4LUOgPViGCtsaePg0F1XCZF
 GDe2iOfoA.b0dUQDGEZkmCqVrj8Pj8d_6hXBarnWyFuDcs2DypGmppo9FQdWTNDXV9wU6FjrSNMJ
 aqSv5wcYCzFk97J0AZ2b7H.S5BPpN41b2Q5EJkOU8dAYfkNScTzrbGxUgcJv_0YMqiMAG2uKusFa
 u4pz0kcRfQUrl9FghqRbUJumlvnn9XZITrn8bxZSk3JRZhzsEh.5eCHO3Twvloh_Mky1RSjRhjFh
 MgYhmGOXaxAuZ9jVjN_.RPXI.0c3mv1VZHX6402Jzzt3VuQErbA1IQJUl5HOL5EDqsiTpZN4RW7e
 nzmDNEE0bngJLjkwqeCHBj3mCHLIuRTvNJ4jzNLgPRQMK7UQ2uz0vZ1oarl402sJHRmaOsQvNaWU
 NF4StMKmrL86lBSJiYK2qKDm7ARyewRHSUJa1baoM4uKKKhT6zejTe.EjfWbXB2Amz6HimrUa_Hy
 qVJywQLGQYO9p0WLBgH5RJzDWc6GT4H.C0qmASFXdeeT_9EN2WBRotdARBhYUDHYwar736ptdmni
 sicNNjNzXkoV7UPyYV4XbHdSSlRybVTIr9lT1l0TYwW0ezCDNvwbNmS.EqscX6MRo6Sf6AY3aXHS
 jn31ZlQ_VFU3ot8T5dHDb2H7xcRM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Mon, 20 Jan 2020 08:57:28 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 108e935cc9711f548eb3f10aaf32bbda;
          Mon, 20 Jan 2020 08:57:28 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] erofs: clean up z_erofs_submit_queue()
Date:   Mon, 20 Jan 2020 16:57:09 +0800
Message-Id: <20200120085709.10320-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120085709.10320-1-hsiangkao@aol.com>
References: <20200120085709.10320-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

A label and extra variables will be eliminated,
which is more cleaner.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 95 ++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6ee5153801b2..9a84609b6d1b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1148,7 +1148,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool z_erofs_submit_queue(struct super_block *sb,
+static void z_erofs_submit_queue(struct super_block *sb,
 				 z_erofs_next_pcluster_t owned_head,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
@@ -1157,19 +1157,12 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	struct bio *bio;
 	void *bi_private;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t uninitialized_var(last_index);
-	bool force_submit = false;
-	unsigned int nr_bios;
+	unsigned int nr_bios = 0;
+	struct bio *bio = NULL;
 
-	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
-		return false;
-
-	force_submit = false;
-	bio = NULL;
-	nr_bios = 0;
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
@@ -1179,11 +1172,9 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 
 	do {
 		struct z_erofs_pcluster *pcl;
-		unsigned int clusterpages;
-		pgoff_t first_index;
-		struct page *page;
-		unsigned int i = 0, bypass = 0;
-		int err;
+		pgoff_t cur, end;
+		unsigned int i = 0;
+		bool bypass = true;
 
 		/* no possible 'owned_head' equals the following */
 		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
@@ -1191,55 +1182,50 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
-		clusterpages = BIT(pcl->clusterbits);
+		cur = pcl->obj.index;
+		end = cur + BIT(pcl->clusterbits);
 
 		/* close the main owned chain at first */
 		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
 				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-		first_index = pcl->obj.index;
-		force_submit |= (first_index != last_index + 1);
+		do {
+			struct page *page;
+			int err;
 
-repeat:
-		page = pickup_page_for_submission(pcl, i, pagepool,
-						  MNGD_MAPPING(sbi),
-						  GFP_NOFS);
-		if (!page) {
-			force_submit = true;
-			++bypass;
-			goto skippage;
-		}
+			page = pickup_page_for_submission(pcl, i++, pagepool,
+							  MNGD_MAPPING(sbi),
+							  GFP_NOFS);
+			if (!page)
+				continue;
 
-		if (bio && force_submit) {
+			if (bio && cur != last_index + 1) {
 submit_bio_retry:
-			submit_bio(bio);
-			bio = NULL;
-		}
-
-		if (!bio) {
-			bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+				submit_bio(bio);
+				bio = NULL;
+			}
 
-			bio->bi_end_io = z_erofs_decompressqueue_endio;
-			bio_set_dev(bio, sb->s_bdev);
-			bio->bi_iter.bi_sector = (sector_t)(first_index + i) <<
-				LOG_SECTORS_PER_BLOCK;
-			bio->bi_private = bi_private;
-			bio->bi_opf = REQ_OP_READ;
+			if (!bio) {
+				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 
-			++nr_bios;
-		}
+				bio->bi_end_io = z_erofs_decompressqueue_endio;
+				bio_set_dev(bio, sb->s_bdev);
+				bio->bi_iter.bi_sector = (sector_t)cur <<
+					LOG_SECTORS_PER_BLOCK;
+				bio->bi_private = bi_private;
+				bio->bi_opf = REQ_OP_READ;
+				++nr_bios;
+			}
 
-		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (err < PAGE_SIZE)
-			goto submit_bio_retry;
+			err = bio_add_page(bio, page, PAGE_SIZE, 0);
+			if (err < PAGE_SIZE)
+				goto submit_bio_retry;
 
-		force_submit = false;
-		last_index = first_index + i;
-skippage:
-		if (++i < clusterpages)
-			goto repeat;
+			last_index = cur;
+			bypass = false;
+		} while (++cur < end);
 
-		if (bypass < clusterpages)
+		if (!bypass)
 			qtail[JQ_SUBMIT] = &pcl->next;
 		else
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
@@ -1254,10 +1240,9 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	 */
 	if (!force_fg && !nr_bios) {
 		kvfree(q[JQ_SUBMIT]);
-		return true;
+		return;
 	}
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
-	return true;
 }
 
 static void z_erofs_runqueue(struct super_block *sb,
@@ -1266,9 +1251,9 @@ static void z_erofs_runqueue(struct super_block *sb,
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
-	if (!z_erofs_submit_queue(sb, clt->owned_head,
-				  pagepool, io, &force_fg))
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
+	z_erofs_submit_queue(sb, clt->owned_head, pagepool, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
-- 
2.20.1

