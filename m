Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD704D2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFTQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 12:02:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17429 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:02:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bae190000>; Thu, 20 Jun 2019 09:02:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:02:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 09:02:33 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:02:29 +0000
Subject: Re: [PATCH] bus: tegra-aconnect: remove PM_CLK dependency
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1561045919-15449-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <55217434-2a50-7abe-25c3-6f4f90d8ba34@nvidia.com>
Date:   Thu, 20 Jun 2019 17:02:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561045919-15449-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561046553; bh=xYfQKL3cLOzja42ChJf8XhBWyKDTsUgOJS477XC+A/Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ezassr21V5vJJ65agMdBVPD0lr1/928pUFpE/6HP7ylDGs8v3meuVt29PC9h4Kx4q
         FsbRy3/GYjkW/7Z4r0i4FIizj9DQB5h1mTN8rWjtL8Au6uBLs0FpHGltG2Dt5w7MEJ
         brOrJD7aPJzud1/aAQs7zzEJMVkJToVP+JRkiGr8leZ3mLFyuJwINx/urRgtN4Zeuh
         tAG++PqhxtMG7bZpRBCAf2XgcP7OGUByigN4FOH3lPNrfsXZVZVMr/H/SeeL4cveMl
         PK02yFNGLQq8ssHRu53JMvIKS9MVOCfWRa+8dXpK4rohFdyq/r0kyrA39Ww0dkEBe9
         uCmNlDYhK7HoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/2019 16:51, Sameer Pujar wrote:
> aconnect bus driver does not use pm-clk interface now and hence the
> dependency is removed from Kconfig.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/bus/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 1851112..4587ef2 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -128,7 +128,6 @@ config TEGRA_ACONNECT
>  	tristate "Tegra ACONNECT Bus Driver"
>  	depends on ARCH_TEGRA_210_SOC
>  	depends on OF && PM
> -	select PM_CLK
>  	help
>  	  Driver for the Tegra ACONNECT bus which is used to interface with
>  	  the devices inside the Audio Processing Engine (APE) for Tegra210.

Thanks. We should probably populate the 'Fixes:' tag for this to show
which commit this fixes. Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
