Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79CF960C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKLQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 11:53:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:32944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfKLQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 357C9B1B4;
        Tue, 12 Nov 2019 16:53:14 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/33] exception cleanup, syscall in C and !COMPAT
Date:   Tue, 12 Nov 2019 17:51:58 +0100
Message-Id: <cover.1573576649.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is merge of https://patchwork.ozlabs.org/cover/1162376/ (except two
last experimental patches) and
https://patchwork.ozlabs.org/patch/1162079/ rebased on top of master.

There was minor conflict in Makefile in the latter series.

Thanks

Michal

Michal Suchanek (8):
  powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/perf: consolidate read_user_stack_32
  powerpc/perf: consolidate valid_user_sp
  powerpc/perf: remove current_is_64bit()
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.
  powerpc/perf: split callchain.c by bitness

Nicholas Piggin (25):
  powerpc/64s/exception: Introduce INT_DEFINE parameter block for code
    generation
  powerpc/64s/exception: Add GEN_COMMON macro that uses INT_DEFINE
    parameters
  powerpc/64s/exception: Add GEN_KVM macro that uses INT_DEFINE
    parameters
  powerpc/64s/exception: Expand EXC_COMMON and EXC_COMMON_ASYNC macros
  powerpc/64s/exception: Move all interrupt handlers to new style code
    gen macros
  powerpc/64s/exception: Remove old INT_ENTRY macro
  powerpc/64s/exception: Remove old INT_COMMON macro
  powerpc/64s/exception: Remove old INT_KVM_HANDLER
  powerpc/64s/exception: Add ISIDE option
  powerpc/64s/exception: move real->virt switch into the common handler
  powerpc/64s/exception: move soft-mask test to common code
  powerpc/64s/exception: move KVM test to common code
  powerpc/64s/exception: remove confusing IEARLY option
  powerpc/64s/exception: remove the SPR saving patch code macros
  powerpc/64s/exception: trim unused arguments from KVMTEST macro
  powerpc/64s/exception: hdecrementer avoid touching the stack
  powerpc/64s/exception: re-inline some handlers
  powerpc/64s/exception: Clean up SRR specifiers
  powerpc/64s/exception: add more comments for interrupt handlers
  powerpc/64s/exception: only test KVM in SRR interrupts when PR KVM is
    supported
  powerpc/64s/exception: soft nmi interrupt should not use
    ret_from_except
  powerpc/64: system call remove non-volatile GPR save optimisation
  powerpc/64: system call implement the bulk of the logic in C
  powerpc/64s: interrupt return in C
  powerpc/64s/exception: remove lite interrupt return

 arch/powerpc/Kconfig                          |    5 +-
 arch/powerpc/include/asm/asm-prototypes.h     |   11 -
 .../powerpc/include/asm/book3s/64/kup-radix.h |   24 +-
 arch/powerpc/include/asm/cputime.h            |   24 +
 arch/powerpc/include/asm/exception-64s.h      |    4 -
 arch/powerpc/include/asm/hw_irq.h             |    4 +
 arch/powerpc/include/asm/ptrace.h             |    3 +
 arch/powerpc/include/asm/signal.h             |    3 +
 arch/powerpc/include/asm/switch_to.h          |   11 +
 arch/powerpc/include/asm/thread_info.h        |    4 +-
 arch/powerpc/include/asm/time.h               |    4 +-
 arch/powerpc/include/asm/unistd.h             |    1 +
 arch/powerpc/kernel/Makefile                  |    9 +-
 arch/powerpc/kernel/entry_64.S                |  880 ++------
 arch/powerpc/kernel/exceptions-64e.S          |  254 ++-
 arch/powerpc/kernel/exceptions-64s.S          | 1937 ++++++++++++-----
 arch/powerpc/kernel/process.c                 |   89 +-
 arch/powerpc/kernel/signal.c                  |  144 +-
 arch/powerpc/kernel/signal.h                  |    2 -
 arch/powerpc/kernel/signal_32.c               |  140 --
 arch/powerpc/kernel/syscall_64.c              |  348 +++
 arch/powerpc/kernel/syscalls/syscall.tbl      |   22 +-
 arch/powerpc/kernel/systbl.S                  |    9 +-
 arch/powerpc/kernel/time.c                    |    9 -
 arch/powerpc/kernel/vdso.c                    |    3 +-
 arch/powerpc/kernel/vector.S                  |    2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |   11 -
 arch/powerpc/kvm/book3s_segment.S             |    7 -
 arch/powerpc/perf/Makefile                    |    5 +-
 arch/powerpc/perf/callchain.c                 |  387 +---
 arch/powerpc/perf/callchain.h                 |   25 +
 arch/powerpc/perf/callchain_32.c              |  197 ++
 arch/powerpc/perf/callchain_64.c              |  178 ++
 fs/read_write.c                               |    3 +-
 34 files changed, 2794 insertions(+), 1965 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscall_64.c
 create mode 100644 arch/powerpc/perf/callchain.h
 create mode 100644 arch/powerpc/perf/callchain_32.c
 create mode 100644 arch/powerpc/perf/callchain_64.c

-- 
2.23.0

