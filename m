Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C539EAF345
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 01:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfIJXbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 19:31:52 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:51249 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfIJXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 19:31:52 -0400
Received: by mail-ua1-f74.google.com with SMTP id m45so2866611uae.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+U1f0KqQfYAaogDeg7a49Wx0YdcoieN+TYJCFeTYFuw=;
        b=lyjZ95NwhGzkX2bz3amjSAFfMwutk1LGmq4WJaz/q5birrg32c3/bDq+ukWTw7DNPz
         d+l4feHzSpB0DCXVsjW44fx5emTkus4s0GqE4570MyAuz4LyU1hBzklBMTS3fG6FuRpY
         y1C9fCuSNqcWb8ZxOhd/J21yXo/7thcHBZ8xcLr2B+7/JjMdbJ7I0KAwE9uVkccQZsjx
         t3WTVHWetu/9PLSZc/UdBD5u06ejRlIx83eiPSDbgMaqwyxZtLJ7qvFetUfAJPhawEuA
         ZgWbSDDNdXfOiBLRH4Yxkk5wf7p+RI012pvYe6RZp1jrGzE1Vjb9ATUikyH5AoXokALj
         OrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+U1f0KqQfYAaogDeg7a49Wx0YdcoieN+TYJCFeTYFuw=;
        b=moPedPhlQUG/h110QcJQGpRQp/6DTl9F98UlhD4Avjz73BjTTqWY7m2+aepCCUe+XL
         Z+Z/srzjeABGGnvtEhPdiskkQ/CcUIz8aWQSGDxfLN+GAMHzVYTTzU+fa9xuOITYyVOY
         N4DXWqNbffwiBzXcaApngHKhfE/eapSV7FZAjxEOuUcz268mtLpyK/S9Zf5HB5LHlDio
         nJkM2QRO4s5b7S5k1eJX20a7RUcz5k48DsUI6d5cMnETOaNTezEmztHajZHxM9FsDPBX
         LHcfZaRaLEHp12zeeJA6rCzK+/dTTYST6eQ2j1tMuDUik22f6Qs7wDZABAYHv7RrlwIL
         kRIA==
X-Gm-Message-State: APjAAAWgth/W1uI4VHpQ4oNO+QFRjs3/d8JWCZ101PoMXKHuZNVtYAee
        j5tpRws5HZZ132J3PNB4FLZODprZ96Vkt9gr9A==
X-Google-Smtp-Source: APXvYqxdWGIlybVVYzMAqcj+QB3C1YccRGMqr4LASZB3MIEHm0KW2OdPzhaFzvpV1ra1tbYwrQFXIPIii2l4AYQ8Pg==
X-Received: by 2002:a9f:2924:: with SMTP id t33mr16147739uat.69.1568158310470;
 Tue, 10 Sep 2019 16:31:50 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:37 -0700
Message-Id: <20190910233146.206080-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 0/9] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
Currently tasks attempting to allocate more hugetlb memory than is available get
a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
However, if a task attempts to allocate hugetlb memory only more than its
hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
but will SIGBUS the task when it attempts to fault the memory in.

We have developers interested in using hugetlb_cgroups, and they have expressed
dissatisfaction regarding this behavior. We'd like to improve this
behavior such that tasks violating the hugetlb_cgroup limits get an error on
mmap/shmget time, rather than getting SIGBUS'd when they try to fault
the excess memory in.

The underlying problem is that today's hugetlb_cgroup accounting happens
at hugetlb memory *fault* time, rather than at *reservation* time.
Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
the offending task gets SIGBUS'd.

Proposed Solution:
A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
counter has slightly different semantics than
hugetlb.xMB.[limit|usage]_in_bytes:

- While usage_in_bytes tracks all *faulted* hugetlb memory,
reservation_usage_in_bytes tracks all *reserved* hugetlb memory.

- If a task attempts to reserve more memory than limit_in_bytes allows,
the kernel will allow it to do so. But if a task attempts to reserve
more memory than reservation_limit_in_bytes, the kernel will fail this
reservation.

This proposal is implemented in this patch, with tests to verify
functionality and show the usage.

Alternatives considered:
1. A new cgroup, instead of only a new page_counter attached to
   the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
   duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
   hugetlb_cgroup seemed cleaner as well.

2. Instead of adding a new counter, we considered adding a sysctl that modifies
   the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
   reservation time rather than fault time. Adding a new page_counter seems
   better as userspace could, if it wants, choose to enforce different cgroups
   differently: one via limit_in_bytes, and another via
   reservation_limit_in_bytes. This could be very useful if you're
   transitioning how hugetlb memory is partitioned on your system one
   cgroup at a time, for example. Also, someone may find usage for both
   limit_in_bytes and reservation_limit_in_bytes concurrently, and this
   approach gives them the option to do so.

Caveats:
1. This support is implemented for cgroups-v1. I have not tried
   hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
   This is largely because we use cgroups-v1 for now. If required, I
   can add hugetlb_cgroup support to cgroups v2 in this patch or
   a follow up.
