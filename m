Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4A13A035
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 05:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgANEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 23:09:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36910 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgANEJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:09:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so4695388plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lk1AizI1EHV9lSqOaMe1Vebf9sR0lxBjnFVTRCczpIM=;
        b=PiAlwUboHVv6bfzcwpZfmQi5dJbPDlbsxU8GeeKbOkqu4/epqzrLc1s5ggWhZ5gtQT
         uHL60mx+QCQq+fOtUB8J/SIWwgkk5SA02E13pPwnW5WiJoWF+DlrwqtmCRYWbXtOy2bk
         kgNBVh2HyzDGZ6kNTNypH6S1qjcPxKSdTcfAXTFMPXFXE7CaaUjJsUz0ZstO0AMKvpij
         pxyRlN1q0rThmXiKYB3B4yDjl9Q23o+KA242EtsMqcMsV6uUhO+Yv8mPNSFkEx933kIW
         9EHsM0ymtYgn5iyYBaxmWB0MliHn6SFj5fmmzFEM2+F+u9TdRaCiFlFpFnzNqi6maZNl
         e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lk1AizI1EHV9lSqOaMe1Vebf9sR0lxBjnFVTRCczpIM=;
        b=srQZRdYnaKVR9hyaHkOCo3L2ol43bF/QnUYFQIp91QE8Jk+3j6cykBc+hVE1Z1E8a2
         BYNSMLN2XcPvutkIhgUnI7s6BUWxpZX/ez1sM/Qgmn90Fit2m5m55k0kuHAIN41m3mv8
         j+r/RqfkcaHlV6UlStuswBxf74oeI6V0mBzzp1hbb7dnJStUkyxQ2o6fmSpBYYCoxOzr
         fJRR1plMpUIzqpx9uT7ZCLecKVsioG/Pk5MQGuZYxkQtSZwV1lKSKbO++4XXcY7diuXH
         uU+NZkEFV2cIU5P4U6kF/DwQuA0D43CKZfVsafRQzBjDQuTCwCPXyWi5A2vTIGXFfidW
         g3Lw==
X-Gm-Message-State: APjAAAXF9O6sfggRKfXOMxGgb0FnR4GM1usQQ6r4fG/3gbY5vvE51zqb
        TTaNPlSZ8qUQTRkk5ZV2XnzLeg==
X-Google-Smtp-Source: APXvYqxnmPZsSb6Jb7K6zwUhM8ksX99PCWuKR5aTnx5csBcmJBdgcPIRJc9vhsJKuCExuubN4dRa3g==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr26931172pjr.74.1578974983877;
        Mon, 13 Jan 2020 20:09:43 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x197sm16474368pfc.1.2020.01.13.20.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 20:09:43 -0800 (PST)
Subject: Re: [BUG] bisected to: block: fix splitting segments on boundary
 masks
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200113221317.0e27f0a9@rorschach.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e8bd9824-20ff-03e0-c289-e77c4f6669af@kernel.dk>
Date:   Mon, 13 Jan 2020 21:09:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113221317.0e27f0a9@rorschach.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 8:13 PM, Steven Rostedt wrote:
> Hi!
> 
> Running one of my ftrace stress tests, I hit this bug:
> (On i386, haven't tested on x86_64 yet)
> 
> ------------[ cut here ]------------
> kernel BUG at block/bio.c:1885!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 1 PID: 105 Comm: kworker/u8:6 Not tainted 5.5.0-rc4-test+ #365
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> Workqueue: writeback wb_workfn (flush-8:0)
> EIP: bio_split+0xf/0x67
> Code: 89 d8 e8 90 0f 02 00 85 c0 79 09 89 d8 31 db e8 e0 fa ff ff 89 d8 5b 5e 5f 5d c3 e8 db 5b d2 ff 55 89 e5 57 56 53 85 d2 7f 02 <0f> 0b 8b 58 20 c1 eb 09 39 d3 77 02 0f 0b 89 cb 8b 4d 08 89 d6 89
> EAX: e2ddb600 EBX: ec74bc80 ECX: 00000c00 EDX: 00000000
> ESI: 00000000 EDI: 00025000 EBP: ec74bbec ESP: ec74bbe0
> DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> CR0: 80050033 CR2: 025c7ed4 CR3: 270bc000 CR4: 001406f0
> Call Trace:
>  __blk_queue_split+0x327/0x40b
>  ? blk_mq_try_issue_directly+0x91/0x91
>  ? blk_mq_try_issue_directly+0x91/0x91
>  blk_mq_make_request+0x6e/0x407
>  ? function_trace_call+0xb8/0xdc
>  ? blk_mq_try_issue_directly+0x91/0x91
>  generic_make_request+0xc7/0x1e1
>  submit_bio+0x113/0x12b
>  ? ftrace_call+0x5/0x15
>  ext4_io_submit+0x47/0x51
>  ext4_writepages+0x53d/0x6ee
>  ? trace_function+0xcc/0xd4
>  ? page_writeback_cpu_online+0x11/0x11
>  do_writepages+0x29/0x55
>  __writeback_single_inode+0xc4/0x420
>  writeback_sb_inodes+0x239/0x395
>  __writeback_inodes_wb+0x5c/0x8b
>  ? trace_trigger_soft_disabled+0x40/0x40
>  wb_writeback+0x175/0x30a
>  wb_workfn+0x255/0x348
>  ? function_trace_call+0xb8/0xdc
>  ? inode_wait_for_writeback+0x28/0x28
>  process_one_work+0x25e/0x3d1
>  worker_thread+0x170/0x21f
>  kthread+0xe1/0xe3
>  ? rescuer_thread+0x217/0x217
>  ? kthread_worker_fn+0x116/0x116
>  ret_from_fork+0x2e/0x38
> Modules linked in: ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables ipv6 crc_ccitt realtek ppdev r8169 parport_pc parport
> ---[ end trace 7b7d4d993e5ceea3 ]---
> 
> It is very reproducible and I bisected it to 429120f3df2dba ("block: fix
> splitting segments on boundary masks")
> 
> The test is simply:
> 
>  # perf record -o perf-test.dat -a -- \
>    trace-cmd record -e all -p function ./hackbench 20
>  # trace-cmd report > /tmp/tempfile
> 
> It appears to crash on the trace-cmd report.

Can you try:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=1ca6b68e516b3de3707ae2cec9e206c8f9dd816e

-- 
Jens Axboe

