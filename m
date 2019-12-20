Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB7127788
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLTIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 03:52:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLTIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:52:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CD75D292A7B
Subject: Re: [PATCH v2 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20191220004946.113151-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e64cc02a-ca4e-53e1-c0b6-4d38c7e95192@collabora.com>
Date:   Fri, 20 Dec 2019 09:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220004946.113151-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Please try to maintain versions and changelog consistently. I.e I see v2 here
but I guess you only send this patch not the full series, also I see that you
send v3 before this?

In general you should send the full series on every version and maintain a full
changelog.

I'd like to see v4 including all the series so it's clear from were we pick up
the patches.

On 20/12/19 1:49, Prashant Malani wrote:
> Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> subdevice on non-ACPI platforms.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

For v4 you can include:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> ---
> 
> Changes in v2:
> - Removed auto-generated Change-Id.
> 
>  drivers/mfd/cros_ec_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..1dde480f35b93 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> +#ifndef CONFIG_ACPI
> +	{ .name = "cros-usbpd-notify", },
> +#endif
>  };
>  
>  static const struct cros_feature_to_cells cros_subdevices[] = {
> 
