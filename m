Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C8151431
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 03:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBDC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 21:28:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbgBDC25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:28:57 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDF6794BC6A9C7913AE0;
        Tue,  4 Feb 2020 10:28:55 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 10:28:54 +0800
Subject: Re: [v2] nbd: add a flush_workqueue in nbd_start_device
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <mchristi@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <20200122031857.5859-1-sunke32@huawei.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
Date:   Tue, 4 Feb 2020 10:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122031857.5859-1-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

�� 2020/1/22 11:18, Sun Ke д��:
> When kzalloc fail, may cause trying to destroy the
> workqueue from inside the workqueue.
> 
> If num_connections is m (2 < m), and NO.1 ~ NO.n
> (1 < n < m) kzalloc are successful. The NO.(n + 1)
> failed. Then, nbd_start_device will return ENOMEM
> to nbd_start_device_ioctl, and nbd_start_device_ioctl
> will return immediately without running flush_workqueue.
> However, we still have n recv threads. If nbd_release
> run first, recv threads may have to drop the last
> config_refs and try to destroy the workqueue from
> inside the workqueue.
> 
> To fix it, add a flush_workqueue in nbd_start_device.
> 
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   drivers/block/nbd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..78181908f0df 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1265,6 +1265,16 @@ static int nbd_start_device(struct nbd_device *nbd)
>   		args = kzalloc(sizeof(*args), GFP_KERNEL);
>   		if (!args) {
>   			sock_shutdown(nbd);
> +			/*
> +			 * If num_connections is m (2 < m),
> +			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
> +			 * But NO.(n + 1) failed. We still have n recv threads.
> +			 * So, add flush_workqueue here to prevent recv threads
> +			 * dropping the last config_refs and trying to destroy
> +			 * the workqueue from inside the workqueue.
> +			 */
> +			if (i)
> +				flush_workqueue(nbd->recv_workq);
>   			return -ENOMEM;
>   		}
>   		sk_set_memalloc(config->socks[i]->sock->sk);
> 

