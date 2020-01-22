Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD0144932
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 02:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAVBGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 20:06:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728609AbgAVBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579655199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viOBq0Oy9N+6NbeXzcqoYU7boYVlTm9ZppUHXuFh0Mo=;
        b=f9X20gY0vEDC2cfQs+LqQjBXyVrFlIQasXZi2Xie4XVIJn7zgF02bX0KpjWmvjykHRDcHD
        FcMh9SL7EK6Njj2R75bZBeS0trTherFo5fuzghb7QvymbtpHDtHjM/2TfIo7Ss60SCXCQ/
        kpinLq2YGC0TQy8btw5ETfjw+KPBQnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-zW94sMSePQK3sgoIck_AWw-1; Tue, 21 Jan 2020 20:06:37 -0500
X-MC-Unique: zW94sMSePQK3sgoIck_AWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3676C107ACC4;
        Wed, 22 Jan 2020 01:06:36 +0000 (UTC)
Received: from [10.10.120.159] (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CEA360BE0;
        Wed, 22 Jan 2020 01:06:34 +0000 (UTC)
Subject: Re: [v2] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     Josef Bacik <josef@toxicpanda.com>, Sun Ke <sunke32@huawei.com>,
        axboe@kernel.dk
References: <20200120124549.27648-1-sunke32@huawei.com>
 <8bb961fe-3412-9c3c-ad9b-54d446e90bf0@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E27A01A.3040600@redhat.com>
Date:   Tue, 21 Jan 2020 19:06:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <8bb961fe-3412-9c3c-ad9b-54d446e90bf0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/2020 08:09 AM, Josef Bacik wrote:
> On 1/20/20 7:45 AM, Sun Ke wrote:
>> Open /dev/nbdX first, the config_refs will be 1 and
>> the pointers in nbd_device are still null. Disconnect
>> /dev/nbdX, then reference a null recv_workq. The
>> protection by config_refs in nbd_genl_disconnect is useless.
>>
>> To fix it, just add a check for a non null task_recv in
>> nbd_genl_disconnect.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v1 -> v2:
>>
>> add an omitted mutex_unlock.
>> ---
>>   drivers/block/nbd.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b4607dd96185..668bc9cb92ed 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -2008,6 +2008,10 @@ static int nbd_genl_disconnect(struct sk_buff
>> *skb, struct genl_info *info)
>>                  index);
>>           return -EINVAL;
>>       }
>> +    if (!nbd->task_recv) {
>> +        mutex_unlock(&nbd_index_mutex);
>> +        return -EINVAL;
>> +    }
>>       if (!refcount_inc_not_zero(&nbd->refs)) {
>>           mutex_unlock(&nbd_index_mutex);
>>           printk(KERN_ERR "nbd: device at index %d is going down\n",
>>
> 
> This doesn't even really protect us, we need to have the
> nbd->config_lock held here to make sure it's ok.  The IOCTL path is safe
> because it creates the device on open so it's sure to exist by the time
> we get to the disconnect, we don't have that for genl_disconnect.  So
> I'd add the config_mutex before getting the config_ref, and then do the
> check, something like
> 
> mutex_lock(&nbd->config_lock);
> if (!refcount_inc_not_zero(&nbd->refs)) {
> }
> if (!nbd->recv_workq) {
> }
> mutex_unlock(&nbd->config_lock);
> 

We will be doing a mix of checks/behavior. Maybe we want to settle on one?

It seems the code, before my patch, would let you do a open() then do a
nbd_genl_disconnect. This function would then try to cleanup what it
could and return success.

To keep the current behavior/style in nbd_disconnect_and_put would you
want to do:

nbd_disconnect_and_put()

....

if (nbd->task_recv)
       flush_workqueue(nbd->recv_workq);

?

Alternatively, I think if we want to make it so calling
nbd_genl_disconnect is not allowed on a device that we have not done a
successful nbd_genl_connect/nbd_start_device call on then we want to add
the new state bit to indicate nbd_start_device was successful.

Or, we could stick to one variable that gets set at start and always use
that to indicate nbd_start_device was called ok. For example, for
nbd_genl_reconfigure we already check if task_recv is set to check if
nbd_start_device was called successfully.


