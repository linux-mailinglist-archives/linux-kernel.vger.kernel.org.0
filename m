Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB56252B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfEUOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:50:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45735 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfEUOu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:50:29 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 921BA20008;
        Tue, 21 May 2019 14:50:24 +0000 (UTC)
Date:   Tue, 21 May 2019 16:50:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
Message-ID: <20190521145024.q5u4kjhfyothy2ni@flea>
References: <20190510194018.28206-1-robh@kernel.org>
 <20190520131846.tqx7h7sjyw6sgka5@flea>
 <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d3bior43nd5urpkd"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3bior43nd5urpkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 11:35:01AM -0500, Rob Herring wrote:
> On Mon, May 20, 2019 at 8:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> > > Convert the vendor prefix registry to a schema. This will enable checking
> > > that new vendor prefixes are added (in addition to the less than perfect
> > > checkpatch.pl check) and will also check against adding other prefixes
> > > which are not vendors.
> > >
> > > Converted vendor-prefixes.txt using the following sed script:
> > >
> > > sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > As vendor prefix updates come in via multiple trees, I plan to merge
> > > this before -rc1 to avoid cross tree conflicts.
> >
> > I just tried this with the 5.2-rc1 release, and this very
> > significantly slows down the validation.
> >
> > With a dtbs_check run on (arm's) sunxi_defconfig, on my core-i5 with 4
> > threads, I go from 1.30 minutes to more than 12.
>
> Indeed. 6 min to 45 min for allmodconfig. However, it's only 5 min to
> run checks with only this file. I'd expect a more linear hit. Maybe
> we're exceeding some cache size and thrashing.
>
> > Should we improve the dt-validate tool before merging this patch?
>
> How? I've looked at optimizing things some and implemented areas I
> found (primarily, saving the fixed-up schema and not printing line
> numbers (of the yaml encoded DT)).

I guess we can always try to profile the dt-validate tool to see where
the bottleneck is.

Another area of improvement might be to use a faster language. Rust's
regex engine is known to be blazing fast for example. However, it's a
pretty exotic language, and it would probably hurt the
maintainability. Maybe go would be a good in-between?

> I've been wanting to have some way to categorize checks, so we can
> split rules from pedantic guidance. Maybe we can add a level keyword
> in select or something.

That would be a good mitigation indeed.

> Short term, I'm fine with just disabling this one by default with
> 'select: false'.

Ok. Do you want to send it or should I do it?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--d3bior43nd5urpkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOQQMAAKCRDj7w1vZxhR
xZRzAP9i1Yld7af7MdiLNeb0VkB4LP8mtDZ75Dqlri26cErJrQEAvVASGcCozvEU
EXBPbt+OsLf8nWGZNAo2Ubi1OzAblw0=
=ZMOc
-----END PGP SIGNATURE-----

--d3bior43nd5urpkd--
