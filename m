Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBA1945B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgCZRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:43:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34330 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgCZRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585244589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iY1VQzG5YGZeuqalkw7ZWUxW/oZQYRokOGvysW5G5q0=;
        b=X75Xw+yHJPwHX9kga+vAt+45C0xdN2JVqTSZ8ntBpeeygmcj8AYBXKlDE1QS2XonhoSyA+
        ci0p+ysGRuMeZ7JiIJdR8ytk9v+BAvCrqweQaWBCyt3F6pggv3/O9ewfuPT/6nzVXd3BdC
        cWhgpIfyi0uqQr/oXC7/zm9j+isGGP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-ldtxsiROPjmMc5hJxGunew-1; Thu, 26 Mar 2020 13:43:08 -0400
X-MC-Unique: ldtxsiROPjmMc5hJxGunew-1
Received: by mail-wm1-f71.google.com with SMTP id s14so2481225wmj.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iY1VQzG5YGZeuqalkw7ZWUxW/oZQYRokOGvysW5G5q0=;
        b=AU7PtODX9bi0+LXP0X1yLMz8BzR9Nm4uKbTH8jG1Hrfahyb7/Cr/8obbREhfqtZyAk
         ew5b1togA2K/AD0a+pcmQfiSMiueHih0aAGHXd33BoHqGGQf4s0/tGhG7Um/47udi9Jo
         wcd6zdpTyrbd04Vh+XFTZEbsdpJaIAjLMlh3iVRKLdboB/QcHDxg0rtCwn0KP/pBWxez
         MMbNlO3f6EO0IvGU5rTAiAWFHoBGI1FjDdVnwx7gJCRyCn+kS6bp3SuNpqFrfdvAAGAq
         VqjyFlK/4N7AfsAtsm0bwY8VHzne4H7FYeFPLZY7hqDskcnjsYtGsqWX9yyO0i1GndmS
         UfGQ==
X-Gm-Message-State: ANhLgQ3kkaemrn+rKMOiQsY+E1aCSRaLzZjCo/NzEHjzd6sD80DlPnNi
        HJ3lmRCfkZpQ3uon4TqIa80djL8noUEinaF/aP1q6klYuUV4N2ICtGAu2gqDdJQW7KnODieUOND
        6AwGH2fX3qeLXYRapCRIpyCcQ
X-Received: by 2002:a1c:f409:: with SMTP id z9mr1104039wma.51.1585244586896;
        Thu, 26 Mar 2020 10:43:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMPwHwvPhttNZ6hV7WchIpLI2fmUMkAhr+s1EXwiqdIt4GRMnfd7iJuY6ed0EETpPwr/6N7A==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr1104010wma.51.1585244586553;
        Thu, 26 Mar 2020 10:43:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p13sm4605885wru.3.2020.03.26.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:43:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
