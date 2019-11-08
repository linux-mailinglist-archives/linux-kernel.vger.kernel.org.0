Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9FF5A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfKHWGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 17:06:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33294 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKHWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:06:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so7791731ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PM7aXIqGlTv4ooyqCBP9d/aFSkST3hpJVxVLXow9peg=;
        b=PS2bjVFaLslkBSK4KUWZW/tIht7XZkmjJaTGU2fPdPRjfl2o/Ml1nSc5Cg3cXbpjrn
         uVwV0UkzJaP00ag8fp+t0sP9z4xcMjUm8fftb7VXNUC7o8uebivBnfsBFl0/gpgF8qbg
         C7Lov0mQEbZd2DawPCA8y68rgZ/YLGOFrSlQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PM7aXIqGlTv4ooyqCBP9d/aFSkST3hpJVxVLXow9peg=;
        b=qzMFHjopilD18DFg1xFNh8P38SPrQXSHQRw4kZ+Hez/zVDdHDnQcxvBeYNubMpt7GH
         lV1/4C+B7SxK+b1eF1CWNgNSDgfJfCA2XHo/WU0kwjfO60eY5OkdAEu8WoP6y3Vae7vj
         eeYaSaYeq/4PPy4aFB7Ej4a199qCdsUDzOdpIfMuzIAbTk11qB/gO9xiiUwhpQCMK8ZP
         KWLAHW+2ybzh7/xSANbF+tEXIoL6zEY5XE3L5OxRZw6gy/AcPAAWu2XyaW06FP8ImXvS
         4hm1RhNpoXYLoJqRT8/q5sPc8RjoqeWVcRaEXqvlTcrd2ITfsGNdYzeCMKlCipdABS8Z
         IVwA==
X-Gm-Message-State: APjAAAWRi1IAj1dbz+czVp86tEUYuCVWANcAiDersxYwK2HocNcRB5lL
        b4yNTGSULx2xhXJakOx3aKzoZVhoAbk=
X-Google-Smtp-Source: APXvYqzDs2F/qDAmyesGtFeDIG98fVQ3rkBKlPTf3OsUCziGmvMBxNg1ZuRuFGjB8jEaZw71OLterw==
X-Received: by 2002:a2e:8857:: with SMTP id z23mr5107071ljj.50.1573250802679;
        Fri, 08 Nov 2019 14:06:42 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d26sm1421593ljo.54.2019.11.08.14.06.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:06:41 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id v8so7765924ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:06:41 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr8150237lji.148.1573250801141;
 Fri, 08 Nov 2019 14:06:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
 <Pine.LNX.4.44L0.1911081649030.1498-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911081649030.1498-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 14:06:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com>
Message-ID: <CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 1:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Can we please agree to call these writes something other than
> "idempotent"?  After all, any write to normal memory is idempotent in
> the sense that doing it twice has the same effect as doing it once
> (ignoring possible races, of course).

No!

You're completely missing the point.

Two writes to normal memory are *not* idempotent if they write
different values. The ordering very much matters, and it's racy and a
tool should complain.

But the point of WRITE_IDEMPOTENT() is that it *always* writes the
same value, so it doesn't matter if two different writers race on it.

So it really is about being idempotent.

> A better name would be "write-if-different" or "write-if-changed"

No.

Again,  you're totally missing the point.

It's not about "write-if-different".

It's about idempotent writes.

But if you do know that all the possible racing writes are idempotent,
then AS A POSSIBLE CACHE OPTIMIZATION, you can then say "only do this
write if somebody else didn't already do it".

But that's a side effect of being idempotent, not the basic rule! And
it's not necessarily obviously an optimization at all, because the
cacheline may already be dirty, and checking the old value and having
a conditional on it may be much more expensive than just writing the
new value./

The point is that certain writes DO NOT CARE ABOUT ORDERING, because
they may be setting a sticky flag (or stickily clearing a flag, as in
this case).  The ordering doesn't matter, because the operation is
idempotent.

That's what "idempotent" means. You can do it once, or a hundred
times, and the end result is the same (but is different from not doing
it at all).

And no, not all writes are idempotent. That's just crazy talk. Writes
have values.

               Linus
