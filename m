Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D503A465
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfFIJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 05:07:41 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35218 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbfFIJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 05:07:40 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 521032E124D;
        Sun,  9 Jun 2019 12:07:37 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BaPFd0wpux-7aOmKXh4;
        Sun, 09 Jun 2019 12:07:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560071257; bh=41wRH7O1RjuIycZL3bPObSY6mj/mQBPhNsOrunGAB0I=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=0jVhzKzlm7ekF4gqCcSRHE3zB0d1+MmxgUtbU/fZQ52gJg7IzdFK1aIjhwNxQnUux
         2sha+8LU3Ip2YddsJOh0RTALXTtaKQBSjaxzbtoQgwIS/qk8wb600Nuaghzruo9WfZ
         WuH8FrXwUzjYH8knG4DqeBrfK+Z8L2zfxeb1lA2Y=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id F3GBYaKJYR-7aemMl4x;
        Sun, 09 Jun 2019 12:07:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 2/5] proc: use down_read_killable for
 /proc/pid/smaps_rollup
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967469.1319.14744588086607025680.stgit@buzz>
 <20190517124555.GB1825@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <bda80d9c-7594-94c9-db2c-37b8bc3b58c8@yandex-team.ru>
Date:   Sun, 9 Jun 2019 12:07:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190517124555.GB1825@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2019 15:45, Michal Hocko wrote:
> On Wed 15-05-19 11:41:14, Konstantin Khlebnikov wrote:
>> Ditto.
> 
> Proper changelog or simply squash those patches into a single patch if
> you do not feel like copy&paste is fun
> 
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   fs/proc/task_mmu.c |    8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 2bf210229daf..781879a91e3b 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -832,7 +832,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>>   
>>   	memset(&mss, 0, sizeof(mss));
>>   
>> -	down_read(&mm->mmap_sem);
>> +	ret = down_read_killable(&mm->mmap_sem);
>> +	if (ret)
>> +		goto out_put_mm;
> 
> Why not ret = -EINTR. The seq_file code seems to be handling all errors
> AFAICS.
> 

I've missed your comment. Sorry.

down_read_killable returns 0 for success and exactly -EINTR for failure.

>> +
>>   	hold_task_mempolicy(priv);
>>   
>>   	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
>> @@ -849,8 +852,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>>   
>>   	release_task_mempolicy(priv);
>>   	up_read(&mm->mmap_sem);
>> -	mmput(mm);
>>   
>> +out_put_mm:
>> +	mmput(mm);
>>   out_put_task:
>>   	put_task_struct(priv->task);
>>   	priv->task = NULL;
> 
