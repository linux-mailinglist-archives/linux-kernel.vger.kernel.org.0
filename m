Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5213198F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgAFUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:45:23 -0500
Received: from foss.arm.com ([217.140.110.172]:48912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:45:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6394328;
        Mon,  6 Jan 2020 12:45:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C91A3F534;
        Mon,  6 Jan 2020 12:45:22 -0800 (PST)
Date:   Mon, 6 Jan 2020 20:45:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] regulator: mp8859: add driver
Message-ID: <20200106204520.GD6448@sirena.org.uk>
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
 <20200104153321.6584-2-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20200104153321.6584-2-m.reichl@fivetechno.de>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 04, 2020 at 04:32:45PM +0100, Markus Reichl wrote:
> The MP8859 from Monolithic Power Systems is a single output DC/DC
> converter. The voltage can be controlled via I2C.

I have patches 1, 2 and 4 with no cover letter or other information
about dependencies.  What's the story there?

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TnGAACgkQJNaLcl1U
h9A46gf/bxiSXCC7UE5lAyiSv1Ty0tmILgIugHIDfpv1kiItsznOj8o8gd3t8Xak
RfV15p/RE5SEf5Mt9PmQ9HZLYrz57LYhPdIW8mdqPYEBBSLIK6yomYITST5+FrH7
pc36LC/KBi310B2EzWReP45Tmw+oEWw/CTYHYcto48soSNDBsoaqoqfM59GrLRP5
2YapCH/IaVzmrxAToY00vPDGeOvkeRIzXV4ewVTedOB/ZDU0tUtKZhDPLzjv6P2+
lEGdUmRK+TYlP9UIB0i9b4i+Rmvx9LjHpZ3e+HZ3WOIiv6ONfgt2j9AcpgZUraeF
ExDGyMhZQFn9v/qcJs5Txp0Tdrebzw==
=5TQL
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
