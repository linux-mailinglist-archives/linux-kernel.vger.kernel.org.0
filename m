Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678B5E9F53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 16:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfJ3PmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 11:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:36654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ3PmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8EF337;
        Wed, 30 Oct 2019 08:42:21 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258383F6C4;
        Wed, 30 Oct 2019 08:42:20 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] sparc: Replace cpu_up/down with device_online/offline
Date:   Wed, 30 Oct 2019 15:38:30 +0000
Message-Id: <20191030153837.18107-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030153837.18107-1-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index bbf59b3b4af8..39350e5dbaf1 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -550,12 +550,13 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 	mdesc_populate_present_mask(mask);
 	mdesc_fill_in_cpu_data(mask);
 
+	lock_device_hotplug();
 	for_each_cpu(cpu, mask) {
 		int err;
 
 		printk(KERN_INFO "ds-%llu: Starting cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_up(cpu);
+		err = device_online(get_cpu_device(cpu));
 		if (err) {
 			__u32 res = DR_CPU_RES_FAILURE;
 			__u32 stat = DR_CPU_STAT_UNCONFIGURED;
@@ -574,6 +575,7 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 			dr_cpu_mark(resp, cpu, ncpus, res, stat);
 		}
 	}
+	unlock_device_hotplug();
 
 	spin_lock_irqsave(&ds_lock, flags);
 	__ds_send(dp->lp, resp, resp_len);
@@ -606,17 +608,19 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
 			     resp_len, ncpus, mask,
 			     DR_CPU_STAT_UNCONFIGURED);
 
+	lock_device_hotplug();
 	for_each_cpu(cpu, mask) {
 		int err;
 
 		printk(KERN_INFO "ds-%llu: Shutting down cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_down(cpu);
+		err = device_offline(get_cpu_device(cpu));
 		if (err)
 			dr_cpu_mark(resp, cpu, ncpus,
 				    DR_CPU_RES_FAILURE,
 				    DR_CPU_STAT_CONFIGURED);
 	}
+	unlock_device_hotplug();
 
 	spin_lock_irqsave(&ds_lock, flags);
 	__ds_send(dp->lp, resp, resp_len);
-- 
2.17.1

