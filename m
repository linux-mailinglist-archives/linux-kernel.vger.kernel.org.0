Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80258759F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfGYWB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 18:01:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43228 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfGYWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:01:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLnjVN047526;
        Thu, 25 Jul 2019 22:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Wehduxv3rRQK2E7/irEvOjIfxwzfa7zL656bjo3lVcY=;
 b=GhtfdZvuNUNRbc8Vg+Twnr3rIF2aJVHyoy9A1Nkp5MOGKkueLofl0az5WE7GrW2OW6k7
 nqD6hyY3lWV1dtvvkIG/Nyj94uSjW18m7qYuiFXwuF2/C2YIZro4VLo1AEIsuUpXs0ZG
 SaFGRAjp2/Qc24wBHqHbFX5Zm519HSKRzXOjpBg+d4Jbr3GegG8rZi75vG0F64us7A+d
 ftKYlo0nYjKzHySQ5oo/qU1x9OcJteprFl7AJEl1xmfqMo0tibm/eKyLlUfPLRhPHT/T
 c2Wla83gmr+2lPRukmodPR9FXb0/KOGHah41gvewrIsrvFZPVd6Rfh3FP1jAlN7/6lTL EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tx61c6r9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 22:01:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLqMsG020509;
        Thu, 25 Jul 2019 22:01:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tyd3nw50n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 22:01:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6PM1jwF028641;
        Thu, 25 Jul 2019 22:01:45 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 15:01:45 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nvdimm@lists.01.org
Subject: [PATCH v3 1/2] mm/memory-failure.c clean up around tk pre-allocation
Date:   Thu, 25 Jul 2019 16:01:40 -0600
Message-Id: <1564092101-3865-2-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
References: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250263
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_to_kill() expects the first 'tk' to be pre-allocated, it makes
subsequent allocations on need basis, this makes the code a bit
difficult to read. Move all the allocation internal to add_to_kill()
and drop the **tk argument.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d9cc660..51d5b20 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -304,25 +304,19 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 /*
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
- * TBD would GFP_NOIO be enough?
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
 		       struct vm_area_struct *vma,
-		       struct list_head *to_kill,
-		       struct to_kill **tkc)
+		       struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
-	if (*tkc) {
-		tk = *tkc;
-		*tkc = NULL;
-	} else {
-		tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
-		if (!tk) {
-			pr_err("Memory failure: Out of memory while machine check handling\n");
-			return;
-		}
+	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
+	if (!tk) {
+		pr_err("Memory failure: Out of memory while machine check handling\n");
+		return;
 	}
+
 	tk->addr = page_address_in_vma(p, vma);
 	tk->addr_valid = 1;
 	if (is_zone_device_page(p))
@@ -341,6 +335,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 			page_to_pfn(p), tsk->comm);
 		tk->addr_valid = 0;
 	}
+
 	get_task_struct(tsk);
 	tk->tsk = tsk;
 	list_add_tail(&tk->nd, to_kill);
@@ -432,7 +427,7 @@ static struct task_struct *task_early_kill(struct task_struct *tsk,
  * Collect processes when the error hit an anonymous page.
  */
 static void collect_procs_anon(struct page *page, struct list_head *to_kill,
-			      struct to_kill **tkc, int force_early)
+				int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -457,7 +452,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill, tkc);
+				add_to_kill(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -468,7 +463,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
  * Collect processes when the error hit a file mapped page.
  */
 static void collect_procs_file(struct page *page, struct list_head *to_kill,
-			      struct to_kill **tkc, int force_early)
+				int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -492,7 +487,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill, tkc);
+				add_to_kill(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -501,26 +496,17 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 
 /*
  * Collect the processes who have the corrupted page mapped to kill.
- * This is done in two steps for locking reasons.
- * First preallocate one tokill structure outside the spin locks,
- * so that we can kill at least one process reasonably reliable.
  */
 static void collect_procs(struct page *page, struct list_head *tokill,
 				int force_early)
 {
-	struct to_kill *tk;
-
 	if (!page->mapping)
 		return;
 
-	tk = kmalloc(sizeof(struct to_kill), GFP_NOIO);
-	if (!tk)
-		return;
 	if (PageAnon(page))
-		collect_procs_anon(page, tokill, &tk, force_early);
+		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, &tk, force_early);
-	kfree(tk);
+		collect_procs_file(page, tokill, force_early);
 }
 
 static const char *action_name[] = {
-- 
1.8.3.1

