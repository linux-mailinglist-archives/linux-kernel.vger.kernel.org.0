Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD12C8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1Ogw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 10:36:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfE1Ogw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:36:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D565B3A651F320E2EBF3;
        Tue, 28 May 2019 22:36:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 22:36:44 +0800
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
To:     <TheSven73@gmail.com>, <gregkh@linuxfoundation.org>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <428cde8a-00cd-9023-9f09-deec4834507d@huawei.com>
Date:   Tue, 28 May 2019 22:36:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190528142912.13224-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is broken, Pls igore this.

On 2019/5/28 22:29, YueHaibing wrote:
> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
> 
> drivers/staging/fieldbus/anybuss/arcx-anybus.o: In function `controller_probe':
> arcx-anybus.c: undefined reference to `__devm_regmap_init_mmio_clk'
> 
> Select REGMAP_MMIO to fix it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2411a336c8ce ("staging: fieldbus: arcx-anybus: change custom -> mmio regmap")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix patch style warning
> ---
>  drivers/staging/fieldbus/anybuss/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/fieldbus/anybuss/Kconfig b/drivers/staging/fieldbus/anybuss/Kconfig
> index 8bc3d9a..635a0a7 100644
> --- a/drivers/staging/fieldbus/anybuss/Kconfig
> +++ b/drivers/staging/fieldbus/anybuss/Kconfig
> @@ -14,6 +14,7 @@ if HMS_ANYBUSS_BUS
>  config ARCX_ANYBUS_CONTROLLER
>  	tristate "Arcx Anybus-S Controller"
>  	depends on OF && GPIOLIB && HAS_IOMEM && REGULATOR
> +	select REGMAP_MMIO
>  	help
>  	  Select this to get support for the Arcx Anybus controller.
>  	  It connects to the SoC via a parallel memory bus, and
> 

