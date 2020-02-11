Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90C6159520
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgBKQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:39:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728049AbgBKQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581439159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xky2KislxK5IxZzkAgr2Tmutbb9TMu3YGRpEz4bopS4=;
        b=EosOjjoopjcjr6VtDhLVLMR8e/GdggO0zd+gd63sAGv/6tSuXydGOQznX3PYon6Ci6b8TO
        mwA4Tthh6p+daTReZYSu+Jq1cAg6PwgQDlMtug0aobSG9WKRRDzgQDp2QZg32aiabI3yQq
        RcodaHgahwPuD7H0YYzu0uxnFShLP2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-V-cC41HZPnSqRFAyQOy5mA-1; Tue, 11 Feb 2020 11:39:17 -0500
X-MC-Unique: V-cC41HZPnSqRFAyQOy5mA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 972E810054E3;
        Tue, 11 Feb 2020 16:39:15 +0000 (UTC)
Received: from [10.10.123.148] (ovpn-123-148.rdu2.redhat.com [10.10.123.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A48F60BF1;
        Tue, 11 Feb 2020 16:39:14 +0000 (UTC)
Subject: Re: [v3] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     "sunke (E)" <sunke32@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk
References: <20200210073241.41813-1-sunke32@huawei.com>
 <5E418D62.8090102@redhat.com>
 <c3531fc5-73b3-6ef4-816e-97f491f45c18@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E42D8B1.406@redhat.com>
Date:   Tue, 11 Feb 2020 10:39:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <c3531fc5-73b3-6ef4-816e-97f491f45c18@huawei.com>
Content-Type: text/plain; charset=utf-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2020 10:12 PM, sunke (E) wrote:
>=20
>=20
> =E5=9C=A8 2020/2/11 1:05, Mike Christie =E5=86=99=E9=81=93:
>> On 02/10/2020 01:32 AM, Sun Ke wrote:
>>> Open /dev/nbdX first, the config_refs will be 1 and
>>> the pointers in nbd_device are still null. Disconnect
>>> /dev/nbdX, then reference a null recv_workq. The
>>> protection by config_refs in nbd_genl_disconnect is useless.
>>>
>>> To fix it, just add a check for a non null task_recv in
>>> nbd_genl_disconnect.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>> ---
>>> v1 -> v2:
>>> Add an omitted mutex_unlock.
>>>
>>> v2 -> v3:
>>> Add nbd->config_lock, suggested by Josef.
>>> ---
>>>   drivers/block/nbd.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index b4607dd96185..870b3fd0c101 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -2008,12 +2008,20 @@ static int nbd_genl_disconnect(struct sk_buff
>>> *skb, struct genl_info *info)
>>>                  index);
>>>           return -EINVAL;
>>>       }
>>> +    mutex_lock(&nbd->config_lock);
>>>       if (!refcount_inc_not_zero(&nbd->refs)) {
>>> +        mutex_unlock(&nbd->config_lock);
>>>           mutex_unlock(&nbd_index_mutex);
>>>           printk(KERN_ERR "nbd: device at index %d is going down\n",
>>>                  index);
>>>           return -EINVAL;
>>>       }
>>> +    if (!nbd->recv_workq) {
>>> +        mutex_unlock(&nbd->config_lock);
>>> +        mutex_unlock(&nbd_index_mutex);
>>> +        return -EINVAL;
>>> +    }
>>> +    mutex_unlock(&nbd->config_lock);
>>>       mutex_unlock(&nbd_index_mutex);
>>>       if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>>           nbd_put(nbd);
>>>
>>
>> With my other patch then we will not need this right? It handles your
>> case by just being integrated with the existing checks in:
>>
>> nbd_disconnect_and_put->nbd_clear_sock->sock_shutdown
>>
>> ...
>>
>> static void sock_shutdown(struct nbd_device *nbd)
>> {
>>
>> ....
>>
>>          if (config->num_connections =3D=3D 0)
>>                  return;
>>
>>
>> num_connections is zero for your case since we never did a
>> nbd_genl_disconnect so we would return here.
>>
>>
>> .
>>
> Hi Mike
>=20
> Your point is not right totally.
>=20
> Yes, config->num_connections is 0 and will return in sock_shutdown. The=
n
> it will back to nbd_disconnect_and_put and do flush_workqueue
> (nbd->recv_workq).
>=20
> nbd_disconnect_and_put
>     ->nbd_clear_sock
>         ->sock_shutdown
>     ->flush_workqueue
>=20

My patch removed that extra flush_workqueue in nbd_disconnect_and_put.

The idea of the patch was to move the flush calls to when we do
sock_shutdown in the config (connect, disconnect, clear sock) code
paths, because that is the time we know we will need to kill the recv
workers and wait for them to complete so we know they are not still
running when userspace does a new config operation.

