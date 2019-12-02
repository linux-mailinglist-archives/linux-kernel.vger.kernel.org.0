Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D551F10E970
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLBLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 06:16:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60946 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfLBLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:16:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6522E28DB10
Subject: Re: [PATCH] platform/chrome: wilco_ec: fix use after free issue
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Benson Leung <bleung@chromium.org>
Cc:     xlpang@linux.alibaba.com, Nick Crews <ncrews@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20191130130842.33763-1-wenyang@linux.alibaba.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5d19df91-ac9a-05a5-3636-c5f1594138a3@collabora.com>
Date:   Mon, 2 Dec 2019 12:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191130130842.33763-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On 30/11/19 14:08, Wen Yang wrote:
> This is caused by dereferencing 'dev_data' after put_device() in
> the telem_device_remove() function.
> This patch just moves the put_device() down a bit to avoid this
> issue.
> 
> Fixes: 1210d1e6bad1 ("platform/chrome: wilco_ec: Add telemetry char device interface")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Nick Crews <ncrews@chromium.org>
> Cc: linux-kernel@vger.kernel.org
> ---

Queued for 5.5 as is a fix.

Thanks.
 Enric

>  drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
> index b9d03c3..1176d54 100644
> --- a/drivers/platform/chrome/wilco_ec/telemetry.c
> +++ b/drivers/platform/chrome/wilco_ec/telemetry.c
> @@ -406,8 +406,8 @@ static int telem_device_remove(struct platform_device *pdev)
>  	struct telem_device_data *dev_data = platform_get_drvdata(pdev);
>  
>  	cdev_device_del(&dev_data->cdev, &dev_data->dev);
> -	put_device(&dev_data->dev);
>  	ida_simple_remove(&telem_ida, MINOR(dev_data->dev.devt));
> +	put_device(&dev_data->dev);
>  
>  	return 0;
>  }
> 
