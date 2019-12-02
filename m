Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5610EA11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 13:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLBMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 07:30:06 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37382 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfLBMaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:30:06 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ibkpz-0000HJ-ES; Mon, 02 Dec 2019 13:29:59 +0100
To:     Daode Huang <huangdaode@hisilicon.com>
Subject: Re: [PATCH] irqchip/stm32: Fix "WARNING: invalid free of  =?UTF-8?Q?devm=5F=20allocated?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 12:29:59 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabien.dessenne@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <1574931880-168682-1-git-send-email-huangdaode@hisilicon.com>
References: <1574931880-168682-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <8acaa494701c91b8a8acd60a2390d810@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: huangdaode@hisilicon.com, tglx@linutronix.de, jason@lakedaemon.net, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, fabien.dessenne@st.com, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-28 09:04, Daode Huang wrote:
> Since devm_ allocated data can be automaitcally released, it's no
> need to free it apparently, just remove it.
>
> Fixes: cfbf9e497094 ("irqchip/stm32: Use a platform driver for
> stm32mp1-exti device")
> Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
> ---
>  drivers/irqchip/irq-stm32-exti.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-stm32-exti.c
> b/drivers/irqchip/irq-stm32-exti.c
> index e00f2fa..46ec0af 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -779,8 +779,6 @@ static int __init stm32_exti_init(const struct
> stm32_exti_drv_data *drv_data,
>  	irq_domain_remove(domain);
>  out_unmap:
>  	iounmap(host_data->base);
> -	kfree(host_data->chips_data);
> -	kfree(host_data);
>  	return ret;
>  }

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