2. Most complicated bit of this patch I believe is: where to store the
   pointer to the hugetlb_cgroup to uncharge at unreservation time?
   Normally the cgroup pointers hang off the struct page. But, with
   hugetlb_cgroup reservations, one task can reserve a specific page and another
   task may fault it in (I believe), so storing the pointer in struct
   page is not appropriate. Proposed approach here is to store the pointer in
   the resv_map. See patch for details.

Testing:
- Added tests passing.
- libhugetlbfs tests mostly passing, but some tests have trouble with and
  without this patch series. Seems environment issue rather than code:
  - Overall results:
    ********** TEST SUMMARY
    *                      2M
    *                      32-bit 64-bit
    *     Total testcases:    84      0
    *             Skipped:     0      0
    *                PASS:    66      0
    *                FAIL:    14      0
    *    Killed by signal:     0      0
    *   Bad configuration:     4      0
    *       Expected FAIL:     0      0
    *     Unexpected PASS:     0      0
    *    Test not present:     0      0
    * Strange test result:     0      0
    **********
  - Failing tests:
    - elflink_rw_and_share_test("linkhuge_rw") segfaults with and without this
      patch series.
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc (2M: 32):
      FAIL    Address is not hugepage
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_RESTRICT_EXE=unknown:malloc
      HUGETLB_MORECORE=yes malloc (2M: 32):
      FAIL    Address is not hugepage
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc_manysmall (2M: 32):
      FAIL    Address is not hugepage
    - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
      HUGETLB_MORECORE=yes heapshrink (2M: 32):
      FAIL    Heap not on hugepages
    - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
      libheapshrink.so HUGETLB_MORECORE=yes heapshrink (2M: 32):
      FAIL    Heap not on hugepages
    - HUGETLB_ELFMAP=RW linkhuge_rw (2M: 32): FAIL    small_data is not hugepage
    - HUGETLB_ELFMAP=RW HUGETLB_MINIMAL_COPY=no linkhuge_rw (2M: 32):
      FAIL    small_data is not hugepage
    - alloc-instantiate-race shared (2M: 32):
      Bad configuration: sched_setaffinity(cpu1): Invalid argument -
      FAIL    Child 1 killed by signal Killed
    - shmoverride_linked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument
    - HUGETLB_SHM=yes shmoverride_linked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument
    - shmoverride_linked_static (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - HUGETLB_SHM=yes shmoverride_linked_static (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - LD_PRELOAD=libhugetlbfs.so shmoverride_unlinked (2M: 32):
      FAIL shmget failed size 2097152 from line 176: Invalid argument
    - LD_PRELOAD=libhugetlbfs.so HUGETLB_SHM=yes shmoverride_unlinked (2M: 32):
      FAIL    shmget failed size 2097152 from line 176: Invalid argument

Signed-off-by: Mina Almasry <almasrymina@google.com>

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Changes in v4:
- Split up 'hugetlb_cgroup: add accounting for shared mappings' into 4 patches
  for better isolation and context on the individual changes:
  - hugetlb_cgroup: add accounting for shared mappings
  - hugetlb: disable region_add file_region coalescing
  - hugetlb: remove duplicated code
  - hugetlb: region_chg provides only cache entry
- Fixed resv->adds_in_progress accounting.
- Retained behavior that region_add never fails, in earlier patchsets region_add
  could return failure.
- Fixed libhugetlbfs failure.
- Minor fix to the added tests that was preventing them from running on some
  environments.

Changes in v3:
- Addressed comments of Hillf Danton:
  - Added docs.
  - cgroup_files now uses enum.
  - Various readability improvements.
- Addressed comments of Mike Kravetz.
  - region_* functions no longer coalesce file_region entries in the resv_map.
  - region_add() and region_chg() refactored to make them much easier to
    understand and remove duplicated code so this patch doesn't add too much
    complexity.
  - Refactored common functionality into helpers.

Changes in v2:
- Split the patch into a 5 patch series.
- Fixed patch subject.

Mina Almasry (9):
  hugetlb_cgroup: Add hugetlb_cgroup reservation counter
  hugetlb_cgroup: add interface for charge/uncharge hugetlb reservations
  hugetlb_cgroup: add reservation accounting for private mappings
  hugetlb: region_chg provides only cache entry
  hugetlb: remove duplicated code
  hugetlb: disable region_add file_region coalescing
  hugetlb_cgroup: add accounting for shared mappings
  hugetlb_cgroup: Add hugetlb_cgroup reservation tests
  hugetlb_cgroup: Add hugetlb_cgroup reservation docs

 .../admin-guide/cgroup-v1/hugetlb.rst         |  84 ++-
 include/linux/hugetlb.h                       |  24 +-
 include/linux/hugetlb_cgroup.h                |  24 +-
 mm/hugetlb.c                                  | 516 +++++++++++-------
 mm/hugetlb_cgroup.c                           | 189 +++++--
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   4 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 440 +++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 252 +++++++++
 10 files changed, 1304 insertions(+), 252 deletions(-)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

--
2.23.0.162.g0b9fbb3734-goog
