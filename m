Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20857EC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfHBGUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 02:20:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32997 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729316AbfHBGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:20:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TYSHu-K_1564726826;
Received: from ali-6c96cfdd2b5d.local(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TYSHu-K_1564726826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Aug 2019 14:20:52 +0800
Subject: Re: [PATCH v2] psi: get poll_work to run when calling poll syscall
 next time
To:     hannes@cmpxchg.org, surenb@google.com
Cc:     dennis@kernel.org, mingo@redhat.com, axboe@kernel.dk,
        lizefan@huawei.com, peterz@infradead.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, caspar@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1564463819-120014-1-git-send-email-kerneljasonxing@linux.alibaba.com>
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
Message-ID: <63ac943a-dc9a-f987-3580-6a0d3192e1dd@linux.alibaba.com>
Date:   Fri, 2 Aug 2019 14:20:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564463819-120014-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

According to the reviews from Johoannes, I've changed the old patch and 
then submitted the version 2 patch a few days ago.

Please let me know if all this sounds good, or if there are any issues.

Thanks,
Jason

On 2019/7/30 下午1:16, Jason Xing wrote:
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
> [PATCH V2]
> In the patch v2, I put the atomic_set(&group->poll_scheduled, 0);
> into the right place.
> Here I quoted from Johannes as the best explaination:
> "The question is why we can end up with poll_scheduled = 1 but the work
> not running (which would reset it to 0). And the answer is because the
> scheduling side sees group->poll_kworker under RCU protection and then
> schedules it, but here we cancel the work and destroy the worker. The
> cancel needs to pair with resetting the poll_scheduled flag."
> 
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   kernel/sched/psi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632..acdada0 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1131,7 +1131,14 @@ static void psi_trigger_destroy(struct kref *ref)
>   	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
>   	 */
>   	if (kworker_to_destroy) {
> +		/*
> +		 * After the RCU grace period has expired, the worker
> +		 * can no longer be found through group->poll_kworker.
> +		 * But it might have been already scheduled before
> +		 * that - deschedule it cleanly before destroying it.
> +		 */
>   		kthread_cancel_delayed_work_sync(&group->poll_work);
> +		atomic_set(&group->poll_scheduled, 0);
>   		kthread_destroy_worker(kworker_to_destroy);
>   	}
>   	kfree(t);
> 
