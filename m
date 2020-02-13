Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF915CA55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBMS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:27:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34828 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBMS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:27:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so6796484oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
        b=rXaw+VQU+BjuhG30DscKYH7MHhb9UTyRb7apt36HoQ8vdfEazZoV8TpMsYehOANm0i
         Ad49SZMMYnTxNsI7UYPu9i/7tKY+5XCh/fe8Z1IbV33TjJwh5imPo0ja1SnmDxIPKhfn
         q+yfBnL9eDiFLTnNzbTpbFj5XyBowu9DqukeqXcR2zJ2l+nDzbWibmPHahu0Rvx6B7gV
         LCizkUaCHYg1paEJYE6UMN3g7C1a9UI3LSbC0Pj+VY65RbvSvZZ46MAz9Lzu1ZR9HI0C
         k+JHaH7IVx36F/8pTOY+F3F7OSNAfYTrt+U8MtfhYkDEjbioFaldj1Q3VG7lIVd6c1/G
         sjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
        b=K1SR6CTrktaFtUvelEnmn9cXmBlQqWeAyIllBSLdaQpWtx3eTtqUUPFH9Gb2cS4BBy
         OkECQh/NUGx+gkdVLU/ef6Y63tbnUTEgT59l8GuPpxfB1Kl/tmmxsAXerxph3isHjSil
         fln0/dfIq/krjV3fzzKOR7WEOTdOG6DgYJSMGXdQ50349U5AH3+gy+fTDT6O2HFEiaEl
         5A2OnxZS7fi4XfyTPhb6Sq0baiFbt6HzHIOVLBcx6VT1PZPhMnABRJWUimRxtfGnuAXf
         mJidgKYy75EY6uJTWqKqag9Itj2JoWPr3ISgQ/OSvSnlQtFzxBpyxvRYF5djhmJly4pA
         OM1g==
X-Gm-Message-State: APjAAAUMajNiXQvEHlYlBQPTGhfHczpoVVKyD+et/vlRTOw3v1Ho91BR
        dLc5sj3d4cbSd3T9CDTwLTdXC8jGBoUwIbDoo5mq2kDXa/w=
X-Google-Smtp-Source: APXvYqxht5FHJenXXKFjAcL0FoNd3tudfWztDG42KiVuUkVg02EE/Iivz69tviiGm0uxN1GdKP8BzvtNR9xEopXkwfI=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4016542oie.105.1581618420229;
 Thu, 13 Feb 2020 10:27:00 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 10:26:49 -0800
Message-ID: <CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce memremap_compat_align()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The "sub-section memory hotplug" facility allows memremap_pages() users
> > like libnvdimm to compensate for hardware platforms like x86 that have a
> > section size larger than their hardware memory mapping granularity.  The
> > compensation that sub-section support affords is being tolerant of
> > physical memory resources shifting by units smaller (64MiB on x86) than
> > the memory-hotplug section size (128 MiB). Where the platform
> > physical-memory mapping granularity is limited by the number and
> > capability of address-decode-registers in the memory controller.
> >
> > While the sub-section support allows memremap_pages() to operate on
> > sub-section (2MiB) granularity, the Power architecture may still
> > require 16MiB alignment on "!radix_enabled()" platforms.
> >
> > In order for libnvdimm to be able to detect and manage this per-arch
> > limitation, introduce memremap_compat_align() as a common minimum
> > alignment across all driver-facing memory-mapping interfaces, and let
> > Power override it to 16MiB in the "!radix_enabled()" case.
> >
> > The assumption / requirement for 16MiB to be a viable
> > memremap_compat_align() value is that Power does not have platforms
> > where its equivalent of address-decode-registers never hardware remaps a
> > persistent memory resource on smaller than 16MiB boundaries. Note that I
> > tried my best to not add a new Kconfig symbol, but header include
> > entanglements defeated the #ifndef memremap_compat_align design pattern
> > and the need to export it defeats the __weak design pattern for arch
> > overrides.
> >
> > Based on an initial patch by Aneesh.
>
> I have just a couple of questions.
>
> First, can you please add a comment above the generic implementation of
> memremap_compat_align describing its purpose, and why a platform might
> want to override it?

Sure, how about:

/*
 * The memremap() and memremap_pages() interfaces are alternately used
 * to map persistent memory namespaces. These interfaces place different
 * constraints on the alignment and size of the mapping (namespace).
 * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
 * only map subsections (2MB), and at least one architecture (PowerPC)
 * the minimum mapping granularity of memremap_pages() is 16MB.
 *
 * The role of memremap_compat_align() is to communicate the minimum
 * arch supported alignment of a namespace such that it can freely
 * switch modes without violating the arch constraint. Namely, do not
 * allow a namespace to be PAGE_SIZE aligned since that namespace may be
 * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
 */

> Second, I will take it at face value that the power architecture
> requires a 16MB alignment, but it's not clear to me why mmu_linear_psize
> was chosen to represent that.  What's the relationship, there, and can
> we please have a comment explaining it?

Aneesh, can you help here?
