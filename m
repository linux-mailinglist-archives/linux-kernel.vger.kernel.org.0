Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18737BDEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406294AbfIYNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 09:14:33 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50937 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406269AbfIYNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:14:32 -0400
X-Originating-IP: 86.250.200.211
Received: from aptenodytes (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2E2C7C000A;
        Wed, 25 Sep 2019 13:14:29 +0000 (UTC)
Date:   Wed, 25 Sep 2019 15:14:28 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <20190925131428.GA207379@aptenodytes>
References: <20190925084932.147971-1-paul.kocialkowski@bootlin.com>
 <20190925084932.147971-2-paul.kocialkowski@bootlin.com>
 <CAL_JsqJY+d9frxuxspvo2SQ=vpWMCAWZfMODA-jm_rKu1GOEaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJY+d9frxuxspvo2SQ=vpWMCAWZfMODA-jm_rKu1GOEaw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 25 Sep 19, 08:07, Rob Herring wrote:
> On Wed, Sep 25, 2019 at 3:49 AM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > The Xylon LogiCVC is a display controller implemented as programmable
> > logic in Xilinx FPGAs.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../display/xylon,logicvc-display.yaml        | 314 ++++++++++++++++++
> >  1 file changed, 314 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/xylon,log=
icvc-display.yaml
>=20
> Error: Documentation/devicetree/bindings/display/xylon,logicvc-display.ex=
ample.dts:17.1-6
> syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:321: recipe for target
> 'Documentation/devicetree/bindings/display/xylon,logicvc-display.example.=
dt.yaml'
> failed
> make[1]: *** [Documentation/devicetree/bindings/display/xylon,logicvc-dis=
play.example.dt.yaml]
> Error 1
> Makefile:1282: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2

Okay I hadn't realized the example is extracted and tested, so I included .=
=2E.
in there. My mistake, sorry.

I did the testing with the dt-schema tools directly, on an out-of-tree dts,
not in-kernel-tree.

Will fix with v3 then.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl2LaDQACgkQ3cLmz3+f
v9GDfAf7BGkW/MJkbSMHAOH7JJPvjMO6DZKdGlxsc7aseFvyex7joJAYutxV5TeF
zo5GZKigVItIuoKdkctHGdFJ/W/13C90SOMEx8NntTFv4Aan00ZF2/PPypkCQUKO
bPbIDnRC6lvdCb5L5ZP+y7d08yrq3Vbhoyz37LUyXahd3eqYS2EwS4m43jtEKsz2
lSTQ2BGmRth/wDJrFVoq1H40+JRX6GsePcmhOuXmKiAx9a2LErnbhgbWKo+48var
m1BxAMtecR4lFp7qWE7L1OdKGy4L3VlzszEcUEMtdb/zPWy8o6pJMaySL5aQtyjI
Ps/os9b9Kh316ykRUf5mkAuHk5izdg==
=9Fif
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
