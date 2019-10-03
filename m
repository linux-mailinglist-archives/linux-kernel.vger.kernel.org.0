Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BACB0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfJCU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 16:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbfJCU7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:59:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB3421783;
        Thu,  3 Oct 2019 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570136376;
        bh=4rPkhVv3VltCH7eEROzE+860uR+lmofxgyA52H8gw0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dna1aFCt6gVcTc+4fmPTB4uadmfs7yI9pJ0SDKtN2T5SNiJWktxV+beMyzLsAgwWY
         OLy8QfHDcMBZEFiDU3TNXETv2BIjWhBSq46X/S6uZuBXEwP96RfLefXj4cxnO96bVB
         0RNdfSZz84UdxnExPCPXodKVZ6+yl7SNIkregb0o=
Date:   Thu, 3 Oct 2019 21:59:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb
 ishld
Message-ID: <20191003205931.d3vp4bh7wdu4oe7u@willie-the-truck>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191003174838.8872-3-vincenzo.frascino@arm.com>
 <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
 <20191003204944.6wuzflqkjdpawzvp@willie-the-truck>
 <CAKwvOdm4ccfhXDDSKXgdN4qkn2NHwAHKCwRV7OqLEG_PQj09vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm4ccfhXDDSKXgdN4qkn2NHwAHKCwRV7OqLEG_PQj09vQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:56:39PM -0700, Nick Desaulniers wrote:
> On Thu, Oct 3, 2019 at 1:49 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Oct 03, 2019 at 01:18:16PM -0700, Nick Desaulniers wrote:
> > > On Thu, Oct 3, 2019 at 10:48 AM Vincenzo Frascino
> > > <vincenzo.frascino@arm.com> wrote:
> > > >
> > > > Older versions of binutils that do not support certain types of memory
> > > > barriers can cause build failure of the vdso32 library.
> > >
> > > Do you know specific version numbers of binutils that are affected?
> > > May be helpful to have in the commit message just for future
> > > travelers.
> >
> > A quick bit of archaeology suggests e797f7e0b2be added this back in 2012,
> > which seems to correlate with the 2.24 release.
> 
> Cool, thanks for digging.  Vincenzo, can we please add that to the
> commit message?

If this is the only change, then I can add it when I apply -- no need to
respin just for this! (although I'm also writing this to remind myself :)

Will
