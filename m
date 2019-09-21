Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB96B9BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 03:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436985AbfIUBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 21:49:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35755 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfIUBt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:49:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so9279409qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FeqXKSmrKgPryn0IKpLutsFyfvdRW6HQixGEpZvfgYU=;
        b=ivuU0aupOrzdi7aeGFvRG+9Q3gOwo6HMwbTO14y4SlF1WyIBCE+57GfqAHOw+lUQNQ
         jEMvvu+KrSwrWkJ5+eZ/9PYnzCjdBjHiy8uTCBKoeCDnMhNwF6dZpNgXBY5r7T4owBbM
         EA0K8+wMK4rHF1/vxDvcQDsSwmZBHP1nuikZUcVTg3/Q3rsfpShMNT1x9JOrJeFtz5Kk
         +Qy7UVrTd3xw0loXH5qn8im1RW1PS8pR3pwMkb8I7C7OXNrTba5jbEQSVRuDV2vzdB3K
         5Q64RQUiX0CKWeZCuc56VQRMD0L0bohoDOJR1xt5QwYSG1SxIatvOnoNAVu/9snFMqX1
         P+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FeqXKSmrKgPryn0IKpLutsFyfvdRW6HQixGEpZvfgYU=;
        b=QMOtNll/dcWkJlhZMm5IIqUbbwWvlLX6Myg9/mI8EA6QFmfRNZJQ8JcscrGaNZs/Cg
         g2tI8/gQIY8iOPwcE8CXQc4MrN5o3f20pIQG6CKLH6DZd+JxcsZaob7WNdvg9teXJg0N
         nTeN/XYNxsD2dHVJhkSZ3oEA91pJ9mqh/e46DSta0eG45SdpnLEpTJ5PbZEpDR8wFDpy
         yA1VVyd9kvWC0mvypTDKmrk9UxVS/loLXnxaGRvV89VQV15yYr1t+H3LhsX0rRVScK9r
         KDiy/8yivsRGoFSE6DXr6kvC3uDL2CegPu6hWBOQ0+EcVkvrZuVsQNENwtokOiAFWaGy
         c4NQ==
X-Gm-Message-State: APjAAAUxhokrMJgYgSuOQ67Yl/zMdPPDJa5AaIQXzKzYhjCpGtFhMf0N
        85wmbK3yJj2EV10Du0tv0iU7Lw==
X-Google-Smtp-Source: APXvYqy3TI36UEKri6vTjhOUCqw4ubZxj6nMjgp2ss02bQkJ8QlGCRYx405pw6P7fPjs52t18v2LGg==
X-Received: by 2002:a05:620a:13c5:: with SMTP id g5mr7077761qkl.475.1569030598344;
        Fri, 20 Sep 2019 18:49:58 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 200sm1764206qkf.65.2019.09.20.18.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 18:49:57 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:49:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net: release skb on failure
Message-ID: <20190920184642.3c36d26b@cakuba.netronome.com>
In-Reply-To: <20190918044521.14953-1-navid.emamdoost@gmail.com>
References: <20190918044521.14953-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 23:45:21 -0500, Navid Emamdoost wrote:
> In ql_run_loopback_test, ql_lb_send does not release skb when fails. So
> it must be released before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c | 4 +++-

Thanks for the patch, this driver has been moved, please see

commit 955315b0dc8c8641311430f40fbe53990ba40e33
Author: Benjamin Poirier <bpoirier@suse.com>
Date:   Tue Jul 23 15:14:13 2019 +0900

    qlge: Move drivers/net/ethernet/qlogic/qlge/ to
    drivers/staging/qlge/ 
    The hardware has been declared EOL by the vendor more than 5 years
    ago. What's more relevant to the Linux kernel is that the quality
    of this driver is not on par with many other mainline drivers.
    
    Cc: Manish Chopra <manishc@marvell.com>
    Message-id: <20190617074858.32467-1-bpoirier@suse.com>
    Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Could you rebase, and send the new version to GregKH as he is the
stable maintainer?

>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
> index a6886cc5654c..d539b71b2a5c 100644
> --- a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
> +++ b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
> @@ -544,8 +544,10 @@ static int ql_run_loopback_test(struct ql_adapter *qdev)
>  		skb_put(skb, size);
>  		ql_create_lb_frame(skb, size);
>  		rc = ql_lb_send(skb, qdev->ndev);
> -		if (rc != NETDEV_TX_OK)
> +		if (rc != NETDEV_TX_OK) {
> +			dev_kfree_skb_any(skb);
>  			return -EPIPE;
> +		}
>  		atomic_inc(&qdev->lb_count);
>  	}
>  	/* Give queue time to settle before testing results. */

