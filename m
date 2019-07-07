Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1961068
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGFLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 07:21:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGFLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 07:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l9zh9YCOWXRRrpVjr6FE4iQKwindWBK+wynvEueKbts=; b=k9BfuLr5+/5fmwnwq1xqsd88Z
        9yNY4LTEjqsm2KTwYdd1LAo19KSFkyPyr+9djkZIbL2U28uKvRjxRSZRjqk7wZw3sfLcLXslw3wjY
        NmcqddEHa/PQo31eHv5KbHU0k++tVe2Vd6YPAB7gE57dhkamb72Ety/h6n9cXx2rSPuuI=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjilF-0006nj-9K; Sat, 06 Jul 2019 11:21:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5E8B227437E5; Sat,  6 Jul 2019 12:21:44 +0100 (BST)
Date:   Sat, 6 Jul 2019 12:21:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: axp20x: fix DCDCA and DCDCD for AXP806
Message-ID: <20190706112144.GH20625@sirena.org.uk>
References: <20190706100545.22759-1-jernej.skrabec@siol.net>
 <20190706100545.22759-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20190706100545.22759-2-jernej.skrabec@siol.net>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 06, 2019 at 12:05:44PM +0200, Jernej Skrabec wrote:
> Refactoring of the driver introduced few bugs in AXP806's DCDCA and
> DCDCD regulator definitions.

This is not a great changelog - what are the bugs and how does
this patch fix them?

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0ghEcACgkQJNaLcl1U
h9DPrAf/aYMgVdPbOheAhHM40pMN7HcxSHYkqgEiPN+guqERGPAeHV6xTn9VsX5I
iZavyKfuFLfY3b66PgFrRa0DU8giSxQZOAN5tFGjysEuyiwrhG2W+ZpMtGalnJ7V
VEKvkzgOR9HofD2uGoXmA7/3iNynObgWlfziL3NYtWEQur64A8pmW/6nXAr4g6FM
LiwL/oU612MJ9np0Edg8sh7qV3ZpfRTcpg4lhVvZR7sYEJ0LAsWJLNFoLnMTmWtS
F9GVVR1w5JJn48yp/Ub2I6VyPbhtbvuAtGttT1UWkJokkjkbj/oPooUMjHU2gsY6
a4vRDWOVdwb3KYKWy8OiMRH+tOajoQ==
=wt9e
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
