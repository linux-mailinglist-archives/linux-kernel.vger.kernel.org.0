Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E201040BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfKTQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:26:31 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37818 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfKTQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:26:31 -0500
Received: by mail-il1-f193.google.com with SMTP id s5so198850iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JENUqEEnkMucQYcuF3hzwhPPTtO+OEvYvVNGiZXej+g=;
        b=wKsYZexC5vSXvFpFtEIocMf7yXYGNIjjSpxvBiQ3kU+tGcaRX9fxHi1klf+UeIDRlf
         1BndtbOC9kePbT8EBdXp+tTwbg/cw7wze8ojHoMHEPMitRgfiFgIlxVEpl9JjEtaQqlw
         HrvOR1zHlx56yMYUvbGKZaywZibdxD/tf1Bfz6Ak4YebiOTMuI+c/hmEJdaGTduNE+yT
         uDAOZwl5QJvZuKwye8LMsrYCFHHZ/7w5s6PPOUqBI0yJTqY/VU42woyfOYHaDRY36gMO
         lIbMGLCb+U383g6ICFeMpzqktydwHsHc96E+L9DsX8DLPQJLLgsYOnPIitb6bDK0/m5Q
         GgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JENUqEEnkMucQYcuF3hzwhPPTtO+OEvYvVNGiZXej+g=;
        b=B99X82+oXwLKNOlkwXoon+51r7jllfgF82zJtyX1IkN6CUu+BENYhfPbdaXWQ/j7lc
         /m5z9WUHHJv7HOTc7e8DsAKuv2fLKzY0YCS6EdlhasNTKD5vi8YrZ7ifkvNFcEoXNkh4
         0exN35d3tucxH1xcJMgL10WgZTPUVJ50ldZ3Ac9idHWsyLjeQptf+4AWfKLIsg0ApVu6
         Sflk6QHqDPVLzc9817p3WnmN8QZY+SJ7lcju8EoEnIWCKbhJiwRkj+8ckq/REB2XS/GC
         BjsrkoIlRvn+ZCAH++fJCHFPsPlC9LG6o6i/FjA+PYHu8zVC6Dy4VrrXPXvI85HN5flG
         Ljjw==
X-Gm-Message-State: APjAAAWrUQ1abAUeuOeNkk8RxFnBNzf3m1wjrc8c4DWNmOGDHgUGtYwx
        Sx3KsRYDQONwsagF+2jRe3rh9g==
X-Google-Smtp-Source: APXvYqw9AiyFurVMLfdttmCuAKXzB/ZMgeFzgo3mCBRzz20cZpDSuTxB1JfsmCsMEH8BHQeRHNt3kA==
X-Received: by 2002:a92:868f:: with SMTP id l15mr4459061ilh.199.1574267190503;
        Wed, 20 Nov 2019 08:26:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o184sm6622713ila.45.2019.11.20.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:26:29 -0800 (PST)
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
To:     syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000003a1f180597c93ffe@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d507894-afcc-5b43-f8d6-ca7812a155e6@kernel.dk>
Date:   Wed, 20 Nov 2019 09:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0000000000003a1f180597c93ffe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 8:58 AM, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=140b0412e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

Thanks, the below should fix it.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 100931b40301..066b59ffb54e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4568,12 +4568,18 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
+	if (size == SIZE_MAX) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -EOVERFLOW;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes)
+	if (!ctx->sq_sqes) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }

-- 
Jens Axboe

