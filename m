Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2DA7D54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfIDIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 04:09:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45960 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfIDIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:09:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AA9C928D35C
Subject: Re: [PATCH] platform/chrome: chromeos_tbmc : Report wake events.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        bleung@chromium.org, swboyd@chromium.org, tbroch@chromium.org,
        linux-kernel@vger.kernel.org
References: <20190830231404.60005-1-ravisadineni@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <43bc0057-9e34-0470-b3b3-a110ad67a229@collabora.com>
Date:   Wed, 4 Sep 2019 10:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830231404.60005-1-ravisadineni@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

Many thanks for this patch.

On 31/8/19 1:14, Ravi Chandra Sadineni wrote:
> Mark chromeos_tbmc as wake capable and report wake events. This helps to
> abort suspend on seeing a tablet mode switch event when kernel is
> suspending. This also helps identifying if chroemos_tbmc is the wake
> source.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

The patch looks good to me, I'll wait a bit before pick the patch for I can get
a Tested-by from someone as I don't think I have the hardware to test this (no
x86/tablet devices on my hand)

For my own reference:
 Acked-for-chrome-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> ---
>  drivers/platform/chrome/chromeos_tbmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
> index ce259ec9f990..d1cf8f3463ce 100644
> --- a/drivers/platform/chrome/chromeos_tbmc.c
> +++ b/drivers/platform/chrome/chromeos_tbmc.c
> @@ -47,6 +47,7 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
>  
>  static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
>  {
> +	acpi_pm_wakeup_event(&adev->dev);
>  	switch (event) {
>  	case 0x80:
>  		chromeos_tbmc_query_switch(adev, adev->driver_data);
> @@ -90,6 +91,7 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
>  		dev_err(dev, "cannot register input device\n");
>  		return ret;
>  	}
> +	device_init_wakeup(dev, true);
>  	return 0;
>  }
>  
> 
