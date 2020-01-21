Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE42143EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAUOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:09:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46860 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:09:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so2717112qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXMAlZrf6RWqgu1sZHLz9u+/Sa6aM/FrrOMx7Y5CS+U=;
        b=U0aT5pb5FoHZj5lISYTKH5SvegT1CwAlwWnXDVcU6MVD4WJMBL4/fWmH1qaQ2YSwUV
         eUXDAKu0ADfvrB0kuVG3ZhJ0AFq553As9ukd2UrMxzPtIK+LiURUpvHSl4wYJIKZLBZ5
         WMwphxiW4auh9oesjHPDimGLxo8R9n5B0fbppZnIpAFIXoR3uJjUew7y4/89ys4+beRZ
         QkR7UWQNR0zBXPk/LXNixzs7s7gxbAsWgNl9mMzREHTzbL9lrXbV8PbBvAg1vqP4sr8/
         fiTKtismOtboFx20pNHqT6F4HVs5/5aEcnHto8mWtBPrHQfh/bp8eMbnR7b94ejl/g3z
         KTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXMAlZrf6RWqgu1sZHLz9u+/Sa6aM/FrrOMx7Y5CS+U=;
        b=CrQP3bsS1sY7m7N7St4dtI2WsAXEPjEi1yolhaY5LW/v9qQ6hWV3aRp53urG0VafHV
         VVAX3E05tUaNj0SxZmBNWn8yYRPVlMIcUSVjoR5VYi6yELBScnc0GP5yYb8dgvdSlUJL
         YEK9kwYKsPZyjAlHFgQQvN4YHA1XV2Xhxc/J6+4AymqrBASKdYxeIqz3QR6uIbKxdijO
         QkyQHNwYzCf9wd2jD/CQqpkRsCLJgn5/5GJaDK8OR1HOsTynb78PRew76q0IBVoTGQ45
         X4XHUgSUMLOCY2kAlSMW4h8orDlGmi0r2qjaQzzW8EPYUpCtI0o7VWC05Ssud/cW60F1
         WjOA==
X-Gm-Message-State: APjAAAVkwRGTO/UbScGuOzZP89VBbtVhJWx4PiSxNfEz/HZwOgAPNdXd
        kwk6bCOJNbHejmrZkZ1OFYXVyHTtgSqw6Q==
X-Google-Smtp-Source: APXvYqzbepHCf8odvOuFZORhg4stdqBChkK/lRhRxCuHcOGffbvJ/jV9yysnaPWYPxVgZaBof9w8Sw==
X-Received: by 2002:a37:b783:: with SMTP id h125mr4507737qkf.75.1579615768137;
        Tue, 21 Jan 2020 06:09:28 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::822a])
        by smtp.gmail.com with ESMTPSA id r28sm19712087qtr.3.2020.01.21.06.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:09:27 -0800 (PST)
Subject: Re: [v2] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200120124549.27648-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8bb961fe-3412-9c3c-ad9b-54d446e90bf0@toxicpanda.com>
Date:   Tue, 21 Jan 2020 09:09:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120124549.27648-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 7:45 AM, Sun Ke wrote:
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
> 
> add an omitted mutex_unlock.
> ---
>   drivers/block/nbd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..668bc9cb92ed 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2008,6 +2008,10 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>   		       index);
>   		return -EINVAL;
>   	}
> +	if (!nbd->task_recv) {
> +		mutex_unlock(&nbd_index_mutex);
> +		return -EINVAL;
> +	}
>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>   		mutex_unlock(&nbd_index_mutex);
>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
> 

This doesn't even really protect us, we need to have the nbd->config_lock held 
here to make sure it's ok.  The IOCTL path is safe because it creates the device 
on open so it's sure to exist by the time we get to the disconnect, we don't 
have that for genl_disconnect.  So I'd add the config_mutex before getting the 
config_ref, and then do the check, something like

mutex_lock(&nbd->config_lock);
if (!refcount_inc_not_zero(&nbd->refs)) {
}
if (!nbd->recv_workq) {
}
mutex_unlock(&nbd->config_lock);

Thanks,

Josef
