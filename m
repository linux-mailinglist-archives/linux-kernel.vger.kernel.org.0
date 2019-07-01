Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2942CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502282AbfFLQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 12:53:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50064 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440346AbfFLQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NPN8bfwZq6cTbjgqtoqpT0enq0VICOKpKzqeN1XUFC4=; b=b2KWPzY9i8fB5AVv6I/4J73SY
        kGQ2f92R/5QJb32/wyLs7IVbii/eurBR7I7+dxNv6Snumit62xce/U6tOyieaJMgsK80oe5nhm+mT
        2zQWjvXYAz9ckK1kmLdHIf7jlDmEtH5QDY1fr/JvFq2T9UtYYtzkCu+mXdFcAueGMNgJQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb6V8-0003CH-6H; Wed, 12 Jun 2019 16:53:30 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 93B9E440046; Wed, 12 Jun 2019 17:53:29 +0100 (BST)
Date:   Wed, 12 Jun 2019 17:53:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: regulator: 88pm800: fix warning same module
 names
Message-ID: <20190612165329.GF5316@sirena.org.uk>
References: <20190612081158.1424-1-anders.roxell@linaro.org>
 <20190612122114.GE5316@sirena.org.uk>
 <CADYN=9K4WZQf4jy0Tk-kkVqwHJQvVBToH7ZOYq3z6gK94vR8ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <CADYN=9K4WZQf4jy0Tk-kkVqwHJQvVBToH7ZOYq3z6gK94vR8ZA@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2019 at 04:14:38PM +0200, Anders Roxell wrote:
> On Wed, 12 Jun 2019 at 14:21, Mark Brown <broonie@kernel.org> wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> I should have payed more attention, sorry.

> Do you want me to send a v3 to fix the subject line for this patch?

It's OK, I fixed it up by hand.

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0BLggACgkQJNaLcl1U
h9CPlQf/TzkXQx2fBiyHR7gtrIz0k8K9xE3RxhGAoYHrqn0/SxOmjBYDb/Gb709h
YTqzOtnoDaRzszpdZnjHQL9QMSdJR9QtzA+Ps4c4mWYVQeZRlwMqnMvN6pDca1Lf
X/73E1gbJIXunzP36X9vwMsv0OZLBY2WKiuuI3DmQaO5DgD6Xw4KYDa2CytMIl1s
ikaxpYiAEqAd8gYOJDuRMGOLcX+EVyyPvyJtuxz9Bz1yeffm1MwEEKXs3Ba56MwZ
5xJR4bpasERKRyPgnhX+m2qA2HKMH4fqX/KLE+5XJFYMXe+xzkhCxeknjm2Hspjh
gwQqMhAToISjb8XRFt17eaqScKoX/A==
=2S8T
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
