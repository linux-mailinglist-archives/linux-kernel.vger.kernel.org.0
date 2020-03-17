Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D74187A31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 08:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCQHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 03:09:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCQHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:09:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2B300290EF2
Subject: Re: [PATCH] platform/chrome: wilco_ec: Provide correct output format
 to 'h1_gpio' file
To:     Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f1635547-2c18-b9d6-0fb2-2f69dcfd124e@collabora.com>
Date:   Tue, 17 Mar 2020 08:09:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/3/20 0:27, Bernardo Perez Priego wrote:
> Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
> this is being passed to 'send_ec_cmd' as type u8, thus, result
> is stored in least significant byte. Due to output format,
> the whole 'val' value was being displayed when any of the most
> significant bytes are different than zero.
> 
> This fix will make sure only least significant byte is displayed
> regardless of remaining bytes value.
> 
> Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>

Daniel, could you give a try and give you Tested-by tag if you're fine with it?

Thanks,
 Enric

> ---
>  drivers/platform/chrome/wilco_ec/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index df5a5f6c3ec6..c775b7d58c6d 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -211,7 +211,7 @@ static int h1_gpio_get(void *arg, u64 *val)
>  	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
>  }
>  
> -DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02hhx\n");
>  
>  /**
>   * test_event_set() - Sends command to EC to cause an EC test event.
> 
