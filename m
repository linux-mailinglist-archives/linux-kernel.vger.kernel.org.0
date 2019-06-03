Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A441F328C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfFCGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 02:47:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48155 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727291AbfFCGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:47:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09180124|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.416466-0.0537556-0.529779;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.EglZUbk_1559544455;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EglZUbk_1559544455)
          by smtp.aliyun-inc.com(10.147.42.197);
          Mon, 03 Jun 2019 14:47:35 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH V3 6/6] csky: Fix perf record in kernel/user space
Date:   Mon,  3 Jun 2019 14:46:25 +0800
Message-Id: <79c0094b29f2315045a9a2544c9837bcf6f78fea.1559544301.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559544301.git.han_mao@c-sky.com>
References: <cover.1559544301.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559544301.git.han_mao@c-sky.com>
References: <cover.1559544301.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csky_pmu_event_init is called several times during the perf record
initialzation. After configure the event counter in either kernel
space or user space, csky_pmu_event_init is called twice with no
attr specified. Configuration will be overwritten with sampling in
both kernel space and user space. --all-kernel/--all-user is
useless without this patch applied.

Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index de95005..011fd9b 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -983,6 +983,12 @@ static int csky_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
+	if (event->attr.type != PERF_TYPE_HARDWARE &&
+	    event->attr.type != PERF_TYPE_HW_CACHE &&
+	    event->attr.type != PERF_TYPE_RAW) {
+		return -ENOENT;
+	}
+
 	if (event->attr.exclude_user)
 		csky_pmu.hpcr = BIT(2);
 	else if (event->attr.exclude_kernel)
-- 
2.7.4

