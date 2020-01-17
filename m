Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780F5141007
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAQRla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 12:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQRl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7E9206D5;
        Fri, 17 Jan 2020 17:41:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVcd-000QM1-Ea; Fri, 17 Jan 2020 12:41:27 -0500
Message-Id: <20200117174111.282847363@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 00/32] Linux 4.19.94-rt39-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.94-rt39-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 1/20/2020.

Enjoy,

-- Steve


To build 4.19.94-rt39-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.94.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-rt39-rc1.patch.xz

You can also build from 4.19.94-rt38 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.94-rt38-rt39-rc1.patch.xz


Changes from 4.19.94-rt38:

---


Clark Williams (1):
      thermal/x86_pkg_temp: make pkg_temp_lock a raw spinlock

Daniel Wagner (1):
      lib/smp_processor_id: Adjust check_preemption_disabled()

Julien Grall (4):
      hrtimer: Use READ_ONCE to access timer->base in hrimer_grab_expiry_lock()
      hrtimer: Don't grab the expiry lock for non-soft hrtimer
      hrtimer: Prevent using hrtimer_grab_expiry_lock() on migration_base
      lib/ubsan: Don't seralize UBSAN report

Juri Lelli (1):
      sched/deadline: Ensure inactive_timer runs in hardirq context

Liu Haitao (1):
      kmemleak: Change the lock of kmemleak_object to raw_spinlock_t

Peter Zijlstra (1):
      locking/rtmutex: Clean ->pi_blocked_on in the error case

Scott Wood (7):
      sched: migrate_dis/enable: Use sleeping_lock…() to annotate sleeping points
      sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
      sched: Remove dead __migrate_disabled() check
      sched: migrate disable: Protect cpus_ptr with lock
      sched: migrate_enable: Use select_fallback_rq()
      sched: Lazy migrate_disable processing
      sched: migrate_enable: Use stop_one_cpu_nowait()

Sebastian Andrzej Siewior (13):
      i2c: exynos5: Remove IRQF_ONESHOT
      i2c: hix5hd2: Remove IRQF_ONESHOT
      dma-buf: Use seqlock_t instread disabling preemption
      x86: preempt: Check preemption level before looking at lazy-preempt
      hrtimer: Add a missing bracket and hide `migration_base' on !SMP
      posix-timers: Unlock expiry lock in the early return
      futex: Make the futex_hash_bucket spinlock_t again and bring back its old state
      Revert "cpufreq: drop K8's driver from beeing selected"
      Revert "ARM: Initialize split page table locks for vector page"
      x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
      locking: Make spinlock_t and rwlock_t a RCU section on RT
      sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
      sched: migrate_enable: Busy loop until the migration request is completed

Steven Rostedt (VMware) (1):
      Linux 4.19.94-rt39-rc1

Thomas Gleixner (1):
      KVM: arm/arm64: Let the timer expire in hardirq context on RT

Waiman Long (1):
      lib/smp_processor_id: Don't use cpumask_equal()

----
 arch/arm/kernel/process.c                        |  24 ---
 arch/x86/include/asm/fpu/internal.h              |   2 +-
 arch/x86/include/asm/preempt.h                   |   2 +
 drivers/cpufreq/Kconfig.x86                      |   2 +-
 drivers/dma-buf/dma-buf.c                        |   8 +-
 drivers/dma-buf/reservation.c                    |  43 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |   6 +-
 drivers/gpu/drm/i915/i915_gem.c                  |  10 +-
 drivers/i2c/busses/i2c-exynos5.c                 |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c                 |   3 +-
 drivers/thermal/x86_pkg_temp_thermal.c           |  24 +--
 include/linux/cpu.h                              |   4 -
 include/linux/reservation.h                      |   4 +-
 include/linux/sched.h                            |  11 +-
 include/linux/stop_machine.h                     |   2 +
 init/init_task.c                                 |   4 +
 kernel/cpu.c                                     | 103 ++++------
 kernel/futex.c                                   | 230 +++++++++++++----------
 kernel/locking/rtmutex.c                         | 114 ++++++++---
 kernel/locking/rtmutex_common.h                  |   3 +
 kernel/locking/rwlock-rt.c                       |   6 +
 kernel/sched/core.c                              | 211 +++++++++------------
 kernel/sched/deadline.c                          |   4 +-
 kernel/sched/sched.h                             |   4 +
 kernel/stop_machine.c                            |   7 +-
 kernel/time/hrtimer.c                            |  14 +-
 kernel/time/posix-cpu-timers.c                   |   4 +-
 lib/smp_processor_id.c                           |   7 +-
 lib/ubsan.c                                      |  64 +++----
 localversion-rt                                  |   2 +-
 mm/kmemleak.c                                    |  72 +++----
 virt/kvm/arm/arch_timer.c                        |   6 +-
 32 files changed, 512 insertions(+), 492 deletions(-)
