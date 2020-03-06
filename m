Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1D17B52C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 05:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCFD75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 22:59:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41127 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFD74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:59:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so438191pgm.8;
        Thu, 05 Mar 2020 19:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fTHfeEGAKUEx09sh7hreY5/yhd9fkPYMGk68O4GQCQg=;
        b=PUcarrjbiWaX0Rz1vdBcrA3yfUMAw8e+Atf96hJeBtwAqJN70Y4poAxEKzUxEnzSsY
         odGxQJnpTsJBJ86fKUNXt2hGyNiOsDdjIbB4Amfxqnoj2pf+SUwk8EGrFiT9TCKtmQuV
         DDhF3OFqRURWzQDi+bnOKdRvJJ8S7ASP9ZzfX6imLHTS4Ep8zc8SFSffajJ4dF1BZMqV
         Rp2Lh0ZOv+BdRzhdo3SxD/TVvbTY9ARexO83cxJF+p+7y1QiY4f/45GBNNhdpDpviR5E
         YM5bHE/CCuNXScULRfE/a5CE25GZO+iCuJwAltYHpgUdxWQgHqZAgKczjy9mz4ZBwpQy
         MWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTHfeEGAKUEx09sh7hreY5/yhd9fkPYMGk68O4GQCQg=;
        b=o04HvcNh3xOpydurLcEATp25ZUyeNyJ9yHcsyUFTxiK4oQdYxXYu8QEvHysQWt1U6K
         +ztDEuhnTogw6bKYvBFauTV9c5cjxAEHqFG3+Lp4kTzytPb2Xa3Th4AaAIGMmbUW+RDY
         pF924A/r0B5LmyNU8INp4ufPeAJFt6ksrom5iJ5ackn0dGDSJfI/VBDvsTQNyHpzzBDz
         KgZRImiZRGYkDYfqmovTXHlv+RHZNE741qWxtGnjII0U7Vh02iHHwkS1jOi/87kfnbRm
         nZ2qhhGqmFLS7to9Uh7wwErrjChVw1zbAWmYu9wlbFK/bD5zrpaP/UOe4oC0WkoYd0WT
         SEAg==
X-Gm-Message-State: ANhLgQ090hFev8o5pS+P4cesf/CkvSUdu0UccDf4HVtlaLM5tII44AKE
        THaN2p191d/6mPUNgbaXwRrBFxAwtOU=
X-Google-Smtp-Source: ADFU+vumLorMOD36Y6V1YPaG/n5y6GEDPX5EPyx/31sT9LIIiW1Y/t2fQdgWUN7brLM19dr6T7ni6A==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr1340495pgh.53.1583467193889;
        Thu, 05 Mar 2020 19:59:53 -0800 (PST)
Received: from [192.168.1.5] ([110.77.155.127])
        by smtp.googlemail.com with ESMTPSA id z3sm7632414pjr.46.2020.03.05.19.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 19:59:53 -0800 (PST)
Subject: Re: [PATCH] Add a new PID for HP
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw, roger@labau.com.tw,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306024048.11408-1-scott@labau.com.tw>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <bc753e9a-6624-0f17-725e-f54144e5a281@gmail.com>
Date:   Fri, 6 Mar 2020 10:59:48 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200306024048.11408-1-scott@labau.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2020 09:40, Scott Chen wrote:
> Add a device id for HP LD381 Display
> LD381:   03f0:0f7f
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>
> ---
>   drivers/usb/serial/pl2303.c | 1 +
>   drivers/usb/serial/pl2303.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index aab737e1e7b6..5cb1c63295f5 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -97,6 +97,7 @@ static const struct usb_device_id id_table[] = {
>   	{ USB_DEVICE(COREGA_VENDOR_ID, COREGA_PRODUCT_ID) },
>   	{ USB_DEVICE(YCCABLE_VENDOR_ID, YCCABLE_PRODUCT_ID) },
>   	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
> +	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381_PRODUCT_ID) },
>   	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
>   	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
>   	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
> diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
> index a019ea7e6e0e..80b20e980064 100644
> --- a/drivers/usb/serial/pl2303.h
> +++ b/drivers/usb/serial/pl2303.h
> @@ -127,6 +127,7 @@
>   
>   /* Hewlett-Packard POS Pole Displays */
>   #define HP_VENDOR_ID		0x03f0
> +#define HP_LD381_PRODUCT_ID	0x0f7f
>   #define HP_LM920_PRODUCT_ID	0x026b
>   #define HP_TD620_PRODUCT_ID	0x0956
>   #define HP_LD960_PRODUCT_ID	0x0b39
> 

The tables were sorted on product id, not product name, before you 
entered this one.

br
/Lars
