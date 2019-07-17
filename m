Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD56BBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfGQLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 07:43:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42419 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbfGQLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:43:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so11840633plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Grx9Ph9cpPxnp5U6FBRGOs65Gt1iaoMhcGq5W71SZXw=;
        b=dPqGbc0mQ4L1HVZkSH8ToVI8fJKg/9UNHDO/j/ERbXAicYMzOFznsbpKlaHUysv6li
         HI+ov6aZkI81aTTtxCqQqgB/bUVOpQn9oyTV62JlPhH7/hgOpXEwCdWu9ddqQHOpZpdv
         vvSbjVE/k6KiaC4iA854H6gt6BntwHIeZhW6TlwY6wZ/6+elD6DGPCHZxZrxLz2uCTHc
         8iFhpa9H1Y4EYvcxgufIOEc+0j2fY1DuwRMYeLwfiF/zvSCA0YG2Xctd4B7QhffRyXW7
         79B+/AUSAWe5ZZuaO+yAHuZlFSQxsBpNhxsDDOkk9SiW6k2AqHelqnkNry2oBYROn4ta
         qk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Grx9Ph9cpPxnp5U6FBRGOs65Gt1iaoMhcGq5W71SZXw=;
        b=o4pO2fdKszzIaOW9GW7T/XRaxWAHMjEtV18765ky0QWw1BH8Ou6KFE05diqoOHZo3q
         zCtkqVduY9HpUZH8ZJVP4FQw19h7jHicqe13XT1AXMwCweoGmfkSFobtWjyWZxQvY0nP
         R+5OhEnZ+3RjMzFEPkZrBlJJv9AaYtdeM4TjFHmApzxktoYnRaU7dWLhRWStoMz6ogHZ
         aX/NVzVhXneN0rb2HQa0zupWfpItBXmsxhePPyxYK84AO8IRSMV/sSKN5MlCY117ieJ5
         wYtW5WksQx3zT2DMuzBO57hPUUy6pHZNH7YcU+hf5YxHt+J67dC76uWPBusHJvR6TeCg
         lhOw==
X-Gm-Message-State: APjAAAWGlxCc22km2QFZsSjjU/muzuTSPEUN5wBtmYRXhFZGZhYWYf8q
        HjJkqnZ2kibiyZPYsK2KO3EoGfDVdWxQdSlvSOsxY5/BdZs=
X-Google-Smtp-Source: APXvYqwmLG+YoWbUJiFaN+0PkmRQxPro9175aUMwlEodu495a+iL+q6DhBuBElFNfaLl03HSknMS7Mny75X+YTtbitI=
X-Received: by 2002:a17:902:8689:: with SMTP id g9mr39719354plo.252.1563363782037;
 Wed, 17 Jul 2019 04:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com> <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca> <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
 <20190716120624.GA29727@ziepe.ca>
In-Reply-To: <20190716120624.GA29727@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Jul 2019 13:42:50 +0200
Message-ID: <CAAeHK+xGfCSNgJ1FA1Bi3-6iVZNa5-cPJF54SY9rETqSqnrOTw@mail.gmail.com>
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 2:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> > On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > > tagged user pointers (with the top byte set to something else other than
> > > > > > 0x00) as syscall arguments.
> > > > > >
> > > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > > only by done with untagged pointers.
> > > > > >
> > > > > > Untag user pointers in this function.
> > > > > >
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > >
> > > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > > >
> > > > Hi Jason,
> > > >
> > > > Could you take a look and give your acked-by?
> > >
> > > Oh, I think I did this a long time ago. Still looks OK.
> >
> > Hm, maybe that was we who lost it. Thanks!
> >
> > > You will send it?
> >
> > I will resend the patchset once the merge window is closed, if that's
> > what you mean.
>
> No.. I mean who send it to Linus's tree? ie do you want me to take
> this patch into rdma?
>
> Jason
