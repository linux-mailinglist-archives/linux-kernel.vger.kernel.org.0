Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62ED16676F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgBTTqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:46:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:46:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FF830E;
        Thu, 20 Feb 2020 11:46:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E3C23F68F;
        Thu, 20 Feb 2020 11:46:22 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:46:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: renesas,rsnd: switch to yaml base
 Documentation
Message-ID: <20200220194620.GK3926@sirena.org.uk>
References: <87d0ahzr9d.wl-kuninori.morimoto.gx@renesas.com>
 <20200219161732.GB25095@bogus>
 <874kvmt355.wl-kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 01:33:56PM -0600, Rob Herring wrote:
> On Wed, Feb 19, 2020 at 8:16 PM Kuninori Morimoto

> > > > +  clock-frequency:
> > > > +    description: for audio_clkout0/1/2/3
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array

> > > This already has a common definition and this conflicts with that.
> > > 'clock-frequency' is a single uint32 or uint64.

> > This needs clock array. Like this

> >         clock-frequency = <12288000 11289600>;

> Sorry, but the type is already defined in the spec. You'll still get
> warnings from the common schema and you can't override that here.

> Not sure what to suggest. Leave it with a fixme or move to
> assigned-clocks-rates instead?

Given that this is an existing schema we should really try to keep
compatibility :/

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4gwACgkQJNaLcl1U
h9DpNgf/T3NsUyExFf1KBDaf9LwB98JuIJZnPVN3szC+niqpV7pWTCL40vzSBGiV
SSlCDGxnMV1mmFT1H6Mv+NWj/E9qf5ech4MVE/LdO6oeRfJ6vlJOhtRVGw9gZz9l
0Jr+r4FrM/F4s+SiCJRpB9bpdBra89Rqy6hMftuOTYORGm4+F+gLM2wMiO0qS7Ro
zVUinC0Toc+WXk2AVK8G2UrErAI9FdZRMXZYXyAYrWk/5cDQXVkWaifVwelDTyy8
INeT1Y0DBOZ1t1In/sJAiw2OL/C+PDxoUE4znyjw53rNB48C0NSVt1XQOyjcXX0o
d5yXeMAnmkXID2NzRS4q3H3OmyN3/w==
=dMJr
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
