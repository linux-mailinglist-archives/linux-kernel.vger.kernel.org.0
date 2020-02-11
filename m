Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA51597EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgBKSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 13:15:30 -0500
Received: from foss.arm.com ([217.140.110.172]:51726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbgBKSP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:15:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C153CFEC;
        Tue, 11 Feb 2020 10:15:26 -0800 (PST)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85D723F68E;
        Tue, 11 Feb 2020 10:15:25 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/2] drivers base/arch_topology: Reformat topology_get_[cpu/freq]_scale() function name
Date:   Tue, 11 Feb 2020 19:15:15 +0100
Message-Id: <20200211181515.32570-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211181515.32570-1-dietmar.eggemann@arm.com>
References: <20200211181515.32570-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The storage class and inline definition as well as the return type,
function name and parameter list fit all into one line.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arch_topology.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index f4b1d4fd7efb..c507e9ddd909 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -16,8 +16,7 @@ bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 DECLARE_PER_CPU(unsigned long, cpu_scale);
 
-static inline
-unsigned long topology_get_cpu_scale(int cpu)
+static inline unsigned long topology_get_cpu_scale(int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
@@ -26,8 +25,7 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
 DECLARE_PER_CPU(unsigned long, freq_scale);
 
-static inline
-unsigned long topology_get_freq_scale(int cpu)
+static inline unsigned long topology_get_freq_scale(int cpu)
 {
 	return per_cpu(freq_scale, cpu);
 }
-- 
2.17.1

