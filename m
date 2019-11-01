Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D2ECAF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKAWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:11:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38835 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:11:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id d126so8451988pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QMYlUo6go1QaBsrZ04QyWd4mPltUOCdHxfrp1U4piPI=;
        b=pA7VrUMFgvackUgMe/piXoHPkTAs+b/FFKd8gPmFfcrm/KLP7Y+qoLxKMb3126U4e4
         sdc0PRcooZZRR7RfeEW8vSmh8Z+iN5SpQ3vrACcpfafjhRMOxaG4DcNMaMQ/jH+YMFTQ
         r/J7E7luA3G1eVcRLIosgkLfpTwkGRI4H5MiJjQGC5qknsQF0D95Ifddmh7yZgfVY06Y
         lGysSOFEA2svnEQDD4F+BF17NRGzU1zUsLAcHo3QsdOsLgpA4MzE8Wua0beo2OciXAbj
         hH7VxVMfFSL3zwxFfUv0LvZAmYLX9knJ/S/TZ4mdE2y8p/EH4Vk5EufFFRO6LzQQem00
         RNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QMYlUo6go1QaBsrZ04QyWd4mPltUOCdHxfrp1U4piPI=;
        b=my3HOxUaRa7ClvbDLQZTZLgWg7sGPrKPSjLFqFhg9OCA/dmcOZKh6Xd5RzggxEo6Rd
         OSseH00StJRkb42JYBeMU/l6tdHuXMJlM0OkHj0DGDK6B46Pxynx9nM8wNKVSCSS5UdN
         HJrsEcV097vPEx+JV6tfgsyRukIG3JvZBiYg+AW2IjD9ev3aJ8oT7E28Co7UFZ1Zxi3i
         1+HMscM86yEENI2/tq33z6btNQ3YZ/dfaaOfuUJgORtYHq6L4xgudbWto0Nm02whBhlO
         ApGwUnrNrh96thPdDIKsAEHBmMHCGx77QrEBJAlTGIYOMRzQ5M9PBtXeboJ4zsXfvG/e
         /ECA==
X-Gm-Message-State: APjAAAU0fnifStKIByLXfd9iGcyNBUnC9Wuw3jX2WLTtofhwikMeT6F4
        hgc4v1ziC+R5/SNnVmcaHQEdxhq5DHnGQ9aBdaY=
X-Google-Smtp-Source: APXvYqzTngnWtjbqEG3gQE3K9LX8wVZzWKEGtYb0s66XOiVH27Hv4t/hwOe2zbXaGKcIrGCYHg0Cwu16o68haAeZgf4=
X-Received: by 2002:a65:64d4:: with SMTP id t20mr15535375pgv.181.1572646314485;
 Fri, 01 Nov 2019 15:11:54 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:33 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 00/17] add support for Clang's Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clang's Shadow Call Stack
(SCS) mitigation, which uses a separately allocated shadow stack
to protect against return address overwrites. More information
can be found here:

  https://clang.llvm.org/docs/ShadowCallStack.html

SCS provides better protection against traditional buffer
overflows than CONFIG_STACKPROTECTOR_*, but it should be noted
that SCS security guarantees in the kernel differ from the ones
documented for user space. The kernel must store addresses of
shadow stacks used by other tasks and interrupt handlers in
memory, which means an attacker capable reading and writing
arbitrary memory may be able to locate them and hijack control
flow by modifying shadow stacks that are not currently in use.

SCS is currently supported only on arm64, where the compiler
requires the x18 register to be reserved for holding the current
task's shadow stack pointer. Because of this, the series includes
patches from Ard to remove x18 usage from assembly code.

With -fsanitize=shadow-call-stack, the compiler injects
instructions to all non-leaf C functions to store the return
address to the shadow stack, and unconditionally load it again
before returning. As a result, SCS is currently incompatible
with features that rely on modifying function return addresses
to alter control flow, such as function graph tracing and
kretprobes, although it may be possible to later change these
features to modify the shadow stack instead. A copy of the return
address is still kept in the kernel stack for compatibility with
stack unwinding, for example.

SCS has a minimal performance overhead, but allocating
shadow stacks increases kernel memory usage. The feature is
therefore mostly useful on hardware that lacks support for PAC
instructions.

Changes in v4:
 - Fixed authorship for Ard's patches
 - Added missing commit messages
 - Commented code that clears SCS from thread_info
 - Added a comment about SCS_END_MAGIC being non-canonical

