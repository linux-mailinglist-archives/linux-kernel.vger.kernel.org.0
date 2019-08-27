Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3A9E604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfH0KqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 06:46:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0KqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8QAAUf3vEixa4AQLyanZm3bk3o3NCepVwowzlteGrV8=; b=SpcTXMiQRD7y+zEJj7wHEMuF4
        BdHm2bdibtEv5B+rAJ0/EF+oWbDSmWg9KZTTH95faBeQs4OseJpdk1lTxb4kOQMe/faiAgyE9jVPL
        v3iJ12dlMyxSwM0jmxfpZoy9dG7xoOY4qvJ+kJnde+0Xempz1BfkDPGyZejBx0KdfnbCM=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2YzP-0007t4-Tr; Tue, 27 Aug 2019 10:46:15 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8B4A3D02CE6; Tue, 27 Aug 2019 11:46:15 +0100 (BST)
Date:   Tue, 27 Aug 2019 11:46:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: Applied "ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on
 newer SoCs" to the asoc tree
Message-ID: <20190827104615.GZ23391@sirena.co.uk>
References: <0e5b4abf06cd3202354315201c6af44caeb20236.1566242458.git-series.maxime.ripard@bootlin.com>
 <20190820174105.96899274314F@ypsilon.sirena.org.uk>
 <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIC76ItX9S6XOZ/S"
Content-Disposition: inline
In-Reply-To: <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIC76ItX9S6XOZ/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 05:25:21PM +0800, Chen-Yu Tsai wrote:

> > From: Marcus Cooper <codekipper@gmail.com>

> The authorship of this patch looks to be wrong. Maybe it's a tooling issue.
> I imagine it might have happened if Maxime created the patches using
> `git format-patch` with his @bootlin.com address, then sent them with his
> @kernel.org address, and `git send-email` swapped out the "From:" header
> and prepended it to the body.

No idea.  In any case it's kind of hard to fix at this point
since there's a merge in the way.  This is why I like using
branches for things but Linus doesn't :/

> Either way the "From:" line looks odd in the commit log.

This is what git format-patch does when sending stuff via e-mail
if the author is different from the sender, it uses that to
override things.

--lIC76ItX9S6XOZ/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lCfYACgkQJNaLcl1U
h9Di7ggAgNoZ8rQn7YvVm4cejhwJBcdMuUs1+pBMAGoZh58gwfOMXjpmjeBhjc/F
tSA0tLaf56ov+6K+icWnoYNv3uAMWBA1jimgQTS/ZOPTnfNPQ94/StKIHQKDxj+U
o4MwOkNdSc/ilIGdzRYa9mbTszAjTcB8zylCWd8ONcxTM8RxADVVlVSNXinS7ZnI
cslI9umNwU7+S8WoO7Q5gdk0cOHWmEjW12kgv6LsT6GyLrdlY08Nylb+uaLX+cQP
Tfoym0mSqCbh5/yCHO5tffAuvsMTUdWw+Pid75EkdaY/u4zmnn0+4D5n64a/wfmi
o2fP8Rqk1GMMBWKc42wqfjqulKd53A==
=onS9
-----END PGP SIGNATURE-----

--lIC76ItX9S6XOZ/S--
