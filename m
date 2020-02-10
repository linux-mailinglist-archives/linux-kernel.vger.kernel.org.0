Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709B415806F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBJRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:05:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727558AbgBJRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581354348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrFG4yx5KHZJPEp8JCGY2d7GTCuNuHloXmrmr/9oJ2w=;
        b=VyjQ+zMwGvRB4QT9oH3mDDqTf+s3ySGg1GkMPup3zj30lfz1opWRwvjw38KjBeW2IVdEIf
        lDBzS5+CVxEQXbdNu5v/f8SKO2eFChJ2NVDZ46tFh8ntBnu+Iaw5mJdetH4N+eSY/mverO
        /aFeknOVyeVPRUAitHTVxkTCnH9e4JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-ig_F83XcMheKg367QqKYBw-1; Mon, 10 Feb 2020 12:05:41 -0500
X-MC-Unique: ig_F83XcMheKg367QqKYBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FB18017DF;
        Mon, 10 Feb 2020 17:05:40 +0000 (UTC)
Received: from [10.10.123.157] (ovpn-123-157.rdu2.redhat.com [10.10.123.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC3B15C108;
        Mon, 10 Feb 2020 17:05:38 +0000 (UTC)
Subject: Re: [v3] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com, axboe@kernel.dk
References: <20200210073241.41813-1-sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E418D62.8090102@redhat.com>
Date:   Mon, 10 Feb 2020 11:05:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200210073241.41813-1-sunke32@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2020 01:32 AM, Sun Ke wrote:
> Open /dev/nbdX first, the config_refs will be 1 and
> the pointers in nbd_device are still null. Disconnect
> /dev/nbdX, then reference a null recv_workq. The
> protection by config_refs in nbd_genl_disconnect is useless.
> 
> To fix it, just add a check for a non null task_recv in
> nbd_genl_disconnect.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> v1 -> v2:
> Add an omitted mutex_unlock.
> 
> v2 -> v3:
> Add nbd->config_lock, suggested by Josef.
> ---
>  drivers/block/nbd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..870b3fd0c101 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2008,12 +2008,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>  		       index);
>  		return -EINVAL;
>  	}
> +	mutex_lock(&nbd->config_lock);
>  	if (!refcount_inc_not_zero(&nbd->refs)) {
> +		mutex_unlock(&nbd->config_lock);
>  		mutex_unlock(&nbd_index_mutex);
>  		printk(KERN_ERR "nbd: device at index %d is going down\n",
>  		       index);
>  		return -EINVAL;
>  	}
> +	if (!nbd->recv_workq) {
> +		mutex_unlock(&nbd->config_lock);
> +		mutex_unlock(&nbd_index_mutex);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&nbd->config_lock);
>  	mutex_unlock(&nbd_index_mutex);
>  	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>  		nbd_put(nbd);
>

With my other patch then we will not need this right? It handles your
case by just being integrated with the existing checks in:

nbd_disconnect_and_put->nbd_clear_sock->sock_shutdown

...

static void sock_shutdown(struct nbd_device *nbd)
{

....

        if (config->num_connections == 0)
                return;


num_connections is zero for your case since we never did a
nbd_genl_disconnect so we would return here.

