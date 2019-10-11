Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2162FD37A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJKC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 22:59:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:60510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfJKC76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:59:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 19:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="219252094"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2019 19:59:14 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, cai@lca.pw, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v3 2/2] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Date:   Fri, 11 Oct 2019 10:58:41 +0800
Message-Id: <20191011025841.16801-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011025841.16801-1-richardw.yang@linux.intel.com>
References: <20191011025841.16801-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __anon_vma_prepare(), we will try to find anon_vma if it is
possible to reuse it. While on fork, the logic is different.

Since commit 5beb49305251 ("mm: change anon_vma linking to fix
multi-process server scalability issue"), function anon_vma_clone()
tries to allocate new anon_vma for child process. But the logic here
will allocate a new anon_vma for each vma, even in parent this vma
is mergeable and share the same anon_vma with its sibling. This may do
better for scalability issue, while it is not necessary to do so
especially after interval tree is used.

Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma hierarchy")
tries to reuse some anon_vma by counting child anon_vma and attached
vmas. While for those mergeable anon_vmas, we can just reuse it and not
necessary to go through the logic.

After this change, kernel build test reduces 20% anon_vma allocation.

Do the same kernel build test, it shows run time in sys reduced 11.5%.

Origin:

real    2m50.467s
user    17m52.002s
sys     1m51.953s

real    2m48.662s
user    17m55.464s
sys     1m50.553s

real    2m51.143s
user    17m59.687s
sys     1m53.600s

Patched:

real	2m40.080s
user	17m4.644s
sys	1m39.321s

real	2m39.967s
user	17m2.445s
sys	1m38.850s

real	2m40.581s
user	17m1.975s
sys	1m39.065s

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/rmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index fc0aba7fb9b9..0dd5f8b04a48 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -269,6 +269,18 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 	struct anon_vma_chain *avc, *pavc;
 	struct anon_vma *root = NULL;
 	bool reuse = !dst->anon_vma && src->anon_vma;
+	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
+
+	/*
+	 * If parent share anon_vma with its vm_prev, keep this sharing in in
+	 * child.
+	 *
+	 * 1. Parent has vm_prev, which implies we have vm_prev.
+	 * 2. Parent and its vm_prev have the same anon_vma.
+	 */
+	if (reuse && pprev && pprev->anon_vma == src->anon_vma)
+		dst->anon_vma = prev->anon_vma;
+
 
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
-- 
2.17.1

