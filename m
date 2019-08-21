Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3198072
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfHUQnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfHUQnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:43:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51A0D89AC8;
        Wed, 21 Aug 2019 16:43:05 +0000 (UTC)
Received: from [10.10.125.147] (ovpn-125-147.rdu2.redhat.com [10.10.125.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 334325DA32;
        Wed, 21 Aug 2019 16:43:04 +0000 (UTC)
Subject: Re: [PATCH v2] nbd: fix possible page fault for nbd disk
To:     xiubli@redhat.com, josef@toxicpanda.com, axboe@kernel.dk
References: <20190821115753.3911-1-xiubli@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D5D7497.9020203@redhat.com>
Date:   Wed, 21 Aug 2019 11:43:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190821115753.3911-1-xiubli@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 21 Aug 2019 16:43:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2019 06:57 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> When the NBD_CFLAG_DESTROY_ON_DISCONNECT flag is set and at the same
> time when the socket is closed due to the server daemon is restarted,
> just before the last DISCONNET is totally done if we start a new connection
> by using the old nbd_index, there will be crashing randomly, like:
> 
> <3>[  110.151949] block nbd1: Receive control failed (result -32)
> <1>[  110.152024] BUG: unable to handle page fault for address: 0000058000000840
> <1>[  110.152063] #PF: supervisor read access in kernel mode
> <1>[  110.152083] #PF: error_code(0x0000) - not-present page
> <6>[  110.152094] PGD 0 P4D 0
> <4>[  110.152106] Oops: 0000 [#1] SMP PTI
> <4>[  110.152120] CPU: 0 PID: 6698 Comm: kworker/u5:1 Kdump: loaded Not tainted 5.3.0-rc4+ #2
> <4>[  110.152136] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> <4>[  110.152166] Workqueue: knbd-recv recv_work [nbd]
> <4>[  110.152187] RIP: 0010:__dev_printk+0xd/0x67
> <4>[  110.152206] Code: 10 e8 c5 fd ff ff 48 8b 4c 24 18 65 48 33 0c 25 28 00 [...]
> <4>[  110.152244] RSP: 0018:ffffa41581f13d18 EFLAGS: 00010206
> <4>[  110.152256] RAX: ffffa41581f13d30 RBX: ffff96dd7374e900 RCX: 0000000000000000
> <4>[  110.152271] RDX: ffffa41581f13d20 RSI: 00000580000007f0 RDI: ffffffff970ec24f
> <4>[  110.152285] RBP: ffffa41581f13d80 R08: ffff96dd7fc17908 R09: 0000000000002e56
> <4>[  110.152299] R10: ffffffff970ec24f R11: 0000000000000003 R12: ffff96dd7374e900
> <4>[  110.152313] R13: 0000000000000000 R14: ffff96dd7374e9d8 R15: ffff96dd6e3b02c8
> <4>[  110.152329] FS:  0000000000000000(0000) GS:ffff96dd7fc00000(0000) knlGS:0000000000000000
> <4>[  110.152362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  110.152383] CR2: 0000058000000840 CR3: 0000000067cc6002 CR4: 00000000001606f0
> <4>[  110.152401] Call Trace:
> <4>[  110.152422]  _dev_err+0x6c/0x83
> <4>[  110.152435]  nbd_read_stat.cold+0xda/0x578 [nbd]
> <4>[  110.152448]  ? __switch_to_asm+0x34/0x70
> <4>[  110.152468]  ? __switch_to_asm+0x40/0x70
> <4>[  110.152478]  ? __switch_to_asm+0x34/0x70
> <4>[  110.152491]  ? __switch_to_asm+0x40/0x70
> <4>[  110.152501]  ? __switch_to_asm+0x34/0x70
> <4>[  110.152511]  ? __switch_to_asm+0x40/0x70
> <4>[  110.152522]  ? __switch_to_asm+0x34/0x70
> <4>[  110.152533]  recv_work+0x35/0x9e [nbd]
> <4>[  110.152547]  process_one_work+0x19d/0x340
> <4>[  110.152558]  worker_thread+0x50/0x3b0
> <4>[  110.152568]  kthread+0xfb/0x130
> <4>[  110.152577]  ? process_one_work+0x340/0x340
> <4>[  110.152609]  ? kthread_park+0x80/0x80
> <4>[  110.152637]  ret_from_fork+0x35/0x40
> 
> This is very easy to reproduce by running the nbd-runner.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  drivers/block/nbd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e21d2ded732b..b07b4452d696 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -112,6 +112,8 @@ struct nbd_device {
>  	struct list_head list;
>  	struct task_struct *task_recv;
>  	struct task_struct *task_setup;
> +
> +	bool shutting_down;
>  };
>  
>  #define NBD_CMD_REQUEUED	1
> @@ -230,8 +232,8 @@ static void nbd_put(struct nbd_device *nbd)
>  	if (refcount_dec_and_mutex_lock(&nbd->refs,
>  					&nbd_index_mutex)) {
>  		idr_remove(&nbd_index_idr, nbd->index);
> -		mutex_unlock(&nbd_index_mutex);
>  		nbd_dev_remove(nbd);
> +		mutex_unlock(&nbd_index_mutex);
>  	}
>  }
>  
> @@ -1103,6 +1105,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
>  
>  	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
>  	set_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
> +	nbd->shutting_down = true;
>  	send_disconnects(nbd);
>  	return 0;
>  }
> @@ -1761,6 +1764,12 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>  		mutex_unlock(&nbd_index_mutex);
>  		return -EINVAL;
>  	}
> +
> +	if (nbd->shutting_down) {
> +		mutex_unlock(&nbd_index_mutex);
> +		goto again;
> +	}

How does shutting_down get set back to false for the case where
NBD_CFLAG_DESTROY_ON_DISCONNECT is not set, we have done a
nbd_disconnect and now the connect has the nbd index of that existing
device. It seems like the flag is going to be stuck as set.
