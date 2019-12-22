Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBD128E08
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfLVNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 08:13:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725791AbfLVNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577020410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agNzo6Bgm/vLlSiDENms0gAQDdi0u7uH+z8qdq2zZwY=;
        b=MRXZC8F0ioCqRiq9i6ygoR8XWtMEA+O8fnGOoHqrm9MGh6Ki2HNEmCcA+0oQILMjb9BJ4A
        +pNbPAyoyxSr1TnVTZPdNP4F9higJzRGxcnIM4xyTayDWoL91iWjxA0cY95FlpsLCmE6lf
        3Odlv0Np6dcLhZe6LxvJcPcXwLMR1+E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-0Sxg-ToxMJGqAkv1wxik4g-1; Sun, 22 Dec 2019 08:13:29 -0500
X-MC-Unique: 0Sxg-ToxMJGqAkv1wxik4g-1
Received: by mail-qk1-f199.google.com with SMTP id a73so9459050qkg.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agNzo6Bgm/vLlSiDENms0gAQDdi0u7uH+z8qdq2zZwY=;
        b=AagljZey7ijn6O1PkWbWIXaXQu4Y4vMfYZW/5oZmdref5WiiNj2Tn9SzFWGmMRmDRX
         mOQfEufaM4kKH1OXRUU6rVp7jVSHOFxhy62eBMLH6X6k+rfybmkRohjexH0aKcUwO4eh
         l/ozoh92Jk5TG8V999e2YAFdboiAVZh0FNCRpmu+3Rb//teLTX63MPwcJtNIdS4Vrtgm
         z1ZP7SpEOzYwFP9L/HHytwCkx5pi5DmEFc+efkqYURnwreyvbGCU2gmN/P/LkGN3gU9M
         LqDGg7xnXKGfQDh++ubtjbgxJYSSUBLpbzC7QEON6pGkCdJsEiMWSBBErJH1bfcSqGtQ
         idtQ==
X-Gm-Message-State: APjAAAXcm0GYsjLRgleGxoMV7z8AKX/xNlEj9Fst1G5rMEsUa2XTyyRk
        IemwvpZMfGDrsb0WpiqhVLC7zYELm9xbcnWIvmk8uLoWL3qzlWV0U7LxMgb8veyrZf/IM1f83R0
        OGZFe77I5h0y3LzW5IecNQ52D
X-Received: by 2002:ac8:220c:: with SMTP id o12mr19343966qto.134.1577020407991;
        Sun, 22 Dec 2019 05:13:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxj4Xyfx+tjODVODJ86b5OaAPLb8/UwXiZwbGHZhJWKsH6cBujZpwJrPvYyt+uagy+bsRjnGA==
X-Received: by 2002:ac8:220c:: with SMTP id o12mr19343948qto.134.1577020407775;
        Sun, 22 Dec 2019 05:13:27 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id i7sm2512278qkf.38.2019.12.22.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:13:26 -0800 (PST)
Date:   Sun, 22 Dec 2019 08:13:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alistair Delva <adelva@google.com>
Cc:     netdev@vger.kernel.org, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "David S . Miller" <davem@davemloft.net>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: Skip set_features on non-cvq devices
Message-ID: <20191222081213-mutt-send-email-mst@kernel.org>
References: <20191220212207.76726-1-adelva@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220212207.76726-1-adelva@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:22:07PM -0800, Alistair Delva wrote:
> On devices without control virtqueue support, such as the virtio_net
> implementation in crosvm[1], attempting to configure LRO will panic the
> kernel:
> 
> kernel BUG at drivers/net/virtio_net.c:1591!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 1 PID: 483 Comm: Binder:330_1 Not tainted 5.4.5-01326-g19463e9acaac #1
> Hardware name: ChromiumOS crosvm, BIOS 0
> RIP: 0010:virtnet_send_command+0x15d/0x170 [virtio_net]
> Code: d8 00 00 00 80 78 02 00 0f 94 c0 65 48 8b 0c 25 28 00 00 00 48 3b 4c 24 70 75 11 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b e8 ec a4 12 c8 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
> RSP: 0018:ffffb97940e7bb50 EFLAGS: 00010246
> RAX: ffffffffc0596020 RBX: ffffa0e1fc8ea840 RCX: 0000000000000017
> RDX: ffffffffc0596110 RSI: 0000000000000011 RDI: 000000000000000d
> RBP: ffffb97940e7bbf8 R08: ffffa0e1fc8ea0b0 R09: ffffa0e1fc8ea0b0
> R10: ffffffffffffffff R11: ffffffffc0590940 R12: 0000000000000005
> R13: ffffa0e1ffad2c00 R14: ffffb97940e7bc08 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffa0e1fd100000(006b) knlGS:00000000e5ef7494
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000e5eeb82c CR3: 0000000079b06001 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ? preempt_count_add+0x58/0xb0
>  ? _raw_spin_lock_irqsave+0x36/0x70
>  ? _raw_spin_unlock_irqrestore+0x1a/0x40
>  ? __wake_up+0x70/0x190
>  virtnet_set_features+0x90/0xf0 [virtio_net]
>  __netdev_update_features+0x271/0x980
>  ? nlmsg_notify+0x5b/0xa0
>  dev_disable_lro+0x2b/0x190
>  ? inet_netconf_notify_devconf+0xe2/0x120
>  devinet_sysctl_forward+0x176/0x1e0
>  proc_sys_call_handler+0x1f0/0x250
>  proc_sys_write+0xf/0x20
>  __vfs_write+0x3e/0x190
>  ? __sb_start_write+0x6d/0xd0
>  vfs_write+0xd3/0x190
>  ksys_write+0x68/0xd0
>  __ia32_sys_write+0x14/0x20
>  do_fast_syscall_32+0x86/0xe0
>  entry_SYSENTER_compat+0x7c/0x8e
> 
> This happens because virtio_set_features() does not check the presence
> of the control virtqueue feature, which is sanity checked by a BUG_ON
> in virtnet_send_command().
> 
> Fix this by skipping any feature processing if the control virtqueue is
> missing. This should be OK for any future feature that is added, as
> presumably all of them would require control virtqueue support to notify
> the endpoint that offload etc. should begin.
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/crosvm/
> 
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Cc: stable@vger.kernel.org [4.20+]
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: kernel-team@android.com
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alistair Delva <adelva@google.com>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4d7d5434cc5d..709bcd34e485 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2560,6 +2560,9 @@ static int virtnet_set_features(struct net_device *dev,
>  	u64 offloads;
>  	int err;
>  
> +	if (!vi->has_cvq)
> +		return 0;
> +


Shouldn't this return failure if the features are actually
being changed?


>  	if ((dev->features ^ features) & NETIF_F_LRO) {
>  		if (vi->xdp_queue_pairs)
>  			return -EBUSY;
> -- 
> 2.24.1.735.g03f4e72817-goog

