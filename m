Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700DC122AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLQMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:10:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfLQMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:10:36 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 884F7B0CB0E29F044E8B;
        Tue, 17 Dec 2019 20:10:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 20:10:23 +0800
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <riel@surriel.com>, <dave.hansen@intel.com>,
        <yeyunfeng@huawei.com>, <longman@redhat.com>,
        <mtosatti@redhat.com>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] x86/process: remove unused variable in __switch_to_xtra()
Message-ID: <0efac42a-1631-d93d-d8a2-e6cf65cdf16b@huawei.com>
Date:   Tue, 17 Dec 2019 20:09:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit ecc7e37d4dad ("x86/io: Speedup schedule out of I/O
bitmap user") and commit 22fe5b0439dd ("x86/ioperm: Move TSS bitmap
update to exit to user work"), warning is found:

arch/x86/kernel/process.c: In function ‘__switch_to_xtra’:
arch/x86/kernel/process.c:618:31: warning: variable ‘next’ set but not
used [-Wunused-but-set-variable]
  struct thread_struct *prev, *next;
                               ^~~~
arch/x86/kernel/process.c:618:24: warning: variable ‘prev’ set but not
used [-Wunused-but-set-variable]
  struct thread_struct *prev, *next;
                        ^~~~
Fix this by removing the unused variable @prev and @next;

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/x86/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 61e93a318983..839b5244e3b7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)

 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
-	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;

-	prev = &prev_p->thread;
-	next = &next_p->thread;
-
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);

-- 
2.7.4

