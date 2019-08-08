Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0A86288
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfHHNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 09:02:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbfHHNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vDgvxRnFHe6Jg69YNcHWL2rm/cbYvx87AACFnx7oU90=; b=L42YWZMsMoio+igAjQUu96bo4
        geO1vCR8YwTzh36MPQXWszoitzZVHod+sphk15BbexSnbzDFLiWRaVo4MLOJuXruG98z9ZY+yYBeg
        IaawLxEIsoEXonMuATreeE+atAXQpVP7B0FNBPxqTJxmUeTzFiM7p/3AvHZIVSUyC8vGA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvi3f-0002wa-J7; Thu, 08 Aug 2019 13:02:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0D6A12742B42; Thu,  8 Aug 2019 14:02:17 +0100 (BST)
Date:   Thu, 8 Aug 2019 14:02:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stefan Agner <stefan@agner.ch>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz,
        Stefan Agner <stefan.agner@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Message-ID: <20190808130217.GE3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
 <s5hlfw3izhl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <s5hlfw3izhl.wl-tiwai@suse.de>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 03:00:06PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, they absolutely should tell the user why they are deferring so the
> > user has some information to go on when they're trying to figure out why
> > their device isn't instantiating.

> But it's no real error that *must* be printed on the console, either.
> Maybe downgrading the printk level?

Yes, downgrading can be OK though it does bloat the code.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MHVkACgkQJNaLcl1U
h9B5dgf+Ki7SUxxyvriFNENPkuylZV1sbMznsZZIogox9AW2hDHgCKXsLjFT5kM9
gQ644qx/g31SqeClGf5qFCdskrusee9JBrbD4KrcjJIUsCJxWo9o04+gzBE2cZSu
KdEgzsGLKWRLHw6KAcOCi8A0ivv+SvHkN0pFABLaT+j/rVwgIk+nqwvCEAw+9TC4
l6TyunmOBcu3V7Xf3zlwtyZvP0s3SppGl2meEHdct3tJvXc/qFuGB6Tajd/6Vlcm
hopnicRj76Ujscy8cubggj371VruYsMEhcv5tdANbC2bEIpOIO7xzcPRHkkV62HR
pcs1+xufhA2K5hluWd7IVYq2+m529w==
=AqHH
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
