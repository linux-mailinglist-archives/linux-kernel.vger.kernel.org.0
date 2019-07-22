Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE206FA70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGVHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 03:37:59 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36391 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbfGVHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:37:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXUNmRj_1563781075;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXUNmRj_1563781075)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jul 2019 15:37:56 +0800
Subject: Re: [PATCH v2 1/2] cputime: remove rq parameter for
 irqtime_account_process_tick func
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
 <20190719081156.GE3419@hirez.programming.kicks-ass.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0fdee790-638b-9228-9c85-b8fefa78b7f2@linux.alibaba.com>
Date:   Mon, 22 Jul 2019 15:37:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719081156.GE3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2019/7/19 ����4:11, Peter Zijlstra д��:
> On Fri, Jul 19, 2019 at 10:42:41AM +0800, Alex Shi wrote:
>> Using the per cpu rq in function directly is enough, don't need get and
>> pass it from outside as a parameter. That's make function neat.
> 
> Please look at code-gen; I'm thinking this patch makes things worse.
> 

Thanks a lot, Peter! 

This patch reference one more time on this_rq(), that do increase cputime.o size. I will move it after access_process_tick() patch in v3. That could resovle the problem and decreases objfile's size on each of patches.

Thanks
Alex 
