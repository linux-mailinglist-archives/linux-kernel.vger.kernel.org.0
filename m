Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13E10A49C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKZTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:33:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40093 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfKZTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:33:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so2371054lfy.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNdeYyzKLpu63DGl2XEkPQDnzQUC1plincAavY5X3kM=;
        b=QvAwJP0j2/X610cvfwW8I1VXhYWVnDyMBDlfw0V9BIJ7RmgPyzRPiAE+jEbmtwdGZe
         OaUI0eIk1VJF8bzxEkApNnJ0YcGdNzhZut3CrbxwDAUu0nJTz0iRtxan5FaleaItrpky
         HB1ZsWPbHd6/69K/6nXAjUupWa94CmR60Whqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNdeYyzKLpu63DGl2XEkPQDnzQUC1plincAavY5X3kM=;
        b=NUBhb7HkVh13go12GA86IVju4v8J6PqB90y7n/+pB5Kw7wa8hjnfpva7M1VrvLT/gQ
         g0MBeUoiCqhcKfh4sfrh1Ik/+/gjulCyCcGmtfFdRyQ67Yy4h5FJPrulo7WcktwVGyAP
         A2mrVD8JyYkmydr0mnRgP5kuY5qJWubmGQtPJHDOo88Cqq1E2J5En5sVOgiwukH3tvVl
         oKzakrXbjIaQD3oO6UMVnYnpfnZT2AvZnGW6e1VKrzDKIqjqSo/H2oxP8KdxkJ9kbeyH
         cULUMNhdmJoLFB+L3seIyeWtImTaUymoqiEgjVd1s5pDEnDOcQPFSExPA2z/FF2bJDk+
         lA9Q==
X-Gm-Message-State: APjAAAV/C25RsCEp6yscfD64ym24fiTKta3vGI8va8rYUY/xg02OHd1K
        w0217GpspEss+BfZeuTxkys/bnQ3yeM=
X-Google-Smtp-Source: APXvYqy1fEmjxyXALZovaClwmL/UPj3Py21qfShyeVx12L9v/npb2s8fXE5/4dG8jCPndkUbROYpxg==
X-Received: by 2002:ac2:5de4:: with SMTP id z4mr24209627lfq.17.1574796834928;
        Tue, 26 Nov 2019 11:33:54 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f3sm5867916lfl.58.2019.11.26.11.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:33:54 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id e10so12441277ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:33:53 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr27984371ljs.26.1574796833583;
 Tue, 26 Nov 2019 11:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20191125161626.GA956@gmail.com>
In-Reply-To: <20191125161626.GA956@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Nov 2019 11:33:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whswxd9b0A9Sr5YhjcGbA0WKrB8Rrtx89PLKeP6RdKT3A@mail.gmail.com>
Message-ID: <CAHk-=whswxd9b0A9Sr5YhjcGbA0WKrB8Rrtx89PLKeP6RdKT3A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 8:16 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> This tree implements a nice simplification of the iopl and ioperm code
> that Thomas Gleixner discovered: we can implement the IO privilege
> features of the iopl system call by using the IO permission bitmap in
> permissive mode, while trapping CLI/STI/POPF/PUSHF uses in user-space if
> they change the interrupt flag.

I've pulled it.

But do we have a test for something like this:

   ioperm(.. limited set of ports..)
   access that limited set.

   special_sequence() {
       iopl(3);
       access some extended set
       iopl(0)
   }

   go back to access the limited set again

because there's subtle interactions with people using *both* iopl()
and ioperm() and switching between the two. Historically you could
trivially do the above, because they are entirely independent
operations. Does it still work?

Too busy/lazy to check myself.

              Linus
