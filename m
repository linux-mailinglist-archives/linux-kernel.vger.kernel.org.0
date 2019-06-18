Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0F497B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 05:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfFRDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 23:13:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRDNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:13:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so2206338pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KhfO2VsqXNYGGnbXV/fbIkGQmA6pJZHViPZUmbEm5iQ=;
        b=i/akO01kRXPc6Axn96IyXBj+YQCuHDqfJg2LW1VB5lHbMDJmoVsycyLyepIvadlC1Q
         jX/AJK9RmgOYlSW3gXqYbH9CetR3wj2KTUJpXIt5sAxILgz2FQ+Wy4cu/Yto4kGEXtTF
         nKDtP0sTyfrdBBfwrDflwYd4M08GmjUfImLgG0VlUZO7v0/4/r2lNH4Bk2LSOb4yeAfR
         rymBVV1U424Em9pVxi9XCbrMcV4EhwZ7s/YDdWW7k2pT4aqlWcGINf9YlNXjizODta3j
         mw3AFhRsKliEfqHkQ5zO5ed6hAxI9ZjT1HtJqN6bQqfKg5tYjuUHARqKbElqWBMvpq/P
         LPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KhfO2VsqXNYGGnbXV/fbIkGQmA6pJZHViPZUmbEm5iQ=;
        b=l/ds31TtpNsrKhok4HjIK3xD6Ja/zguc/idSdVF5gxeC/c0IS3/nv/cWkMWIP7M1Zj
         ZMV08/ZTwR33r7YBT1K6+tp2/BjYoBiWe0Dk5IDKZHtYSegghiLQYQRl8FVb+XOzIkd3
         L3my3+PLSsS3y4wfZk/Jn4hgilhdiG0idHu8rMK3keaEPK5wzYVc0S1dj7zQ2sEiCTRh
         M6QMwCeL3iark7/xTpgVlW2g/6esgAW5BbHB0Nx0FP1t6tZL6vkUA0d6l1RVUd5m2LFx
         8UstO0IIF3X27w04m0/JfNbE9nwtcXFRpPjB7/o7yzQFvjRO7r82BZFbgrGXj3TX4UK1
         aITg==
X-Gm-Message-State: APjAAAUWNH9IV3c3Fe4uPmP5OzZKTtQyMlz2/g8lC9WzxvuUbSM2l2D9
        UFJRaK20sdeE+oarfMtKDP7Iuhgr
X-Google-Smtp-Source: APXvYqw+8b4cYPNCayrDZ1FsK4rjLmAl6pskm95IFxogKNcYD3SlVXwsRc62OXWDs15/b3EZhnWzMA==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr2631153pjw.90.1560827586304;
        Mon, 17 Jun 2019 20:13:06 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id d4sm608709pju.19.2019.06.17.20.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 20:13:05 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] sched/nohz: Optimize get nohz timer target
Date:   Tue, 18 Jun 2019 11:13:01 +0800
Message-Id: <1560827581-8827-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

On a machine, cpu 0 is used for housekeeping, other 39 cpus are in 
nohz_full mode. We can observe huge time burn in the loop for seaching 
nearest busy housekeeper cpu by ftrace.

  2)               |                        get_nohz_timer_target() {
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.458 us    |                          housekeeping_test_cpu();

  ...

  2)   0.292 us    |                          housekeeping_test_cpu();
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.227 us    |                          housekeeping_any_cpu();
  2) + 43.460 us   |                        }
  
This patch optimizes the searching logic by finding a nearest housekeeper
cpu in the housekeeping cpumask, it can minimize the worst searching time 
from ~44us to < 10us in my testing.

Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83bd6bb..db550cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -548,11 +548,12 @@ int get_nohz_timer_target(void)
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+			housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
-- 
2.7.4

