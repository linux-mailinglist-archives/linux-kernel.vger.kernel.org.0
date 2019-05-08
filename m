Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4561734B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEHIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 04:09:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41670 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ULOCWDUQGwmAxHk+ckxsmDle5ZaAI58gkU46nk3dets=; b=kJNl4MWhG+iTqTlQO+ZJIp6V3
        ob89WFRfcXV47eRAArKsK1QStuSP2FSXEFdDWAkWpGGKpd19TtpNBZ0KU6VDXX4PKKJxT7ximoCa1
        mATDKcyuFpk7MqFbjYIUtVRQ26CJ2+RC6UTHPYRAbZnko5nYt59HninUptyz70dmqkLgw=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHdf-0007QV-ES; Wed, 08 May 2019 08:09:20 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A16ED440034; Wed,  8 May 2019 08:58:48 +0100 (BST)
Date:   Wed, 8 May 2019 16:58:48 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
Message-ID: <20190508075848.GX14916@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wrNCEKhXQ1Rm601q"
Content-Disposition: inline
In-Reply-To: <20190414175939.12368-7-digetx@gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wrNCEKhXQ1Rm601q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2019 at 08:59:39PM +0300, Dmitry Osipenko wrote:
> Add regulators coupler for Tegra30 SoC's that performs voltage balancing
> of a coupled regulators and thus provides voltage scaling functionality.

Same here, what are the requirements this is implementing?

--wrNCEKhXQ1Rm601q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSjDcACgkQJNaLcl1U
h9AkPwf/Z7aGD6BhjDwDnRf1W+OFfusRfArS876TN0gpG4jze/ueQvIgTtuwni6t
lKRHI5u/7G1tXtN0czWxH6XOVWC6rGk2eGGW4DEFiEkqKhi7mYweSL6ed0YuUOna
LKBsZYuozCWxCsro4IHsSNpxO3NMOf/lHPWwvsLF9BaqxNA2cIsMNeUu0+a1+n5J
vCYGm6Mpb1wp9hr1LJ6A3FgAOOrkIUwWoshN+fKSdC3rEQZitCBMiv5eTpmCxNDK
hF4J510FgAujo03oGglUaR4Qzv8NrL6ng67QTyY7Ix5tWrDu2zXgYNWI9pIXwrZI
rfECvpY97JH/5JKy6HTbtN0xupaUfQ==
=vCuY
-----END PGP SIGNATURE-----

--wrNCEKhXQ1Rm601q--
