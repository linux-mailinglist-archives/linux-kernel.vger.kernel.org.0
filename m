Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E68F5335
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfKHSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 13:05:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40334 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfKHSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:05:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so7164863ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9NweSEf4drXt4A6DP1qgzu1cS6gHr1cMfGzVR+7ZWY=;
        b=BFXx5UUjilC2VGGIFH0qbcrUE/AJuyx2/d46qw2iAAOeTsVx8j2aw2hoCox9tJS3wD
         paX9fnyjuYtJC19oeyWD/gCxwI2Uq0qQyNq71XhkZ11olv7oacH0v1uAPcX/b+eFj2DD
         4IPRZi+crMZ7QCrYaUhsZncB/RosCknDpvqSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9NweSEf4drXt4A6DP1qgzu1cS6gHr1cMfGzVR+7ZWY=;
        b=PE3iClr4/AMDvW4sklnZH1zn2eTNiiWb9FY2HYlV1OIqp9jhK46GhvyKhevPeGFetQ
         KhMskzr8ld5SYCmAU5W7ijZlZLyHZ5SSeCz7DnW8P4OGkhcntTgIH8PFWVe+gEo0gm/h
         OaaBMfMeWsSnArHvWV/YXlOrIYbQdVbcQ65iOpvRQkdPvm799KO1GDHsFtu5nYNmNHgN
         +85KjZygjc2/P0TMwO6voJDb1hnieXnAP8LHALwNphttaa2AQNskz2eJB70H3/6//suv
         qe1I+0KcnDNFoB8eML8EqbRrFtgc+vX11WShB6pv421GWE6OZLaz6FkjrhoOlgfDHcu9
         HNVg==
X-Gm-Message-State: APjAAAX+P4sUKnRANE+Aea2SdTKGhubiUdCo9VE3NF7aCG+RZAa2v8fu
        fblPIf+D9ic4gUVYhi6o2KfFMS9ZwSc=
X-Google-Smtp-Source: APXvYqw0elrUSsZ1A9fkKwOmP7gOpPmvrD3CAqPpj0pg5I+m85zbbwQvRYbcmlEXIpLgZ1mUqXAxEA==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr7657869ljg.158.1573236326441;
        Fri, 08 Nov 2019 10:05:26 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u14sm2890932lfk.47.2019.11.08.10.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:05:25 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id g3so7136229ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:05:25 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr7860520lji.1.1573236324900;
 Fri, 08 Nov 2019 10:05:24 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com> <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
In-Reply-To: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
Message-ID: <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
>
> I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> and is the facto accessor we used for many years (before KCSAN was conceived)

So I generally prefer WRITE_ONCE() over adding "volatile" to random
data structure members.

Because volatile *does* have potentially absolutely horrendous
overhead on generated code. It just happens to be ok for the simple
case of writing once to a variable.

In fact, you bring that up yourself in your next email when you ask
for "ADD_ONCE()". Exactly because gcc generates absolutely horrendous
garbage for volatiles, for no actual good reason. Gcc *could* generate
a single add-to-memory instruction. But no, that's not at all what gcc
does.

So for the kernel, we've generally had the rule to avoid 'volatile'
data structures as much as humanly possible, because it actually does
something much worse than it could do, and the source code _looks_
simple when the volatile is hidden in the data structures.

Which is why we have READ_ONCE/WRITE_ONCE - it puts the volatile in
the code, and makes it clear not only what is going on, but also the
impact it has on code generation.

But at the same time, I don't love WRITE_ONCE() when it's not actually
about writing once. It might be better to have another way to show
"this variable is a flag that we set to a single value". Even if maybe
the implementation is then the same (ie we use a 'volatile' assignment
to make KCSAN happy).

> Hmm, which questionable optimization are you referring to?

The "avoid dirty cacheline" one by adding a read and a conditional.
Yes, it can be an optimization. And it might not be.

                Linus
