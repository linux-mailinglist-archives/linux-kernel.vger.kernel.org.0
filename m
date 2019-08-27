Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25819F369
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfH0Toq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:44:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0Top (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZkyrTJsfOjFeT9DU9YWNBO4J5POV3kWv2nzxcp7HESs=; b=QtmmuBPjjKfKpMEpglfMXttTa
        faxnzfOuiy1GhBkPAlXWqwyaqvB8iSyPV8eJyN021MSTWTB1X4EoMc0Ql4JyUTxeXZFwq3CB7Zvbh
        EmGbT0/cfgk4Lh8BULMhrUeNbiZIldlkijPtXe/AKweP2SNN1XWe4t/n/voGUiZTlUJfE=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hOS-00018k-L3; Tue, 27 Aug 2019 19:44:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7D13ED02CE6; Tue, 27 Aug 2019 20:44:37 +0100 (BST)
Date:   Tue, 27 Aug 2019 20:44:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8] regulator: add support for SY8824C regulator
Message-ID: <20190827194437.GO23391@sirena.co.uk>
References: <20190827163252.4982af95@xhacker.debian>
 <20190827163418.1a32fc48@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ch6x/diZ8cQC324S"
Content-Disposition: inline
In-Reply-To: <20190827163418.1a32fc48@xhacker.debian>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ch6x/diZ8cQC324S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 08:45:33AM +0000, Jisheng Zhang wrote:

This looks mostly good and I'll apply it, a couple of small
things though:

> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SY8824C regulator driver
> + *

Please send a patch which updates the entire comment block to be
C++ style so it looks consistent.

> +#define BUCK_EN		(1 << 7)
> +#define MODE		(1 << 6)
> +

Please also add prefixes to these to namespace them, especially
MODE is likely to collide with something later.

--ch6x/diZ8cQC324S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1liCQACgkQJNaLcl1U
h9C9rgf/Xy1nABMJdavfpBaTNK/T0dAqzeL4PbecKw+JWZ95N5qd8YzDvedjAyT1
ZZNNKYyF6i8+gLPjEs2h3CCLfZqnYMyGrNnLSOGzW9k/a0DtnLg8+4lIFdls9qKc
CcZyOdp+UrPirPfxpjJCG4hvqXPfex1LNX0T7TU5XL84vPnFaq7LUM5l8bLW4QfQ
xCTK4Fx1UzFGodW/24DpXvI1OI5suqnS2e+PtMPxM56sT8KgjE9Y/ZsGWUi//SLH
ogxrcoA6YG49Y/JWd52cFGiFkLvkrkfPdnqLM+2XtpRSwItqOkdVFnQkIFEg8wQF
KHNnU8/HPD+izR09pC/BF2AB4NgebQ==
=Zq5D
-----END PGP SIGNATURE-----

--ch6x/diZ8cQC324S--
