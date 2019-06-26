Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9036156833
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfFZMFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 08:05:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vV+ITGIODyCQri15lRJpK7Y1fkGWUDu5aFGbJ1voBgc=; b=dNO6aHBZaaOsxcY8ovtp4KriB
        kByoKeu+e0chNGg6MROb2D2kUnqYyZ5K5uNuMyxX7mXh56gHHDxYBSSAjuH9FP/tDjK0o01CcAl1l
        AfPjKSyoyBSLc2FrHQnF6+BdDcr71sCHHTM2G8iwHKNrKfUCu2QyYnVEShwcAa6ENSCV4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg6gP-0007pw-R3; Wed, 26 Jun 2019 12:05:49 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2B7DC440046; Wed, 26 Jun 2019 13:05:49 +0100 (BST)
Date:   Wed, 26 Jun 2019 13:05:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH] regmap: Drop CONFIG_64BIT checks from core
Message-ID: <20190626120549.GC5316@sirena.org.uk>
References: <20190625233116.2889-1-marex@denx.de>
 <20190626111508.GA5316@sirena.org.uk>
 <f0098753-8219-27c0-d992-a209f3c67d4d@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="odPpP5ru0JScGiDm"
Content-Disposition: inline
In-Reply-To: <f0098753-8219-27c0-d992-a209f3c67d4d@denx.de>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--odPpP5ru0JScGiDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2019 at 01:20:17PM +0200, Marek Vasut wrote:
> On 6/26/19 1:15 PM, Mark Brown wrote:

> > registers was that we use unsigned long for
> > addresses and values and a 64 bit value won't fit in those on a 32 bit
> > system.  Some of the bulk APIs will work but things like individual
> > register writes and the caches will have problems.

> Good thing I sent this as RFC, I realized that shortly after too.

> So, what would be the suggestion here ?

I think if I had any really good ideas I'd have done it at the time :/
Converting to unsigned long long is going to hurt performance for the
common case but it'd probably be what we need to do, I think we'd need
to have some sort of preprocessor fun and build two copies of the code
with a 64 bit clean version available for devices that need it which is
ugly but bleh.  It's how we handle similar issues with zlib.

--odPpP5ru0JScGiDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TX5wACgkQJNaLcl1U
h9D5fgf/ae+4+Sb4KQCVduBSgmsF1GkE7GlbUn2i4LSkSN+IHqQftZrDG1LJJEya
LbaY4VT7iocajRUYYtFM1k7PmXAW3BlD1vk/NXcRkw+a6i2KWaWPaLVStZ0DEqFa
3K1L5EHSKQAmuFev3gmcp8QOi13nSfdSYVbJxPO7zF/SUjlxjnuUPqrX/kgigP2W
TaZaQ9EAiOyUqF/Rt9kv+yWJtQv2jJbLan/GmTQyNZVcGIvGa+lk20XNrUv+0UzK
X4uTxQyaARpLeaIPs0+N58DGEHpPa9W5B6PAOQgJg059hl+nvaARDodcOHqWs52q
AJq96BRz6FVGD9G1YqahZ9B3IuG/HQ==
=/aQY
-----END PGP SIGNATURE-----

--odPpP5ru0JScGiDm--
