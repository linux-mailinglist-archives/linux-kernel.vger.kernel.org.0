Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90028E9B27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfJ3LwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 07:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:52:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515DC204FD;
        Wed, 30 Oct 2019 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572436324;
        bh=IvB9WaMgABgRUtIw6oX6tMl7t4hkqeqx/FZY3rIjcTg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iIIi71vX7QfYWMgwNXvIcD+0ccAO0XmsByrOjGXr9OtaIYNyTOOM2K/RkY/WIqIgl
         pf9TcBWidxEjURwAxsWcKJLauBAoUeolbz0RivWFsNd0l5bWoooxk1zXdLPmDoBNTZ
         m8iDJVLR6m59ryEUtByqLHRu1Rf9tjEuEcBC+Jds=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1E6603521071; Wed, 30 Oct 2019 04:52:04 -0700 (PDT)
Date:   Wed, 30 Oct 2019 04:52:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, mchehab+samsung@kernel.org,
        bigeasy@linutronix.de, dan.carpenter@oracle.com,
        frederic@kernel.org, 1ethanhansen@gmail.com, hslester96@gmail.com,
        linuxball@gmail.com, stern@rowland.harvard.edu,
        sfr@canb.auug.org.au, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com
Subject: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits for 5.5
Message-ID: <20191030115204.GA26510@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains the following changes:

1.	Documentation updates.

	https://lore.kernel.org/lkml/20191003012741.GA12456@paulmck-ThinkPad-P72

2.	Miscellaneous fixes.

	https://lore.kernel.org/lkml/20191003013243.GA12705@paulmck-ThinkPad-P72

3.	Dynamic tick (nohz) updates, perhaps most notably changes to
	force the tick on when needed due to lengthy in-kernel execution
	on CPUs on which RCU is waiting.

	https://lore.kernel.org/lkml/20191003013834.GA12927@paulmck-ThinkPad-P72

