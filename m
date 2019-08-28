Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910199FC43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfH1Hy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:54:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Hy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:54:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 86B8728A7BD
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Add host command AP sleep
 state support
To:     Yilun Lin <yllin@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     pihsun@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
References: <20190814081757.65056-1-yllin@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2974b535-8b0d-3ae3-4ce6-7fa014243ca2@collabora.com>
Date:   Wed, 28 Aug 2019 09:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814081757.65056-1-yllin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/8/19 10:17, Yilun Lin wrote:
> Add EC host command to inform EC of AP suspend/resume status.
> 
> Signed-off-by: Yilun Lin <yllin@chromium.org>

Applied for 5.4. Thanks,

 Enric

> ---
> 
>  drivers/platform/chrome/cros_ec_rpmsg.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index 5d3fb2abad1d..6f34fe629e2c 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -236,6 +236,25 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
>  	cancel_work_sync(&ec_rpmsg->host_event_work);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_ec_rpmsg_suspend(struct device *dev)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +	return cros_ec_suspend(ec_dev);
> +}
> +
> +static int cros_ec_rpmsg_resume(struct device *dev)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +	return cros_ec_resume(ec_dev);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
> +			 cros_ec_rpmsg_resume);
> +
>  static const struct of_device_id cros_ec_rpmsg_of_match[] = {
>  	{ .compatible = "google,cros-ec-rpmsg", },
>  	{ }
> @@ -246,6 +265,7 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
>  	.drv = {
>  		.name   = "cros-ec-rpmsg",
>  		.of_match_table = cros_ec_rpmsg_of_match,
> +		.pm	= &cros_ec_rpmsg_pm_ops,
>  	},
>  	.probe		= cros_ec_rpmsg_probe,
>  	.remove		= cros_ec_rpmsg_remove,
> 
