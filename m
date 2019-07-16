Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2710C6A351
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 09:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfGPHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 03:55:19 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55028 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbfGPHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:55:19 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id AA1842E09CF;
        Tue, 16 Jul 2019 10:55:15 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZqZ8dH9oSo-tFimFMZq;
        Tue, 16 Jul 2019 10:55:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563263715; bh=gCDlZYrZ5fRoxvTXchUThC5WNWbnV5h3sRsaJ9Xhvjc=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=pik3kkc676yCfS/UUGMCuvgMLFwRIQEyCQuI+94e14cafDzMmhWkuMIh2IL2L2ito
         9uO0y/rqsNZhirVoMfrTVeV24f9U17aJPVlErYb65mnrPBaylXZiLL29P6UEh7tNhA
         QtTNOJb13fRR0jJMsHyGmmJnNpModDXDLSLuj7As=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38d2:81d0:9f31:221f])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id mQ63WBUkBR-tFwS1sST;
        Tue, 16 Jul 2019 10:55:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] kernel/printk: prevent deadlock at unexpected call
 kmsg_dump in NMI context
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <156317789553.326.15952579019338825022.stgit@buzz>
 <20190716074104.jeagfyr4k57lranz@pathway.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5a101004-72b5-3699-b39d-e1acac996551@yandex-team.ru>
Date:   Tue, 16 Jul 2019 10:55:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716074104.jeagfyr4k57lranz@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.2019 10:41, Petr Mladek wrote:
> On Mon 2019-07-15 11:04:55, Konstantin Khlebnikov wrote:
>> Kernel message dumper - function kmsg_dump() is called on various oops or
>> panic paths which could happen in unpredictable context including NMI.
>>
>> Panic in NMI is handled especially by stopping all other cpus with
>> smp_send_stop() and busting locks in printk_safe_flush_on_panic().
>>
>> Other less-fatal cases shouldn't happen in NMI and cannot be handled.
>> But this might happen for example on oops in nmi context. In this case
>> dumper could deadlock on lockbuf_lock or break internal structures.
> 
> If I get it correctly than this patch could really prevent a deadlock
> in at least:
> 
>    + oops_end()
>      + oops_exit()
>        + kmsg_dump(KMSG_DUMP_OOPS)
> 
> If it is called in NMI, it should end up with panic(). Then the dump
> will be called later after stopping CPUs...
> 
> Or am I wrong?

Yep. Under 'oops in nmi context' I mean exactly that case.

> 
> Otherwise, the patch looks good to me. I would just mention
> the above scenario if it is correct.
> 
> Best Regards,
> Petr
> 
>> This patch catches kmsg_dump() called in NMI context except panic and
>> prints warning once.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Link: https://lore.kernel.org/lkml/156294329676.1745.2620297516210526183.stgit@buzz/ (v1)
>> ---
>>   kernel/printk/printk.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1888f6a3b694..e711f64a1843 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3104,6 +3104,13 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>>   	struct kmsg_dumper *dumper;
>>   	unsigned long flags;
>>   
>> +	/*
>> +	 * In NMI context only panic could be handled safely:
>> +	 * it stops other cpus and busts logbuf lock.
>> +	 */
>> +	if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
>> +		return;
>> +
>>   	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
>>   		return;
>>   
>>
