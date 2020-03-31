Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56300199669
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgCaMZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 08:25:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:25:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EB9A31B;
        Tue, 31 Mar 2020 05:25:42 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020F63F68F;
        Tue, 31 Mar 2020 05:25:42 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:25:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@gmail.com, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        yuehaibing@huawei.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/5] ASoC: SOF: imx: fix undefined reference issue
Message-ID: <20200331122540.GD4802@sirena.org.uk>
References: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
 <20200319194957.9569-3-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <20200319194957.9569-3-daniel.baluta@oss.nxp.com>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2020 at 09:49:54PM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>

> Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF
> dependency")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

This has you as the author but you list a signoff by Pierre before you?

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6DNsMACgkQJNaLcl1U
h9AAewf/SRLQsBBj6wlAv5rhKMVQLnmnQY5R9scerh2jz6AEv/pHxINQd4zTWjnh
pIhrebacgZCwofsY/n31xPI/thHIHJIo4bqgKIQs85UkXwCVHXXctSlyWKPsQz7y
yuwX5Wp7Yamg32an6JuCQo3KCVC5kZt9TMT36nkVKSyhdxmVAkDj7x78EjJRPBTV
1kvi+UzHvDghla+wt2olnvA5KfhNc2SlMi7hDBPtXAEnHr3XDwVoeDxIwobdLC4j
KK0gxmGaHrmB5darIqDjRJeRiG9uzurATnY2GJREkJHgOnRV3mZkeOeQ4yFMoAvG
iJphl8WUXrpNLg0rdwTMnxFHXL4fPg==
=aJV2
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
