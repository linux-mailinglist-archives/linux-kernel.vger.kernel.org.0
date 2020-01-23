Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE69146732
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAWLsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 06:48:08 -0500
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgAWLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:48:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0FC328;
        Thu, 23 Jan 2020 03:48:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DBF13F6C4;
        Thu, 23 Jan 2020 03:48:07 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:48:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123114805.GA5440@sirena.org.uk>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200123092639.GC4098@ediswmail.ad.cirrus.com>
X-Cookie: ((lambda (foo) (bar foo)) (baz))
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2020 at 09:26:39AM +0000, Charles Keepax wrote:

> 3) We could look at doing something in regmap IRQ to change when
> it does PM runtime calls, it is regmap doing runtime gets when
> drivers remove IRQs that causes the issue. But my accessment was
> that what regmap is doing makes perfect sense, so I don't think
> this is a good approach.

Why do you even care about the errors?  It's not like this device is
going to get removed in a production system and the primary IRQ will be
disabled when the core is removed, this is just something that happens
during development isn't it?

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ph/IACgkQJNaLcl1U
h9Arnwf9Fajpy9ImwxaVzbe5ya64UjdSTAQpKU/CPvVZiEmGWUpiiG030wtRUV4E
+bxPoRUMTwnre4Q9HVA9hEaHCtLkq7kEqQczdaonVBIg39nZ+rx0HlF7VvHbYiJU
JFhoM/LCeWioxrvUjh7+fTKIfSGRYiO7k/Rb51kC3wekFwytP1Xz+eOR2ToNymDb
P2v70shC5dCVY/QR527BK2hTxUk41Z8fAgCS/fq0rWHdR+HU8uRCeWMJKVAVokKU
q34spGxN2pzlDlBXOdd06VyQlMP3I1UGYpyOytMctKivuNa0Krl0YXNuNnemiu4v
qKFiTEbWbLrQqrTvFGMYMfKzWBk4mQ==
=9spY
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
