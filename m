Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABC15790D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgBJNMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 08:12:01 -0500
Received: from foss.arm.com ([217.140.110.172]:32958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBJNL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:11:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498531FB;
        Mon, 10 Feb 2020 05:11:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11273F68E;
        Mon, 10 Feb 2020 05:11:58 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:11:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/5] regmap: optimize sync() and drop() regcache callbacks
Message-ID: <20200210131157.GE7685@sirena.org.uk>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20200207180305.11092-4-dave@stgolabs.net>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2020 at 10:03:03AM -0800, Davidlohr Bueso wrote:
> At a higher memory footprint (two additional pointers per node) we
> can get branchless O(1) tree iterators which can optimize in-order
> tree walks/traversals. For example, on my laptop looking at the rbtree
> debugfs entries:

It's not clear that this is a good optimization - we're increasing the
memory footprint for a bit of performance but our performance is all
relative to the I2C or SPI I/O we're most likely all in the noise here
whereas for larger maps the size cost looks like it could be quite bad
(but equally your case looks to have a lot of 2 register blocks which is
almost the worst case for overhead so...).

That said the code is fine so from that point of view:

Acked-by: Mark Brown <broonie@kernel.org>

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BVpwACgkQJNaLcl1U
h9D9nQf/UDELw4nM+mVlqjci3E7CLgv2DvqtZdkaYcs/g8i10jrF2mZBquvaUwUX
DpgA8imJ1niA81szUWxxUjbMXLT/FRbVZBHAGDK47n1b6E0j1k1K35eq9nvsgchW
Lg6NaXfqNFgmm4TCwKbS+eQZANklImbERJkdELSFasEwi2I2WETW1T2/TmHxGO3j
orStHxYCiSIobLd+kXwzC/gcFg5H17s9zRpDDNqr+qIK/XMkEzoXckoVCE4bDIS7
k9NX3PD64PKfTSjgsfCbJmhQUCvSqo02zgUkFfHOzBSE4YCTf0CijLV4wwlnaNuM
7SiD49YTlzecyrzgmFA2iQEgp/Jbww==
=utDt
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
