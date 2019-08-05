Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A853981663
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfHEKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 06:06:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33124 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:06:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so83900614wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KHSDHJMmRR6+MAepna6mVzgtfSoIEzKmWS4o8nXlsKc=;
        b=SWu4dMFKHveoFPIW0bxi5L4TVlaL6qZiph7igNRLaaJWzrfCaBtdKuVoZAgnT0WG5+
         Zhx3RKZHhsj4RwZLfa6WNkoVf1evGZmRxcUfPVvrdhK5fLc/t5u10WXzAmGrMtbskKhA
         D4hufCVbKEp7GpUp7Np5wKbbrQzN1W9esvTXTjUrvBoD6TmOxmBI+PoAsUmryn2uk8qN
         chE2Mm4v1jsd6hmkiI8Zbo1JWve+8SfrOzkMdWrENVQ3zrsYHSr0NmiamUQmoofL2BeF
         OirVn8G5XR9uWAxm8NsgmUbkM0Yf6qLTsKvd1kjXPVfHFshiQHe/aD5NeoQbm26KJxsf
         Isnw==
X-Gm-Message-State: APjAAAUu9ztTs9KQpkHdKTt0y6GJIB5A6q3CThu8/01nORs/LDJeQttR
        q1fe9ABAF+JLlIg72ZHLkunkvA==
X-Google-Smtp-Source: APXvYqzS7rfxkH1QK7P1OTYH2JCFz0B6tRjCy+fpaZyc9HZj3VCgRxllujcrgSAWFdZYdsw/x/gMGA==
X-Received: by 2002:adf:deca:: with SMTP id i10mr20675715wrn.313.1564999609568;
        Mon, 05 Aug 2019 03:06:49 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id 91sm170413277wrp.3.2019.08.05.03.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 03:06:48 -0700 (PDT)
Date:   Mon, 5 Aug 2019 12:06:46 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RT BUG] isolcpus causes sleeping function called from invalid
 context (4.19.59-rt24)
Message-ID: <20190805100646.GH14724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Booting 4.19.59-rt24 with debug options enabled (DEBUG_ATOMIC_SLEEP) I
noticed the following splat (edited for clarity):

--->8---
 Linux version 4.19.59-rt24 (...) (...) #2 SMP PREEMPT RT Mon Aug 5 05:23:26 EDT 2019
 Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-4.19.59-rt24 ... skew_tick=1 isolcpus=9-35 intel_pstate=disable nosoftlockup nohz=on nohz_full=9-35 rcu_nocbs=9-35
 ...
 smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz (family: 0x6, model: 0x3f, stepping: 0x2)
 ...
 smp: Bringing up secondary CPUs ...
 x86: Booting SMP configuration:
 .... node  #0, CPUs:        #1
   #2
   #3
   #4
   #5
   #6
   #7
   #8
 .... node  #1, CPUs:    #9
 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:967
 in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/9
 1 lock held by swapper/9/0:
  #0: 00000000eb141bd9 ((pendingb_lock).lock){+.+.}, at: queue_delayed_work_on+0x103/0x580
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>]
 hardirqs last disabled at (0): [<ffffffffadda7bf8>] copy_process.part.18+0x1928/0x7250
 softirqs last  enabled at (0): [<ffffffffadda7c94>] copy_process.part.18+0x19c4/0x7250
 softirqs last disabled at (0): [<0000000000000000>]           (null)
 Preemption disabled at:
 [<ffffffffadcbdaef>] start_secondary+0x11f/0x530
 CPU: 9 PID: 0 Comm: swapper/9 Not tainted 4.19.59-rt24 #2
 Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/17/2018
 Call Trace:
  dump_stack+0x9a/0xf0
  ___might_sleep.cold.57+0x6a/0x7c
  rt_spin_lock+0x75/0x90
  ? queue_delayed_work_on+0x103/0x580
  queue_delayed_work_on+0x103/0x580
  sched_cpu_starting+0x28c/0x370
  ? sched_cpu_deactivate+0x2b0/0x2b0
  cpuhp_invoke_callback+0x1d0/0x1dc0
  ? _raw_spin_unlock_irqrestore+0x4a/0xf0
  notify_cpu_starting+0x117/0x190
  start_secondary+0x2be/0x530
  ? set_c+0x27c0/0x27c0
  secondary_startup_64+0xb6/0xc0
  #10
  #11
  #12
  #13
  #14
  #15
  #16
  #17
 .... node  #0, CPUs:   #18
  #19
  #20
  #21
  #22
  #23
  #24
  #25
  #26
 .... node  #1, CPUs:   #27
  #28
 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:967
 in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/28
 1 lock held by swapper/28/0:
  #0: 0000000004707c3e ((pendingb_lock).lock){+.+.}, at: queue_delayed_work_on+0x103/0x580
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>]           (null)
 hardirqs last disabled at (0): [<ffffffffadda7bf8>] copy_process.part.18+0x1928/0x7250
 softirqs last  enabled at (0): [<ffffffffadda7c94>] copy_process.part.18+0x19c4/0x0
 softirqs last disabled at (0): [<0000000000000000>]           (null)
 Preemption disabled at:
 [<ffffffffadcbdaef>] start_secondary+0x11f/0x530
 CPU: 28 PID: 0 Comm: swapper/28 Tainted: G        W         4.19.59-rt24 #2
 Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/17/2018
 Call Trace:
  dump_stack+0x9a/0xf0
  ___might_sleep.cold.57+0x6a/0x7c
  rt_spin_lock+0x75/0x90
  ? queue_delayed_work_on+0x103/0x580
  queue_delayed_work_on+0x103/0x580
  sched_cpu_starting+0x28c/0x370
  ? sched_cpu_deactivate+0x2b0/0x2b0
  cpuhp_invoke_callback+0x1d0/0x1dc0
  ? _raw_spin_unlock_irqrestore+0x4a/0xf0
  notify_cpu_starting+0x117/0x190
  start_secondary+0x2be/0x530
  ? set_cpu_sibling_map+0x27c0/0x27c0
  secondary_startup_64+0xb6/0xc0
  #29
  #30
  #31
  #32
  #33

  #35
 smp: Brought up 2 nodes, 36 CPUs
 smpboot: Max logical packages: 2
 smpboot: Total of 36 processors activated (166451.61 BogoMIPS)
--->8---

This only happens if isolcpus are configured at boot.

AFAIU, RT is reworking workqueues and 5.x-rt shouldn't suffer from this.
As a matter of fact, I could verify that backporting the workqueue
rework all-in change from 5.0-rt [1] fixes this problem.

I'm thus wondering if there is any plan on backporting the rework to
4.19-rt stable, and if that patch has dependencies, or if any alternative
fix might be found for this problem.

Thanks,

Juri

1 - https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=v5.0.19-rt11&id=d15a862f24df983458533aebd6fa207ecdd1095a
