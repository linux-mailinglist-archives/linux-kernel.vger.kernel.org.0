Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53B52E644
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE2Ug6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:36:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40300 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2Ug6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:36:58 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so5778470itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TAplLGxgX6E2eCP7Vyrlwjs1jAbUhN21T+mgnkcj9Gw=;
        b=MSPaLPn9fnXCi+QtGNpxbOvNOOIbtFURFEypZNV40ABhsgzHo/HU9Z7ZIkuirZwkxe
         pS+pxvvaOZ2712I4y9kOjE3SQYmr6tPnkS4sIq8TeU7Ghz7197hKd/hSnVi0qO1lQVZ4
         emHqQ8gTj+dy9jXduyIjRgGkF6tTOgOQ4KMy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAplLGxgX6E2eCP7Vyrlwjs1jAbUhN21T+mgnkcj9Gw=;
        b=MB167gbnxuiq4Jdw89mvc2CA6o7Dr9b4elkSYA4qf9P1JeOu/Fk4DKfYhEwpKLEO3v
         yul8LMVsOAo3TNM5J+FOAcbpqKdUe8VmEOxG1bsDE3DY7qSqZ/cTFo8lKu0Qr3x835p4
         KcIrYkXS4z2y1p8ULN9lLnuxAEShjD1p4siGj6vPsrlsMROqWWCevLAtds74C8+xXIBb
         nOAsZECtrwCFODJWSKHprCxpkXC5AlcjLQdnO/C5k80RJ17l+Gno5LXTVIoFPOoeUah7
         eVu1dYro6LbvWTjhGNgPLxAr43FCK50hgeOSN/XotD+DtlqW7CzkMOtv/xVfo/bYzJY8
         c2iQ==
X-Gm-Message-State: APjAAAXPgJexDW3a/apSIicegamVv73a22Wcuydc6ytZpcmDBuF8OM3G
        vr0dqnFHunVA4n227etFybcKRA==
X-Google-Smtp-Source: APXvYqygc8rBBUYfjClAb6qTpWu0H5No483DhBfrxkxRMRYbu1D3pzFVcaAcy0DylqY1IDM9ErsCWg==
X-Received: by 2002:a24:5592:: with SMTP id e140mr644itb.48.1559162217203;
        Wed, 29 May 2019 13:36:57 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id w194sm172506itb.33.2019.05.29.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:36:56 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 00/16] Core scheduling v3
Date:   Wed, 29 May 2019 20:36:36 +0000
Message-Id: <cover.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Third iteration of the Core-Scheduling feature.

This version fixes mostly correctness related issues in v2 and
addresses performance issues. Also, addressed some crashes related
to cgroups and cpu hotplugging.

We have tested and verified that incompatible processes are not
selected during schedule. In terms of performance, the impact
depends on the workload: 
- on CPU intensive applications that use all the logical CPUs with
  SMT enabled, enabling core scheduling performs better than nosmt.
- on mixed workloads with considerable io compared to cpu usage,
  nosmt seems to perform better than core scheduling.

Changes in v3
-------------
- Fixes the issue of sibling picking up an incompatible task
  - Aaron Lu
  - Vineeth Pillai
  - Julien Desfossez
- Fixes the issue of starving threads due to forced idle
  - Peter Zijlstra
- Fixes the refcounting issue when deleting a cgroup with tag
  - Julien Desfossez
- Fixes a crash during cpu offline/online with coresched enabled
  - Vineeth Pillai
- Fixes a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
-------------
- Fixes for couple of NULL pointer dereference crashes
  - Subhra Mazumdar
  - Tim Chen
- Improves priority comparison logic for process in different cpus
  - Peter Zijlstra
  - Aaron Lu
- Fixes a hard lockup in rq locking
  - Vineeth Pillai
  - Julien Desfossez
- Fixes a performance issue seen on IO heavy workloads
  - Vineeth Pillai
  - Julien Desfossez
- Fix for 32bit build
  - Aubrey Li

Issues
------
- Comparing process priority across cpus is not accurate

TODO
----
- Decide on the API for exposing the feature to userland

---

Peter Zijlstra (16):
  stop_machine: Fix stop_cpus_in_progress ordering
  sched: Fix kerneldoc comment for ia64_set_curr_task
  sched: Wrap rq::lock access
  sched/{rt,deadline}: Fix set_next_task vs pick_next_task
  sched: Add task_struct pointer to sched_class::set_curr_task
  sched/fair: Export newidle_balance()
  sched: Allow put_prev_task() to drop rq->lock
  sched: Rework pick_next_task() slow-path
  sched: Introduce sched_class::pick_task()
  sched: Core-wide rq->lock
  sched: Basic tracking of matching tasks
  sched: A quick and dirty cgroup tagging interface
  sched: Add core wide task selection and scheduling.
  sched/fair: Add a few assertions
  sched: Trivial forced-newidle balancer
  sched: Debug bits...

 include/linux/sched.h    |   9 +-
 kernel/Kconfig.preempt   |   7 +-
 kernel/sched/core.c      | 858 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/cpuacct.c   |  12 +-
 kernel/sched/deadline.c  |  99 +++--
 kernel/sched/debug.c     |   4 +-
 kernel/sched/fair.c      | 180 ++++----
 kernel/sched/idle.c      |  42 +-
 kernel/sched/pelt.h      |   2 +-
 kernel/sched/rt.c        |  96 ++---
 kernel/sched/sched.h     | 237 ++++++++---
 kernel/sched/stop_task.c |  35 +-
 kernel/sched/topology.c  |   4 +-
 kernel/stop_machine.c    |   2 +
 14 files changed, 1250 insertions(+), 337 deletions(-)

-- 
2.17.1

