Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CEC0E12
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfI0WjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:39:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35331 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0WjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:39:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so3045881lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iijkTNAwazlkcEPbWHD7/Pt6NR9/VHJLHxMEdKPkjs=;
        b=W4T7eFxOsxAOhy+qoHNVBHbvWBZnkWvEbzx+5PVLryQsWZlsSjLj6GrpIRs9Pvsc4P
         uXgrUwtt+UFdta+Ixw2KIGOKyd88GrPA6t6bfUV6/KTqYQLQXhrgwSIapfQh+TP/7tF3
         cAblA/InJlUZ+QeP1vKRt+lABmPCLOH+4cP0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iijkTNAwazlkcEPbWHD7/Pt6NR9/VHJLHxMEdKPkjs=;
        b=FzpqlWu5PYX3nY5DpmV1BUNppQG4AtehN4Y5xgjsIrUxSXsP6pPhO4rxdMWVSh/R5h
         YUVcOvO60Arn616CDQIsOKyalDnH4+6+YNbff2ztL6/asELbDaDiSgkcLYtC7+rdFaHa
         775MP21oOSck06X1HydCkWxIGFBvWaLvVGLRbWGRItEn0ZNvhkP5cLE8Rtx27+MQ/ggn
         kfCfPBllxK6H325+PuTjakGbHMEcocc/W1sVnDG0ER5TnS6Cpz6qc6vAda+SP4rPKkKk
         6mprRSUWBI2acUuGA6brUxGTnaoHSF0+yye+fG0/J3asam8LPBop8lh5U8+21qMYFYGd
         DvEQ==
X-Gm-Message-State: APjAAAUH+ZIiebmJqu/taV8W6mg3fSAA+pB3vVojKNz35jYmehH1r5L+
        M5Chx0qHQZWG9Wlhk/jyLMlbrHB2eWk=
X-Google-Smtp-Source: APXvYqymMB5y4TccG5t2PL9mfFCYUANshd4zOgWKRfUPVXrk9CDnBvTxEnI7HdBVZhsoh0k62Er9fA==
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr3942932lfn.125.1569623942844;
        Fri, 27 Sep 2019 15:39:02 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e29sm708848ljb.105.2019.09.27.15.39.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 15:39:01 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m7so3985977lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:39:00 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr4417255lje.90.1569623940537;
 Fri, 27 Sep 2019 15:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
In-Reply-To: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 15:38:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
Message-ID: <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 3:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So get_user() was passed a bad value/pointer from userspace? Do you
> know which of the tree calls to get_user() from sock_setsockopt() is
> failing?  (It's not immediately clear to me how this patch is at
> fault, vs there just being a bug in the source somewhere).

Based on the error messages, the SO_PASSCRED ones are almost certainly
from the get_user() in net/core/sock.c: sock_setsockopt(), which just
does

        if (optlen < sizeof(int))
                return -EINVAL;

        if (get_user(val, (int __user *)optval))
                return -EFAULT;

        valbool = val ? 1 : 0;

but it's the other messages imply that a lot of other cases are
failing too (ie the "Failed to bind netlink socket" is, according to
google, a bind() that fails with the same EFAULT error).

There are probably even more failures that happen elsewhere and just
don't even syslog the fact. I'd guess that all get_user() calls just
fail, and those are the ones that happen to get printed out.

Now, _why_ it would fail, I have ni idea. There are several inlines in
the arm uaccess.h file, and it depends on other headers like
<asm/domain.h> with more inlines still - eg get/set_domain() etc.

Soem of that code is pretty subtle. They have fixed register usage
(but the asm macros actually check them). And the inline asms clobber
the link register, but they do seem to clearly _state_ that they
clobber it, so who knows.

Just based on the EFAULT, I'd _guess_ that it's some interaction with
the domain access control register (so that get/set_domain() thing).
But I'm not even sure that code is enabled for the Rpi2, so who
knows..

               Linus
