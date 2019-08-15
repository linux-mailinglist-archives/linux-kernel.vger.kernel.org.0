Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF058F58D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHOUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 16:12:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46748 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfHOUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:12:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so7492069otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0+yFoccKuBfbcsXsXsga1tmUthvWenlvN1lT3lVs28=;
        b=qO7wFUVBcfsXZdEWtESTlkgDJFIn+h2Zftaw2r0fFx3myFLMcmx/1PxE8CN+fqldWQ
         zjBl3Dul7mG+AB3phn1DsCwl/3tGds0vBJ1kqEV+ap8hW1PegTxQmwVct4e6eZW5Mfez
         HLsQOrHW17zkzc1s7yiRXL2BVjwVwr/l/20Il9jmjG/teTTaa5j9sARFRpHce+kxtMJS
         6pcaFtAD6i7TvosBx8nv53Etr/AFABojJvFQyvd2/naDP/49htS0fK6O8E2SpX+XvJFi
         LHhffCbJNMAu8GkF3l05nJPd/24PikpQTsobVDta1UgZR+WEGVU1hpgkfCqVY0EkQboc
         34+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0+yFoccKuBfbcsXsXsga1tmUthvWenlvN1lT3lVs28=;
        b=jpmKvwS+tm10bxxNEZK4pWmuGmPykJQFf7wU3CP6aM/rraDDzLi3rki3xFCW/MFD83
         ahfj0U4dTZqZEpYI1xI7glo/bjt9RVlSeo48Pb3j3GoWENc/xdUp+HAn8RUPijlAbQEM
         zlR/Dkr5XmxDwCuu5ocigHDRwQKPRLzy2XqJoM4JnL6pboYxyvkPv9TxP0s+Jd2md9H4
         7bb7QB1nokHtyogS29AxbgW118VpKHGxDEtyDT1KVUXqfMVIVBIHYZBnj4bXUqlj7UKB
         qFUQcCBjisGQCPE5BRn46pI+Ad1mn1fB1zxi6UaFfMMvM3kI5B91g0HoTBRr5g9C2msV
         J95Q==
X-Gm-Message-State: APjAAAWSlENi6R9WV5SZsfAf4VbMY48W8oFuEbKxpUJVNz7Gk+iJ2QKz
        AFs1rfpzJ84mwc5wxKAWztBEcD5WFFUOs4agDXCuRA==
X-Google-Smtp-Source: APXvYqwuZcCCvgwgQl2Mb8pVIF/qyxKE2rFZqaszAzmMCreK6bW5n2dN0Ore2hO/padEjUkbv/NUNR4f+frL+RoGGBk=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr4370413otn.71.1565899953979;
 Thu, 15 Aug 2019 13:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-5-hch@lst.de> <20190807174548.GJ1571@mellanox.com>
 <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com>
In-Reply-To: <20190815194339.GC9253@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Aug 2019 13:12:22 -0700
Message-ID: <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:44 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Thu, Aug 15, 2019 at 12:36:58PM -0700, Dan Williams wrote:
> > On Thu, Aug 15, 2019 at 11:07 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Wed, Aug 14, 2019 at 07:48:28AM -0700, Dan Williams wrote:
> > > > On Wed, Aug 14, 2019 at 6:28 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > > >
> > > > > On Wed, Aug 14, 2019 at 09:38:54AM +0200, Christoph Hellwig wrote:
> > > > > > On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> > > > > > > Section alignment constraints somewhat save us here. The only example
> > > > > > > I can think of a PMD not containing a uniform pgmap association for
> > > > > > > each pte is the case when the pgmap overlaps normal dram, i.e. shares
> > > > > > > the same 'struct memory_section' for a given span. Otherwise, distinct
> > > > > > > pgmaps arrange to manage their own exclusive sections (and now
> > > > > > > subsections as of v5.3). Otherwise the implementation could not
> > > > > > > guarantee different mapping lifetimes.
> > > > > > >
> > > > > > > That said, this seems to want a better mechanism to determine "pfn is
> > > > > > > ZONE_DEVICE".
> > > > > >
> > > > > > So I guess this patch is fine for now, and once you provide a better
> > > > > > mechanism we can switch over to it?
> > > > >
> > > > > What about the version I sent to just get rid of all the strange
> > > > > put_dev_pagemaps while scanning? Odds are good we will work with only
> > > > > a single pagemap, so it makes some sense to cache it once we find it?
> > > >
> > > > Yes, if the scan is over a single pmd then caching it makes sense.
> > >
> > > Quite frankly an easier an better solution is to remove the pagemap
> > > lookup as HMM user abide by mmu notifier it means we will not make
> > > use or dereference the struct page so that we are safe from any
> > > racing hotunplug of dax memory (as long as device driver using hmm
> > > do not have a bug).
> >
> > Yes, as long as the driver remove is synchronized against HMM
> > operations via another mechanism then there is no need to take pagemap
> > references. Can you briefly describe what that other mechanism is?
>
> So if you hotunplug some dax memory i assume that this can only
> happens once all the pages are unmapped (as it must have the
> zero refcount, well 1 because of the bias) and any unmap will
> trigger a mmu notifier callback. User of hmm mirror abiding by
> the API will never make use of information they get through the
> fault or snapshot function until checking for racing notifier
> under lock.

Hmm that first assumption is not guaranteed by the dev_pagemap core.
The dev_pagemap end of life model is "disable, invalidate, drain" so
it's possible to call devm_munmap_pages() while pages are still mapped
it just won't complete the teardown of the pagemap until the last
reference is dropped. New references are blocked during this teardown.

However, if the driver is validating the liveness of the mapping in
the mmu-notifier path and blocking new references it sounds like it
should be ok. Might there be GPU driver unit tests that cover this
racing teardown case?
