Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D793E1775E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 13:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgCCMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 07:30:13 -0500
Received: from foss.arm.com ([217.140.110.172]:46372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCCMaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:30:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81713FEC;
        Tue,  3 Mar 2020 04:30:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066563F534;
        Tue,  3 Mar 2020 04:30:11 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:30:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] regulator: anatop: Drop error message for -EPROBE_DEFER
Message-ID: <20200303123010.GB3866@sirena.org.uk>
References: <1583205261-1994-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1583205261-1994-1-git-send-email-Anson.Huang@nxp.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 11:14:21AM +0800, Anson Huang wrote:
> devm_regulator_register() could return -EPROBE_DEFER when trying to
> get init data and NOT all resources are available at that time, for
> this case, error message should NOT be present, the driver will call
> probe again later, so drop error message for -EPROBE_DEFER.

No, this is not good - it means that if there is some problem the user
will not get any information about why the driver is not instantiating
and how to fix it.  At most lower the message to dev_dbg().

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eTdEACgkQJNaLcl1U
h9DP0Af9EBo3Ed3IWJcDJkDD8qmTx/jmBM6AWA11STYC8A1vzwM+VrL+y/SLXSFV
fp7s2QPZtWc/ZAb6hXnj6CzYr2T2iOxWvNf23G6lqMrUzMkLWwrUo3RPh9LrHdoU
2ogfGwxtr58v1TlXuQlNzztjl3NDkybE0eTyCmvBX3RGwuStrcoMiSeYfA4NF4sq
ybruAa0kXwn+WCOw6VMvNdfv9XI9Gjav4mPVu2GqNNI1oOIbbvFqLDzLLvpbPsJt
bmCuQrC59gbvM/Nj7XdVJSQN5PTMDeRlMB2mWPkv66Te3T1MVr7QfKrQf1RSbgvf
gvXkLlRfaNgldAl14nclxqggLmFDxQ==
=oY7L
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
