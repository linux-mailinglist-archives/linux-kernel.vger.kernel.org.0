Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368B2B150E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 22:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfILUHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 16:07:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:35544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfILUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:07:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 13:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336688197"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 13:07:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v8 00/17] Enable FSGSBASE instructions
Date:   Thu, 12 Sep 2019 13:06:41 -0700
Message-Id: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction:
FSGSBASE is a 64-bit instruction set to allow read/write FS/GS base from
user and kernel spaces. Currently a user process reads/writes to FS/GS base
needs a system call. Read/write to FS/GS base allows performance
improvement specifically during context switch. A third party reported out
promising performance numbers out of their initial benchmarking of the
previous version of this patch series [9].

Enablement check:
The kernel provides information about the enabled state of FSGSBASE to
applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
the AUX vector, the kernel has FSGSBASE instructions enabled and
applications can use them.

Kernel changes:
Major changes made in the kernel are in context switch, paranoid path, and
ptrace. In a context switch, a task's FS/GS base will be secured regardless
of its selector. In the paranoid path, GS base is unconditionally
overwritten to the kernel GS base on entry and the original GS base is
restored on exit. Ptrace includes divergence of FS/GS index and base
values.

Security:
For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
on most kernel entries. Those patches are dependent on previous behaviors
that users couldn't load a kernel address into the GS base. These patches
change that assumption since the user can load any address into GS base.
The changes to the kernel entry path in this patch series take account of
the SWAPGS issue.

Updates from v7 [7]:
(1) Consider FSGSBASE when determining which Spectre SWAPGS mitigations are
    required.
(2) Fixed save_fsgs() to be aware of interrupt conditions
(3) Made selftest changes based on Andy's previous fixes and cleanups
(4) Included Andy's paranoid exit cleanup
(5) Included documentation rewritten by Thomas
(6) Carried on Thomas' edits on multiple changelogs and comments
(7) Used '[FS|GS] base' consistently, except for selftest where GSBASE has
    been already used in its test messages
(8) Dropped the READ_MSR_GSBASE macro

Updates from the last merged version [8] (that was reverted) are (1), (2)
and (7) items. Thomas' SOB has been removed, except for the documentation
patch.

Previous versions: [1-6]

[1] version 1: https://lkml.kernel.org/r/1521481767-22113-1-git-send-email-chang.seok.bae@intel.com/
[2] version 2: https://lkml.kernel.org/r/1527789525-8857-1-git-send-email-chang.seok.bae@intel.com/
[3] version 3: https://lkml.kernel.org/r/20181023184234.14025-1-chang.seok.bae@intel.com/
[4] version 4: https://lkml.kernel.org/r/20190116224849.8617-1-chang.seok.bae@intel.com/
[5] version 5: https://lkml.kernel.org/r/20190201205319.15995-1-chang.seok.bae@intel.com/
[6] version 6: https://lkml.kernel.org/r/1552680405-5265-1-git-send-email-chang.seok.bae@intel.com/
[7] version 7: https://lkml.kernel.org/r/1557309753-24073-1-git-send-email-chang.seok.bae@intel.com/
[8] previously merged point (right before reverted):
    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86-cpu-for-linus&id=697096b14444f458fb81212d1c82d7846e932455
[9] initial benchmark: https://www.phoronix.com/scan.php?page=article&item=linux-wip-fsgsbase&num=1

Andi Kleen (2):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (4):
  x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
  x86/entry/64: Clean up paranoid exit
  x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
    bit

Chang S. Bae (9):
  x86/ptrace: Prevent ptrace from clearing the FS/GS selector
  selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
    write
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
  x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
  x86/entry/64: Introduce the FIND_PERCPU_BASE macro
  x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
  x86/entry/64: Document GSBASE handling in the paranoid path
  selftests/x86/fsgsbase: Test ptracer-induced GS base write with
    FSGSBASE

Thomas Gleixner (1):
  Documentation/x86/64: Add documentation for GS/FS addressing mode

Tony Luck (1):
  x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/x86/entry_64.rst                  |   9 ++
 Documentation/x86/x86_64/fsgs.rst               | 200 ++++++++++++++++++++++++
 Documentation/x86/x86_64/index.rst              |   1 +
 arch/x86/entry/calling.h                        |  40 +++++
 arch/x86/entry/entry_64.S                       | 134 ++++++++++++----
 arch/x86/include/asm/fsgsbase.h                 |  45 ++++--
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h              |   3 +
 arch/x86/kernel/cpu/bugs.c                      |   6 +-
 arch/x86/kernel/cpu/common.c                    |  22 +++
 arch/x86/kernel/process_64.c                    | 121 ++++++++++++--
 arch/x86/kernel/ptrace.c                        |  14 +-
 tools/testing/selftests/x86/fsgsbase.c          |  24 ++-
 14 files changed, 564 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst

--
2.7.4

