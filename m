Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AAF9584
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKLQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 11:24:35 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfKLQYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:24:35 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5885442030B8FF11AA90;
        Tue, 12 Nov 2019 16:24:33 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Nov 2019 16:24:32 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 Nov
 2019 16:24:32 +0000
Subject: Re: [PATCH] arm64: Kconfig: add a choice for endianess
To:     Anders Roxell <anders.roxell@linaro.org>, <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191112160144.8357-1-anders.roxell@linaro.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e44db1ec-e562-18c4-ca6f-96e4279564ed@huawei.com>
Date:   Tue, 12 Nov 2019 16:24:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191112160144.8357-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 16:01, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> people wants. Another concern that thas come up is that ACPI in't built

/s/wants/want/, s/thas/has/, s/in't/isn't/

> for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.
> 
> Rework so that we introduce a 'choice' and default the choice to
> CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
> it will default to CPU_LITTLE_ENDIAN that most people tends to want.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

FWIW, apart from spelling mistakes:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   arch/arm64/Kconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 64764ca92fca..62f83c234a61 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -877,11 +877,24 @@ config ARM64_PA_BITS
>   	default 48 if ARM64_PA_BITS_48
>   	default 52 if ARM64_PA_BITS_52
>   
> +choice
> +	prompt "Endianess"

Should this be "Endianness"?

> +	default CPU_LITTLE_ENDIAN
> +	help
> +	  Choose what mode you plan on running your kernel in.
> +
>   config CPU_BIG_ENDIAN
>          bool "Build big-endian kernel"
>          help
>            Say Y if you plan on running a kernel in big-endian mode.
>   
> +config CPU_LITTLE_ENDIAN
> +	bool "Build little-endian kernel"
> +	help
> +	  Say Y if you plan on running a kernel in little-endian mode.
> +
> +endchoice
> +
>   config SCHED_MC
>   	bool "Multi-core scheduler support"
>   	help
> 

