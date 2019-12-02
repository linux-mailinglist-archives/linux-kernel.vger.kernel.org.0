Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A967B10E812
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 11:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLBKAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 05:00:13 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:56544 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfLBKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:00:13 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ibiUy-0006FX-Mv; Mon, 02 Dec 2019 11:00:08 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Reference to  =?UTF-8?Q?its=5Finvall=5Fcmd=20descriptor=20when=20building=20INVALL?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 10:00:08 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
In-Reply-To: <20191202071021.1251-1-yuzenghui@huawei.com>
References: <20191202071021.1251-1-yuzenghui@huawei.com>
Message-ID: <f44b2fc14d26731333ee6ef1a50e63d6@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-12-02 07:10, Zenghui Yu wrote:
> It looks like an obvious mistake to use its_mapc_cmd descriptor when
> building the INVALL command block. It so far worked by luck because
> both its_mapc_cmd.col and its_invall_cmd.col sit at the same offset 
> of
> the ITS command descriptor, but we should not rely on it.
>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index c52cc8d6d6b8..b3fec78b2226 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -598,7 +598,7 @@ static struct its_collection
> *its_build_invall_cmd(struct its_node *its,
>  						   struct its_cmd_desc *desc)
>  {
>  	its_encode_cmd(cmd, GITS_CMD_INVALL);
> -	its_encode_collection(cmd, desc->its_mapc_cmd.col->col_id);
> +	its_encode_collection(cmd, desc->its_invall_cmd.col->col_id);
>
>  	its_fixup_cmd(cmd);

Yup, well spotted. Thankfully, there is no impact due to the two
structures having similar layouts, but that definitely needs
fixing.

I'll queue this for post -rc1.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
