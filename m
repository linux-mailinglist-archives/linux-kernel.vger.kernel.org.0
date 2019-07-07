Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428DA6135E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 02:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGGAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 20:46:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726966AbfGGAqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:46:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E65DD218EFFAD6451C1;
        Sun,  7 Jul 2019 08:46:04 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sun, 7 Jul 2019
 08:45:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2] time: compat settimeofday: Validate the values of tv from user
Date:   Sun, 7 Jul 2019 08:51:41 +0800
Message-ID: <1562460701-113301-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 6ada1fc0e1c4
("time: settimeofday: Validate the values of tv from user"),
for a wide range of negative tv_usec values the multiplication overflow
turns them in positive numbers. So the 'validated later' is not catching
the invalid input.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 kernel/time/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 7f7d691..5c54ca6 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -251,6 +251,10 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	if (tv) {
 		if (compat_get_timeval(&user_tv, tv))
 			return -EFAULT;
+
+		if (!timeval_valid(&user_tv))
+			return -EINVAL;
+
 		new_ts.tv_sec = user_tv.tv_sec;
 		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
 	}
--
2.7.4

