Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8044A717E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfICRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:17:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54293 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfICRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:17:01 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1i5CQM-0006gX-Vl; Tue, 03 Sep 2019 17:16:59 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH 1/2] sched: sched_getattr should return E2BIG, not EFBIG
Date:   Tue,  3 Sep 2019 14:16:44 -0300
Message-Id: <20190903171645.28090-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented and the behavior before commit 22400674945c (sched: Simplify
return logic in sched_read_attr()), sched_getattr should return E2BIG instead
of EFBIG when there is not enough space to copy sched_attr.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Fixes: 22400674945c (sched: Simplify return logic in sched_read_attr())
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2477893dd069..0fd67281e656 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5129,7 +5129,7 @@ static int sched_read_attr(struct sched_attr __user *uattr,
 
 		for (; addr < end; addr++) {
 			if (*addr)
-				return -EFBIG;
+				return -E2BIG;
 		}
 
 		attr->size = usize;
-- 
2.20.1

