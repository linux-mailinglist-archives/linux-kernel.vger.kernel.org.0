Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB16210A505
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKZUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:03:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43646 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfKZUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:03:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so21679047ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWV9arggnPlqa0lazxpcwxfW6DO0FvZ1dHAsZFOz/2Q=;
        b=WsPvXjG5t74MPCFoRSj5L+BalU5zqcKRAVt7HyQM8jo02n6sA2b1cJrmb3EV7BYp3n
         du2/QOrTOQFvmdBWqbFNwITB5p5iP9gO1lvitMNJM7sKQCZ4Lkhyj0cOkbV15nePagsQ
         oxnsIpG0jie9HZxKh87rV4lPw8f0at7/W135w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWV9arggnPlqa0lazxpcwxfW6DO0FvZ1dHAsZFOz/2Q=;
        b=cZ1r+Vre1mSApw3tNWDW7jmp/GcEWS9apEmbdVuASax9ugrZFOB1oKcJN+J+RR91jy
         LUs6CDBt63VxWs1mmwKcXxfkHJijJINSi7F0ko/65TgrTzERVo2lY4xK91Ux5PPXEWbs
         G3zMyqMdg+wv6Gpqs653N5dKjdBtjJh+8Dc+B4nu33jRK0axD8oMceDFmUFg9My0f+wq
         U/7ph0AocVmkhIXkHF87hobSW30jMfNjNSkZw6acK1dfSRqQVf55dkemcQuDupyWeBZi
         Ty9O+jUbS4n8/S9pRbcro2o3dsYZRiw+jnzcCRnF/MCNUojQJNmN12HWY+lDezeqM+It
         XgBA==
X-Gm-Message-State: APjAAAWIIYtbB/rg2k1p0HMOfY/mr4Kax0Y73Wqlz5cipTJAAbyYmwfp
        jhVYU1siVF59LTMkadlTn0N6Ou4tpXE=
X-Google-Smtp-Source: APXvYqx1xSDS0YHVYnalXtstJpWWcFQN42eO7Lna7hiJkpOi0cCb6roUytOfBEBEFW7Yqir7/RaE7w==
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr24809885ljj.99.1574798634109;
        Tue, 26 Nov 2019 12:03:54 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y6sm5918969ljn.40.2019.11.26.12.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 12:03:53 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e10so12536434ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:03:53 -0800 (PST)
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr16849464ljh.48.1574798632799;
 Tue, 26 Nov 2019 12:03:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
 <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
 <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com> <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
In-Reply-To: <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Nov 2019 12:03:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6w6U5FgZZXq-Eo8+aH1Y6ffp+Nwr_6GzmuzjVuGXmNw@mail.gmail.com>
Message-ID: <CAHk-=wh6w6U5FgZZXq-Eo8+aH1Y6ffp+Nwr_6GzmuzjVuGXmNw@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 7:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think I'll have to revert that trial commit. I'll give it another
> day in case somebody has a better idea, but it looks like it's too
> early to do that nice cleanup as things are now.

I've reverted it for now,

I don't want this problem to cause people to report known bugs during
the merge window. The fact that I saw no issues obviously is just a
matter of my workloads being too simple.

               Linus