4.	Replace rcu_swap_protected() with rcu_prepace_pointer().

	https://lore.kernel.org/lkml/20191022191136.GA25627@paulmck-ThinkPad-P72

	NOTE: Commit 81db81f82993 ("drivers/scsi: Replace
	rcu_swap_protected() with rcu_replace()") conflicts with the
	SCSI tree's d188b0675b21 ("scsi: core: Add sysfs attributes for
	VPD pages 0h and 89h"), as noted by Stephen Rothwell here:

	https://lore.kernel.org/lkml/20191029150826.38c26ef8@canb.auug.org.au

	Stephen's fixup looks good both to me and to Martin Peterson:

	https://lore.kernel.org/lkml/yq1pnif6ne7.fsf@oracle.com

5.	Torture-test updates.

	https://lore.kernel.org/lkml/20191003014710.GA13323@paulmck-ThinkPad-P72

6.	Linux-kernel memory consistency model updates.

	https://lore.kernel.org/lkml/20191003001039.GA8027@paulmck-ThinkPad-P72

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 8e655478739142a2df879907d14977721ab36c9f:

  Merge branches 'doc.2019.10.29a', 'fixes.2019.10.29a', 'nohz.2019.10.28a', 'replace.2019.10.28a', 'torture.2019.10.05a' and 'lkmm.2019.10.05a' into HEAD (2019-10-29 02:49:25 -0700)

These changes decrease the size of the kernel by about 500 lines, mostly
due to .rst files being more compact than the original .html files.
The net savings would have been greater except for the addition of some
much-needed LKMM documentation.

----------------------------------------------------------------
Alan Stern (4):
      tools/memory-model: Fix data race detection for unordered store and load
      tools/memory-model/Documentation: Fix typos in explanation.txt
      tools/memory-model/Documentation: Put redefinition of rcu-fence into explanation.txt
      tools/memory-model/Documentation: Add plain accesses and data races to explanation.txt

Chuhong Yuan (1):
      locktorture: Replace strncmp() with str_has_prefix()

Dan Carpenter (1):
      rcu: Fix uninitialized variable in nocb_gp_wait()

Ethan Hansen (2):
      rcu: Remove unused function rcutorture_record_progress()
      rcu: Remove unused variable rcu_perf_writer_state

Frederic Weisbecker (1):
      nohz: Add TICK_DEP_BIT_RCU

Joel Fernandes (Google) (8):
      rcu: Reset CPU hints when reporting a quiescent state
      Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
      Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"
      docs: rcu: Correct links referring to titles
      docs: rcu: Increase toctree to 3
      Restore docs "treewide: Rename rcu_dereference_raw_notrace() to _check()"
      Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
      doc: Update list_for_each_entry_rcu() documentation

Mauro Carvalho Chehab (1):
      docs: rcu: convert some articles from html to ReST

Paul E. McKenney (32):
      rcu: Remove unused function hlist_bl_del_init_rcu()
      time: Export tick start/stop functions for rcutorture
      rcu: Force on tick when invoking lots of callbacks
      rcutorture: Force on tick for readers and callback flooders
      stop_machine: Provide RCU quiescent state in multi_cpu_stop()
      rcu: Make CPU-hotplug removal operations enable tick
      rcutorture: Emulate dyntick aspect of userspace nohz_full sojourn
      rcutorture: Remove CONFIG_HOTPLUG_CPU=n from scenarios
      rcutorture: Separate warnings for each failure type
      rcutorture: Make in-kernel-loop testing more brutal
      rcu: Upgrade rcu_swap_protected() to rcu_replace()
      x86/kvm/pmu: Replace rcu_swap_protected() with rcu_replace()
      drm/i915: Replace rcu_swap_protected() with rcu_replace()
      drivers/scsi: Replace rcu_swap_protected() with rcu_replace()
      fs/afs: Replace rcu_swap_protected() with rcu_replace()
      bpf/cgroup: Replace rcu_swap_protected() with rcu_replace()
      net/core: Replace rcu_swap_protected() with rcu_replace()
      net/netfilter: Replace rcu_swap_protected() with rcu_replace()
      net/sched: Replace rcu_swap_protected() with rcu_replace()
      security/safesetid: Replace rcu_swap_protected() with rcu_replace()
      rcu: Force tick on for nohz_full CPUs not reaching quiescent states
      rcu: Force nohz_full tick on upon irq enter instead of exit
      rcu: Confine ->core_needs_qs accesses to the corresponding CPU
      rcu: Make kernel-mode nohz_full CPUs invoke the RCU core processing
      rcu: Several rcu_segcblist functions can be static
      workqueue: Convert for_each_wq to use built-in list check
      rcu: Ensure that ->rcu_urgent_qs is set before resched IPI
      rcu: Remove obsolete descriptions for rcu_barrier tracepoint
      rcu: Update descriptions for rcu_nocb_wake tracepoint
      rcu: Update descriptions for rcu_future_grace_period tracepoint
      rcu: Suppress levelspread uninitialized messages
      Merge branches 'doc.2019.10.29a', 'fixes.2019.10.29a', 'nohz.2019.10.28a', 'replace.2019.10.28a', 'torture.2019.10.05a' and 'lkmm.2019.10.05a' into HEAD

Sebastian Andrzej Siewior (1):
      Documentation: Rename rcu_node_context_switch() to rcu_note_context_switch()

Wolfgang M. Reimer (1):
      locking: locktorture: Do not include rwlock.h directly

 .../Design/Data-Structures/Data-Structures.html    | 1391 --------
 .../RCU/Design/Data-Structures/Data-Structures.rst | 1163 +++++++
 .../Expedited-Grace-Periods.html                   |  668 ----
 .../Expedited-Grace-Periods.rst                    |  521 +++
 .../Design/Memory-Ordering/Tree-RCU-Diagram.html   |    9 -
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |  704 ----
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |  624 ++++
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |    2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |    2 +-
 .../RCU/Design/Requirements/Requirements.html      | 3401 --------------------
 .../RCU/Design/Requirements/Requirements.rst       | 2704 ++++++++++++++++
 Documentation/RCU/index.rst                        |    7 +-
 Documentation/RCU/lockdep.txt                      |   18 +-
 Documentation/RCU/whatisRCU.txt                    |   14 +-
 arch/x86/kvm/pmu.c                                 |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |    2 +-
 drivers/scsi/scsi.c                                |    4 +-
 drivers/scsi/scsi_sysfs.c                          |    8 +-
 fs/afs/vl_list.c                                   |    4 +-
 include/linux/rculist_bl.h                         |   28 -
 include/linux/rcupdate.h                           |   18 +
 include/linux/rcutiny.h                            |    1 +
 include/linux/rcutree.h                            |    1 +
 include/linux/tick.h                               |    7 +-
 include/trace/events/rcu.h                         |   47 +-
 include/trace/events/timer.h                       |    3 +-
 kernel/bpf/cgroup.c                                |    4 +-
 kernel/locking/locktorture.c                       |    9 +-
 kernel/rcu/rcu.h                                   |    4 +-
 kernel/rcu/rcu_segcblist.c                         |    6 +-
 kernel/rcu/rcuperf.c                               |   16 -
 kernel/rcu/rcutorture.c                            |   44 +-
 kernel/rcu/tree.c                                  |   73 +-
 kernel/rcu/tree.h                                  |    1 +
 kernel/rcu/tree_plugin.h                           |    2 +-
 kernel/stop_machine.c                              |    1 +
 kernel/time/tick-sched.c                           |   11 +
 kernel/workqueue.c                                 |   10 +-
 net/core/dev.c                                     |    4 +-
 net/core/sock_reuseport.c                          |    4 +-
 net/netfilter/nf_tables_api.c                      |    5 +-
 net/sched/act_api.c                                |    2 +-
 net/sched/act_csum.c                               |    4 +-
 net/sched/act_ct.c                                 |    3 +-
 net/sched/act_ctinfo.c                             |    4 +-
 net/sched/act_ife.c                                |    2 +-
 net/sched/act_mirred.c                             |    4 +-
 net/sched/act_mpls.c                               |    2 +-
 net/sched/act_police.c                             |    6 +-
 net/sched/act_sample.c                             |    4 +-
 net/sched/act_skbedit.c                            |    4 +-
 net/sched/act_tunnel_key.c                         |    4 +-
 net/sched/act_vlan.c                               |    2 +-
 security/safesetid/securityfs.c                    |    4 +-
 tools/memory-model/Documentation/explanation.txt   |  602 +++-
 tools/memory-model/linux-kernel.cat                |    2 +-
 .../selftests/rcutorture/configs/rcu/TASKS03       |    3 -
 .../selftests/rcutorture/configs/rcu/TREE02        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE04        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE06        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE08        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE09        |    3 -
 .../selftests/rcutorture/configs/rcu/TRIVIAL       |    3 -
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    1 -
 64 files changed, 5830 insertions(+), 6390 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
 create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
 delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
 create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
 create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
 delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
 create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst
