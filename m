Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882F2178331
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 20:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgCCThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 14:37:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35700 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgCCThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:37:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id c7so5952063edu.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBhHEEvkyvTqJUIeskr6E9PxwbWHltx4bOMIa0nWNlI=;
        b=k0CN52kfaQSrU0vhHAsHAaeZKCT/mzcnizfqKi9Ww28fmClOjKMhv5QxYf0nhbSv5f
         WsmJKV3XkebOq7gvuwlHq/ER1sJu2EM4SvpYnhuZ4QBLjTA6KIDTTj4XkfvOme7ta48F
         rg9ITvUV5abS+JVxJAqqvCFmkZn+X4oAixtjGrfuVSmwfFESBySd1O7lQuHwMnVNUKws
         PUupLqzTtMcVz7YESyLHUmDYBVgmeX3QPhPDo30FPww/nGyV3lsktqVfj/omYQKfOTHO
         rYctsYn95+v5dcLaWR8CccBpSy4tr5Cfr0ZAF22phQjQuhnqfVbHQfAPMD3peSIzIj5Q
         ITtw==
X-Gm-Message-State: ANhLgQ2OD7aPTNT9rMLcQX17fGbHeIUkLYrGTf/rigBeNvkT4ireScEE
        PyMp+dDB8cTZ9VXZqpOx740=
X-Google-Smtp-Source: ADFU+vujWG4mhhwgFbY7jL5PWOYmiaZfGajGy7CqmtPLIEZCdmfdgCiolJp1Cq7fqRElIbD0or0rUQ==
X-Received: by 2002:aa7:cfc6:: with SMTP id r6mr5340823edy.15.1583264223101;
        Tue, 03 Mar 2020 11:37:03 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-230.amazon.com. [54.240.197.230])
        by smtp.gmail.com with ESMTPSA id v25sm976168edx.89.2020.03.03.11.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:37:02 -0800 (PST)
Subject: Re: [PATCH v2 1/2] xenbus: req->body should be updated before
 req->state
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303184752.20821-1-dongli.zhang@oracle.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <4ed129f9-ff23-f228-6833-77e37c2bb7b2@xen.org>
Date:   Tue, 3 Mar 2020 19:37:01 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303184752.20821-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 18:47, Dongli Zhang wrote:
> The req->body should be updated before req->state is updated and the
> order should be guaranteed by a barrier.
> 
> Otherwise, read_reply() might return req->body = NULL.
> 
> Below is sample callstack when the issue is reproduced on purpose by
> reordering the updates of req->body and req->state and adding delay in
> code between updates of req->state and req->body.
> 
> [   22.356105] general protection fault: 0000 [#1] SMP PTI
> [   22.361185] CPU: 2 PID: 52 Comm: xenwatch Not tainted 5.5.0xen+ #6
> [   22.366727] Hardware name: Xen HVM domU, BIOS ...
> [   22.372245] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
> ... ...
> [   22.392163] RSP: 0018:ffffb2d64023fdf0 EFLAGS: 00010246
> [   22.395933] RAX: 0000000000000000 RBX: 75746e7562755f6d RCX: 0000000000000000
> [   22.400871] RDX: 0000000000000000 RSI: ffffb2d64023fdfc RDI: 75746e7562755f6d
> [   22.405874] RBP: 0000000000000000 R08: 00000000000001e8 R09: 0000000000cdcdcd
> [   22.410945] R10: ffffb2d6402ffe00 R11: ffff9d95395eaeb0 R12: ffff9d9535935000
> [   22.417613] R13: ffff9d9526d4a000 R14: ffff9d9526f4f340 R15: ffff9d9537654000
> [   22.423726] FS:  0000000000000000(0000) GS:ffff9d953bc80000(0000) knlGS:0000000000000000
> [   22.429898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.434342] CR2: 000000c4206a9000 CR3: 00000001ea3fc002 CR4: 00000000001606e0
> [   22.439645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   22.444941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   22.450342] Call Trace:
> [   22.452509]  simple_strtoull+0x27/0x70
> [   22.455572]  xenbus_transaction_start+0x31/0x50
> [   22.459104]  netback_changed+0x76c/0xcc1 [xen_netfront]
> [   22.463279]  ? find_watch+0x40/0x40
> [   22.466156]  xenwatch_thread+0xb4/0x150
> [   22.469309]  ? wait_woken+0x80/0x80
> [   22.472198]  kthread+0x10e/0x130
> [   22.474925]  ? kthread_park+0x80/0x80
> [   22.477946]  ret_from_fork+0x35/0x40
> [   22.480968] Modules linked in: xen_kbdfront xen_fbfront(+) xen_netfront xen_blkfront
> [   22.486783] ---[ end trace a9222030a747c3f7 ]---
> [   22.490424] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
> 
> The barrier() in test_reply() is changed to virt_rmb(). The "while" is
> changed to "do while" so that test_reply() is used as a read memory
> barrier.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>    - change "barrier()" to "virt_rmb()" in test_reply()
> 
>   drivers/xen/xenbus/xenbus_comms.c |  2 ++
>   drivers/xen/xenbus/xenbus_xs.c    | 11 +++++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index d239fc3c5e3d..852ed161fc2a 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -313,6 +313,8 @@ static int process_msg(void)
>   			req->msg.type = state.msg.type;
>   			req->msg.len = state.msg.len;
>   			req->body = state.body;
> +			/* write body, then update state */
> +			virt_wmb();
>   			req->state = xb_req_state_got_reply;
>   			req->cb(req);
>   		} else
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index ddc18da61834..1e14c2118861 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -194,15 +194,18 @@ static bool test_reply(struct xb_req_data *req)
>   	if (req->state == xb_req_state_got_reply || !xenbus_ok())
>   		return true;
>   
> -	/* Make sure to reread req->state each time. */
> -	barrier();
> +	/*
> +	 * read req->state before other fields of struct xb_req_data
> +	 * in the caller of test_reply(), e.g., read_reply()
> +	 */
> +	virt_rmb();

Looking at the code again, I am afraid the barrier only happen in the 
false case. Should not the new barrier added in the 'true' case?

Cheers,

-- 
Julien Grall
