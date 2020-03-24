Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB3191B94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 21:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgCXU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 16:57:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38947 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCXU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:57:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so14468630lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfkpZBONhIm2kahgF1k041JWmTwgX7aXtGtLwbGmno8=;
        b=ZrWYfmkROhgW5Qe30qGiRWtsa4lPXPRYSJ7cqapGER4PzRqCxwEF+dJguyJZ7FF6Ll
         u/Zi1t2urAAq25y6dQ5ynQLQXoBhsw2Q+tNanRBglZqULb7gJYp6SanwRrt7FLa3qIeu
         9Ib7NWaVYv+Fkb7oj9J2ClZWHS6IY4kKUJ5J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfkpZBONhIm2kahgF1k041JWmTwgX7aXtGtLwbGmno8=;
        b=ZmCURyv73CTweP0bB1M/7mWX2nujmX6I18TvS91YnG+bEmIu59svG3dC6mQwQWFG2g
         q1ZFbW8ovuLfYU+DQgKPjPzIkX9qyqNaxeajKFnJqmbtXAkJUPy+RnqVh6dzpA8HIlLY
         TdT9QfkQNfq7GfSQNHjxEjob5K3H1WbtAd3g0ZvQfva4GAUcR3sGZfVl27OzJFPGNT42
         lFfTgDb1VjuGkSduVPo/JXgnR/ujvoigiakldItX8akJRo8sJKt1WW9qVoJ7jrC2l5IZ
         hV+fa/+hfW6uf9ghDzhbhRZqJDpHb5BuKiKsHdM6GaeKbVEVdxVgJx2X0y04pHRidecV
         2n4w==
X-Gm-Message-State: ANhLgQ33Ebgd0UPz2d83ReLmlsqsteXV2vgXyYkzQdjVcrGFfQnTTnU3
        YkPlDTgbm1bD5JDVmJyjNqMLAEYcayo=
X-Google-Smtp-Source: ADFU+vuKI2lTlunwmj6jcCOmLpFfBLbJp4l1z65ZMQqnuUx9phz2RL79OSTiKc3AysWWIVmCJ2wYmQ==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr16708923lfi.172.1585083456749;
        Tue, 24 Mar 2020 13:57:36 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l7sm3980311lfp.65.2020.03.24.13.57.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:57:35 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j15so14468577lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:57:35 -0700 (PDT)
X-Received: by 2002:a19:6712:: with SMTP id b18mr573410lfc.152.1585083455357;
 Tue, 24 Mar 2020 13:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk> <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk> <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk>
In-Reply-To: <20200324204246.GH23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 13:57:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
Message-ID: <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK...  BTW, I'd been trying to recall the reasons for the way
> __futex_atomic_op2() loop is done; ISTR some discussion along
> the lines of cacheline ping-pong prevention, but I'd been unable
> to reconstruct enough details to find it and I'm not sure it
> hadn't been about some other code ;-/

No, that doesn't look like any cacheline advantage I can think of -
quite the reverse.

I suspect it's just lazy code, with the reload being unnecessary. Or
it might be written that way because you avoid an extra variable.

In fact, from a cacheline optimization standpoint, there are
advantages to not doing the load even on the initial run: if you know
a certain value is particularly likely, there are advantages to just
_assuming_ that value, rather than loading it. So no initial load at
all, and just initialize the first value to the likely case.

That can avoid an unnecessary "load for shared ownership" cacheline
state transition (since the cmpxchg will want to turn it into an
exclusive modified cacheline anyway).

But I don't think that optimization is likely the case here, and
you're right, the loop would be better written with the initial load
outside the loop.

           Linus
