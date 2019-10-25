Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B18E4478
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406908AbfJYHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 03:31:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405554AbfJYHb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:31:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76B832B0C9F9B3549437;
        Fri, 25 Oct 2019 15:31:55 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 15:31:47 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <zephaniah@gmail.com>, <tglx@linutronix.de>, <len.brown@intel.com>,
        <ben@decadent.org.uk>, <swinslow@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <hewenliang4@huawei.com>
Subject: [PATCH] tools/power x86_energy_perf_policy: Fix the leakage of file descriptor in get_pkg_num
Date:   Fri, 25 Oct 2019 03:31:46 -0400
Message-ID: <20191025073146.23582-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we need close the file(fp pointer) before the return of get_pkg_num.

Fixes: 4beec1d75 ("tools/power x86_energy_perf_policy: support HWP.EPP")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3fe1eed900d4..165eb4da8a64 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1111,6 +1111,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.19.1

