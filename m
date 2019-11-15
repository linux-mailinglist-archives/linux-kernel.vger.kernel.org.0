Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED41FD3EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKOFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 00:07:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44347 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfKOFH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:07:58 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78485464"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 13:07:56 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B36324CE14FE;
        Fri, 15 Nov 2019 12:59:44 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 13:08:04 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/setup: Fix typos
Date:   Fri, 15 Nov 2019 13:07:45 +0800
Message-ID: <20191115050745.1941-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: B36324CE14FE.A73FE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

BIOSen -> BIOSes; paing -> paging.
And improve comments via 640"Kb".

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..56ac9ff12461 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -459,7 +459,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * due to mapping restrictions.
  *
  * On 64bit, kdump kernel need be restricted to be under 64TB, which is
- * the upper limit of system RAM in 4-level paing mode. Since the kdump
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
  * jumping could be from 5-level to 4-level, the jumping will fail if
  * kernel is put above 64TB, and there's no way to detect the paging mode
  * of the kernel which will be loaded for dumping during the 1st kernel
@@ -743,8 +743,8 @@ static void __init trim_bios_range(void)
 	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 
 	/*
-	 * special case: Some BIOSen report the PC BIOS
-	 * area (640->1Mb) as ram even though it is not.
+	 * special case: Some BIOSes report the PC BIOS
+	 * area (640Kb->1Mb) as ram even though it is not.
 	 * take them out.
 	 */
 	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM, 1);
-- 
2.21.0



