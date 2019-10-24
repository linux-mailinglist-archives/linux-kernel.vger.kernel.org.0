Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A00E2770
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392867AbfJXApg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 20:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392229AbfJXApg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 20:45:36 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDE82084B;
        Thu, 24 Oct 2019 00:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571877935;
        bh=OCnHofUdhqX5/lVrpGj0gGxJBg5HNLhVPUUgH1rUszk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdJrRDXbENBRwZ3Sp4Asn4pCaapfy94wQ6A0bq9QEvYWnRfo0/kaq69Gf2fqA32Tg
         7rg/HgRvuPVyPYH5vBv7FPscEH4NijTk3sX89tz/KdT7fRTrW2+OfjhAe3O2Jdok8j
         7Na7pzNpwGBaJiGmTmXPsGqUkKaiPY7YvnCQ3SiE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] sched/nohz: Make kcpustat's CPUTIME_SYSTEM vtime aware
Date:   Thu, 24 Oct 2019 02:45:30 +0200
Message-Id: <20191024004530.7037-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Peter, 

Please pull the nohz/kcpustat-for-tip branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat-for-tip

HEAD: e179e89320c53a96c5d585af38126cfb124da789

Thanks,
	Frederic
---

Frederic Weisbecker (14):
      sched/vtime: Record CPU under seqcount for kcpustat needs
      sched/cputime: Add vtime idle task state
      sched/cputime: Add vtime guest task state
      context_tracking: Remove context_tracking_active()
      context_tracking: s/context_tracking_is_enabled/context_tracking_enabled()
      context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
      context_tracking: Introduce context_tracking_enabled_cpu()
      sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
      sched/vtime: Introduce vtime_accounting_enabled_cpu()
      context_tracking: Check static key on context_tracking_enabled_*cpu()
      sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM
      procfs: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      cpufreq: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      leds: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM


 arch/x86/entry/calling.h                |   2 +-
 drivers/cpufreq/cpufreq.c               |   2 +-
 drivers/leds/trigger/ledtrig-activity.c |   2 +-
 fs/proc/stat.c                          |   4 +-
 include/linux/context_tracking.h        |  26 +++----
 include/linux/context_tracking_state.h  |  21 +++---
 include/linux/kernel_stat.h             |  11 +++
 include/linux/sched.h                   |   9 ++-
 include/linux/tick.h                    |   2 +-
 include/linux/vtime.h                   |  23 +++---
 kernel/context_tracking.c               |   6 +-
 kernel/sched/cputime.c                  | 119 ++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c                |   2 +-
 13 files changed, 172 insertions(+), 57 deletions(-)
