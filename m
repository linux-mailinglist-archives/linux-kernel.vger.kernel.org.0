Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896424C54B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfFTCU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 22:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfFTCU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F2093092671;
        Thu, 20 Jun 2019 02:20:25 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D53C91001DC3;
        Thu, 20 Jun 2019 02:20:10 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 00/25] userfaultfd: write protection support
Date:   Thu, 20 Jun 2019 10:19:43 +0800
Message-Id: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 20 Jun 2019 02:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements initial write protection support for
userfaultfd.  Currently both shmem and hugetlbfs are not supported
yet, but only anonymous memory.  This is the 4nd version of it.

The latest code can also be found at:

  https://github.com/xzpeter/linux/tree/uffd-wp-merged

v5 changelog:
- rebase
- drop two patches:
    "userfaultfd: wp: handle COW properly for uffd-wp"
    "mm: introduce do_wp_page_cont()"
  instead remove the write bit always when resolving uffd-wp page
  fault in previous patch ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
  then COW will be handled correctly in the PF irq handler [Andrea]

v4 changelog:
- add r-bs
- use kernel-doc format for fault_flag_allow_retry_first [Jerome]
- drop "export wp_page_copy", add new patch to split do_wp_page(), use
  it in change_pte_range() to replace the wp_page_copy(). [Jerome] (I
  thought about different ways to do this but I still can't find a
  100% good way for all... in this version I still used the
  do_wp_page_cont naming.  We can still discuss this and how we should
  split do_wp_page)
- make sure uffd-wp will also apply to device private entries which
  HMM uses [Jerome]

