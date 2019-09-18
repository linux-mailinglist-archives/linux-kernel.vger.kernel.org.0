Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC7B6653
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfIROmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 10:42:06 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:25564 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfIROmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:42:05 -0400
IronPort-SDR: 3MoQyIVurvkT+KhWfrbvVIDwsCzN0wUVPJUBu7iKWGrr15fWGBdf7Pq1FR006TfMZ7mVgB+55g
 kPoIKVKKTtP+YB84DqmO+YGK7d3bsf5hHGNSEjNb07VBxyxHsVj3Db9grEoeRr0emMvWNW58dq
 FtRIQzFZsEoipU9ZyAqCStGly4vECdfUue3WuRyUCgv/5wBX2YikekLKKVy7zABz4uGqcRsEqV
 M8CnqC+YAylKH3xs+08N1hxJtQyhcJS4WymCSSikOBBtliWUND/XEyvfPwKsJrFIyEBQut2esI
 xkk=
X-IronPort-AV: E=Sophos;i="5.64,520,1559548800"; 
   d="scan'208";a="43273330"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 18 Sep 2019 06:42:03 -0800
IronPort-SDR: pIi8VRSqP9Jd5hL4tFSvbOR8YtqhYsM7eY1NmdWYPLED7kveOTEaYzXFEvaisxtt7VBbLvvSpH
 f7QBF3oDwjGcf806/0ofvqFWMXmlXO8y2oKF1rku+6zGaPDrPJV3AhO3FyJ8T6I3r4D6aB+6zY
 BboY15rjLYIjiKrAkFG5QTwA5MkwQOiPJc92sMM7Aom2wG2vzm34me7ADjAJgwQCnEqFkeLB/d
 A3MfqZj4fn14NPHVzPcIEpECfif2Ab4LwGC40bKRDwPwasuCIw7VFYjOWeOvC9wY4d5PCj/8lJ
 eOk=
From:   Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>
CC:     <balasubramani_vivekanandan@mentor.com>, <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 0/1] tick: broadcast-hrtimer: Fix a race in bc_set_next
Date:   Wed, 18 Sep 2019 16:41:37 +0200
Message-ID: <20190918144138.24839-1-balasubramani_vivekanandan@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was investigating a rcu stall warning on ARM64 Renesas Rcar3
platform. On analysis I found that rcu stall warning was because the
rcu_preempt kthread was starved of cpu time. rcu_preempt was blocked in
the function schedule_timeout() and never woken up. On further
investigation I found that local timer interrupts were not happening on
the cpu where the rcu_preempt kthread was blocked. So the rcu_preempt
was not woken up after timeout.
I continued my analysis to debug why the timer failed on the cpu. I
found that when cpu goes through idle state cycle, the timer failure
happens. When the cpu enters the idle state it subscribes to the tick
broadcast clock and shutsdown the local timer. Then on exit from idle
state the local timer is programmed to fire interrupts. But I found that
the during the error scenario, cpu fails to program the local timer on
exit from idle state. The below code in
__tick_broadcast_oneshot_control() is where the idle code exit path goes
through and fails to program the timer hardware

now = ktime_get();
if (dev->next_event <= now) {
	cpumask_set_cpu(cpu, tick_broadcast_force_mask);
		goto out;
}

The value in next_event will be earlier than current time because the
tick broadcast clock did not wake up the cpu on its subcribed
timeout. Later when the cpu is woken up due to some other event this
condition will arise. After the cpu woken up, any further timeout
requests by any task on the cpu might fail to program the timer
hardware because the value in next_event will be earlier than the
current time.
Then I focussed on why the tick broadcast clock failed to wake up the
cpu. I noticed a race condition in the hrtimer based tick broadcast
clock. The race condition results in a condition where the tick
broadcast hrtimer is never restarted. I have created a patch to fix the
race condition. Please review 

Balasubramani Vivekanandan (1):
  tick: broadcast-hrtimer: Fix a race in bc_set_next

 kernel/time/tick-broadcast-hrtimer.c | 58 ++++++++++++++++++++++------
 kernel/time/tick-broadcast.c         |  2 +
 2 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.17.1

