Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60297651E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfGKGli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 02:41:38 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51069 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfGKGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:41:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TWb7dXD_1562827284;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TWb7dXD_1562827284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jul 2019 14:41:24 +0800
Subject: Re: [PATCH 2/2] cputime: remove duplicate code in
 account_process_tick
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190709060100.214154-1-alex.shi@linux.alibaba.com>
 <20190709060100.214154-2-alex.shi@linux.alibaba.com>
 <20190710141500.GQ3402@hirez.programming.kicks-ass.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0c3ce3c1-5a7e-314a-97f8-8270cc6ed990@linux.alibaba.com>
Date:   Thu, 11 Jul 2019 14:41:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710141500.GQ3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2019/7/10 ����10:15, Peter Zijlstra д��:
> On Tue, Jul 09, 2019 at 02:01:00PM +0800, Alex Shi wrote:
>> In funcation account_process_tick, func actually do same things with
>> irqtime_account_process_tick, whenever if IRQ_TIME_ACCOUNTING set or
>> if sched_clock_irqtime enabled.
>>
>> So it's better to reuse one function for both.
> 
> But it's not the exact same.. and you didn't say, not did you say why
> that is fine.
> 

Thanks for reply!

The irqtime_account_process_tick path was introduced for precise ns irq time account(abb74cefa9c682fb sched: Export ns irqtimes through /proc/stat) while account_process_tick still use jiffes. but now both pathes are using ns cputime. And there is not strong reason to keep 2 very very similar path coexists. That's the reason I believe unite the collection is better. 

Thanks
Alex
