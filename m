Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE7AF9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfIKKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:04:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jfmz88C6lrhs31cRlnO49TRqP1LMaWlkChTQG4q+Yew=; b=SyVqUXDTdYWAInG1jgsHwaWdH
        tFuY19DeE6XUnOA8U1ciXF7ZiKrzizIVnnPTY6a92MPIuOvWPmsjgqyQtrNbBWMkLEq0JsiR9WWN1
        cQeZAgZYhaSoiYcVYR/4luC1DZDJWUAVMCNaegctmk9+yh50ZCeqva6nVQmNIi4/WDrOQ=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7zTd-0007XI-4R; Wed, 11 Sep 2019 10:03:53 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 87284D02D76; Wed, 11 Sep 2019 11:03:52 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:03:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl_mqs: add DT binding documentation
Message-ID: <20190911100352.GS2036@sirena.org.uk>
References: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="//h4sZKAxcnndsN6"
Content-Disposition: inline
In-Reply-To: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//h4sZKAxcnndsN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 10:42:38AM -0400, Shengjiu Wang wrote:

> +  - gpr : The gpr node.

What is a gpr node?

--//h4sZKAxcnndsN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14xocACgkQJNaLcl1U
h9DCkQf/boGjyVueB4AhrIMUugvRHAK7g8btFd64V3bz8anjolHMklTWGGeE9FGv
Z0dIvqYu+GNy8SdEDagnH4ZqeiGhgDyeNLCPCSg++HgsJLsw2PadGfxpIagEPm1X
5MXKVBiRW31EKo8d58xRsNVbWdWpkNsMW/4JiTRQR6IZ4op8DxAqGmpWpvjuAcPZ
KBNo78YpmO3x+stm5dC9zAXWro0NzcMu2G98bLWAHieY5yT8v7aQDFZtPvNRjxNr
2IyRhZDcE1NU+Kbi8QGKYtmTYICdgJtt4wsx2k4GZ9/+SXx+d+HL6UHu67imQm6N
/0diiJmTf9MkEXh05p1whRrAXYKiyA==
=XX1U
-----END PGP SIGNATURE-----

--//h4sZKAxcnndsN6--
