Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF156FDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfD3Q1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 12:27:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44867 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3Q1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:27:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id c6so6882035lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPJ14HI8nidtRQ09xbk5mtnZ2GEqgeW1g0o9PAYcc7E=;
        b=N71KCO/OD3WVF6avSQuHQlEpn5ohk7wqryuyQsevf2srgYtCoP3CQc9ORuDKUH7RiD
         EFC0FLhGc/4syjSWjmKURrMQsiJDM+d2OOLgA39+/dzcTaOBbXV/QrgIAytHBe9kKjMQ
         lGI7zuiHf+5TrZMM5uFoPlrJcAHhz5pQPw+30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPJ14HI8nidtRQ09xbk5mtnZ2GEqgeW1g0o9PAYcc7E=;
        b=SOWWlf7uMSxGgdx1Jf10KUZxbfc3L3HQ2aKzEMU+6XktYiDA4OD+ioyO2Kmin5kXD/
         2F9wHxx3MHvRCXrUd8h/FGJ6vRLBd+77o2wOKh41xpT9ftZ9YS+Q83I7i+B8yD7hYjCK
         ZAfhUWPcCn/p5KnlTXZQinSZ9sXTgYTZ29rICSkb9gMUqMh829qzkWgyfEJYcnh178qB
         8Ut4VIvuFeOXpPpzL53cbLoGBEqkRWjkVIS06yfvJw7dZjyqhKT9u0tvRLLYD2NvISq3
         bbfuyP2qeRiV8nINLmdeO3yrgJgDkPQz5pYrgpEKC6Yg4E53lfnL3tLeYc9lzM7BdYZL
         kcdw==
X-Gm-Message-State: APjAAAUlgkR8EBe9yg/sewec8mIBB6jHzr2yRHb2gr3YZSxf4dbq9nUv
        iOosJYJnGu4LHWxDMqcyzoJ7SzxGAXY=
X-Google-Smtp-Source: APXvYqzSpt5LM+mpvPqYowJMsqO+NVtpOofdMLozySIumfDB2DA6/XdS18dErzGsxY3KcbTrVAp8xQ==
X-Received: by 2002:a2e:7c02:: with SMTP id x2mr35217641ljc.176.1556641636920;
        Tue, 30 Apr 2019 09:27:16 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w8sm8072449lfn.95.2019.04.30.09.27.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:27:14 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h18so11195413lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:27:13 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr36979375lfm.166.1556641633154;
 Tue, 30 Apr 2019 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
 <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
 <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
 <87r29jaoov.fsf@oldenburg2.str.redhat.com> <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
In-Reply-To: <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:26:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxqoH=Cztd7W67pYJyZwPPNtY5P7K66u2QTDEpEYHVAw@mail.gmail.com>
Message-ID: <CAHk-=wgxqoH=Cztd7W67pYJyZwPPNtY5P7K66u2QTDEpEYHVAw@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 9:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, if you *don't* need the exact vfork() semantics, clone
> itself actually very much supports a callback model with s separate
> stack. You can basically do this:
>
>  - allocate new stack for the child
>  - in trivial asm wrapper, do:
>     - push the callback address on the child stack
>     - clone(CLONE_VFORK|CLONE_VM|CLONE_SIGCHLD, chld_stack, NULL, NULL,NULL)
>     - "ret"
>  - free new stack
>
> where the "ret" in the child will just go to the callback, while the
> parent (eventually) just returns from the trivial wrapper and frees
> the new stack (which by definition is no longer used, since the child
> has exited or execve'd.

In fact, Florian, maybe this is the solution to your "I want to use
vfork for posix_spawn(), but I don't know if I can trust it" problem.

Just use clone() directly. On WSL it will presumably just fail, and
you can then fall back on doing the slow stupid
fork+pipes-to-communicate.

On valgrind, I don't know what will happen. Maybe it will just do an
unchecked posix_spawn() because valgrind doesn't catch it?

                  Linus
