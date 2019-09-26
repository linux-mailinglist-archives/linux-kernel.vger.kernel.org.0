Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC57BF5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfIZPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 11:20:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CkcTAd4S96JpD35jbvDi6z+phIXmR7MSa7e/rGtaKb4=; b=kx7Cbp6SHnYTy5/8mkX9LsA03
        zoLd51jZwr4WSGElOynTrJjN7UAfjOJb3xbJMGIADPIs0hzoOzgssneeHyqelOdmdoaEtGmrPIvYq
        ylLR4W40pJuq0fW3zMz/i3G5SijHk9mWGGUAZD4FaiyO3147Mk3+wf1Ir569uYWdbEtMM=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDVYn-0003uG-8U; Thu, 26 Sep 2019 15:20:01 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A5E6DD02CFF; Thu, 26 Sep 2019 16:19:59 +0100 (BST)
Date:   Thu, 26 Sep 2019 08:19:59 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Missing Initialization of IRQFLAGS
Message-ID: <20190926151959.GV2036@sirena.org.uk>
References: <1569542689-25512-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L0pirLHWQnJmYWnZ"
Content-Disposition: inline
In-Reply-To: <1569542689-25512-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L0pirLHWQnJmYWnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 05:34:47AM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> Fix for missing initialization of IRQFLAGS in
> ACP-PCI driver and Missing Macro of ACP3x_DEVS.
>=20
> Follow up to IDb33df346

What is "IDb33df346"?

--L0pirLHWQnJmYWnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2M1x4ACgkQJNaLcl1U
h9CzMQf8CW7bKL6E1DaPRcJ+5j/bmPxewThu9xmDy3QUSp98vzdVj2nsqQTwrE/n
2khiq4zkCK1f8ocT0C92+DNHMQN+1jUoMHSPDP4ZSiIBAIIGIbGJOilcvIx5TGEp
ZiHGBfXILiDBqeqnxX0wJ40RCgidP7gbGUUoliWt69KKIBYhuzlm7Rg0rWr/Zy0o
nPRZVY978qNnIDmIgKl6vMaRCPpwibYJl3XGls+Xg8ek4gUbfDYNY0fnK2J3wLTW
Hg1525ARow6o7PbjaGkqxlf7jilKlPYvClqWPU/qC5tdVG55HMxKsX191vV0iKTe
/TP/nMEQm1qvryDg0TKCyUKMVD6YGA==
=G7K2
-----END PGP SIGNATURE-----

--L0pirLHWQnJmYWnZ--
