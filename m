Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4064EE9F57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfJ3Pmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 11:42:33 -0400
Received: from foss.arm.com ([217.140.110.172]:36704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfJ3Pm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AECB5337;
        Wed, 30 Oct 2019 08:42:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E333F6C4;
        Wed, 30 Oct 2019 08:42:27 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] driver: xen: Replace cpu_up/down with device_online/offline
Date:   Wed, 30 Oct 2019 15:38:33 +0000
Message-Id: <20191030153837.18107-9-qais.yousef@arm.com>
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
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
 drivers/xen/cpu_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index f192b6f42da9..ec975decb5de 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -94,7 +94,7 @@ static int setup_cpu_watcher(struct notifier_block *notifier,
 
 	for_each_possible_cpu(cpu) {
 		if (vcpu_online(cpu) == 0) {
-			(void)cpu_down(cpu);
+			device_offline(get_cpu_device(cpu));
 			set_cpu_present(cpu, false);
 		}
 	}
-- 
2.17.1

