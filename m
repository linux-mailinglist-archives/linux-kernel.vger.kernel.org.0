Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2916517049D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:42:32 -0500
Received: from foss.arm.com ([217.140.110.172]:38952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgBZQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:42:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 199864B2;
        Wed, 26 Feb 2020 08:42:29 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87CF13F819;
        Wed, 26 Feb 2020 08:42:27 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: defconfig: enable CONFIG_SCHED_SMT
Date:   Wed, 26 Feb 2020 16:41:18 +0000
Message-Id: <20200226164118.6405-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226164118.6405-1-valentin.schneider@arm.com>
References: <20200226164118.6405-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (CFS) scheduler has some extra logic catering to systems with SMT, but
that logic won't be compiled in unless the above config is set.

Note that the SMT-centric codepaths are gated by the sched_smt_present
static key, and the SMT sched_domains will only survive if the platform has
SMT. As such, the only impact on !SMT platforms should be a slightly
bigger kernel - no behavioural change.

Distro kernels already enable it, which makes sense since there already are
things like ThunderX2 out in the wild. Enable it for the defconfig.

Some deltas
===========

FWIW my ELF symbol table diff looks something like this:

  NAME                                BEFORE    AFTER     DELTA
  update_sd_lb_stats.constprop.135    0         1864      +1864
  find_idlest_group.isra.115          0         1808      +1808
  update_numa_stats.isra.121          0         628       +628
  select_task_rq_fair                 3236      3732      +496
  compute_energy.isra.112             0         420       +420
  score_nearby_nodes.part.120         0         380       +380
  __update_idle_core                  0         232       +232
  nohz_balance_exit_idle.part.127     0         216       +216
  sched_slice.isra.99                 0         172       +172
  update_load_avg.part.107            0         116       +116
  wakeup_preempt_entity.isra.101      0         92        +92
  sched_cpu_activate                  340       396       +56
  pick_next_task_idle                 8         56        +48
  sched_cpu_deactivate                252       292       +40
  show_smt_active                     44        80        +36
  cpu_smt_mask                        0         28        +28
  set_next_task_idle                  4         32        +28
  task_numa_work                      680       692       +12
  cpu_smt_flags                       0         8         +8
  enqueue_task_fair                   2608      2612      +4
  wakeup_preempt_entity.isra.104      92        0         -92
  update_load_avg                     1028      932       -96
  task_numa_migrate                   1824      1728      -96
  sched_slice.isra.102                172       0         -172
  nohz_balance_exit_idle.part.130     216       0         -216
  task_numa_find_cpu                  2116      1868      -248
  score_nearby_nodes.part.123         380       0         -380
  compute_energy.isra.115             420       0         -420
  update_numa_stats.isra.124          472       0         -472
  find_idlest_group.isra.118          1808      0         -1808
  update_sd_lb_stats.constprop.138    1864      0         -1864
  ------------------------------------------------------------------
  DELTA SUM                                               +820

As for the sched_domains, this is on a hikey960:

before:
  $ cat /proc/sys/kernel/sched_domain/cpu*/domain*/name | sort | uniq
  DIE
  MC

after:
  $ cat /proc/sys/kernel/sched_domain/cpu*/domain*/name | sort | uniq
  DIE
  MC

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 905109f6814f..3e75007f6592 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -62,6 +62,7 @@ CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
+CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
-- 
2.24.0

