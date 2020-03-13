Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA86184DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCMRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 13:47:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:14 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoOt-00017r-DB; Fri, 13 Mar 2020 18:47:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/9] Lock ordering documentation and annotation for lockdep
Date:   Fri, 13 Mar 2020 18:46:52 +0100
Message-Id: <20200313174701.148376-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch introduces the long asked locking documentation
regarding spinlock_t vs raw_spinlock_t (and other locking primitives).
Followed by updates to obey the rules including a change to completions
to use struct swait_queue_head instead of wait_queue_head_t.

It ends with lockdep updates to recognize the "bad" lock nesting. This
new lockdep feature is activated by CONFIG_PROVE_RAW_LOCK_NESTING. Once
enabled it will report for instance printk, the memory allocator or the
workqueue implementation. This is known and it is worked on.

Sebastian


