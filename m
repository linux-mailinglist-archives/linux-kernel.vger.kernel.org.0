Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9744117E91E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCITso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCITsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:18 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0ED124676;
        Mon,  9 Mar 2020 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783297;
        bh=t5E4LYaQi3hLF0ZQnDleGqngq0///iKC3muWnbwhvos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=G9pFhIVSforCc9xPpZFfoKmL0cEmzc1qDZ6RmU/cCg85aAsvHSeLjn3jTCGrx8SnH
         vZpUjOFYkdDfsus9ROEJvg3v4+z9wR9JKgHM3C0d/UVwj19esUYY0WAPxgVNgrn54H
         My8oK5vREsjuTtnX/SlnhJWORuaGDJ9eiRiMVc9o=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Scott Wood <swood@redhat.com>
Subject: [PATCH RT 3/8] sched: migrate_enable: Remove __schedule() call
Date:   Mon,  9 Mar 2020 14:47:48 -0500
Message-Id: <f0a8c1fd33e6f0311487e055bb8318f265628f60.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit b8162e61e9a33bd1de6452eb838fbf50a93ddd9a ]

We can rely on preempt_enable() to schedule.  Besides simplifying the
code, this potentially allows sequences such as the following to be
permitted:

migrate_disable();
preempt_disable();
migrate_enable();
preempt_enable();

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Scott Wood <swood@redhat.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 960daa6bc7f04..3ff48df25cff8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7024,7 +7024,6 @@ void migrate_enable(void)
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    arg, work);
 		tlb_migrate_finish(p->mm);
-		__schedule(true);
 	}
 
 out:
-- 
2.14.1

