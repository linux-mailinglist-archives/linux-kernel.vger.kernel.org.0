Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC49071ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbfGWOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 10:54:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43793 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfGWOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:54:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so20059099otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4KWYzLiz8Q76GJXEl0Zz0b7uhOVauu+r5qbYmNBT7A=;
        b=qXzwwQuBz/BmI26lbVCqNhkrQrcAoVMmFk29raVO7XCfT+iYt7qIl5aMn+cE0enLiD
         3+xaEvX2sNlGH8nkUL47bNlG38bxXHpFIXUqMIM/39Zba78y5N1D9sev9Ti45+6yKvFo
         fnptNuTBEsfw1q7trWYvR9MRl1i1CmZJ81dZIrb9qrELPtiW892ktHWMpqYVyezzutph
         EzfwjamCsf8fVFG4I08D2wdsCJDH1gV8GIksnHln9mgLPk0eckvQ9VliameBuufWzcy4
         PlTOxHKX/9Vzj1mpMqG7PlDpXbg/JnOaAe+W5cw6SU3DpVodIr8KnfpprqFivQ+asM2D
         WWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4KWYzLiz8Q76GJXEl0Zz0b7uhOVauu+r5qbYmNBT7A=;
        b=IBVEeJE0+/8rk8gEAkjQy6PKg1SLfoSccT2hzf0JM+C1SIGIhQOzHcNRvseYdv30Z8
         WBxQHWQXNYy5LpzbMSWV6yfXEUFxe9kxAqJq7xnaFyVs6sjSS/9Hl0qwDiaquh98QpVg
         btzRmFupzX4qn9PDePHw2gporEMugXAnSGmISQVVA/5tZYcfyZ6S7ojv8/XiiUe6T/vT
         2kcpFz87cLU6K7RfySDF0cKTHODRfidH2WuJoTfWNsgEZyiZvZCnfQxEKMJhhHPTfTpW
         aKlMN67L2snEZVOdwftSmRdW1AifcMNX6s9O8qFyBKubmA/xvvZLUkzHATT2LhCC9PU3
         LEEw==
X-Gm-Message-State: APjAAAVSlNDvv0FYHgYzfOLIDNeKBL1rTAqjyLo7fTaCftQQaJ1qXT7r
        GmxzllJ8juvOjJJPJ9IEgTgi4kkueYzgZJuLlUuWqA==
X-Google-Smtp-Source: APXvYqz6MT1sE9TYkC+Gt3TnmGvb96tCIp+1WidsrIqgtwnzoYqgfblBqQU7t6GJZutpN2xUNv4oxyMInzb5C00uRSI=
X-Received: by 2002:a9d:812:: with SMTP id 18mr48441341oty.180.1563893653534;
 Tue, 23 Jul 2019 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
In-Reply-To: <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Jul 2019 16:53:47 +0200
Message-ID: <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> >
> > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
>
> Nack.
>
> The 'count' variable is not used as a reference counter here. It
> tracks the number of entries in sidtab, which is a very specific
> lookup table that can only grow (the count never decreases). I only
> made it atomic because the variable is read outside of the sidtab's
> spin lock and thus the reads and writes to it need to be guaranteed to
> be atomic. The counter is only updated under the spin lock, so
> insertions do not race with each other.

Probably shouldn't even be atomic_t... quoting Documentation/atomic_t.txt:

| SEMANTICS
| ---------
|
| Non-RMW ops:
|
| The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
| implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
| smp_store_release() respectively. Therefore, if you find yourself only using
| the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
| and are doing it wrong.

So I think what you actually want here is a plain "int count", and then:
 - for unlocked reads, either READ_ONCE()+smp_rmb() or smp_load_acquire()
 - for writes, either smp_wmb()+WRITE_ONCE() or smp_store_release()

smp_load_acquire() and smp_store_release() are probably the nicest
here, since they are semantically clearer than smp_rmb()/smp_wmb().
