Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D64168935
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBUVZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgBUVZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:15 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59195206EF;
        Fri, 21 Feb 2020 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320315;
        bh=+XroxI3EJiMSxkRKHu1Xniyh64pp6vnvlxd5aw4FSeI=;
        h=From:To:Subject:Date:From;
        b=MKRIl7DAFUtGhujFLG+R/NORW+MyxUJsYvtRkAFj5K9jZHO+u9jV/nhjHPOrJgYyg
         AdSIBFr5547SDWR5LWQaG2+YHndKeVSyeqSBlPn3VGoTiWB0DgapN69MwST5AGeXPh
         T2rmdDRPVbOjUz3NmwuzK4fT779k+RSW2L1OiK9c=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 00/25] Linux v4.14.170-rt75-rc1
Date:   Fri, 21 Feb 2020 15:24:28 -0600
Message-Id: <cover.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.170-rt75-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-02-28.

To build 4.14.170-rt75-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.170.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.170-rt75-rc1.patch.xz

You can also build from 4.14.170-rt74 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.170-rt74-rt75-rc1.patch.xz


Enjoy,

-- Tom


Joe Korty (1):
  Fix wrong-variable use in irq_set_affinity_notifier

Julien Grall (1):
  lib/ubsan: Don't seralize UBSAN report

Juri Lelli (1):
  sched/deadline: Ensure inactive_timer runs in hardirq context

Liu Haitao (1):
  kmemleak: Change the lock of kmemleak_object to raw_spinlock_t

Matt Fleming (1):
  mm/memcontrol: Move misplaced local_unlock_irqrestore()

Peter Zijlstra (1):
  locking/rtmutex: Clean ->pi_blocked_on in the error case

Scott Wood (5):
  sched: migrate_dis/enable: Use sleeping_lock…() to annotate sleeping
    points
  sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
  sched: Remove dead __migrate_disabled() check
  sched: migrate disable: Protect cpus_ptr with lock
  sched: migrate_enable: Use select_fallback_rq()

Sebastian Andrzej Siewior (11):
  x86: preempt: Check preemption level before looking at lazy-preempt
  i2c: hix5hd2: Remove IRQF_ONESHOT
  i2c: exynos5: Remove IRQF_ONESHOT
  futex: Make the futex_hash_bucket spinlock_t again and bring back its
    old state
  Revert "ARM: Initialize split page table locks for vector page"
  x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
  locking: Make spinlock_t and rwlock_t a RCU section on RT
  userfaultfd: Use a seqlock instead of seqcount
  kmemleak: Cosmetic changes
  smp: Use smp_cond_func_t as type for the conditional function
  locallock: Include header for the `current' macro

Thomas Gleixner (1):
  sched: Provide migrate_disable/enable() inlines

Tom Zanussi (1):
  Linux 4.14.170-rt75-rc1

Waiman Long (1):
  lib/smp_processor_id: Don't use cpumask_equal()

 arch/arm/kernel/process.c           |  24 ----
 arch/x86/include/asm/fpu/internal.h |   2 +-
 arch/x86/include/asm/preempt.h      |   2 +
 drivers/i2c/busses/i2c-exynos5.c    |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c    |   3 +-
 fs/userfaultfd.c                    |  12 +-
 include/linux/locallock.h           |   1 +
 include/linux/preempt.h             |  26 +++-
 include/linux/smp.h                 |   6 +-
 kernel/cpu.c                        |   2 +
 kernel/futex.c                      | 231 ++++++++++++++++++++----------------
 kernel/irq/manage.c                 |   2 +-
 kernel/locking/rtmutex.c            | 114 ++++++++++++++----
 kernel/locking/rtmutex_common.h     |   3 +
 kernel/locking/rwlock-rt.c          |   6 +
 kernel/sched/core.c                 |  43 +++----
 kernel/sched/deadline.c             |   4 +-
 kernel/smp.c                        |   5 +-
 kernel/up.c                         |   5 +-
 lib/smp_processor_id.c              |   2 +-
 lib/ubsan.c                         |  76 +++++-------
 localversion-rt                     |   2 +-
 mm/kmemleak.c                       |  90 +++++++-------
 mm/memcontrol.c                     |   2 +-
 24 files changed, 370 insertions(+), 297 deletions(-)

-- 
2.14.1

