Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3912C8E259
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfHOB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 21:27:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbfHOB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:27:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8239D636284E109C16C6;
        Thu, 15 Aug 2019 09:27:18 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 09:27:14 +0800
Subject: Re: [PATCH] nbd: add a missed nbd_config_put() in nbd_xmit_timeout()
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <05b3cd4a-d2c1-5ad7-7a39-64bac470032a@huawei.com>
Date:   Thu, 15 Aug 2019 09:27:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

�� 2019/8/12 20:31, Sun Ke д��:
> When try to get the lock failed, before return, execute the
> nbd_config_put() to decrease the nbd->config_refs.
> 
> If the nbd->config_refs is added but not decreased. Then will not
> execute nbd_clear_sock() in nbd_config_put(). bd->task_setup will
> not be cleared away. Finally, print"Device being setup by another
> task" in nbd_add_sock() and nbd device can not be reused.
> 
> Fixes: 8f3ea35929a0 ("nbd: handle unexpected replies better")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   drivers/block/nbd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e21d2de..a69a90a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -357,8 +357,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   	}
>   	config = nbd->config;
>   
> -	if (!mutex_trylock(&cmd->lock))
> +	if (!mutex_trylock(&cmd->lock)) {
> +		nbd_config_put(nbd);
>   		return BLK_EH_RESET_TIMER;
> +	}
>   
>   	if (config->num_connections > 1) {
>   		dev_err_ratelimited(nbd_to_dev(nbd),
> 

