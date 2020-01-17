Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF37140CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAQOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:39:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbgAQOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7D35ACD6;
        Fri, 17 Jan 2020 14:39:09 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 15/15] arm: config: enable coresight in v5 and v7 defconfigs
Date:   Fri, 17 Jan 2020 15:40:10 +0100
Message-Id: <20200117144010.11149-16-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight drivers can be built as modules now. Enable them in
multi_v5_defconfig and multi_v7_defconfig.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm/configs/multi_v5_defconfig | 8 ++++++++
 arch/arm/configs/multi_v7_defconfig | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 2724fb3155cd..2b58f41655b3 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -307,3 +307,11 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_CORESIGHT=m
+CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
+CONFIG_CORESIGHT_CATU=m
+CONFIG_CORESIGHT_SINK_TPIU=m
+CONFIG_CORESIGHT_SINK_ETBV10=m
+CONFIG_CORESIGHT_SOURCE_ETM3X=m
+CONFIG_CORESIGHT_STM=m
+CONFIG_CORESIGHT_CPU_DEBUG=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 80373fe0280d..765857d9717a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1115,3 +1115,11 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_CORESIGHT=m
+CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
+CONFIG_CORESIGHT_CATU=m
+CONFIG_CORESIGHT_SINK_TPIU=m
+CONFIG_CORESIGHT_SINK_ETBV10=m
+CONFIG_CORESIGHT_SOURCE_ETM3X=m
+CONFIG_CORESIGHT_STM=m
+CONFIG_CORESIGHT_CPU_DEBUG=m
-- 
2.16.4

