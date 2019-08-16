Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EEB8FE76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHPIpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 04:45:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54465 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726893AbfHPIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:45:18 -0400
X-IronPort-AV: E=Sophos;i="5.64,391,1559491200"; 
   d="scan'208";a="73760552"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Aug 2019 16:45:14 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id AC78F4CE03C4;
        Fri, 16 Aug 2019 16:45:14 +0800 (CST)
Received: from localhost.localdomain (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 16 Aug 2019 16:45:16 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] perf/x86: Fix typo in core.c
Date:   Fri, 16 Aug 2019 16:43:21 +0800
Message-ID: <1565945001-4413-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: AC78F4CE03C4.AE432
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change related.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81b005e..325959d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1236,7 +1236,7 @@ void x86_pmu_enable_event(struct perf_event *event)
  * Add a single event to the PMU.
  *
  * The event is added to the group of enabled events
- * but only if it can be scehduled with existing events.
+ * but only if it can be scheduled with existing events.
  */
 static int x86_pmu_add(struct perf_event *event, int flags)
 {
-- 
2.7.4



