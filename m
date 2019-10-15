Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3466D7323
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfJOKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 06:25:38 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56402 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728459AbfJOKZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tf7BXHR_1571135103;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tf7BXHR_1571135103)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 18:25:35 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 0/7] rcu: cleanups
Date:   Tue, 15 Oct 2019 10:23:55 +0000
Message-Id: <20191015102402.1978-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All are minimal independent cleanups, expect that patch 3 depends
on patch 2.

Lai Jiangshan (7):
  rcu: fix incorrect conditional compilation
  rcu: fix tracepoint string when RCU CPU kthread runs
  rcu: trace_rcu_utilization() paired
  rcu: remove the declaration of call_rcu() in tree.h
  rcu: move gp_state_names[] and gp_state_getname() to tree_stall.h
  rcu: rename some CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU
  rcu: splite tasks_rcu to tasks.c

 kernel/rcu/Makefile      |   1 +
 kernel/rcu/rcu.h         |   4 +-
 kernel/rcu/tasks.c       | 395 +++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c        |  19 +-
 kernel/rcu/tree.h        |  15 +-
 kernel/rcu/tree_plugin.h |   1 +
 kernel/rcu/tree_stall.h  |  28 ++-
 kernel/rcu/update.c      | 365 ------------------------------------
 8 files changed, 431 insertions(+), 397 deletions(-)
 create mode 100644 kernel/rcu/tasks.c

-- 
2.20.1

