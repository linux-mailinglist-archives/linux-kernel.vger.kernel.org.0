Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF3134B52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 20:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgAHTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 14:13:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34240 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbgAHTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:13:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so4699619otf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nwzT+0Ljs8ayMxiId4ILWJbQFwhi5ruplGd3VdIX3RM=;
        b=aXBKpkre4lcb7sMUk8RY7fqYF6hOlQVFhJATgnLjVCY7K15QLYyf7hixiIBa3HZVMC
         ExlCfpewfRpBKMlrL2bkTmYPm4CaGYlyL7tRjpgwgPPKYXDXxvC/+KRYGg7RVNI+Zch3
         OJDriIxWyOMcD19jmlVDHU8kJyYPULCFXFwxijHaC7h6OhkrZpOvqpN/E+KTL4l7U/4j
         xMaDx7uVFsBEhMyQ6lG95oYF9HfECFKNHuarmwK5/8nBEJr63/BKQtroqLrTIogIYeYL
         rpBX2fz3/DPf9u8qNUR4UvRqVBL+6fbPeQn8qT6bzEnk6MNhhgAhhL1sSxjlwCfUWh9O
         nRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nwzT+0Ljs8ayMxiId4ILWJbQFwhi5ruplGd3VdIX3RM=;
        b=K54uuv9pGJh4OaarnSX0hmEeivdS0kRhdr3xpZsSm9l/pEIjgGZpndyGKcoiTOnYES
         ld9X5B1egsQs1YB+Rye3Ajc3CV2blO+hRQbzdzEq25HyAwUtmJvJsuuYVlSbWJqm4SUd
         6h3vbTvlhmEYCHbjzTAbsOYX4Bh94l19W810XUMrhJkUmCeGnhbVAU77vSRsopcA9BSI
         WeVSSvZegjV0A8t5lLnCb9e4m9XXvDti5qBVsh9cth1QaTefaqgWftlWkiOvQbmKqqPS
         UHHoZLNfsW5JhimN+Ei+X01a+OLgXg38/L2IWxIX3chMsy1DSUTpXXvPLYCXGlTpowvA
         Wsng==
X-Gm-Message-State: APjAAAXQDma3zqKwpK5C4+1ozXQXNhS24t7ri2vGFabUQOJm9Q235qib
        twb+/DbTvIHEEHSUmY2GUi5U7GAzPcXRM7cjNP6Jkg==
X-Google-Smtp-Source: APXvYqyvspS0KBUPu+LfGCtgbi8xLvL1j8+dWGl+2876Wfu60VTn5s+jGWcdaAy33x3gyVzhze0VmNrhk5SnuXfeXQA=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr4986153oto.71.1578510824036;
 Wed, 08 Jan 2020 11:13:44 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
 <5D5ED235-EB67-4072-8CCA-C046B7EC031C@redhat.com>
In-Reply-To: <5D5ED235-EB67-4072-8CCA-C046B7EC031C@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jan 2020 11:13:33 -0800
Message-ID: <CAPcyv4jJgBm6rhLn2685HN3DnBKB1FO2ONXC1=Aftspu1hiqmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to mhp_modifiers
To:     David Hildenbrand <david@redhat.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 11:08 AM David Hildenbrand <david@redhat.com> wrote:
>
>
>
> > Am 08.01.2020 um 20:00 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Wed, Jan 8, 2020 at 9:17 AM Logan Gunthorpe <logang@deltate=
e.com> wrote:
> >>
> >>
> >>
> >>> On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
> >>> On 07.01.20 21:59, Logan Gunthorpe wrote:
> >>>> The mhp_restrictions struct really doesn't specify anything resembli=
ng
> >>>> a restriction anymore so rename it to be mhp_modifiers.
> >>>
> >>> I wonder if something like "mhp_params" would be even better. It's
> >>> essentially just a way to avoid changing call chains rough-out all ar=
chs
> >>> whenever we want to add a new parameter.
> >>
> >> Sure, that does sound a bit nicer to me. I can change it for v3.
> >
> > Oh, I was just about to chime in to support "modifiers" because I
> > would expect all parameters to folded into a "params" struct. The
> > modifiers seem to be limited to the set of items that are only
> > considered in a non-default / expert memory hotplug use cases.
> >
>
> It=E2=80=98s a set of extended parameters I=E2=80=98d say.

Sure, we can call them "mhp_params" and just clarify that they are
optional / extended in the kernel-doc.
>
