Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09010B901F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 15:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfITNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 09:01:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33896 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfITNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:01:49 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so16013130ion.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=juuiPG/fHEmMJPmhspavpQpcbVMdX9oagajwxn+rKyc=;
        b=qZWPKwMCH3gBR5XUkKeK96eUgMjkwaxHzVXDKA2aJKxVmXSCuHJIw2ri5DOPV6DjIS
         jIUoxPeIsf31sNQnsVfuh7dKiT+F3oaNdK1nyu752KsV2/5LIQ2CGTUWIlax9xWMAAtG
         pDAvDEhmBj+D8UB256YuQp6DRXFfdPtKLDpqU7mlw73U0zaVxbQRoQw60WPW/HnBKgrW
         eTk7JlxGQL69jSZmcGao1V1XRbMntqTIqZR0X1tU9PfQpQ9XE3btICPIrpOXPQgxY3tu
         HjEErE+uwhGrdTCAGmkdZNFf8uH+XMsdN7B/NCimw161MUsb9qBx0aHFwOznnlwub7OL
         48ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=juuiPG/fHEmMJPmhspavpQpcbVMdX9oagajwxn+rKyc=;
        b=oy3AyAyQEzjKyf2vWXcr1J3oi7InNvOHO401CqakluD1W80CXosK9zS3mp5/MZeJOE
         b4omwC1rM8tEJPjLj95ZJdf0YNKEFx63ntdbnmJvnSPu3qT9UZZWsPbYHIIFXBQIOqpN
         08273atoarm6j4dvHepCXt97Dk/wOPIHo7aNcr3jof4zL5Ei/0W87t9eFF+ocoBRjNgu
         ti2OBBrAqnO5LBW0+MFffnUfGnPG10ffBrJNynusI+xjgxsCzp6TGFTGCmydOztnxooC
         6MsKoVC+yssDcDS9ppNo1HVY+7KVdlryWdqAdFbrmY/tlRZjvYLhiLrFCuVB5JrJgvSp
         RFKQ==
X-Gm-Message-State: APjAAAXlkjjvWuLrq+qsoRdHeBIA8YlT2gSGfvqP8FXKflUrTx05Hhzg
        q9fJu6Uz0i66s+EIWHBS7xjsDfFyzEz3vw==
X-Google-Smtp-Source: APXvYqxaveHz80d5vcRRdrPgrljtLKBuxiv42GRTYkH6zeHXYQgCOOtysioFgOFFG0aG4/XYp32udg==
X-Received: by 2002:a02:cd05:: with SMTP id g5mr9119601jaq.52.1568984507725;
        Fri, 20 Sep 2019 06:01:47 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i20sm1485833ioh.77.2019.09.20.06.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:01:46 -0700 (PDT)
Subject: Re: [sparc64] pktcdvd: setup of pktcdvd device failed
To:     Anatoly Pugachev <matorola@gmail.com>, linux-block@vger.kernel.org
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <CADxRZqz_TF7jyGtbg9cVSnCGh2VzfCoRGBdCU_yE_v1cveq1Pg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c02d0e0c-e468-003f-6b66-8592a987cbf8@kernel.dk>
Date:   Fri, 20 Sep 2019 07:01:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CADxRZqz_TF7jyGtbg9cVSnCGh2VzfCoRGBdCU_yE_v1cveq1Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 4:27 AM, Anatoly Pugachev wrote:
> Hello!
> 
> Getting the following call trace on boot on sparc64 ldom/machine with
> current git kernel:
> 
> ...
> [   13.352975] aes_sparc64: Using sparc64 aes opcodes optimized AES
> implementation
> [   13.428002] ------------[ cut here ]------------
> [   13.428081] WARNING: CPU: 21 PID: 586 at
> drivers/block/pktcdvd.c:2597 pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
> [   13.428147] Attempt to register a non-SCSI queue
> [   13.428184] Modules linked in: pktcdvd libdes cdrom aes_sparc64
> n2_rng md5_sparc64 sha512_sparc64 rng_core sha256_sparc64 flash
> sha1_sparc64 ip_tables x_tables ipv6 crc_ccitt nf_defrag_ipv6 autofs4
> ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy
> async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear
> md_mod crc32c_sparc64
> [   13.428452] CPU: 21 PID: 586 Comm: pktsetup Not tainted
> 5.3.0-10169-g574cc4539762 #1234
> [   13.428507] Call Trace:
> [   13.428542]  [00000000004635c0] __warn+0xc0/0x100
> [   13.428582]  [0000000000463634] warn_slowpath_fmt+0x34/0x60
> [   13.428626]  [000000001045b244] pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
> [   13.428674]  [000000001045ccf4] pkt_ctl_ioctl+0x94/0x220 [pktcdvd]
> [   13.428724]  [00000000006b95c8] do_vfs_ioctl+0x628/0x6e0
> [   13.428764]  [00000000006b96c8] ksys_ioctl+0x48/0x80
> [   13.428803]  [00000000006b9714] sys_ioctl+0x14/0x40
> [   13.428847]  [0000000000406294] linux_sparc_syscall+0x34/0x44
> [   13.428890] irq event stamp: 4181
> [   13.428924] hardirqs last  enabled at (4189): [<00000000004e0a74>]
> console_unlock+0x634/0x6c0
> [   13.428984] hardirqs last disabled at (4196): [<00000000004e0540>]
> console_unlock+0x100/0x6c0
> [   13.429048] softirqs last  enabled at (3978): [<0000000000b2e2d8>]
> __do_softirq+0x498/0x520
> [   13.429110] softirqs last disabled at (3967): [<000000000042cfb4>]
> do_softirq_own_stack+0x34/0x60
> [   13.429172] ---[ end trace 2220ca468f32967d ]---
> [   13.430018] pktcdvd: setup of pktcdvd device failed
> [   13.455589] des_sparc64: Using sparc64 des opcodes optimized DES
> implementation
> [   13.515334] camellia_sparc64: Using sparc64 camellia opcodes
> optimized CAMELLIA implementation
> [   13.522856] pktcdvd: setup of pktcdvd device failed
> [   13.529327] pktcdvd: setup of pktcdvd device failed
> [   13.532932] pktcdvd: setup of pktcdvd device failed
> [   13.536165] pktcdvd: setup of pktcdvd device failed
> [   13.539372] pktcdvd: setup of pktcdvd device failed
> [   13.542834] pktcdvd: setup of pktcdvd device failed
> [   13.546536] pktcdvd: setup of pktcdvd device failed
> [   15.431071] XFS (dm-0): Mounting V5 Filesystem

Someone is running pktsetup to set up a device, at boot time. The device
being passed in doesn't support pass-through commands.

I believe there are two questions here:

1) Why is pktsetup being called? I don't expect anyone to use pktcdvd
   anymore.

2) Given #1, what kind of device is being passed in?

Do  you have some ancient funky init scripts?

-- 
Jens Axboe

