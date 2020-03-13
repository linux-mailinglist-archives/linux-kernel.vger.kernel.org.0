Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082FC185027
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCMUSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 16:18:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46214 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:18:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id d23so11908220ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dyaDXD6kKcsjU3cdaN9tJMCmO/tIPHlkK3dbzeZyfg=;
        b=IyxmDZ+MInB7hJJiSvQ8M6SvkLSa6alEsIj47Hf+qqZ5CYMCROkdK8r49X48qyOGZZ
         DvHajJVv4/N9Xt+1+F5wfePvt104x04McIxOVjzj8DY7AvoCiMni8wf4vkLGHwgkAqKb
         NXkS+J6hgxY+A06g0a4K+hKEe7gxItoNaFqjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dyaDXD6kKcsjU3cdaN9tJMCmO/tIPHlkK3dbzeZyfg=;
        b=cBbDI6Gxf32SddJXQn+XGCwSZSTKFnm/lvo7f3R3A30VQsSGGoh6bybU2kQFYFBIMZ
         eAQCY/5XaTKvm+caOP+U8aq53eMcK5taq4/Wi8+8PhnNubkQSN+uTrm/usyyjZmZD5fM
         uxJtFGuVFQHiNg0mpYG6cXWvUGCTA0WnDpWx6l1uBojJKel1OQxZsf6UZagkCAHG9wC/
         qHYJmI8bO+Gbn00bQ4SXX6Ox5At3ZniL+rRU6EhLxRm4ZGLJfsLCWhu+6yX+3z0otEiO
         +F93Be/PZuqPUSqMqKxjw04/Y7Y7DO7t0vPjbIKJWGMC/bk5Fbm781sRF6bXEjQMSiA/
         0vew==
X-Gm-Message-State: ANhLgQ29BLyxSnHJxaPJ695ie8IF47lqoCv69hlLci0/20yP8P/YxbDA
        m5lRXGgt+4ss2X3nT2OxRTkNrsjsgY0=
X-Google-Smtp-Source: ADFU+vs37sVJW9aTdhjWOL+R3RXkiI2rIbdRoal2WhsuE2zAJVsYW4QmJPQ39dx7oLJKX1WQ/Fpxsw==
X-Received: by 2002:a2e:9cc1:: with SMTP id g1mr9459574ljj.152.1584130728095;
        Fri, 13 Mar 2020 13:18:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b23sm9282494lfi.55.2020.03.13.13.18.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 13:18:47 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 5so1811910lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:18:46 -0700 (PDT)
X-Received: by 2002:ac2:5508:: with SMTP id j8mr9590741lfk.31.1584130726499;
 Fri, 13 Mar 2020 13:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <00e5ab7d-f0ad-bc94-204a-d2b7fb88f594@fb.com>
In-Reply-To: <00e5ab7d-f0ad-bc94-204a-d2b7fb88f594@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 13:18:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGN-9dmso4L+6RWdouEg4zQfd74m23K6c9E_=Qua+H1Q@mail.gmail.com>
Message-ID: <CAHk-=wgGN-9dmso4L+6RWdouEg4zQfd74m23K6c9E_=Qua+H1Q@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.6-rc
To:     Jens Axboe <axboe@fb.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:50 AM Jens Axboe <axboe@fb.com> wrote:
>
> Just a single fix here, improving the RCU callback ordering from last
> week. After a bit more perusing by Paul, he poked a hole in the
> original.

Ouch.

If I read this patch correctly, you're now adding a rcu_barrier() onto
the system workqueue for each io_uring context freeing op.

This makes me worry:

 - I think system_wq is unordered, so does it even guarantee that the
rcu_barrier happens after whatever work you're expecting it to be
after?

Or is it using a workqueue not because it wants to serialize with any
other work, but because it needs to use rcu_barrier in a context where
it can't sleep?

But the commit message does seem to imply that ordering is important..

 - doesn't this have the potential to flood the system_wq be full of
flushing things that all could take a while..

I've pulled it, and it may all be correct, just chalk this message up
to "Linus got nervous looking at it".

Added Paul and Tejun to the participants explicitly.

             Linus
