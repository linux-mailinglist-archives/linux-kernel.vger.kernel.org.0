Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F714448
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 07:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfEFFs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 01:48:57 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFFs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:48:57 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841006; Mon, 06 May 2019 06:48:53 +0200
From:   Luca Abeni <luca.abeni@santannapisa.it>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        luca abeni <luca.abeni@santannapisa.it>
Subject: [RFC PATCH 0/6] Capacity awareness for SCHED_DEADLINE
Date:   Mon,  6 May 2019 06:48:30 +0200
Message-Id: <20190506044836.2914-1-luca.abeni@santannapisa.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luca abeni <luca.abeni@santannapisa.it>

The SCHED_DEADLINE scheduling policy currently has some issues with
asymmetric CPU capacity architectures (such as ARM big.LITTLE).
In particular, the admission control mechanism does not work correctly
(because it considers all cores to have the same speed of the fastest
core), and the scheduler does not consider the cores' speed when
migrating tasks. 

This patchset fixes the issues by explicitly considering the cores'
capacities in the admission control mechanism and in tasks' migration.

In particular, the scheduler is improved so that "heavyweight tasks"
(processes or threads having a runtime that on LITTLE cores becomes
larger than the relative deadline) are scheduled on big cores. This
allows respecting deadlines that are missed by the current scheduler.

Moreover, the migration logic is modified so that "lightweight tasks"
(processes or threads having a runtime that on LITTLE cores is still
smaller than the relative deadline) are scheduled on LITTLE cores
when possible. This allows saving some energy without missing deadlines. 
 

luca abeni (6):
  sched/dl: Improve deadline admission control for asymmetric CPU
    capacities
  sched/dl: Capacity-aware migrations
  sched/dl: Try better placement even for deadline tasks that do not
    block
  sched/dl: Improve capacity-aware wakeup
  sched/dl: If the task does not fit anywhere, select the fastest core
  sched/dl: Try not to select a too fast core

 drivers/base/arch_topology.c   |  1 +
 include/linux/sched.h          |  1 +
 include/linux/sched/topology.h |  3 ++
 kernel/sched/core.c            |  2 +
 kernel/sched/cpudeadline.c     | 53 ++++++++++++++++++++++--
 kernel/sched/deadline.c        | 76 ++++++++++++++++++++++++++++------
 kernel/sched/sched.h           | 16 +++++--
 kernel/sched/topology.c        |  9 ++++
 8 files changed, 143 insertions(+), 18 deletions(-)

-- 
2.20.1

