Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE96D713A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfJOIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 04:38:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfJOIiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:38:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B850CAF8BBCA47091DA;
        Tue, 15 Oct 2019 16:38:18 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 16:38:10 +0800
Subject: Re: [PATCH 2/3] arm64: configs: unset CMDLINE_FORCE
To:     Anders Roxell <anders.roxell@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-4-anders.roxell@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        <linux@armlinux.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fc64ee58-8b21-1d3e-7e05-e0959f468f95@huawei.com>
Date:   Tue, 15 Oct 2019 09:38:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190926193030.5843-4-anders.roxell@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 20:30, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CMDLINE_FORCE gets enabled. Which forces the user to pass the
> full cmdline to CONFIG_CMDLINE="...".
>
> Rework so that we disable CONFIG_CMDLINE_FORCE in the defconfig file so
> we don't have to pass in the CONFIG_CMDLINE="..." when building an
> allmodconfig kernel. Since CONFIG_CMDLINE_FORCE is unset default, so
> when doing 'make savedefconfig' CONFIG_CMDLINE_FORCE will be dropped.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 52a32b53b2ed..878f379d8d84 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -854,3 +854,4 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_MEMTEST=y
> +# CONFIG_CMDLINE_FORCE is not set

This was my initial idea for an alternative Kconfig change:

--->8---

According to the comment for CMDLINE, we should at least have the root 
device defined. So if CMDLINE is "", then it can not be defined so 
disallow CMDLINE_FORCE in this scenario.

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 950a56b71ff0..6f3bff2f385e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1580,6 +1580,7 @@ config CMDLINE

  config CMDLINE_FORCE
         bool "Always use the default kernel command string"
+       depends on CMDLINE != ""
         help
           Always use the default kernel command string, even if the boot
           loader passes other arguments to the kernel.

>


