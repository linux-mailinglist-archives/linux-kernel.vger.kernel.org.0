Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79976B0B86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfILJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 05:36:28 -0400
Received: from foss.arm.com ([217.140.110.172]:59766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfILJg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:36:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264081000;
        Thu, 12 Sep 2019 02:36:27 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C98E3F59C;
        Thu, 12 Sep 2019 02:36:26 -0700 (PDT)
Subject: Re: [RESEND PATCH] drm/panfrost: Reduce the amount of logs on
 deferred probe
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190909155146.14065-1-krzk@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1858ea3d-8f33-66f4-0e71-31bf68443b24@arm.com>
Date:   Thu, 12 Sep 2019 10:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909155146.14065-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2019 16:51, Krzysztof Kozlowski wrote:
> There is no point to print deferred probe (and its failures to get
> resources) as an error.
> 
> In case of multiple probe tries this would pollute the dmesg.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Looks like a good idea, however from what I can tell you haven't
completely silenced the 'error' as the return from
panfrost_regulator_init() will be -EPROBE_DEFER causing another
dev_err() output:

        err = panfrost_regulator_init(pfdev);
        if (err) {
                dev_err(pfdev->dev, "regulator init failed %d\n", err);
                goto err_out0;
        }

Can you fix that up as well? Or indeed drop it altogether since
panfrost_regulator_init() already outputs an appropriate message.

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 46b0b02e4289..2252147bc285 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -95,7 +95,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
>  		pfdev->regulator = NULL;
>  		if (ret == -ENODEV)
>  			return 0;
> -		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "failed to get regulator: %d\n",
> +				ret);
>  		return ret;
>  	}
>  
> 

