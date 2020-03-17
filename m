Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81461876C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgCQA0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 20:26:03 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:49038 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbgCQA0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:26:03 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id A3E30270;
        Tue, 17 Mar 2020 08:19:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P20067T140595454527232S1584404312807233_;
        Tue, 17 Mar 2020 08:19:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2b68b92362a0c690d724f94dc8d9c475>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     linux-kernel@vger.kernel.org
Cc:     anders.roxell@linaro.org, arnd@arndb.de, sboyd@kernel.org,
        gregkh@linuxfoundation.org, naresh.kamboju@linaro.org,
        daniel.lezcano@linaro.org, Basil.Eljuse@arm.com,
        mturquette@baylibre.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] arch_topology: Fix putting invalid cpu clk
Date:   Tue, 17 Mar 2020 08:18:29 +0800
Message-Id: <20200317001829.29516-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sanity check before putting the cpu clk.

Fixes: 2a6d1c6bcd1f (“arch_topology: Adjust initial CPU capacities with current freq")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/base/arch_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8a9fe2bc8635..4d0a0038b476 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -176,11 +176,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial freq_factor value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk))
+		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
 			per_cpu(freq_factor, cpu) =
 				clk_get_rate(cpu_clk) / 1000;
-
-		clk_put(cpu_clk);
+			clk_put(cpu_clk);
+		}
 	} else {
 		if (raw_capacity) {
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
-- 
2.11.0



