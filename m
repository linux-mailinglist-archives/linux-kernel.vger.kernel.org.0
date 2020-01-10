Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDF136525
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 02:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgAJB6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 20:58:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbgAJB6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:58:21 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 49F253D405613892E65B;
        Fri, 10 Jan 2020 09:58:19 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 09:58:09 +0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <dhowells@redhat.com>, <akpm@linux-foundation.org>,
        <torvalds@linux-foundation.org>
CC:     <bywxiaobai@163.com>, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        renxudong <renxudong1@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: kdev_t: mask mi with MINORMASK in MKDEV macro
Message-ID: <7df17479-629f-21f8-8533-df38be69bd75@huawei.com>
Date:   Fri, 10 Jan 2020 09:58:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In MKDEV macro, if mi is larger than MINORMASK, the major will be
affected by mi. For example, set dev = MKDEV(2, (1U << MINORBITS)),
then MAJOR(dev) will be equal to 3, incorrectly.

Here, we mask mi with MINORMASK in MKDEV macro.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 include/linux/kdev_t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
index 85b5151911cf..40a9423720b2 100644
--- a/include/linux/kdev_t.h
+++ b/include/linux/kdev_t.h
@@ -9,7 +9,7 @@

 #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
 #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+#define MKDEV(ma, mi)	(((ma) << MINORBITS) | ((mi) & MINORMASK))

 #define print_dev_t(buffer, dev)					\
 	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
-- 
2.19.1