Changes in v3:
 - Switched to filter-out for removing SCS flags in Makefiles
 - Changed the __noscs attribute to use __no_sanitize__("...")
   instead of no_sanitize("...")
 - Cleaned up inline function definitions and moved task_scs()
   into a macro
 - Cleaned up scs_free() and scs_magic()
 - Moved SCS initialization into dup_task_struct() and removed
   the now unused scs_task_init()
 - Added comments to __scs_base() and scs_task_reset() to better
   document design choices
 - Changed copy_page to make the offset and bias explicit

Changes in v2:
 - Changed Ard's KVM patch to use x29 instead of x18 for the
   guest context, which makes restore_callee_saved_regs cleaner
 - Updated help text (and commit messages) to point out
   differences in security properties compared to user space SCS
 - Cleaned up config options: removed the ROP protection choice,
   replaced the CC_IS_CLANG dependency with an arch-specific
   cc-option test, and moved disabling of incompatible config
   options to an arch-specific Kconfig
 - Added CC_FLAGS_SCS, which are filtered out where needed
   instead of using DISABLE_SCS
 - Added a __has_feature guard around __noscs for older clang
   versions

Ard Biesheuvel (3):
  arm64/lib: copy_page: avoid x18 register in assembler code
  arm64: kvm: stop treating register x18 as caller save
  arm64: kernel: avoid x18 __cpu_soft_restart

Sami Tolvanen (14):
  arm64: mm: avoid x18 in idmap_kpti_install_ng_mappings
  add support for Clang's Shadow Call Stack (SCS)
  scs: add accounting
  scs: add support for stack usage debugging
  kprobes: fix compilation without CONFIG_KRETPROBES
  arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
  arm64: disable kretprobes with SCS
  arm64: disable function graph tracing with SCS
  arm64: reserve x18 from general allocation with SCS
  arm64: preserve x18 when CPU is suspended
  arm64: efi: restore x18 if it was corrupted
  arm64: vdso: disable Shadow Call Stack
  arm64: disable SCS for hypervisor code
  arm64: implement Shadow Call Stack

 Makefile                             |   6 +
 arch/Kconfig                         |  33 ++++
 arch/arm64/Kconfig                   |   9 +-
 arch/arm64/Makefile                  |   4 +
 arch/arm64/include/asm/scs.h         |  37 +++++
 arch/arm64/include/asm/stacktrace.h  |   4 +
 arch/arm64/include/asm/suspend.h     |   2 +-
 arch/arm64/include/asm/thread_info.h |   3 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/cpu-reset.S        |   4 +-
 arch/arm64/kernel/efi-rt-wrapper.S   |   7 +-
 arch/arm64/kernel/entry.S            |  28 ++++
 arch/arm64/kernel/head.S             |   9 ++
 arch/arm64/kernel/irq.c              |   2 +
 arch/arm64/kernel/probes/kprobes.c   |   2 +
 arch/arm64/kernel/process.c          |   2 +
 arch/arm64/kernel/scs.c              |  39 +++++
 arch/arm64/kernel/smp.c              |   4 +
 arch/arm64/kernel/vdso/Makefile      |   2 +-
 arch/arm64/kvm/hyp/Makefile          |   3 +
 arch/arm64/kvm/hyp/entry.S           |  41 +++--
 arch/arm64/lib/copy_page.S           |  38 ++---
 arch/arm64/mm/proc.S                 |  73 +++++----
 drivers/base/node.c                  |   6 +
 fs/proc/meminfo.c                    |   4 +
 include/linux/compiler-clang.h       |   6 +
 include/linux/compiler_types.h       |   4 +
 include/linux/mmzone.h               |   3 +
 include/linux/scs.h                  |  57 +++++++
 init/init_task.c                     |   8 +
 kernel/Makefile                      |   1 +
 kernel/fork.c                        |   9 ++
 kernel/kprobes.c                     |  38 ++---
 kernel/sched/core.c                  |   2 +
 kernel/sched/sched.h                 |   1 +
 kernel/scs.c                         | 227 +++++++++++++++++++++++++++
 mm/page_alloc.c                      |   6 +
 mm/vmstat.c                          |   3 +
 39 files changed, 634 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c


base-commit: 0dbe6cb8f7e05bc9611602ef45980a6c57b245a3
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

