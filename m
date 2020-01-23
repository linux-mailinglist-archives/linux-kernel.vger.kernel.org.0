Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9596146741
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 12:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAWLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 06:52:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgAWLwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579780357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InTGFoFr4K0JH5iJeKl7FcrQzJzUete0v0UfYk0ekVs=;
        b=ZUN40+oIEvEynQNhzyzM9Funuik6m5tDDDdo4sKJ9mY1bJCMC7hII2DLOqBMEj+wjvOUFg
        zyHbeqIXtSasxgKKmKsIFoYGeYmLQMXdEu+4acImTC4RS6BIo8mRON/J7tBMbyurmiOKQ1
        MruXXq2jIPbv5ZKE1Yphit3OrePVIic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-osJjPQaQMtCD_ERo0jKsQg-1; Thu, 23 Jan 2020 06:52:35 -0500
X-MC-Unique: osJjPQaQMtCD_ERo0jKsQg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1583169wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=InTGFoFr4K0JH5iJeKl7FcrQzJzUete0v0UfYk0ekVs=;
        b=joYM8WV1SrXcBESCOIpQLQ8SLXrd1rzaUaBdOmS8n5tE/MjrTgt9lN2lPBRn7Fdn8F
         gIfByzfdr/ffHsVDxPZZCFftk8qWKCjgF0rTLzYl80Tvy5YQAN3XvquUMp4o8oMQKFQ/
         1E7xWIiTpAU4YrFRKaWPw7f0/YZHIfWLLzH6Rbt7IkNZKGbDIlckzTv0C0ntQEcjupp+
         rtCFD07Nhyj6LpbPiKkZrygYSV1DOx02JOsjp+V8h18eIoFVVbselQBWabMPBbOp+Xql
         lk82TQlTxu1pNadRsVnB+Omz6pvL7gJjvOhiMtUlilxi4wWeRHX8+ZeiMhXB8PsXoeCi
         DyHg==
X-Gm-Message-State: APjAAAWjcNrhs1ns3Oa8zv9ZSIhrJ0eHpZEHXb1bUqgdv+B19Rc/uiE3
        LeaUbVKWmXiix4oP1vpAV8U3XP2CHjoiPVVHxGeVaDV4ba56LOz4D+kl6MgJPRK9vZIBPYG24Ua
        oMhsOFUXiOAIOAfntcQKpFxV8
X-Received: by 2002:adf:82a7:: with SMTP id 36mr17569551wrc.203.1579780353363;
        Thu, 23 Jan 2020 03:52:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5O2ZqEQVqQn32hTKvSwhWMEEvVB7a4Div4tqNA/qDlS49TvRgqkmhE+r7V5GWwO3fPdE5RA==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr17569535wrc.203.1579780353079;
        Thu, 23 Jan 2020 03:52:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
        by smtp.gmail.com with ESMTPSA id a9sm2320787wmm.15.2020.01.23.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:52:32 -0800 (PST)
Date:   Thu, 23 Jan 2020 06:52:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [CRASH] crypto: virtio: crash when modprobing tcrypt on 5.5-rc7
 / next-20200122
