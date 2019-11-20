Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072CD103FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfKTPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 10:49:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47760 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfKTPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:49:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AA68D291102
Subject: Re: [PATCH] platform/chrome: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>
References: <20191120134014.14277-1-krzk@kernel.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <92c310c5-a6b6-94e3-33de-b8d94663ef9e@collabora.com>
Date:   Wed, 20 Nov 2019 16:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120134014.14277-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

On 20/11/19 14:40, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It is simple enough to be included in 5.5, queued.

Thanks,
 Enric

> ---
>  drivers/platform/chrome/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index ee5f08ea57b6..b66cc7182287 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -132,9 +132,9 @@ config CROS_EC_LPC
>  	  module will be called cros_ec_lpcs.
>  
>  config CROS_EC_PROTO
> -        bool
> -        help
> -          ChromeOS EC communication protocol helpers.
> +	bool
> +	help
> +	  ChromeOS EC communication protocol helpers.
>  
>  config CROS_KBD_LED_BACKLIGHT
>  	tristate "Backlight LED support for Chrome OS keyboards"
> 
