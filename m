Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACEFC3E34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfJARKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:10:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJARKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:10:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so14209761ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP66g09MiSCdy0XNQAORHC/+/yzYTstNbMb+ZKdqlWg=;
        b=lLeWSWvearlSbNPQ3vT1c8F1vZxuB+G/IN6H7lXXbVUiiYjfglkJc9dzfGfhy1WzUf
         FYbHY/amFNpMw7IwUtedVOiD6hAIqJMNvNNiYeTftW9BuzqLrd/OG/DaKgjEYhcbdGpm
         9GAlVWGOHvAuxqaMsyvm0HATklhfeQ4pN/9NdqWmJtrxxt454Fl6L5Hi5Mg31VjkDIKz
         tbytySXgp8thodhCMMQVGnIfvjleTD9wTWzvDxqrhew8XzTlY4FyWhQ3oDh5rIZKuGem
         aG5aNo+If5FyRJohSz/+xTFLJSAnKKWlZwWgLZ3ufptRktZaUM6I6ZG1sR2rRVy9DjQb
         w6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP66g09MiSCdy0XNQAORHC/+/yzYTstNbMb+ZKdqlWg=;
        b=fEZD3kyIobZATT1N/Vl2GsrUwn69SywxjzNaWIHaHFXl3juMfQ7kOHqC8JX5xD7qWZ
         b3/d+DvOb11QdHekeuQTdRBhCdPXQkwOyi/nAxvDhGXH7YFBsz5RscGbw8pVY/Jdoe1m
         jVX3/BDNTN/CwyLISI8xzfF3ugvsV61AbIZVFAL9TFF3St5stS9bfwcYmrQPlP1RgaaW
         q4uHZ+4s0owJHs12XaU3fd9mX17Ll8bNL+oWl9tBkLRUnCL5EKma1AxM5q+2ABZ7JsQk
         rTnKAwvinqMraiaGigbvs1PSdw+b2UzD81VltG0mIkMTK8Qv/gLGtS7MkmzwDAAbvvoO
         jvrw==
X-Gm-Message-State: APjAAAU/97ku36T3qCLOy8AwF2PcfqsDzm2G5aIZlnowkXTe60GIN2bQ
        qIJPgoCSSR4Qgey1TawKTb//xPtbohbVReelhtuxCB/+AIU=
X-Google-Smtp-Source: APXvYqzbzA7ZkfH8DhEE7ioodPmEgLrj3L1UwHX0Jt0vwAFi5yQkkBQaT22N+fFn8m4AoxNn9OVuaXHAAbB2PwUjrm0=
X-Received: by 2002:a2e:a316:: with SMTP id l22mr16644896lje.211.1569949799769;
 Tue, 01 Oct 2019 10:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com> <20191001121623.GA22532@ziepe.ca>
In-Reply-To: <20191001121623.GA22532@ziepe.ca>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 1 Oct 2019 10:09:48 -0700
Message-ID: <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify sg_miter_stop() to validate the page pointer
> > before calling PageSlab(). This check prevents a crash
> > that will occur if PageSlab() gets called with a page
> > pointer that is not backed by page struct.
> >
> > A virtual address obtained from ioremap() for a physical
> > address in PCI address space can be assigned to a
> > scatterlist segment using the public scatterlist API
> > as in the following example:
> >
> > my_sg_set_page(struct scatterlist *sg,
> >                const void __iomem *ioaddr,
> >                size_t iosize)
> > {
> >       sg_set_page(sg,
> >               virt_to_page(ioaddr),
> >               (unsigned int)iosize,
> >               offset_in_page(ioaddr));
> >       sg_init_marker(sg, 1);
> > }
> >
> > If the virtual address obtained from ioremap() is not
> > backed by a page struct, virt_to_page() returns an
> > invalid page pointer. However, sg_copy_buffer() can
> > correctly recover the original virtual address. Such
> > addresses can successfully be assigned to scatterlist
> > segments to transfer data across the PCI bus with
> > sg_copy_buffer() if it were not for the crash in
> > PageSlab() when called by sg_miter_stop().
>
> I thought we already agreed in general that putting things that don't
> have struct page into the scatter list was not allowed?
>
> Jason

Thanks Jason for your comment.

Cost of adding page structs to a large PCI I/O address range can be
quite substantial. Allowing PCI I/O pages without page structs may be
desirable. Perhaps it is worth considering this cost.

Scatterlist has no problem doing its memcpy() from pages without a
page struct that were obtained from ioremap(). It is only at
sg_miter_stop() that the call to PageSlab() prevents such use by
crashing. This seems accidental, not by design. Scatterlist API
function sg_set_page() allows any page pointer to be assigned even if
it has no page struct. It doesn't check if the page pointer is valid.
Its description doesn't say that a page struct is required.

Regards,
Alan
