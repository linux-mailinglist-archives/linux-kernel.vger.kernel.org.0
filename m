Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BCAE82F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393804AbfIJKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393680AbfIJKaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78914B11B;
        Tue, 10 Sep 2019 10:30:23 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 00/10] Hwpoison soft-offline rework
Date:   Tue, 10 Sep 2019 12:30:06 +0200
Message-Id: <20190910103016.14290-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset was based on Naoya's hwpoison rework [1], so thanks to him
for the initial work.

This patchset aims to fix some issues laying in soft-offline handling,
but it also takes the chance and takes some further steps to perform 
cleanups and some refactoring as well.

 - Motivation:

   A customer and I were facing an issue where poisoned pages we returned
   back to user-space after having offlined them properly.
   This was only seend under some memory stress + soft offlining pages.
   After some anaylsis, it became clear that the problem was that
   when kcompactd kicked in to migrate pages over, compaction_alloc
   callback was handing poisoned pages to the migrate routine.
   Once this page was later on fault in, __do_page_fault returned
   VM_FAULT_HWPOISON making the process being killed.

   All this could happen because isolate_freepages_block and
   fast_isolate_freepages just check for the page to be PageBuddy,
   and since 1) poisoned pages can be part of a higher order page
   and 2) poisoned pages are also Page Buddy, they can sneak in easily.

   I also saw some problem with swap pages, but I suspected to be the
   same sort of problem, so I did not follow that trace.

   The full explanation can be see in [2].

 - Approach:

   The taken approach is to not let poisoned pages hit neither
   pcplists nor buddy freelists.
   This is achieved by:

In-use pages:

   * Normal pages

   1) do not release the last reference count after the
      invalidation/migration of the page.
   2) the page is being handed to page_set_poison, which does:
      2a) sets PageHWPoison flag
      2b) calls put_page (only to be able to call __page_cache_release)
          Since poisoned pages are skipped in free_pages_prepare,
          this put_page is safe.
      2c) Sets the refcount to 1
    
   * Hugetlb pages

   1) Hand the page to page_set_poison after migration
   2) page_set_poison does:
      2a) Calls dissolve_free_huge_page
      2b) If ranged to be dissolved contains poisoned pages,
          we free the rangeas order-0 pages (as we do with gigantic hugetlb page),
          so free_pages_prepare will skip them accordingly.
      2c) Sets the refcount to 1

Free pages:

   * Normal pages:

   1) Take the page off the buddy freelist
   2) Set PageHWPoison flag and set refcount to 1

   * Hugetlb pages

   1) Try to allocate a new hugetlb page to the pool
   2) Take off the pool the poisoned hugetlb


With this patchset, I no longer see the issues I faced before.

Note:
I presented this as RFC to open discussion of the taken aproach.
I think that furthers cleanups and refactors could be made, but I would
like to get some insight of the taken approach before touching more
code.

Thanks

[1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
[2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u

Naoya Horiguchi (5):
  mm,hwpoison: cleanup unused PageHuge() check
  mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
  mm,hwpoison-inject: don't pin for hwpoison_filter
  mm,hwpoison: remove MF_COUNT_INCREASED
  mm: remove flag argument from soft offline functions

Oscar Salvador (5):
  mm,hwpoison: Unify THP handling for hard and soft offline
  mm,hwpoison: Rework soft offline for in-use pages
  mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
  mm,hwpoison: Rework soft offline for free pages
  mm,hwpoison: Use hugetlb_replace_page to replace free hugetlb pages

 drivers/base/memory.c      |   2 +-
 include/linux/mm.h         |   9 +-
 include/linux/page-flags.h |   5 -
 mm/hugetlb.c               |  51 +++++++-
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |  25 ++--
 mm/memory-failure.c        | 319 +++++++++++++++++++++------------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  62 +++++++--
 9 files changed, 267 insertions(+), 235 deletions(-)

-- 
2.12.3

