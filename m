Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A866D4DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfJLGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 02:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLGwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4562F302246D;
        Sat, 12 Oct 2019 06:52:20 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15CA608A5;
        Sat, 12 Oct 2019 06:52:14 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RT v2 0/3] migrate disable fixes and performance
Date:   Sat, 12 Oct 2019 01:52:11 -0500
Message-Id: <20191012065214.28109-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 12 Oct 2019 06:52:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the unapplied patches from v1, minus the sched deadline
patch, and with stop_one_cpu_nowait() in place of clobbering
current->state.

Scott Wood (3):
  sched: migrate_enable: Use select_fallback_rq()
  sched: Lazy migrate_disable processing
  sched: migrate_enable: Use stop_one_cpu_nowait()

 include/linux/cpu.h          |   4 -
 include/linux/sched.h        |  11 +--
 include/linux/stop_machine.h |   2 +
 init/init_task.c             |   4 +
 kernel/cpu.c                 | 103 +++++++++--------------
 kernel/sched/core.c          | 195 ++++++++++++++++++-------------------------
 kernel/sched/sched.h         |   4 +
 kernel/stop_machine.c        |   7 +-
 lib/smp_processor_id.c       |   3 +
 9 files changed, 142 insertions(+), 191 deletions(-)

-- 
1.8.3.1

