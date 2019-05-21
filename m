Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E329925785
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfEUSZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 14:25:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36207 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEUSZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:25:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id e68so7678715ywf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ket4euZtb3xz1ehJlbZaL3tfZFi5DUGnboPkY3hOqrI=;
        b=CYnppNljbluNwkxhUzp7fN+4F5MYGWsEPpY8jH65mFnMLfU90Ylk4X8m1xwT/sXoSS
         rnyXsflhcA8XRQ3Zy44sQ5DASV9x1QhqnuMSEYrdabtHuTrxFhOYjK6icej0YXJuuXZM
         5VN/PjRFAQnjUm/DKDoTkItLZ+EE04y/Uzh/2qjSE0tZQgZBUntjF6a55kzqXqiETDQj
         sKcAGZabQWS/I8G5Ou3UUtuJmnb+BzXiNwzCsdGg9bIr0UAiwfFCtewSu2iqEH0PO249
         5eVvv9+hBqFTqWtZtIw0DLBZ5e72Q3rLIpPmPp3jjNc6vZMsCuPXbOzPYKRLNKq6fK8A
         6CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ket4euZtb3xz1ehJlbZaL3tfZFi5DUGnboPkY3hOqrI=;
        b=NQppbp9CjKW5qN9QF4X7v860hwhDQABRcei2LC4HSwbbS1MiqLvMN6GNWp3F/F5E+P
         LSH1d6N+7ed1yJT8B53IguOVrg6Nr0okSi0Z6IM6EzqAQ2eCdD1AgwaMOQBuhWNkFAqC
         oRRZB2kLj/miFCjsu0qgqLN/5kxW8FrlimHDjHS/EA0dFowUvW2MESfsapJroczv4s5c
         CqFiWVBb9ZbiYCTG3kNV9c3dMH4RuU2S9qij/seA8rNalKBAlZugHOQskBf6+lD9KfNk
         TS5ksRi4DOZhmcWalj7QC6DkMUsGlEWOMVnNtgWs2P3zYnDP2wGzF+PLktT+U3l2xRRL
         f/uw==
X-Gm-Message-State: APjAAAVraLdUAszFKT2w9NjkyU4jsWOGt0E8dKIF/YBcVT/b8GuqHDKi
        RsvyLrlbZqU6gPImzW0/XoDaRl1OS/ipNPKfM4YMmOfVvpY=
X-Google-Smtp-Source: APXvYqz2rPJcAHuNgBAXH1XHagqt69jMr/zWFdOQPCTaNY+iRYgUkO7fBPqB7cj50j1ezYTe5LgWGvm9D/DCeYHTG+s=
X-Received: by 2002:a0d:d60c:: with SMTP id y12mr36831206ywd.64.1558463142815;
 Tue, 21 May 2019 11:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190520182528.10627-1-paul.walmsley@sifive.com>
 <20190521063551.GA5959@infradead.org> <alpine.DEB.2.21.9999.1905210110220.24268@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1905210110220.24268@viisi.sifive.com>
From:   Wesley Terpstra <wesley@sifive.com>
Date:   Tue, 21 May 2019 11:25:32 -0700
Message-ID: <CAMgXwTic9WWjVviEdvh2+0+LB1va--+7zJOt7C2YxsB=hu72WA@mail.gmail.com>
Subject: Re: [PATCH] riscv: include generic support for MSI irqdomains
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed.


On Tue, May 21, 2019 at 1:11 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Mon, 20 May 2019, Christoph Hellwig wrote:
>
> > On Mon, May 20, 2019 at 11:25:28AM -0700, Paul Walmsley wrote:
> > > Some RISC-V systems include PCIe host controllers that support PCIe
> > > message-signaled interrupts.  For this to work on Linux, we need to
> > > enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
> > > for the latter is enabled by including the architecture-generic msi.h
> > > include.
> > >
> > > Based on a patch from Wesley Terpstra <wesley@sifive.com>:
> > >
> > > https://github.com/riscv/riscv-linux/commit/7d55f38fb79f459d2e88bcee7e147796400cafa8
> > >
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Cc: Wesley Terpstra <wesley@sifive.com>
> >
> > Well, this is very much Wes' patch as-is.  It should probably be
> > attributed to him and you should ask for his signoff.
>
> Yeah.  There aren't many other ways to do it.
>
> Wes, care to reply with your Signed-off-by: ?
>
>
> - Paul
