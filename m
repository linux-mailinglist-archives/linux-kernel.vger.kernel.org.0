Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C092AAFB00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfIKLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 07:00:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45160 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIKLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TZQLypzWeA/ilSOYe3wzlLd06xCmw+pwR+Ix533idW0=; b=V0gdhRqskzcdurAO9eFX3mVdj
        h2iVFeEf05IwfJEsafqzFNUOrrkpE5snp9+fnI1usUcQ7ecZjcI8OYv5QCq1z0C8RD1QjwS9KlR/e
        PdI8or5Z/dRsphnfoAcrRFWBiPpegfvqpogoO2DUePEcrUv6Eyu/fbTELFjNC+9eLSbAQ=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i80ME-0008NR-3j; Wed, 11 Sep 2019 11:00:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6FE80D00451; Wed, 11 Sep 2019 12:00:17 +0100 (BST)
Date:   Wed, 11 Sep 2019 12:00:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, festevam@gmail.com,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Viorel Suman <viorel.suman@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
Message-ID: <20190911110017.GA2036@sirena.org.uk>
References: <20190830215910.31590-1-daniel.baluta@nxp.com>
 <20190906012938.GB17926@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Content-Disposition: inline
In-Reply-To: <20190906012938.GB17926@Asurada-Nvidia.nvidia.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 06:29:39PM -0700, Nicolin Chen wrote:
> On Sat, Aug 31, 2019 at 12:59:10AM +0300, Daniel Baluta wrote:

> > This is to allow machine drivers to set a certain bitclk rate
> > which might not be exactly rate * frame size.

> Just a quick thought of mine: slot_width and slots could be
> set via set_dai_tdm_slot() actually, while set_bclk_ratio()
> would override that one with your change. I'm not sure which
> one could be more important...so would you mind elaborating
> your use case?

The reason we have both operations is partly that some hardware
can configure the ratio but not do TDM and partly that setting
TDM slots forces us to configure the slot size depending on the
current stream configuration while just setting the ratio means
we can just fix the configuration once.  I'd say it's just a user
error to try to do both simultaneously.

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1408AACgkQJNaLcl1U
h9DPtAf7BDckq3blE9Yvy2E6HPiI+Pp9nt1hQ9NDgfX9Mypn7Vp6rfruIjCr5kKK
Pk3fQYVDLvUt0LjscDDDibjxgRnk+mPUcSc0/i9KLuS+AGpIyo+RJP2xnzG+KLox
dgzhk6Ti0RzhqxUcv8tamcsRApdEN+rHOFm7zE8NxJR13AEGR5/BIbJnixGDDZtA
GfmZPcxreMijqLu43Gt5EURM7b1tyKW7usyuYsD9K7tn71E2OuBUJJQhWTWKBiDS
vC+6KmzfUqPuJNH2tO/Wq7ZWZ4ho7+1F+nTmk0s6h1YJI6Qz6jWEmU2MCSgyioTi
X+G5eL6O9bY8OC2mL/IxNrE0j8wbIw==
=fLXK
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--
