Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32416395B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfGIQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 12:27:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18027 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:27:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d24c07c0000>; Tue, 09 Jul 2019 09:27:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 09:27:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 09:27:35 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 16:27:34 +0000
Subject: Re: [PATCH v1] drm/tegra: Fix gpiod_get_from_of_node() regression
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190705151139.19032-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9425f0e8-36ec-76cb-b177-fa486fcafc19@nvidia.com>
Date:   Tue, 9 Jul 2019 17:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705151139.19032-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562689660; bh=eiMzdExQqfXSHcpxt0RmPgRZdbS5a+9W8kuVpeJfT2c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dx1hthAf1o0tT3KQdGbZYxZ3xITziFcwzhbVcVlCGqjCi/pXXZcY0f+Juxw7JzeXG
         eiFsootJn9+BVTyUxsLp+tS5HJ/z4SOR2RK5TL4kr+1ia/YIBULICdwqpC9HJbidxl
         PEHODPxSDzE/aBh3WSRjb0ntsQf+Y8d2VnwvDfbCaT/4+AcZGz5v423d3smJzDiXp0
         1JaK5aMrkeeRNdhkArKkkVN2wLWgseC1bXG5S6MUKrBCcA2ZtNKfUZuBDIHKXoUvpY
         yRqpsCiQnPZ/FSqdzYqCaBcj8EU/lovtZkh6h7CJKsB1y6kKEs1LFV/gQd4yt43MJN
         U+eLjK17qMMTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/2019 16:11, Dmitry Osipenko wrote:
> That function now returns ERR_PTR instead of NULL if "hpd-gpio" is not
> present in device-tree. The offending patch missed to adapt the Tegra's
> DRM driver for the API change.
> 
> Fixes: 025bf37725f1 ("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/output.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
> index 274cb955e2e1..471d33809cd4 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -126,8 +126,12 @@ int tegra_output_probe(struct tegra_output *output)
>  						       "nvidia,hpd-gpio", 0,
>  						       GPIOD_IN,
>  						       "HDMI hotplug detect");
> -	if (IS_ERR(output->hpd_gpio))
> -		return PTR_ERR(output->hpd_gpio);
> +	if (IS_ERR(output->hpd_gpio)) {
> +		if (PTR_ERR(output->hpd_gpio) == -ENOENT)
> +			output->hpd_gpio = NULL;
> +		else
> +			return PTR_ERR(output->hpd_gpio);
> +	}
>  
>  	if (output->hpd_gpio) {
>  		err = gpiod_to_irq(output->hpd_gpio);
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
