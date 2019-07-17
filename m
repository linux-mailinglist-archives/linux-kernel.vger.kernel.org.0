Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF56C2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfGQV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 17:59:43 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42479 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbfGQV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:59:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TX9KWw9_1563400771;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX9KWw9_1563400771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 05:59:38 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 0/2] Fix false negative of shmem vma's THP eligibility
Date:   Thu, 18 Jul 2019 05:59:16 +0800
Message-Id: <1563400758-124759-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
vma") introduced THPeligible bit for processes' smaps. But, when checking
the eligibility for shmem vma, __transparent_hugepage_enabled() is
called to override the result from shmem_huge_enabled().  It may result
in the anonymous vma's THP flag override shmem's.  For example, running a
simple test which create THP for shmem, but with anonymous THP disabled,
when reading the process's smaps, it may show:

7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
Size:               4096 kB
...
[snip]
...
ShmemPmdMapped:     4096 kB
...
[snip]
...
THPeligible:    0

And, /proc/meminfo does show THP allocated and PMD mapped too:

ShmemHugePages:     4096 kB
ShmemPmdMapped:     4096 kB

This doesn't make too much sense.  The shmem objects should be treated
separately from anonymous THP.  Calling shmem_huge_enabled() with checking
MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
dax vma check since we already checked if the vma is shmem already.

The transhuge_vma_suitable() is needed to check vma, but it was only
available for shmem THP.  The patch 1/2 makes it available for all kind of
THPs and does some code duplication cleanup, so it is made a separate patch.


Changelog:
v4: * Moved transhuge_vma_suitable() to include/linux/huge_mm.h and
      regroup some functions in linux/include/mm.h. Per Hugh Dickins.
    * Added Hugh’s Acked-by to patch 2/2.
v3: * Check if vma is suitable for allocating THP per Hugh Dickins.
    * Fixed smaps output alignment and documentation per Hugh Dickins.
v2: * Check VM_NOHUGEPAGE per Michal Hocko.


Yang Shi (2):
      mm: thp: make transhuge_vma_suitable available for anonymous THP
      mm: thp: fix false negative of shmem vma's THP eligibility

 Documentation/filesystems/proc.txt |  4 ++--
 fs/proc/task_mmu.c                 |  3 ++-
 include/linux/huge_mm.h            | 23 +++++++++++++++++++++++
 include/linux/mm.h                 | 34 +++++++++++++++++-----------------
 mm/huge_memory.c                   | 11 ++++++++---
 mm/memory.c                        | 13 -------------
 mm/shmem.c                         |  3 +++
 7 files changed, 55 insertions(+), 36 deletions(-)
