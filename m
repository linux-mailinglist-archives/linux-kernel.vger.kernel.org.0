Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757661360E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAITQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:16:58 -0500
Received: from foss.arm.com ([217.140.110.172]:35950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgAITQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:16:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4501831B;
        Thu,  9 Jan 2020 11:16:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF31F3F703;
        Thu,  9 Jan 2020 11:16:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 19:16:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] regulator: mpq7920: add mpq7920 regulator driver
Message-ID: <20200109191654.GC3702@sirena.org.uk>
References: <20200109112548.23914-1-sravanhome@gmail.com>
 <20200109112548.23914-4-sravanhome@gmail.com>
 <20200109132835.GA7768@sirena.org.uk>
 <aefe7c78-6bd9-bafd-9215-5784f8168400@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <aefe7c78-6bd9-bafd-9215-5784f8168400@gmail.com>
X-Cookie: Killing turkeys causes winter.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2020 at 07:34:04PM +0100, saravanan sekar wrote:

> Means should I rebase this v6 patch to linux-next and send, or
> of_parse_cb callback changes as separate patch on top of v5?

Send based on -next, no need to resend the other patches which were
already applied.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XfCYACgkQJNaLcl1U
h9DiEgf/QUCnXEMlNCMPMbJFKITDyHLVu1W4kgM8q0ushmz1qMFgq/qz7U1dr0uZ
ZBUvp4uPnhYS2GAkp/j8J8XGvlQVECwicxpyXzgnzkJIh8DLladDdZ8f/EhC7ZcB
Xhb/c2u1vUwrEbPvkseIND71Aps8M75Kt6LfBa2TIuaJj7V2Xwo5atQGLkOKlEjN
vgDhQUOWDF4sChPBb8RWzztAFIEKGFIcIMmNwumf5Xa03dTC9AueyjWXLROAyXuE
wNKmWrLjR7kCMJ47TcD9Rwdw2ksEGB1a87BEouHEM0SQgw5M5QS+bdz6NW/VVaab
Z2f+w42UfUUVAp7dn2vEFABx4w44kg==
=BWkd
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
