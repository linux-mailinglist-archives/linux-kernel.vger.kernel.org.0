Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF73318D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFCNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:54:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44488 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFCNyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:54:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so12143929wru.11;
        Mon, 03 Jun 2019 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOLJAb47J6suPT31dVCEHN+/0FUVoo53pcrrD0BrXa0=;
        b=kNvHCGiH9bIhYodCq4cBZZUjZidvQr36X/U2+4sypDKAUtopXKLWb9SGUHoIH3ns5b
         bz+SKWFVFGSeNmGY3AU0xM+AshQxnPJFaq/jXXkpJCqqhZFg6gtUuamyhcAK799JX1uJ
         5weQwp5aYvm9nAa1Mdfy7mr8XCTGxs1wLCf16y7vPSt96uR3jnWqu0JC1uelvTS33X5W
         dt7QP+eWuDiWAoRNUGPvDqkQA8qyLG/08JGslSHvdP8f3mngfXYtARRui/+xY9bKtel8
         LNNtnaIsEur/0cfps6c5jALVT37pZuwiUhQ65XtJ2+dk7LuGn8p9+2mk+zcV7wBaFtVp
         0CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOLJAb47J6suPT31dVCEHN+/0FUVoo53pcrrD0BrXa0=;
        b=cEENFjmuin+5CE+dZRK7d0MOF3jhQJUO7gzmsOAw6teC02gxhGcJ5mitzbyfc3ap8r
         HB25tkUhg7vsAagB5aJh1ejDSuA5em4OKE2pjAe1SnlxsckmkMWr552XdcXXCIpFxa29
         0Qp2onU+q/6kwIRM9ot74lJG/KPK9LV2pgRbOXskFI+PffaCU/VA9zMPSxaEwR7APUA8
         kstGp3oDxbhPTDxmkIK3J0ylqA7q3r9magERnqGE6lh0DnSYaV9NiNC8ecaVQE6Eq6Zy
         c4NKhcUXBOSqQgzspVLwNDXX83qT6m2xdNMRSeldHlR764ZOSAfYbCllbMThZWtXOavU
         t71Q==
X-Gm-Message-State: APjAAAUmr/86w+Rj0ujT3mY9dPcYZRVgWsq/kFgDUqsYeImWOaUMbALd
        /DYlskmBDBivplwftlsitZw=
X-Google-Smtp-Source: APXvYqwBRxL1UNgBQBtCYJ/fYTy8aYZ+K/EPqrlhRxj135IKkvRYV8d3QAIxXRud/LcpvlJKpcdzjQ==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr2522063wrv.268.1559570050936;
        Mon, 03 Jun 2019 06:54:10 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id d3sm11070337wrs.8.2019.06.03.06.54.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 06:54:09 -0700 (PDT)
Date:   Mon, 3 Jun 2019 15:54:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
Message-ID: <20190603135408.GE30132@ulmo>
References: <20181201165348.24140-1-robdclark@gmail.com>
 <CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
 <CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
 <CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
 <CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
 <CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
 <401f9948-14bd-27a2-34c1-fb429cae966d@arm.com>
 <CAF6AEGuGGAThqs9ztTNyGnMyhFc9wbtn=N8A4qqQxcN_PAxsEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <CAF6AEGuGGAThqs9ztTNyGnMyhFc9wbtn=N8A4qqQxcN_PAxsEw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2019 at 06:20:57AM -0700, Rob Clark wrote:
> On Mon, Jun 3, 2019 at 4:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 03/06/2019 11:47, Rob Clark wrote:
> > > On Sun, Jun 2, 2019 at 11:25 PM Tomasz Figa <tfiga@chromium.org> wrot=
e:
> > >>
> > >> On Mon, Jun 3, 2019 at 4:40 AM Rob Clark <robdclark@gmail.com> wrote:
> > >>>
> > >>> So, another case I've come across, on the display side.. I'm working
> > >>> on handling the case where bootloader enables display (and takes io=
mmu
> > >>> out of reset).. as soon as DMA domain gets attached we get iommu
> > >>> faults, because bootloader has already configured display for scano=
ut.
> > >>> Unfortunately this all happens before actual driver is probed and h=
as
> > >>> a chance to intervene.
> > >>>
> > >>> It's rather unfortunate that we tried to be clever rather than just
> > >>> making drivers call some function to opt-in to the hookup of dma io=
mmu
> > >>> ops :-(
> > >>
> > >> I think it still works for the 90% of cases and if 10% needs some
> > >> explicit work in the drivers, that's better than requiring 100% of t=
he
> > >> drivers to do things manually.
> >
> > Right, it's not about "being clever", it's about not adding opt-in code
> > to the hundreds and hundreds and hundreds of drivers which *might* ever
> > find themselves used on a system where they would need the IOMMU's help
> > for DMA.
>=20
> Well, I mean, at one point we didn't do the automatic iommu hookup, we
> could have just stuck with that and added a helper so drivers could
> request the hookup.  Things wouldn't have been any more broken than
> before, and when people bring up systems where iommu is required, they
> could have added the necessary dma_iommu_configure() call.  But that
> is water under the bridge now.
>=20
> > >> Adding Marek who had the same problem on Exynos.
> > >
> > > I do wonder how many drivers need to iommu_map in their ->probe()?
> > > I'm thinking moving the auto-hookup to after a successful probe(),
> > > with some function a driver could call if they need mapping in probe,
> > > might be a way to eventually get rid of the blacklist.  But I've no
> > > idea how to find the subset of drivers that would be broken without a
> > > dma_setup_iommu_stuff() call in their probe.
> >
> > Wouldn't help much. That particular issue is nothing to do with DMA ops
> > really, it's about IOMMU initialisation. On something like SMMUv3 there
> > is literally no way to turn the thing on without blocking unknown
> > traffic - it *has* to have stream table entries programmed before it can
> > even allow stuff to bypass.
>=20
> fwiw, on these sdm850 laptops (and I think sdm845 boards like mtp and
> db845c) the SMMU (v2) is taken out of bypass by the bootloader.  Bjorn
> has some patches for arm-smmu to read-back the state at boot.
>=20
> (Although older devices were booting with display enabled but SMMU in byp=
ass.)
>=20
> > The answer is either to either pay attention to the "Quiesce all DMA
> > capable devices" part of the boot protocol (which has been there since
> > pretty much forever), or to come up with some robust way of
> > communicating "live" boot-time mappings to IOMMU drivers so that they
> > can program themselves appropriately during probe.
>=20
> Unfortunately display lit up by bootloader is basically ubiquitous.
> Every single android phone does it.  All of the windows-arm laptops do
> it.  Basically 99.9% of things that have a display do it.  It's a
> tough problem to solve involving clks, gdsc, regulators, etc, in
> addition to the display driver.. and sadly now smmu.  And devices
> where we can make changes to and update the firmware are rather rare.
> So there is really no option to ignore this problem.

