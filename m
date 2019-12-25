Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D015B12A6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 10:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLYJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 04:04:44 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54720 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfLYJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:04:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TltD6EY_1577264680;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TltD6EY_1577264680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 17:04:40 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Subject: [PATCH v7 00/10] per lruvec lru_lock for memcg
Date:   Wed, 25 Dec 2019 17:04:16 +0800
Message-Id: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Merry Christmas! :)

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg per node.

We introduce function lock_page_lruvec, which will lock the page's
memcg and then memcg's lruvec->lru_lock(Thanks Johannes Weiner,
Hugh Dickins and Konstantin Khlebnikov suggestion/reminder) to replace
old pgdat->lru_lock.

Following to Daniel Jordan's suggestion, I run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this patchset, the readtwice performance increased about 80%
with containers. And no performance drops w/o container.

Another way to guard move_account is by lru_lock instead of move_lock 
Considering the memcg move task path:
   mem_cgroup_move_task:
     mem_cgroup_move_charge:
	lru_add_drain_all();
	atomic_inc(&mc.from->moving_account); //ask lruvec's move_lock
	synchronize_rcu();
	walk_parge_range: do charge_walk_ops(mem_cgroup_move_charge_pte_range):
	   isolate_lru_page();
	   mem_cgroup_move_account(page,)
		spin_lock(&from->move_lock) 
		page->mem_cgroup = to;
		spin_unlock(&from->move_lock) 
	   putback_lru_page(page)

to guard 'page->mem_cgroup = to' by to_vec->lru_lock has the similar effect with
move_lock. So for performance reason, both solutions are same.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought the same idea
7 years ago.

Thanks all the comments from Hugh Dickins, Konstantin Khlebnikov, Daniel Jordan, 
Johannes Weiner, Mel Gorman, Shakeel Butt, Rong Chen, Fengguang Wu, Yun Wang etc.
and some testing support from Intel 0days!

v7,
  a, rebase on v5.5-rc3, 
  b, move the lock_page_lru() clean up before lock replace.

v6, 
  a, rebase on v5.5-rc2, and do retesting.
  b, pick up Johanness' comments change and a lock_page_lru cleanup.

v5,
  a, locking page's memcg according JohannesW suggestion
  b, using macro for non memcg, according to Johanness and Metthew's suggestion.

v4: 
  a, fix the page->mem_cgroup dereferencing issue, thanks Johannes Weiner
  b, remove the irqsave flags changes, thanks Metthew Wilcox
  c, merge/split patches for better understanding and bisection purpose

v3: rebase on linux-next, and fold the relock fix patch into introduceing patch

v2: bypass a performance regression bug and fix some function issues

v1: initial version, aim testing show 5% performance increase on a 16 threads box.


Alex Shi (9):
  mm/vmscan: remove unnecessary lruvec adding
  mm/memcg: fold lru_lock in lock_page_lru
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: introduce the relock_page_lruvec function
  mm/mlock: optimize munlock_pagevec by relocking
  mm/swap: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: add debug checking for page memcg moving
  mm/memcg: add debug checking in lock_page_memcg

Hugh Dickins (1):
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +---
 Documentation/admin-guide/cgroup-v1/memory.rst     |  6 +-
 Documentation/trace/events-kmem.rst                |  2 +-
 Documentation/vm/unevictable-lru.rst               | 22 ++---
 include/linux/memcontrol.h                         | 63 ++++++++++++++
 include/linux/mm_types.h                           |  2 +-
 include/linux/mmzone.h                             |  5 +-
 mm/compaction.c                                    | 59 ++++++++-----
 mm/filemap.c                                       |  4 +-
 mm/huge_memory.c                                   | 18 ++--
 mm/memcontrol.c                                    | 84 +++++++++++++++----
 mm/mlock.c                                         | 28 +++----
 mm/mmzone.c                                        |  1 +
 mm/page_alloc.c                                    |  1 -
 mm/page_idle.c                                     |  7 +-
 mm/rmap.c                                          |  2 +-
 mm/swap.c                                          | 75 +++++++----------
 mm/vmscan.c                                        | 98 ++++++++++++----------
 18 files changed, 297 insertions(+), 195 deletions(-)

-- 
1.8.3.1

