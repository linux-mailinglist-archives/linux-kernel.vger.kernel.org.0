Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDBAFE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfIKNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 09:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfIKNwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:52:32 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC307A76C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:52:31 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id c8so9866835qtd.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTpTDYaW4L1Gk4pQTaJgOsQGofG8+keatPi5K+boUSM=;
        b=lm7TWnQhOwO1dJ0McoeUfgQKP27C0aI2/PvOrWGY0RDSOIejkcY51o+l3+uMtHyats
         EyFqJ0N7euB8Fr7xDHos+TwOPUPJ3CH7b8niPlkIpVkqsV4eMtybrxMyxIWgK8+FlL9C
         94k29+O4E8CMjIvHumF9NWAHf0vgW6nUFjOvoXCBmv/rOOsQj/dOJAc37ePjrLkv4m3a
         l4/4itRaELRyOMs3tIRUX3ENOc9sJkQ4/1nUd5M8D8Ocmlyv/GTiyebOXUGtfBg+XgAZ
         OyrVa7oImrGBXUKD4GuBQcfogdjeG//7lAKco0W7Y/EoOw4rgJ/SfP3zO+nTtLSVsbrC
         c52w==
X-Gm-Message-State: APjAAAWQhJMd5Pc6UIQekUIQbpuPzNDgR5fdTlEaFXkkAa36bBGAnHF4
        Kk/FimHSYWnHmlvxA0AF60tRspPu6MlpEvSfFm0ktZpCqpQ1cfjcWT1uRhu2zKb9CgWu+jj/89Y
        qIc+FhSqBZQfxpnZVxYA/wdmg
X-Received: by 2002:a37:4651:: with SMTP id t78mr35308379qka.259.1568209950747;
        Wed, 11 Sep 2019 06:52:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAArEKuceihQtc6r95FHhQta9AhTzn+LrxDRMztlrzqQf2WbTHO7axIccFjavXyHt6DHiEWw==
X-Received: by 2002:a37:4651:: with SMTP id t78mr35308358qka.259.1568209950581;
        Wed, 11 Sep 2019 06:52:30 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id n62sm9969475qkd.124.2019.09.11.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 06:52:29 -0700 (PDT)
Date:   Wed, 11 Sep 2019 09:52:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911095147-mutt-send-email-mst@kernel.org>
References: <20190911120908.28410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911120908.28410-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:10:00AM -0400, Michael S. Tsirkin wrote:
> iovec addresses coming from vhost are assumed to be
> pre-validated, but in fact can be speculated to a value
> out of range.
> 
> Userspace address are later validated with array_index_nospec so we can
> be sure kernel info does not leak through these addresses, but vhost
> must also not leak userspace info outside the allowed memory table to
> guests.
> 
> Following the defence in depth principle, make sure
> the address is not validated out of node range.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Tested-by: Jason Wang <jasowang@redhat.com>
> ---

Cc: security@kernel.org

Pls advise on whether you'd like me to merge this directly,
Cc stable, or handle it in some other way.

> changes from v1: fix build on 32 bit
> 
>  drivers/vhost/vhost.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5dc174ac8cac..34ea219936e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2071,8 +2071,10 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>  		_iov = iov + ret;
>  		size = node->size - addr + node->start;
>  		_iov->iov_len = min((u64)len - s, size);
> -		_iov->iov_base = (void __user *)(unsigned long)
> -			(node->userspace_addr + addr - node->start);
> +		_iov->iov_base = (void __user *)
> +			((unsigned long)node->userspace_addr +
> +			 array_index_nospec((unsigned long)(addr - node->start),
> +					    node->size));
>  		s += size;
>  		addr += size;
>  		++ret;
> -- 
> MST