v3 changelog:
- take r-bs
- patch 1: fix typo [Jerome]
- patch 2: use brackets where proper around (flags & VM_FAULT_RETRY)
  (there're three places to change, not four...) [Jerome]
- patch 4: make sure TRIED is applied correctly on all archs, add more
  comment to explain the new page fault mechanism [Jerome]
- patch 7: in do_swap_page() remove the two lines to remove
  FAULT_FLAG_WRITE flag [Jerome]
- patch 10: another brackets change like above, and in
  mfill_atomic_pte return -EINVAL when detected wp_copy==1 upon shared
  memories [Jerome]
- patch 12: move _PAGE_CHG_MASK change to patch 8 [Jerome]
- patch 14: wp_page_copy() - fix write bit; change_pte_range() -
  detect PTE change after COW [Jerome]
- patch 17: remove last paragraph of commit message, no need to drop
  the two lines in do_swap_page() since they've been directly dropped
  in patch 7; touch up remove_migration_pte() to only detect uffd-wp
  bit if it's read migration entry [Jerome]
- add patch: "userfaultfd: wp: declare _UFFDIO_WRITEPROTECT
  conditionally", which remove _UFFDIO_WRITEPROTECT bit if detected
  non-anonymous memory during REGISTER; meanwhile fixup the test case
  for shmem too for expected ioctls returned from REGISTER [Mike]
- add patch: "userfaultfd: wp: fixup swap entries in
  change_pte_range", the new patch will allow to apply the uffd-wp
  bits upon swap entries directly (e.g., when the page is during
  migration or the page was swapped out).  Please see the patch for
  detail information.

v2 changelog:
- add some r-bs
- split the patch "mm: userfault: return VM_FAULT_RETRY on signals"
  into two: one to focus on the signal behavior change, the other to
  remove the NOPAGE special path in handle_userfault().  Removing the
  ARC specific change and remove that part of commit message since
  it's fixed in 4d447455e73b already [Jerome]
- return -ENOENT when VMA is invalid for UFFDIO_WRITEPROTECT to match
  UFFDIO_COPY errno [Mike]
- add a new patch to introduce helper to find valid VMA for uffd
  [Mike]
- check against VM_MAYWRITE instead of VM_WRITE when registering UFFD
  WP [Mike]
- MM_CP_DIRTY_ACCT is used incorrectly, fix it up [Jerome]
- make sure the lock_page behavior will not be changed [Jerome]
- reorder the whole series, introduce the new ioctl last. [Jerome]
- fix up the uffdio_writeprotect() following commit df2cc96e77011cf79
  to return -EAGAIN when detected mm layout changes [Mike]

v1 can be found at: https://lkml.org/lkml/2019/1/21/130

Any comment would be greatly welcomed.   Thanks.

Overview
====================

The uffd-wp work was initialized by Shaohua Li [1], and later
continued by Andrea [2]. This series is based upon Andrea's latest
userfaultfd tree, and it is a continuous works from both Shaohua and
Andrea.  Many of the follow up ideas come from Andrea too.

Besides the old MISSING register mode of userfaultfd, the new uffd-wp
support provides another alternative register mode called
UFFDIO_REGISTER_MODE_WP that can be used to listen to not only missing
page faults but also write protection page faults, or even they can be
registered together.  At the same time, the new feature also provides
a new userfaultfd ioctl called UFFDIO_WRITEPROTECT which allows the
userspace to write protect a range or memory or fixup write permission
of faulted pages.

Please refer to the document patch "userfaultfd: wp:
UFFDIO_REGISTER_MODE_WP documentation update" for more information on
the new interface and what it can do.

The major workflow of an uffd-wp program should be:

  1. Register a memory region with WP mode using UFFDIO_REGISTER_MODE_WP

  2. Write protect part of the whole registered region using
     UFFDIO_WRITEPROTECT, passing in UFFDIO_WRITEPROTECT_MODE_WP to
     show that we want to write protect the range.

  3. Start a working thread that modifies the protected pages,
     meanwhile listening to UFFD messages.

  4. When a write is detected upon the protected range, page fault
     happens, a UFFD message will be generated and reported to the
     page fault handling thread

  5. The page fault handler thread resolves the page fault using the
     new UFFDIO_WRITEPROTECT ioctl, but this time passing in
     !UFFDIO_WRITEPROTECT_MODE_WP instead showing that we want to
     recover the write permission.  Before this operation, the fault
     handler thread can do anything it wants, e.g., dumps the page to
     a persistent storage.

  6. The worker thread will continue running with the correctly
     applied write permission from step 5.

Currently there are already two projects that are based on this new
userfaultfd feature.

QEMU Live Snapshot: The project provides a way to allow the QEMU
                    hypervisor to take snapshot of VMs without
                    stopping the VM [3].

LLNL umap library:  The project provides a mmap-like interface and
                    "allow to have an application specific buffer of
                    pages cached from a large file, i.e. out-of-core
                    execution using memory map" [4][5].

Before posting the patchset, this series was smoke tested against QEMU
live snapshot and the LLNL umap library (by doing parallel quicksort
using 128 sorting threads + 80 uffd servicing threads).  My sincere
thanks to Marty Mcfadden and Denis Plotnikov for the help along the
way.

TODO
=============

- hugetlbfs/shmem support
- performance
- more architectures
- cooperate with mprotect()-allowed processes (???)
- ...

References
==========

[1] https://lwn.net/Articles/666187/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/log/?h=userfault
[3] https://github.com/denis-plotnikov/qemu/commits/background-snapshot-kvm
[4] https://github.com/LLNL/umap
[5] https://llnl-umap.readthedocs.io/en/develop/
[6] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?h=userfault&id=b245ecf6cf59156966f3da6e6b674f6695a5ffa5
[7] https://lkml.org/lkml/2018/11/21/370
[8] https://lkml.org/lkml/2018/12/30/64

Andrea Arcangeli (5):
  userfaultfd: wp: hook userfault handler to write protection fault
  userfaultfd: wp: add WP pagetable tracking to x86
  userfaultfd: wp: userfaultfd_pte/huge_pmd_wp() helpers
  userfaultfd: wp: add UFFDIO_COPY_MODE_WP
  userfaultfd: wp: add the writeprotect API to userfaultfd ioctl

Martin Cracauer (1):
  userfaultfd: wp: UFFDIO_REGISTER_MODE_WP documentation update

Peter Xu (16):
  mm: gup: rename "nonblocking" to "locked" where proper
  mm: userfault: return VM_FAULT_RETRY on signals
  userfaultfd: don't retake mmap_sem to emulate NOPAGE
  mm: allow VM_FAULT_RETRY for multiple times
  mm: gup: allow VM_FAULT_RETRY for multiple times
  mm: merge parameters for change_protection()
  userfaultfd: wp: apply _PAGE_UFFD_WP bit
  userfaultfd: wp: drop _PAGE_UFFD_WP properly when fork
  userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
  userfaultfd: wp: support swap and page migration
  khugepaged: skip collapse if uffd-wp detected
  userfaultfd: introduce helper vma_find_uffd
  userfaultfd: wp: don't wake up when doing write protect
  userfaultfd: wp: declare _UFFDIO_WRITEPROTECT conditionally
  userfaultfd: selftests: refactor statistics
  userfaultfd: selftests: add write-protect test

Shaohua Li (3):
  userfaultfd: wp: add helper for writeprotect check
  userfaultfd: wp: support write protection for userfault vma range
  userfaultfd: wp: enabled write protection in userfaultfd API

 Documentation/admin-guide/mm/userfaultfd.rst |  51 +++++
 arch/alpha/mm/fault.c                        |   4 +-
 arch/arc/mm/fault.c                          |  12 +-
 arch/arm/mm/fault.c                          |   9 +-
 arch/arm64/mm/fault.c                        |  11 +-
 arch/hexagon/mm/vm_fault.c                   |   3 +-
 arch/ia64/mm/fault.c                         |   3 +-
 arch/m68k/mm/fault.c                         |   5 +-
 arch/microblaze/mm/fault.c                   |   3 +-
 arch/mips/mm/fault.c                         |   3 +-
 arch/nds32/mm/fault.c                        |   7 +-
 arch/nios2/mm/fault.c                        |   5 +-
 arch/openrisc/mm/fault.c                     |   3 +-
 arch/parisc/mm/fault.c                       |   6 +-
 arch/powerpc/mm/fault.c                      |   8 +-
 arch/riscv/mm/fault.c                        |   9 +-
 arch/s390/mm/fault.c                         |  14 +-
 arch/sh/mm/fault.c                           |   5 +-
 arch/sparc/mm/fault_32.c                     |   4 +-
 arch/sparc/mm/fault_64.c                     |   4 +-
 arch/um/kernel/trap.c                        |   6 +-
 arch/unicore32/mm/fault.c                    |   8 +-
 arch/x86/Kconfig                             |   1 +
 arch/x86/include/asm/pgtable.h               |  67 ++++++
 arch/x86/include/asm/pgtable_64.h            |   8 +-
 arch/x86/include/asm/pgtable_types.h         |  11 +-
 arch/x86/mm/fault.c                          |   8 +-
 arch/xtensa/mm/fault.c                       |   4 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c              |  12 +-
 fs/userfaultfd.c                             | 130 +++++++----
 include/asm-generic/pgtable.h                |   1 +
 include/asm-generic/pgtable_uffd.h           |  66 ++++++
 include/linux/huge_mm.h                      |   2 +-
 include/linux/mm.h                           |  60 ++++-
 include/linux/swapops.h                      |   2 +
 include/linux/userfaultfd_k.h                |  42 +++-
 include/trace/events/huge_memory.h           |   1 +
 include/uapi/linux/userfaultfd.h             |  40 +++-
 init/Kconfig                                 |   5 +
 mm/filemap.c                                 |   2 +-
 mm/gup.c                                     |  61 ++---
 mm/huge_memory.c                             |  32 ++-
 mm/hugetlb.c                                 |  14 +-
 mm/khugepaged.c                              |  23 ++
 mm/memory.c                                  |  26 ++-
 mm/mempolicy.c                               |   2 +-
 mm/migrate.c                                 |   6 +
 mm/mprotect.c                                |  74 ++++--
 mm/rmap.c                                    |   6 +
 mm/shmem.c                                   |   2 +-
 mm/userfaultfd.c                             | 148 +++++++++---
 tools/testing/selftests/vm/userfaultfd.c     | 225 +++++++++++++++----
 52 files changed, 974 insertions(+), 290 deletions(-)
 create mode 100644 include/asm-generic/pgtable_uffd.h

-- 
2.21.0

