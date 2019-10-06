Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AECD74B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJFR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 13:26:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44436 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfJFR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so11194895ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LD/QuvpU5V35ufYWzjU9v/JEj2qpuPjp0dtITIN3rWA=;
        b=S3MM3D6smPa34vOHPfluicJiARO1dDKcvC12PGnfAAyaGefJ4znW1MqRiG0lyXEU/N
         IBGtypKWSuuEf4QshUzI3pxZ5iN7ZDxdj1pbU+MkBGPVJyz89XvqwPwPCV9z4IEN7iwY
         XkArmwPd29c0YIJ7FsefqMhPuO2V2MntkyEfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LD/QuvpU5V35ufYWzjU9v/JEj2qpuPjp0dtITIN3rWA=;
        b=GFIijxIoR4u3ZOTq2QaoUhWrNjDVTu0v3GxJaaKvP6aILK/IB4RkgljP1F5C7PRjqg
         xbmDHBESItrA76ZNiSSAmReloHmg9EWNoLRsX0CetY/mG7mFME1hY7J5X7+2iZm78LML
         Bdk6EFPshLwG1AZbvK4KnyxpsaSMNKq5QWbtnYYVy5ZOUwX1PmVt0Xj2JGTfi0EfqyJo
         31uo9gDkkj5Or5tO6b4L5bB+Sdv3pEZxwxMmP0bQXS75WfkHVtW0lXbVyMn04rdjgwMd
         1sxEuZV+uBX3UxLGP0nbIx01McGZ7nRCb/qZcaRVIyL+zafacWlj8RAtia/3xKL9Vpas
         EAbw==
X-Gm-Message-State: APjAAAUb+yOJS6JkHzdKYU0W+tNb/AoYkyIYIMJQVe5+hFPsVNEtyRHY
        CiRwG5i/RlZrp/2QU0CDrInErPKq8WY=
X-Google-Smtp-Source: APXvYqzBKY4+vO+o/+GkcuJ+lBSrePhTHwAt0NrfRg6b5ak9zjD0njP2W+N+QDd4fG4X/G+nA0F9lQ==
X-Received: by 2002:a2e:7212:: with SMTP id n18mr15478369ljc.91.1570382797153;
        Sun, 06 Oct 2019 10:26:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c26sm2252690lfp.20.2019.10.06.10.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 10:26:36 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 7so11227219ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 10:26:35 -0700 (PDT)
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr16048856lju.26.1570382794914;
 Sun, 06 Oct 2019 10:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com> <20191006114129.GD24605@amd>
In-Reply-To: <20191006114129.GD24605@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 10:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
Message-ID: <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 4:41 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Should we have some kind of notifier chain, so that we could utilize
> better random sources (spinning rust) if we had them?

The spinning rust will get entropy on its own just thanks to the
regular interrupt stuff. And the kernel tryin gto do IO is a bad idea.

Plus I think it's kind of pointless to do anythign at all for things
like spinning rust in this day and age. It's no longer relevant, and
never really was in the area where this was a problem.

Also, I don't really like the notion of random (sic) notifiers that
different drivers or things could attach to this thing. People will
disagree about how much entropy it has anyway, and I'd rather have
_one_ clear implementation that people can look at and comment on and
try to actually write an academic paper on and suggest improvements
to, than some generic "entropy notifier interface" that then gets
whatever input somebody decides is appropriate.

We already have interfaces for "I think I have interesting data":
add_interrupt_randomness(), add_device_randomness(),
add_hwgenerator_randomness() are all for different sources of entropy.

             Linus