Message-ID: <20200123065150-mutt-send-email-mst@kernel.org>
References: <20200123101000.GB24255@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123101000.GB24255@Red>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:10:00AM +0100, LABBE Corentin wrote:
> Hello
> 
> When modprobing tcrypt on qemu 4.1.0 I get a kernel panic on 5.5-rc7 and next-20200122
> qemu is started by:
> /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic,model=e1000,macaddr=52:54:00:12:34:58 -net tap -m 512 -monitor none -object cryptodev-backend-builtin,id=cryptodev0 -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 -append 'console=ttyS0 root=/dev/ram0 ip=dhcp' -kernel /var/lib/lava/dispatcher/tmp/41332/deployimages-td18675m/kernel/bzImage -initrd /var/lib/lava/dispatcher/tmp/41332/deployimages-td18675m/ramdisk/rootfs.cpio.gz -drive format=qcow2,file=/var/lib/lava/dispatcher/tmp/41332/apply-overlay-guest-icy4k1ol/lava-guest.qcow2,media=disk,if=ide,id=lavatest
> 
> [  112.771925] general protection fault: 0000 [#1] SMP PTI
> [  112.772686] CPU: 0 PID: 126 Comm: virtio0-engine Not tainted 5.5.0-rc7+ #1
> [  112.773576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
> [  112.775319] RIP: 0010:sg_next+0x0/0x20
> [  112.775821] Code: cc cc cc cc cc cc cc cc cc cc c7 47 10 00 00 00 00 89 57 0c 48 89 37 89 4f 08 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <f6> 07 02 75 17 48 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2
> [  112.778330] RSP: 0018:ffffa92440237d90 EFLAGS: 00010006
> [  112.779071] RAX: fefefefe00000000 RBX: 000000000000000a RCX: fefefefe00000000
> [  112.780081] RDX: 0000000000000001 RSI: ffff9b19da1a2180 RDI: fefefefe00000000
> [  112.781081] RBP: ffff9b19da1a2198 R08: ffff9b19dfb24ee8 R09: 0000000000000a20
> [  112.782079] R10: ffff9b19da125010 R11: 0000000000000000 R12: ffff9b19da1a21b8
> [  112.783079] R13: 0000000000000003 R14: ffff9b19da1a2180 R15: 0000000000000004
> [  112.784077] FS:  0000000000000000(0000) GS:ffff9b19de400000(0000) knlGS:0000000000000000
> [  112.785202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  112.786030] CR2: 00007f18a157b050 CR3: 000000001040a004 CR4: 0000000000060ef0
> [  112.787034] Call Trace:
> [  112.787393]  virtqueue_add_sgs+0x4c/0x90
> [  112.787998]  virtio_crypto_skcipher_crypt_req+0x310/0x3e0
> [  112.788817]  crypto_pump_work+0x10c/0x240
> [  112.789420]  ? __kthread_init_worker+0x50/0x50
> [  112.790082]  kthread_worker_fn+0x89/0x180
> [  112.790690]  kthread+0x10e/0x130
> [  112.791182]  ? kthread_park+0x80/0x80
> [  112.791736]  ret_from_fork+0x35/0x40
> [  112.792282] Modules linked in: cts lzo salsa20_generic camellia_x86_64 camellia_generic fcrypt pcbc tgr192 anubis wp512 khazad tea michael_mic arc4 cast6_generic cast5_generic cast_common deflate sha512_ssse3 sha512_generic cfb ofb serpent_sse2_x86_64 serpent_generic lrw twofish_x86_64_3way twofish_x86_64 crypto_simd cryptd glue_helper twofish_generic twofish_common blowfish_x86_64 blowfish_generic blowfish_common md4 tcrypt(+)
> [  112.797652] ---[ end trace 4a8142d4a08c2518 ]---
> [  112.798320] RIP: 0010:sg_next+0x0/0x20
> [  112.798865] Code: cc cc cc cc cc cc cc cc cc cc c7 47 10 00 00 00 00 89 57 0c 48 89 37 89 4f 08 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <f6> 07 02 75 17 48 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2
> [  112.801452] RSP: 0018:ffffa92440237d90 EFLAGS: 00010006
> [  112.802189] RAX: fefefefe00000000 RBX: 000000000000000a RCX: fefefefe00000000
> [  112.803190] RDX: 0000000000000001 RSI: ffff9b19da1a2180 RDI: fefefefe00000000
> [  112.804192] RBP: ffff9b19da1a2198 R08: ffff9b19dfb24ee8 R09: 0000000000000a20
> [  112.805201] R10: ffff9b19da125010 R11: 0000000000000000 R12: ffff9b19da1a21b8
> [  112.806195] R13: 0000000000000003 R14: ffff9b19da1a2180 R15: 0000000000000004
> [  112.807222] FS:  0000000000000000(0000) GS:ffff9b19de400000(0000) knlGS:0000000000000000
> [  112.808352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  112.809169] CR2: 00007f18a157b050 CR3: 000000001040a004 CR4: 0000000000060ef0
> 
> I have tested also 5.4.14 
> and I got random freeze with:
> qemu-system-x86_64: virtio: zero sized buffers are not allowed
> 
> Regards

did any of previous versions work for you?
Any chance of a bisect?

