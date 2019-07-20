Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D042C6EDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 08:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfGTF7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 01:59:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfGTF7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 01:59:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68C18AD67F3811885278;
        Sat, 20 Jul 2019 13:59:40 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 20 Jul 2019
 13:59:33 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <dedekind1@gmail.com>,
        <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps
Date:   Sat, 20 Jul 2019 14:05:20 +0800
Message-ID: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running stress-test test_2 in mtd-utils on ubi device, sometimes we can
get following oops message:

  BUG: unable to handle page fault for address: ffffffff00000140
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 280a067 P4D 280a067 PUD 0
  Oops: 0000 [#1] SMP
  CPU: 0 PID: 60 Comm: kworker/u16:1 Kdump: loaded Not tainted 5.2.0 #13
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0
  -0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  Workqueue: writeback wb_workfn (flush-ubifs_0_0)
  RIP: 0010:rb_next_postorder+0x2e/0xb0
  Code: 80 db 03 01 48 85 ff 0f 84 97 00 00 00 48 8b 17 48 83 05 bc 80 db
  03 01 48 83 e2 fc 0f 84 82 00 00 00 48 83 05 b2 80 db 03 01 <48> 3b 7a
  10 48 89 d0 74 02 f3 c3 48 8b 52 08 48 83 05 a3 80 db 03
  RSP: 0018:ffffc90000887758 EFLAGS: 00010202
  RAX: ffff888129ae4700 RBX: ffff888138b08400 RCX: 0000000080800001
  RDX: ffffffff00000130 RSI: 0000000080800024 RDI: ffff888138b08400
  RBP: ffff888138b08400 R08: ffffea0004a6b920 R09: 0000000000000000
  R10: ffffc90000887740 R11: 0000000000000001 R12: ffff888128d48000
  R13: 0000000000000800 R14: 000000000000011e R15: 00000000000007c8
  FS:  0000000000000000(0000) GS:ffff88813ba00000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffff00000140 CR3: 000000013789d000 CR4: 00000000000006f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
    destroy_old_idx+0x5d/0xa0 [ubifs]
    ubifs_tnc_start_commit+0x4fe/0x1380 [ubifs]
    do_commit+0x3eb/0x830 [ubifs]
    ubifs_run_commit+0xdc/0x1c0 [ubifs]

Above Oops are due to the slab-out-of-bounds happened in do-while of
function layout_in_gaps indirectly called by ubifs_tnc_start_commit. In
function layout_in_gaps, there is a do-while loop placing index nodes
into the gaps created by obsolete index nodes in non-empty index LEBs
until rest index nodes can totally be placed into pre-allocated empty
LEBs. @c->gap_lebs points to a memory area(integer array) which records
LEB numbers used by 'in-the-gaps' method. Whenever a fitable index LEB
is found, corresponding lnum will be incrementally written into the
memory area pointed by @c->gap_lebs. The size
((@c->lst.idx_lebs + 1) * sizeof(int)) of memory area is allocated before
do-while loop and can not be changed in the loop. But @c->lst.idx_lebs
could be increased by function ubifs_change_lp (called by
layout_leb_in_gaps->ubifs_find_dirty_idx_leb->get_idx_gc_leb) during the
loop. So, sometimes oob happens when number of cycles in do-while loop
exceeds the original value of @c->lst.idx_lebs. See detail in
https://bugzilla.kernel.org/show_bug.cgi?id=204229.
This patch fixes oob in layout_in_gaps.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/tnc_commit.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a384a0f..234be1c 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -212,7 +212,7 @@ static int is_idx_node_in_use(struct ubifs_info *c, union ubifs_key *key,
 /**
  * layout_leb_in_gaps - layout index nodes using in-the-gaps method.
  * @c: UBIFS file-system description object
- * @p: return LEB number here
+ * @p: return LEB number in @c->gap_lebs[p]
  *
  * This function lays out new index nodes for dirty znodes using in-the-gaps
  * method of TNC commit.
@@ -221,7 +221,7 @@ static int is_idx_node_in_use(struct ubifs_info *c, union ubifs_key *key,
  * This function returns the number of index nodes written into the gaps, or a
  * negative error code on failure.
  */
-static int layout_leb_in_gaps(struct ubifs_info *c, int *p)
+static int layout_leb_in_gaps(struct ubifs_info *c, int p)
 {
 	struct ubifs_scan_leb *sleb;
 	struct ubifs_scan_node *snod;
@@ -236,7 +236,7 @@ static int layout_leb_in_gaps(struct ubifs_info *c, int *p)
 		 * filled, however we do not check there at present.
 		 */
 		return lnum; /* Error code */
-	*p = lnum;
+	c->gap_lebs[p] = lnum;
 	dbg_gc("LEB %d", lnum);
 	/*
 	 * Scan the index LEB.  We use the generic scan for this even though
@@ -355,7 +355,7 @@ static int get_leb_cnt(struct ubifs_info *c, int cnt)
  */
 static int layout_in_gaps(struct ubifs_info *c, int cnt)
 {
-	int err, leb_needed_cnt, written, *p;
+	int err, leb_needed_cnt, written, p = 0, old_idx_lebs, *gap_lebs;
 
 	dbg_gc("%d znodes to write", cnt);
 
@@ -364,9 +364,9 @@ static int layout_in_gaps(struct ubifs_info *c, int cnt)
 	if (!c->gap_lebs)
 		return -ENOMEM;
 
-	p = c->gap_lebs;
+	old_idx_lebs = c->lst.idx_lebs;
 	do {
-		ubifs_assert(c, p < c->gap_lebs + c->lst.idx_lebs);
+		ubifs_assert(c, p < c->lst.idx_lebs);
 		written = layout_leb_in_gaps(c, p);
 		if (written < 0) {
 			err = written;
@@ -392,9 +392,29 @@ static int layout_in_gaps(struct ubifs_info *c, int cnt)
 		leb_needed_cnt = get_leb_cnt(c, cnt);
 		dbg_gc("%d znodes remaining, need %d LEBs, have %d", cnt,
 		       leb_needed_cnt, c->ileb_cnt);
+		/*
+		 * Dynamically change the size of @c->gap_lebs to prevent
+		 * oob, because @c->lst.idx_lebs could be increased by
+		 * function @get_idx_gc_leb (called by layout_leb_in_gaps->
+		 * ubifs_find_dirty_idx_leb) during loop. Only enlarge
+		 * @c->gap_lebs when needed.
+		 *
+		 */
+		if (leb_needed_cnt > c->ileb_cnt && p >= old_idx_lebs &&
+		    old_idx_lebs < c->lst.idx_lebs) {
+			old_idx_lebs = c->lst.idx_lebs;
+			gap_lebs = krealloc(c->gap_lebs, sizeof(int) *
+					       (old_idx_lebs + 1), GFP_NOFS);
+			if (!gap_lebs) {
+				kfree(c->gap_lebs);
+				c->gap_lebs = NULL;
+				return -ENOMEM;
+			}
+			c->gap_lebs = gap_lebs;
+		}
 	} while (leb_needed_cnt > c->ileb_cnt);
 
-	*p = -1;
+	c->gap_lebs[p] = -1;
 	return 0;
 }
 
-- 
2.7.4