In-Reply-To: <20200326170518.GA14314@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com> <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea>
Date:   Thu, 26 Mar 2020 18:43:04 +0100
Message-ID: <87pncz3tcn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Thu, Mar 26, 2020 at 03:31:20PM +0100, Vitaly Kuznetsov wrote:
>> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
>> 
>> > When Hyper-V sends an interrupt to the guest, the guest has to figure
>> > out which channel the interrupt is associated with.  Hyper-V sets a bit
>> > in a memory page that is shared with the guest, indicating a particular
>> > "relid" that the interrupt is associated with.  The current Linux code
>> > then uses a set of per-CPU linked lists to map a given "relid" to a
>> > pointer to a channel structure.
>> >
>> > This design introduces a synchronization problem if the CPU that Hyper-V
>> > will interrupt for a certain channel is changed.  If the interrupt comes
>> > on the "old CPU" and the channel was already moved to the per-CPU list
>> > of the "new CPU", then the relid -> channel mapping will fail and the
>> > interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
>> > but the channel was not moved to the per-CPU list of the new CPU, then
>> > the mapping will fail and the interrupt is dropped.
>> >
>> > Relids are integers ranging from 0 to 2047.  The mapping from relids to
>> > channel structures can be done by setting up an array with 2048 entries,
>> > each entry being a pointer to a channel structure (hence total size ~16K
>> > bytes, which is not a problem).  The array is global, so there are no
>> > per-CPU linked lists to update.   The array can be searched and updated
>> > by simply loading and storing the array at the specified index.  With no
>> > per-CPU data structures, the above mentioned synchronization problem is
>> > avoided and the relid2channel() function gets simpler.
>> >
>> > Suggested-by: Michael Kelley <mikelley@microsoft.com>
>> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>> > ---
>> >  drivers/hv/channel_mgmt.c | 158 ++++++++++++++++++++++----------------
>> >  drivers/hv/connection.c   |  38 +++------
>> >  drivers/hv/hv.c           |   2 -
>> >  drivers/hv/hyperv_vmbus.h |  14 ++--
>> >  drivers/hv/vmbus_drv.c    |  48 +++++++-----
>> >  include/linux/hyperv.h    |   5 --
>> >  6 files changed, 139 insertions(+), 126 deletions(-)
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index 1191f3d76d111..9b1449c839575 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -319,7 +319,6 @@ static struct vmbus_channel *alloc_channel(void)
>> >  	init_completion(&channel->rescind_event);
>> >  
>> >  	INIT_LIST_HEAD(&channel->sc_list);
>> > -	INIT_LIST_HEAD(&channel->percpu_list);
>> >  
>> >  	tasklet_init(&channel->callback_event,
>> >  		     vmbus_on_event, (unsigned long)channel);
>> > @@ -340,23 +339,28 @@ static void free_channel(struct vmbus_channel *channel)
>> >  	kobject_put(&channel->kobj);
>> >  }
>> >  
>> > -static void percpu_channel_enq(void *arg)
>> > +void vmbus_channel_map_relid(struct vmbus_channel *channel)
>> >  {
>> > -	struct vmbus_channel *channel = arg;
>> > -	struct hv_per_cpu_context *hv_cpu
>> > -		= this_cpu_ptr(hv_context.cpu_context);
>> > -
>> > -	list_add_tail_rcu(&channel->percpu_list, &hv_cpu->chan_list);
>> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
>> > +		return;
>> > +	/*
>> > +	 * Pairs with the READ_ONCE() in vmbus_chan_sched().  Guarantees
>> > +	 * that vmbus_chan_sched() will find up-to-date data.
>> > +	 */
>> > +	smp_store_release(
>> > +		&vmbus_connection.channels[channel->offermsg.child_relid],
>> > +		channel);
>> >  }
>> >  
>> > -static void percpu_channel_deq(void *arg)
>> > +void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
>> >  {
>> > -	struct vmbus_channel *channel = arg;
>> > -
>> > -	list_del_rcu(&channel->percpu_list);
>> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
>> > +		return;
>> > +	WRITE_ONCE(
>> > +		vmbus_connection.channels[channel->offermsg.child_relid],
>> > +		NULL);
>> 
>> I don't think this smp_store_release()/WRITE_ONCE() fanciness gives you
>> anything. Basically, without proper synchronization with a lock there is
>> no such constructions which will give you any additional guarantee on
>> top of just doing X=1. E.g. smp_store_release() is just 
>>   barrier();
>>   *p = v;
>> if I'm not mistaken. Nobody tells you when *some other CPU* will see the
>> update - 'eventually' is your best guess. Here, you're only setting one
>> pointer.
>> 
>> Percpu structures have an advantage: we (almost) never access them from
>> different CPUs so just doing updates atomically (and writing 64bit
>> pointer on x86_64 is atomic) is OK.
>> 
>> I haven't looked at all possible scenarios but I'd suggest protecting
>> this array with a spinlock (in case we can have simultaneous accesses
>> from different CPUs and care about the result, of course).
>
> The smp_store_release()+READ_ONCE() pair should guarantee that any store
> to the channel fields performed before (in program order) the "mapping"
> of the channel are visible to the CPU which observes that mapping; this
> guarantee is expected to hold for all architectures.

Yes, basically the order is preserved (but no guarantees WHEN another
CPU will see it).

>
> Notice that this apporach follows the current/upstream code, cf. the
> rcu_assign_pointer() in list_add_tail_rcu() and notice that (both before
> and after this series) vmbus_chan_sched() accesses the channel array
> without any mutex/lock held.
>
> I'd be inclined to stick to the current code (unless more turns out to
> be required).  Thoughts?

Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
per-cpu list of channels on the same CPU so we don't need a spinlock to
guarantee that during an interrupt we'll be able to see the update if it
happened before the interrupt (in chronological order). With a global
list of relids, who guarantees that an interrupt handler on another CPU
will actually see the modified list? 

-- 
Vitaly

