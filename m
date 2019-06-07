Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896B939695
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfFGUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 16:14:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42152 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfFGUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:14:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so2518832lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUEu5wST+UHrWo914sEu5kjdDbXuNNjK9ZP+p24WTJk=;
        b=BCH3+i2RkSQKcHf+jy2IJ/CTFV2fxPDMCV0yygfkoiboPb59bnWZMo807PibOJ2plD
         Uzjrx+QO3Nq0MQ317FiYIxzStxeM1kuEVYh+K84ZNuWFKtAvM5wPFRvOkAKdLL7zeJ6A
         bzrmNyaYZqOEIK+oJwa8qi4l+leu534qbZlrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUEu5wST+UHrWo914sEu5kjdDbXuNNjK9ZP+p24WTJk=;
        b=AsxnNkRABDNd7J4xpFADtVYk8XpolGPzi3ibrii3VE0vMi206gAgTYTw4Rrrvqcrif
         3Gt2A/GkVXLMxnzRSx/7L7JLfqT3tRhU+xnrEW+V9H3ciavrCxwQMLVAp5I3WPcsS2aU
         L7CxFG9Xpr3HiHOEq5fpFBbZq6imgC7NWB3bXCodr38KPMJizOWHCthf5St+Tmw6vxip
         cWK1cWVop/NrPi3NHF6KWc+TMhp00+E5Po1l8K/qrf3/mosLokOYsylDVf53W4d83uES
         +uTJGygYXv7Pa+vfQ+uQOcFfilcjCIFWGrxHzViSDG3USSs5aWq26HFdTNxR22ycAPUu
         8bnA==
X-Gm-Message-State: APjAAAWQ44qnX86LS/UTNedJHMNJ2ImfJIrfEYzZyJ7OhVfFqLB5q/ZS
        Ygb8Mffx9/s2p9tN7n0C+xPl5po4uBM=
X-Google-Smtp-Source: APXvYqyKBnWQw0T51nmBfHNQCkw5h8Y5qVullLSwJjbOWJEzQlwxaWD6m2K1ONkLmZwGIqoWAq0hjg==
X-Received: by 2002:a19:740e:: with SMTP id v14mr29096235lfe.144.1559938466755;
        Fri, 07 Jun 2019 13:14:26 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v12sm521900ljv.49.2019.06.07.13.14.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:14:25 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h11so2823228ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:14:25 -0700 (PDT)
X-Received: by 2002:a2e:6109:: with SMTP id v9mr29356668ljb.205.1559938465306;
 Fri, 07 Jun 2019 13:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190605134849.28108-1-jglauber@marvell.com> <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
 <20190606080317.GA10606@hc> <20190606094154.GB6795@fuggles.cambridge.arm.com>
 <20190606102803.GA15499@hc> <20190607072652.GA5522@hc>
In-Reply-To: <20190607072652.GA5522@hc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 13:14:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwgOUP8ihvxcDmP4dr6gjSv-y9sJ4MzXM5NQFe0B7-pg@mail.gmail.com>
Message-ID: <CAHk-=wjwgOUP8ihvxcDmP4dr6gjSv-y9sJ4MzXM5NQFe0B7-pg@mail.gmail.com>
Subject: Re: [PATCH] lockref: Limit number of cmpxchg loop retries
To:     Jan Glauber <jglauber@marvell.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jan Glauber <jglauber@cavium.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 12:27 AM Jan Glauber <jglauber@marvell.com> wrote:
>
> To clarify, with 224 threads & CPUs queued_spin_lock_slowpath is the top hit
> even without a retry limit in lockref. This could be unrelated to the lockref
> fallback, it looks like it's coming from the spinlock in:
>         do_sys_open -> get_unused_fd_flags -> __alloc_fd

At some point I stop worrying about microbenchmarks just because it's
easy to hit some locking paths in them, without it necessarily being
relevant in real loads.

But I'll apply the lockref patch because I think the "limit cmpxchg
loop" is conceptually a valid model, and while I think the "hitting
the same dentry lockref over and over again" is likely also an
artifact of a microbenchmark, I could at least imagine that it happens
with some common dentries (root, cwd) in some situations.

                   Linus
