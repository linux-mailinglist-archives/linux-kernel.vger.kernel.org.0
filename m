Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98137870F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfG2INK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 04:13:10 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34916 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfG2INJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:13:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TY1HZl2_1564387964;
Received: from ali-6c96cfdd2b5d.local(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TY1HZl2_1564387964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Jul 2019 16:13:03 +0800
Subject: Re: [PATCH] psi: get poll_work to run when calling poll syscall next
 time
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org
Cc:     dennis@kernel.org, axboe@kernel.dk, lizefan@huawei.com,
        tj@kernel.org, linux-kernel@vger.kernel.org
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
Message-ID: <4d7ca842-3246-10ee-9ae2-973d1b88ed93@linux.alibaba.com>
Date:   Mon, 29 Jul 2019 16:12:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could someone take a quick look at this patch? It's not complicated at 
all, just one line added into PSI which can make the poll() run in the 
right way.

Thanks,
Jason

On 2019/7/23 下午2:45, Jason Xing wrote:
> Only when calling the poll syscall the first time can user
> receive POLLPRI correctly. After that, user always fails to
> acquire the event signal.
> 
> Reproduce case:
> 1. Get the monitor code in Documentation/accounting/psi.txt
> 2. Run it, and wait for the event triggered.
> 3. Kill and restart the process.
> 
> If the user doesn't kill the monitor process, it seems the
> poll_work works fine. After killing and restarting the monitor,
> the poll_work in kernel will never run again due to the wrong
> value of poll_scheduled. Therefore, we should reset the value
> as group_init() does after the last trigger is destroyed.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> ---
>   kernel/sched/psi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632..66f4385 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
>   	if (kworker_to_destroy) {
>   		kthread_cancel_delayed_work_sync(&group->poll_work);
>   		kthread_destroy_worker(kworker_to_destroy);
> +		/*
> +		 * The poll_work should have the chance to be put into the
> +		 * kthread queue when calling poll syscall next time. So
> +		 * reset poll_scheduled to zero as group_init() does
> +		 */
> +		atomic_set(&group->poll_scheduled, 0);
>   	}
>   	kfree(t);
>   }
> 
