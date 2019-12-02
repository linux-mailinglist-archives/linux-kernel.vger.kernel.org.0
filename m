Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B6210EC9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLBPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 10:49:08 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34372 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLBPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:49:08 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so41071286iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lUV1YCzvy/Bk6GN33KJO5EoQ21oVlzfQOCa/jgUbcKY=;
        b=HJkUaW0iR9HaWBDgP8ZPABt63QabWVV4dTdB0xaaL9Q2LRIU/9WmY37uezyL7CoEPd
         Mvx7Gc6G9XPtagzkOTej4N5I5QPIKOQt1oFf2KoFrx+CbL+TwcD9MqVljWrtQ8D1hPxz
         1cBrfPxro1f/GsGSestA42WJTtKEqRL8pQdjPijXtTWbpaQmyV+Vfolgdqlf2qllZWgx
         pmuQgCD5CVMRVNqc7vouerqLz56c0l6q1XclAYLmK1y2nhAMOpcybk4u3FFCcZhGni6b
         fpkztX+83ifcMaBmyEpTZPaQ1cqWyyKxAj6fRa1aYF6CXc3JkyHIGuy08ns60oWmx2U0
         UKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUV1YCzvy/Bk6GN33KJO5EoQ21oVlzfQOCa/jgUbcKY=;
        b=VoumZAsgkn/VsHu7D5NezRk2jNLW03ngxFGxVATd+760FTm0xqR64AmPnHo10mO1BE
         LWWaWbesgNcVvlNNDfJyBhfG4gRLBLxXt5IAdx0TPpXdQXDBa5kXLXlVYe7CUATXLeUE
         hfwiMy8qKgUF5+8xunPjgzEmgXUrQOBFiD8ZOBsR2ZpFrFk8MFdYtFNBkWc8jrYxS/ay
         zMm5WWzpkF6G/BBSHAr4uDtngM+f8DBbTHyD+OFLtm6L5gZxSwk2jWgwKKQw4S650vdV
         zuYlrduDyqVXP2ZrHS9ayZsQj2pU6v2gIF3Vpii2CRr9dBo1GF86ovpbx0LecYdaqVnq
         PCvw==
X-Gm-Message-State: APjAAAVwyOQzt0ApuFFKxZxCRztWBsTGzSMH0a6zZZBaD5zZrmg+4mwd
        cOTVT2r1SlUvXgh1gpOTRNq/XQ==
X-Google-Smtp-Source: APXvYqzZBDPylb+uAXhA22FT+e+8mIXSGoWX+RQK9aCeE0TCVTRfcOL1V7MzvTw5GbyOa29G6IJNmg==
X-Received: by 2002:a6b:ef13:: with SMTP id k19mr21106341ioh.23.1575301746677;
        Mon, 02 Dec 2019 07:49:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i2sm3539171iol.29.2019.12.02.07.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 07:49:05 -0800 (PST)
Subject: Re: general protection fault in override_creds
From:   Jens Axboe <axboe@kernel.dk>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Anna.Schumaker@netapp.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <000000000000da160a0598b2c704@google.com>
 <CACT4Y+ZGx16qc8qtekP0Bx=syVQest8K_RVtEN084jnszx4qhA@mail.gmail.com>
 <39ea5e00-3278-a84f-25ae-c7a93a4b8ab5@kernel.dk>
Message-ID: <7be77044-5390-7df1-33d4-e92166fb927a@kernel.dk>
Date:   Mon, 2 Dec 2019 08:49:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <39ea5e00-3278-a84f-25ae-c7a93a4b8ab5@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/19 7:40 AM, Jens Axboe wrote:
> On 12/1/19 10:40 PM, Dmitry Vyukov wrote:
>> On Mon, Dec 2, 2019 at 7:35 AM syzbot
>> <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10f9ffcee00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
>>
>> I think this relates to fs/io_uring.c rather than kernel/cred.c.
>> +io_uring maintainers
> 
> Yeah that's my fault, guessing the below will fix it. I'll test and
> queue it up.

This is cleaner, tested fine.


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 91b85df0861e..74b40506c5d9 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -111,7 +111,7 @@ struct io_wq {
  
  	struct task_struct *manager;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  	struct mm_struct *mm;
  	refcount_t refs;
  	struct completion done;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 600e0158cba7..dd0af0d7376c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -87,7 +87,7 @@ typedef void (put_work_fn)(struct io_wq_work *);
  struct io_wq_data {
  	struct mm_struct *mm;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  
  	get_work_fn *get_work;
  	put_work_fn *put_work;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ec53aa7cdc94..5cab7a047317 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -238,7 +238,7 @@ struct io_ring_ctx {
  
  	struct user_struct	*user;
  
-	struct cred		*creds;
+	const struct cred	*creds;
  
  	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
  	struct completion	*completions;
@@ -4759,7 +4759,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
  	ctx->compat = in_compat_syscall();
  	ctx->account_mem = account_mem;
  	ctx->user = user;
-	ctx->creds = prepare_creds();
+	ctx->creds = get_current_cred();
  
  	ret = io_allocate_scq_urings(ctx, p);
  	if (ret)

-- 
Jens Axboe

