Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D773178954
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 04:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCDD6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 22:58:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCDD6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:58:41 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43BDCC901401D4F4FFA7;
        Wed,  4 Mar 2020 11:58:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Mar 2020 11:58:32 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <sudeep.holla@arm.com>
CC:     <linuxarm@huawei.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpu-topology: Fix the potential data corruption
Date:   Wed, 4 Mar 2020 11:54:52 +0800
Message-ID: <1583294092-5929-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are only 10 bytes to store the cpu-topology 'name'
information. Only 10 bytes copied into cluster/thread/core names.

If the cluster ID exceeds 2-digit number, it will result in the data
corruption, and ending up in a dead loop in the parsing routines. The
same applies to the thread names with more that 3-digit number.

This issue was found using the boundary tests under virtualised
environment like QEMU.

Let us increase the buffer to fix such potential issues.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

---
Changelog:
v1->v2: update the commit message suggested by sudeep.
---
 drivers/base/arch_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6119e11..f489883 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -281,7 +281,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 static int __init parse_core(struct device_node *core, int package_id,
 			     int core_id)
 {
-	char name[10];
+	char name[20];
 	bool leaf = true;
 	int i = 0;
 	int cpu;
@@ -327,7 +327,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 
 static int __init parse_cluster(struct device_node *cluster, int depth)
 {
-	char name[10];
+	char name[20];
 	bool leaf = true;
 	bool has_cores = false;
 	struct device_node *c;
-- 
2.8.1

