Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9451910290E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKSQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 11:13:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33970 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:13:37 -0500
Received: by mail-io1-f67.google.com with SMTP id q83so23895279iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CuQtXznqoyz5kssTjNmYau458WwEA/pCkBJj2OVVqhw=;
        b=Y5yP5yxkELILFBRuBu782FQosIibbXWrJ8k7FKQ7MfRe6h15lWXrRvR/RpmAanLRyb
         sOHSEKJc89xwSjmr0aegjdhW95nfNpI0UBLLh/Dod62dh7jjr0LmY5JpGhIWiQFzl4TD
         TqqIeS4cy8gEAvmpofDPnro5dCnkUcrWaIFQ5SNWHTKLsb1snDYcJaA15KuscmjBbAis
         aU3lD8Ws7FIG/mm/iqeJvgZaE3kh+ku6pu5ubn37PAFNRkVs9omWdk3Txfk8JteJpZBr
         keK4Ips74YC+7A92ul65nGHBp+l0JtVT6IBmXKVW70OM9pqqrn0Pf4YuMMHNaOcwr9kj
         3/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuQtXznqoyz5kssTjNmYau458WwEA/pCkBJj2OVVqhw=;
        b=FqN6smmmnA9F90PrEV9bM8JQ4w5a3MT8vs0n7pJ92NZyX5Xq+tB47q9oJLze6XOulk
         W5zedVe8VCDPgsf+ZFOAu/b9bUoqTFfj/m8SPyqLETAzPRENeIrZObbSgxJeX38G0Sl4
         3eNuL2EttCt6mif+5ls6vHrVuvnErJuEXLRvUwS1YkAapfYoLCN5YK739NBTV6Jg6oI8
         ZueoM24xldJUDNWJqY1PdJjeXPI9D8Nk2taREDk/l1Q3JlVpcHZ0k/MFGUvLM+HCgTEZ
         j/RoMOoImN0eq9tv+yeAaRXB1dJJvQLdyAQCsf2MJxi+5JScJ9mu0TzMz7ku8O+pMyH+
         I+fw==
X-Gm-Message-State: APjAAAXOOn08MXwKbZbWpchTFKX1Qvl2tZcjfeN7V5+RRjXDjGk1ZEFo
        vZcQXSv6yCR80ArdtUpjlsRxvQ==
X-Google-Smtp-Source: APXvYqyrsEqORsYQXRnAbGvk2VKAQluxp4RFlBrdGsPXjw9zQza5QmSohcjFAyNMdDM3atBr+47PwQ==
X-Received: by 2002:a05:6602:251a:: with SMTP id i26mr18935296ioe.302.1574180016622;
        Tue, 19 Nov 2019 08:13:36 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t11sm5546611ild.38.2019.11.19.08.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:13:35 -0800 (PST)
Subject: Re: [v2] nbd:fix memory leak in nbd_get_socket()
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
References: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d68d17be-0c4e-1286-4327-0e3ba6600eca@kernel.dk>
Date:   Tue, 19 Nov 2019 09:13:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 11:09 PM, Sun Ke wrote:
> Before return NULL,put the sock first.
> 
> Cc: stable@vger.kernel.org
> Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Please always CC the author of the patch you're fixing.

Mike, Josef - we probably need to get this upstream ASAP.

> ---
> v2: add cc:stable tag
> ---
>   drivers/block/nbd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index a94ee45..19e7599 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -993,6 +993,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>   	if (sock->ops->shutdown == sock_no_shutdown) {
>   		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
>   		*err = -EINVAL;
> +		sockfd_put(sock);
>   		return NULL;
>   	}
>   
> 


-- 
Jens Axboe

