Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5008D108978
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 08:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKYHtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 02:49:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYHtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:49:13 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1928820815;
        Mon, 25 Nov 2019 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574668152;
        bh=nLjdEdPDudvrrqhZzLDSFcnK9nYQa1HDaY+yBxzgcyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg53IdXZR1RHNmiDEYu1fkeOy6L4nRwNZD1qYSLy5Y53NbtutvYyYw+r9T6vcQbPi
         z8ITbY6OqiV/DmmayIs9nhqAWvargbhO6VGSoKBPph+qFVMk2tmNCyKDiJRUsuQOpU
         ws9EgHIcC4p0RIewiffZkHABLK0F4SI4XalQ16o4=
Date:   Mon, 25 Nov 2019 07:49:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        iommu@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
Message-ID: <20191125074906.GA1809@willie-the-truck>
References: <20191120190028.4722-1-will@kernel.org>
 <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck>
 <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
 <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
 <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 02:16:31PM -0600, Rob Herring wrote:
> On Fri, Nov 22, 2019 at 10:13 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 22 Nov 2019 at 17:01, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > [+Ard]
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > > > > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > > > > >
> > > > > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > > > > mboxes and io-channels") added device link support for IOMMU linkages
> > > > > > described using the "iommus" property. For PCI devices, this property
> > > > > > is not present and instead the "iommu-map" property is used on the host
> > > > > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > > > > IOMMU instance.
> > > > > >
> > > > > > Add support for "iommu-map" to the device link supplier bindings so that
> > > > > > probing of PCI devices can be deferred until after the IOMMU is
> > > > > > available.
> > > > > >
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > > ---
> > > > > >
> > > > > > Applies against driver-core/driver-core-next.
> > > > > > Tested on AMD Seattle (arm64).
> > > > >
> > > > > Guess that answers my question whether anyone uses Seattle with DT.
> > > > > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > > > > associated with the PCI host. I raise this mainly because the dts
> > > > > files for Seattle either need some love or perhaps should be removed.
> > > >
> > > > I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> > > > (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> > > > modular builds of the arm-smmu driver require that the old binding is
> > > > disabled [1].
> > >
> > > Going to post those dts changes?
> > >
> >
> > Last time I tried upstreaming seattle DT changes I got zero response,
> > so I didn't bother since.
> 
> I leave most dts reviews up to sub-arch maintainers and I'm pretty
> sure AMD doesn't care about it anymore, so we need a new maintainer or
> just send a pull request to Arnd/Olof.

Feel free to add my:

Tested-by: Will Deacon <will@kernel.org>

If it's the same as the DT exposed by the firmware I have.

Will