I think this is going to require at least some degree of cooperation
=66rom the bootloader. See my other thread on that. Unfortunately I think
this is an area where everyone has kind of been doing their own thing
even if standard bindings for this have been around for quite a while
(actually 5 years by now). I suspect that most bootloaders that run
today are not that old, but as always downstream doesn't follow closely
where upstream is guiding.

> I guess if we had some early-quirks mechanism like x86 does, we could
> mash the display off early in boot.  That would be an easy solution.
> Although I'd prefer a proper solution so that android phones aren't
> carrying around enormous stacks of hack patches to achieve a smooth
> flicker-free boot.

The proper solution, I think, is for bootloader and kernel to work
together. Unfortunately that means we'll just have to bite the bullet
and get things fixed across the stack. I think this is just the latest
manifestation of the catch-up that upstream has been playing. Only now
that we're starting to enable all of these features upstream are we
running into interoperability issues.

If upstream had been further along we would've caught these issues way
ahead of time and could've influenced the designs of bootloader much
earlier. Now, unless we get all the vendors to go back and modify 5 year
old code that's going to be difficult.

However, I think Robin has a point here: it's clearly documented in the
boot protocol, so technically bootloaders are buggy and we can't always
go and fix things so that buggy bootloaders continue to work. There's
not a whole lot of incentive for anyone to fix the bootloaders if we
keep doing that, ey?

> I suppose arm-smmu could realize that the context bank is already
> taken out of bypass..  although I'm not entirely sure if we can assume
> that the CPU would be able to read back the pagetable setup by the
> bootloader.  Maybe Vivek has an idea about that?

I've been thinking, though, and I'm not sure I see this issue on newer
Tegras that use the ARM SMMU. I suppose this could be because the
bootloader doesn't enable the SMMU, but then again, I should be getting
these faults even so. Interestingly I don't see those on 64-bit ARM, so
perhaps there's something special about that.

Let me reload a bit of context here so I can give you more than just
speculation.

Thierry

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz1Jn4ACgkQ3SOs138+
s6EGAw//WoBqSWhuMgvrTtVCOhbWBmxJmptmdHLDjx/yvLkoM0MCaam+Aiybw0Kh
G3KXAkBVmuVBCF2OTARyRatHhq+VOocpT2Kal8dLYU61v7HQv5gh0w3CMlG2h1Xd
d42cI6eKLvoocd1LcC8R4YD8ouRiecEoQVbz9r8juSXYdWMX8C1NSV9RjnahesWY
VN5/A256cr+1abCJkL/0CiJQpoqPtO4OmyCNGklzGqDb1iTu4Nmcl6xNfOiVlhtc
OanNYDOHdEXgS3n7+XWair3DLicvhbWC0N38S3ku+SuG5jk9FNwV+k6NDvNwEkTh
f1qm6svYfZXW4gGFiem795DEjYmxGww+k7UIkNR+qIMgk7MtyaTHMvxWz1AJzbAy
UDCdWfFJ1l2Tr38/0Ew1P6ROWrXWbDaF17uMlr/ru3itx0K8jqSwi2Y7H6IqdJTv
tncVAvf7E956Oq7JsCU7UbrR1hQxyv/MflhajnABr7kHwg20Wj47MQltsffnDIEY
cxqesXYmS3lnbUb3woKFRRJy9USMt+OKMvpBsX4Pwwo/JfrfQeTlgEt3lDNeD1o2
S0Am5PYyGji4gTXw0lNRXNImmHKPP/zoF3ykVTQ80VzTxPhvREpTplxTGd38ZylS
6D+Hff8Y6ToyqtvqGCChbDwPfu7LJg0JtsVBJxZ4Qv10j7FIdMo=
=Rz8c
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
