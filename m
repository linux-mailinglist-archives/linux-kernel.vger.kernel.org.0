Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962EE1358C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgAIMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 07:03:57 -0500
Received: from foss.arm.com ([217.140.110.172]:58044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgAIMD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:03:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7293831B;
        Thu,  9 Jan 2020 04:03:56 -0800 (PST)
Received: from [10.1.32.29] (e122027.cambridge.arm.com [10.1.32.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C6553F534;
        Thu,  9 Jan 2020 04:03:53 -0800 (PST)
Subject: Re: [PATCH v2 3/7] drm/panfrost: Improve error reporting in
 panfrost_gpu_power_on
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <20200108052337.65916-4-drinkcat@chromium.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3997e444-e388-929f-b764-537d62643bae@arm.com>
Date:   Thu, 9 Jan 2020 12:03:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108052337.65916-4-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2020 05:23, Nicolas Boichat wrote:
> It is useful to know which component cannot be powered on.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Looks like helpful error reporting.

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> 
> Was useful when trying to probe bifrost GPU, to understand what
> issue we are facing.
> ---
>   drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 8822ec13a0d619f..ba02bbfcf28c011 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -308,21 +308,26 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
>   	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
>   	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
>   		val, val == pfdev->features.l2_present, 100, 1000);
> +	if (ret)
> +		dev_err(pfdev->dev, "error powering up gpu L2");
>   
>   	gpu_write(pfdev, STACK_PWRON_LO, pfdev->features.stack_present);
> -	ret |= readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
> +	ret = readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
>   		val, val == pfdev->features.stack_present, 100, 1000);
> +	if (ret)
> +		dev_err(pfdev->dev, "error powering up gpu stack");

As mentioned in my previous email - we could just drop this entire section dealing with the core stacks and let the GPU's own dependency management code handle it. Of course there might be a GPU out there for which that is broken... in which case some sort of quirk handling will be needed :(

Steve

>   
>   	gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
> -	ret |= readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
> +	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
>   		val, val == pfdev->features.shader_present, 100, 1000);
> +	if (ret)
> +		dev_err(pfdev->dev, "error powering up gpu shader");
>   
>   	gpu_write(pfdev, TILER_PWRON_LO, pfdev->features.tiler_present);
> -	ret |= readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
> +	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
>   		val, val == pfdev->features.tiler_present, 100, 1000);
> -
>   	if (ret)
> -		dev_err(pfdev->dev, "error powering up gpu");
> +		dev_err(pfdev->dev, "error powering up gpu tiler");
>   }
>   
>   void panfrost_gpu_power_off(struct panfrost_device *pfdev)
> 

