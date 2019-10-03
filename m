Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB630C9658
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfJCBl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCBl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:41:56 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE28222BE;
        Thu,  3 Oct 2019 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066915;
        bh=bzqrGPwyvYmyxv4cMeaBL5r00na4FxhLczouqFPG5Fc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QhjP1X3vwPFLuxkX2H+tbj8Ufauau79bS4svw1wkRtCEC7yzCd31Yf8PReBKbKASS
         E3M9IAjoRvU13CVH5DEepuvBaB+MAc/m3irRsmqzEFc7T/Zbn7j/XddWcgNqzxyYh4
         yNI2vuhIieOlIlUbwDa08b9aMgdhOwvucj0bXtdI=
Date:   Wed, 2 Oct 2019 18:41:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Replace rcu_swap_protected() for v5.5
Message-ID: <20191003014153.GA13156@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series replaces uses of rcu_swap_protected() with rcu_replace().
A later patch will remove rcu_swap_protected().

1.	Upgrade rcu_swap_protected() to rcu_replace().

2-9.	Replace calls to rcu_swap_protected() with rcu_replace().

							Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kvm/pmu.c                          |    4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_context.c |    2 +-
 drivers/scsi/scsi.c                         |    4 ++--
 drivers/scsi/scsi_sysfs.c                   |    8 ++++----
 fs/afs/vl_list.c                            |    4 ++--
 include/linux/rcupdate.h                    |   18 ++++++++++++++++++
 kernel/bpf/cgroup.c                         |    4 ++--
 net/core/dev.c                              |    4 ++--
 net/core/sock_reuseport.c                   |    4 ++--
 net/netfilter/nf_tables_api.c               |    5 +++--
 net/sched/act_api.c                         |    2 +-
 net/sched/act_csum.c                        |    4 ++--
 net/sched/act_ct.c                          |    2 +-
 net/sched/act_ctinfo.c                      |    4 ++--
 net/sched/act_ife.c                         |    2 +-
 net/sched/act_mirred.c                      |    4 ++--
 net/sched/act_mpls.c                        |    2 +-
 net/sched/act_police.c                      |    6 +++---
 net/sched/act_skbedit.c                     |    4 ++--
 net/sched/act_tunnel_key.c                  |    4 ++--
 net/sched/act_vlan.c                        |    2 +-
 21 files changed, 56 insertions(+), 37 deletions(-)
