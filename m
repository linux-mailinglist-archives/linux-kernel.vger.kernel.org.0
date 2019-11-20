Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69D21040AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfKTQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:23:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfKTQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:23:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6715128CFC2
Subject: Re: [PATCH] platform/chrome: cros_usbpd_logger: add missed
 destroy_workqueue in remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
References: <20191113063821.8896-1-hslester96@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0d4c340d-7b4f-6efe-7643-97f848fa1f04@collabora.com>
Date:   Wed, 20 Nov 2019 17:22:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113063821.8896-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/19 7:38, Chuhong Yuan wrote:
> The driver forgets to destroy workqueue in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for 5.5

Thanks,
 Enric

> ---
>  drivers/platform/chrome/cros_usbpd_logger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
> index 2430e8b82810..374cdd1e868a 100644
> --- a/drivers/platform/chrome/cros_usbpd_logger.c
> +++ b/drivers/platform/chrome/cros_usbpd_logger.c
> @@ -224,6 +224,7 @@ static int cros_usbpd_logger_remove(struct platform_device *pd)
>  	struct logger_data *logger = platform_get_drvdata(pd);
>  
>  	cancel_delayed_work_sync(&logger->log_work);
> +	destroy_workqueue(logger->log_workqueue);
>  
>  	return 0;
>  }
> 
