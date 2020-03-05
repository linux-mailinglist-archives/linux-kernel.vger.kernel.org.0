Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA617A12F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 03:24:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:41560 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:24:03 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 03:24:02 EST
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 045DC8B0D3;
        Thu,  5 Mar 2020 16:16:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32633T140274034538240S1583396184137610_;
        Thu, 05 Mar 2020 16:16:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e59db39a75117ec32bc961e850a9069c>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, Liang Chen <cl@rock-chips.com>
Subject: [PATCH v1 0/1] wait_task_inactive() spend too much time on system startup
Date:   Thu,  5 Mar 2020 16:16:10 +0800
Message-Id: <20200305081611.29323-1-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Changelog:
v1: wait_task_inactive() frequently call schedule_hrtimeout() and spend a lot of time,
i am trying to optimize it on rockchip platform.

Liang Chen (1):
  sched/fair: do not preempt current task if it is going to call
    schedule()

 arch/arm/include/asm/thread_info.h   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 include/linux/sched.h                | 15 +++++++++++++++
 kernel/kthread.c                     |  4 ++++
 kernel/sched/fair.c                  |  4 ++++
 5 files changed, 25 insertions(+)

-- 
2.17.1



