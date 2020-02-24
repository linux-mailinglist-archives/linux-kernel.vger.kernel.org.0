Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F418416AC87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgBXRA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:00:27 -0500
Received: from foss.arm.com ([217.140.110.172]:39960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:00:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA8A1FB;
        Mon, 24 Feb 2020 09:00:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8433F703;
        Mon, 24 Feb 2020 09:00:26 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:00:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, hns@goldelico.com,
        j.neuschaefer@gmx.net, contact@paulk.fr, josua.mayer@jm0.eu,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages e.g.
 in EPD PMICs
Message-ID: <20200224170024.GK6215@sirena.org.uk>
References: <20200223153502.15306-1-andreas@kemnade.info>
 <20200224162131.2a4f9b01@primarylaptop.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <20200224162131.2a4f9b01@primarylaptop.localdomain>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 04:21:31PM +0100, Denis 'GNUtoo' Carikli wrote:
> Andreas Kemnade <andreas@kemnade.info> wrote:

> > No idea about the "Amazon Kindle Fire (first generation)"
> > which also has a partial devicetree in mainline.

> I think that the first generation Kindle Fire (omap4-kc1.dts) are
> regular tablet and have a regular display (no e-ink).

Right, all Kindle Fire devices have regular displays.

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5UAScACgkQJNaLcl1U
h9BhHggAhiZGz+eNFZStZ9O0Qnpt/aA7SqICKdTqmMPsB4L8dbfbPzDcu4zobgNx
pVUjdbTpUR0tsQQrNc+i/ozy947hTdNEJI21zDnDrpNFC6lLUz6H69AWnjlEiJt0
052c5hU+q6it5PaoztU/VlA7N6M6Tuj2PjlO9Y6hwmhVZuHitMI2j4g2stz03Rzt
+vZowNFcs9JSg6hLaRwr/9bcKMfD0oNmhODt0gQbYnbSZ7pIrSctwWMwFLoHbHm4
mhDv0DIfV48gALTBtI67I9z9+AoG2JlB6wce+U14asllME4PZkJtaDnfeFMFAeHC
T5wMlnskg2myKf/xeb+yQkY8LHgbYQ==
=Z7Tn
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
