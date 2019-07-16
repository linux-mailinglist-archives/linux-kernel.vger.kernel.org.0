Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC96A843
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfGPMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:06:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43985 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731855AbfGPMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:06:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so19209101qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhpcQElL3lG0JSgeqXLUe/9qK61Ylnz+wgQS3Fp7AjE=;
        b=D1pZEppikXtQIEAGheASyppn4vPK1DguzWZpiaVk939PKpSlX+xsQppOI0OBkx+nKq
         1JMeoAeO2RtNcmtGWYdKLbdcc2TbWA6drTUMGhZaq0sz3Geu8LfsJw1hCEqbsa4Bc/j+
         JrOL+39tH0pc4sSRyK3u0NuDnGgXAecwBuMSo8RvbrqgC5vpbNsoC1TREtbzabbzYUMS
         k9WxSC0qQS+DehVxRxUbV/PWa/pVTJQcjtukye20Ck/yNfMpOiGdSRCyc7pAxi48HA7M
         W3ECRyTg6vWSNWsyBv8+jZrvPzt1c26ISNAUAqR3Nk0GH9Y/cYJuNImJ996hTYW3Y9ab
         lyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhpcQElL3lG0JSgeqXLUe/9qK61Ylnz+wgQS3Fp7AjE=;
        b=Fotnfww4eINqMENQqWtybr13N+8zfAd9PX9HDYKTh78u4j0zs4iaxzbKWMVbXwWDDp
         j8YXpU8H5T8j61XkkMWgyKBEvlkxCv0dLG5YF9cju3S4yDTN7+qe0K8YMxjwR/iTcQQN
         idwo6qzm5QiTYIuzvfMlE7bvlEyXJytMT/nqSni15vb6b1tO1BqBwlnrjPO7/iR4UnwX
         o7EwSerSuBP1baFQPeTu6sWwS4j2wc5KjNsIg+KAuJfknN4Mt5rvh64Kbk5tn2eagRhf
         Ytc2JiWeOLj46V2x0pUtK95KXJNZ8xUTa4f8Fw3R4dLWUYWVnBFtW1gM4ISkh4HD/tzn
         sLSQ==
X-Gm-Message-State: APjAAAU7gHxZwOzHPWroPaQp7ySSKuo+hB9VA0yxNdUKqG+fkryBc1w0
        vEih7w5aTxkP8lmLjQ/9NzDdGw==
X-Google-Smtp-Source: APXvYqwaXFZZiwZu977J+QGokWcpz5v06kUp2glLI/ZNMEHnjOvZ6hmUglcng9VwXT1727jmbSrxcg==
X-Received: by 2002:a0c:e703:: with SMTP id d3mr22592037qvn.194.1563278785764;
        Tue, 16 Jul 2019 05:06:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a6sm8577367qkn.59.2019.07.16.05.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 05:06:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnMDw-0007mK-JQ; Tue, 16 Jul 2019 09:06:24 -0300
Date:   Tue, 16 Jul 2019 09:06:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrey Konovalov <andreyknvl@google.com>
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
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <20190716120624.GA29727@ziepe.ca>
References: <cover.1561386715.git.andreyknvl@google.com>
 <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com>
 <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca>
 <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >
> > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > tagged user pointers (with the top byte set to something else other than
> > > > > 0x00) as syscall arguments.
> > > > >
> > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > only by done with untagged pointers.
> > > > >
> > > > > Untag user pointers in this function.
> > > > >
> > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > >
> > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > >
> > > Hi Jason,
> > >
> > > Could you take a look and give your acked-by?
> >
> > Oh, I think I did this a long time ago. Still looks OK.
> 
> Hm, maybe that was we who lost it. Thanks!
> 
> > You will send it?
> 
> I will resend the patchset once the merge window is closed, if that's
> what you mean.

No.. I mean who send it to Linus's tree? ie do you want me to take
this patch into rdma?

Jason
