Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF289CFA51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfJHMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:47:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbfJHMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jMyiYxmqhwMzidIJ1KYFcPmFN0sukm0TZJhb74dfpvo=; b=IfNuj1qjZ8lNMtO71VeiBn4D/
        sHTKhHPpKZHVZn7m63qH7RszZpZAN19FgIqoCJaTE5efZoi/UwQcZWZVQXw/OqaY3lTsLSFFe9/1E
        hP9SyAPvDpgHGJP805X6wIDc8BiqHJc5L6M7FxfIKASnlXxJRQHr+RXoA+ejDR+KSteWs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHots-0008Kv-Ny; Tue, 08 Oct 2019 12:47:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2F8D42740D48; Tue,  8 Oct 2019 13:47:36 +0100 (BST)
Date:   Tue, 8 Oct 2019 13:47:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008124736.GJ4382@sirena.co.uk>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 02:38:55PM +0200, Marek Szyprowski wrote:

> Then if I get it right, the issue is caused by the commit 7f93ff73f7c8=20
> ("opp: core: add regulators enable and disable"). I've checked and=20
> indeed reverting it fixes Peach Pi to boot properly. The question is if=
=20
> this is desired behavior or not?

That doesn't seem ideal - either it's redundant for regulators that need
to be marked as always-on anyway or it's going to force the regulators
on when a device could do runtime PM (eg, if the same code can run on
something like a GPU which can be turned off while the screen is off or
is displaying a static image).

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2chWcACgkQJNaLcl1U
h9CXBQf/b+pmbUPYAhUShO4eVdxzuwWcxfei9CJpiBusJoaR/D523P4pH5wKHcU1
tuxCRGKqrO3Ty6SAttrXl6/8hPRkESeRnWXfCqeorDOC3LSC/wrTHR7UedCALn69
hmT7pqOJeD2130JqCuPKit1HxxjxgT8KZHMEamDgqFcB7nh2wU3VwMCWTGRl1VyK
GN9McMSpWCQeSSRRhrrlKGRf+UAiAeDo1MdDe7eO8cowlc4OWOHsaPyL6LU0Uvli
ou6lJxFBUH9ZVbYEX45741FGDAXZimtGkmnwoBgH7r3WB23D9G90L60auCMemmk+
pmMMDHYAfBOliiuDs57KsPnmbgDZDw==
=J/eq
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
