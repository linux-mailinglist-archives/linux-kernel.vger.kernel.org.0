Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540DAE9490
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfJ3BZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 21:25:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:40177 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3BZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:25:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 18:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="198538632"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2019 18:25:09 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        rppt@linux.ibm.com, will@kernel.org, mhocko@suse.com,
        catalin.marinas@arm.com, aarcange@redhat.com, jannh@google.com,
        darrick.wong@oracle.com, steve.capper@arm.com, walken@google.com,
        dave.hansen@linux.intel.com, tiny.windzz@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmap.c: make vma_merge() comment more easy to understand
Date:   Wed, 30 Oct 2019 09:24:45 +0800
Message-Id: <20191030012445.16944-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Case 1/6, 2/7 and 3/8 have the same pattern and we handle them in the
same logic.

Rearrange the comment to make it a little easy for audience to
understand.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a7d8c84d19b7..d485100f9d29 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1116,15 +1116,18 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * the area passed down from mprotect_fixup, never extending beyond one
  * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
  *
- *     AAAA             AAAA                AAAA          AAAA
- *    PPPPPPNNNNNN    PPPPPPNNNNNN    PPPPPPNNNNNN    PPPPNNNNXXXX
- *    cannot merge    might become    might become    might become
- *                    PPNNNNNNNNNN    PPPPPPPPPPNN    PPPPPPPPPPPP 6 or
- *    mmap, brk or    case 4 below    case 5 below    PPPPPPPPXXXX 7 or
- *    mremap move:                                    PPPPXXXXXXXX 8
- *        AAAA
- *    PPPP    NNNN    PPPPPPPPPPPP    PPPPPPPPNNNN    PPPPNNNNNNNN
- *    might become    case 1 below    case 2 below    case 3 below
+ *     AAAA             AAAA                   AAAA
+ *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPNNNNNN
+ *    cannot merge    might become       might become
+ *                    PPNNNNNNNNNN       PPPPPPPPPPNN
+ *    mmap, brk or    case 4 below       case 5 below
+ *    mremap move:
+ *                        AAAA               AAAA
+ *                    PPPP    NNNN       PPPPNNNNXXXX
+ *                    might become       might become
+ *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
+ *                    PPPPPPPPNNNN 2 or  PPPPPPPPXXXX 7 or
+ *                    PPPPNNNNNNNN 3     PPPPXXXXXXXX 8
  *
  * It is important for case 8 that the vma NNNN overlapping the
  * region AAAA is never going to extended over XXXX. Instead XXXX must
-- 
2.17.1

