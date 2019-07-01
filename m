Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73275A1F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF1RKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:10:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36727 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfF1RKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:10:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so6700649oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qddKJwRb2cnRQ/FqFwYrdLbb8wYT8FUIpp0K6iYqKlE=;
        b=UnNjKOhDg6JhNrF0ffG6CmZkREW7rw22qwft9R1X5G1Y463lGz745qKb1Cpvvz1sEl
         zLMecGaZR5ynK6GE8f7Ml3Ex/6APldy0qkkzEaBAkhcBHC+GivS+i5qPLFaYjJ5IxfYg
         Ix0HdpLCjBnqAz9m39WW1jharT+5YOHNU4YfrM8Ah8R+FrEe4b6pxjgCmbbqGgh3sqcB
         2VYQ2agoAbSDUL/b0JhCGJa4iHWfU4XJrqUvTFK2MBTunnoIIjMYIkxDb4U+7zHLnerF
         GdJi7b5u2PxxVuLRhm8fJldQb7CTmEb8WCfsS3hc/y78yAwulmlFeUWonzJRUQpwECvp
         g/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qddKJwRb2cnRQ/FqFwYrdLbb8wYT8FUIpp0K6iYqKlE=;
        b=Mu6K9As6M7q6U8wCyKh+rIEneQWyCboP+JoWkVHrpX12WbFhzK/IcHQ/VwIe8xSpfL
         1yZyHF5W9g/WcOpha2sKy1OlVO/C9sfYSgBy6bnkMT8DsNG7rKDpDUQPbQrWt4v28/Du
         5ALZzUgEwWu9NlVvCzJrJY7XpcJKJiQsTnK3EXkOqKPHsaenvtUEf821lOuY4gBxGorz
         l2uFAA+FySWgmil9ZtiBhqDC5nipYkKQNRUVkqeqafv4ME+5wvEdJGqOS1cxbPAATdBA
         7xGQ3KczGvvlk0vJLcPboVmSeBOvhzOsxE29018YENH57pyP0fnQgcm8JyTsFbZLaYzI
         b0mw==
X-Gm-Message-State: APjAAAVChpmNxKxxkdOGbI9S5mMi01f/D6fRS8XX6WZplls7WcwR6b11
        v8DBh6nZLCB25PUsZ49zZJKXWQ82gTBbeXUPQqw/7A==
X-Google-Smtp-Source: APXvYqziEb+tNzkKv17KjDDhi4UpD13NUfzT1yqPT34PEQGi0shpxcj8jFfercRLfAyVoLhNe8H8Bkb71Cnf2tL/n+k=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr8124495otn.71.1561741823760;
 Fri, 28 Jun 2019 10:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com> <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com> <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
In-Reply-To: <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 10:10:12 -0700
Message-ID: <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:08 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > > The functionality is identical to the one currently open coded in
> > > > > device-dax.
> > > > >
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > >  drivers/dax/dax-private.h |  4 ----
> > > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > > >  2 files changed, 47 deletions(-)
> > > >
> > > > DanW: I think this series has reached enough review, did you want
> > > > to ack/test any further?
> > > >
> > > > This needs to land in hmm.git soon to make the merge window.
> > >
> > > I was awaiting a decision about resolving the collision with Ira's
> > > patch before testing the final result again [1]. You can go ahead and
> > > add my reviewed-by for the series, but my tested-by should be on the
> > > final state of the series.
> >
> > The conflict looks OK to me, I think we can let Andrew and Linus
> > resolve it.
> >
>
> Andrew's tree effectively always rebases since it's a quilt series.
> I'd recommend pulling Ira's patch out of -mm and applying it with the
> rest of hmm reworks. Any other git tree I'd agree with just doing the
> late conflict resolution, but I'm not clear on what's the best
> practice when conflicting with -mm.

Regardless the patch is buggy. If you want to do the conflict
resolution it should be because the DEVICE_PUBLIC removal effectively
does the same fix otherwise we're knowingly leaving a broken point in
the history.
