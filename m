Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E629110E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 03:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBBbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 21:31:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 21:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BtxNJuTi7c3Tm7Seqwv07Ixzy3v5k8zXO4yysFcyrAY=; b=n7KTPS7Hip3Do1cImIfuzKRoF
        gp6miykBujjShJmfKLlbPRC6vUFMYma5H2cjMLsrAZ+X+Mei+o6wobozcDXhNwAXHSR3St4H9ozjU
        +riBDVgyCwoNO5BQewK98McYRpfI0xXa7favAXRhawPvaB2Oz2DHyrJwQRfackEy7K2ZI=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM0YN-0005QG-Gf; Thu, 02 May 2019 01:30:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7C2EB441D3B; Thu,  2 May 2019 02:30:22 +0100 (BST)
Date:   Thu, 2 May 2019 10:30:22 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Message-ID: <20190502013022.GN14916@sirena.org.uk>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
 <20190427171955.GH14916@sirena.org.uk>
 <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 09:16:08AM +0000, Adam Thomson wrote:
> On 27 April 2019 18:20, Mark Brown wrote:

> > Don't we need to validate that the rounded rate is actually viable for
> > the parameters we're trying to set here?  If there's missing constraints
> > causing something to try to do something unsupportable then we should
> > return an error rather than silently accept.

> Thanks for directing my gaze to this again. Actually I don't think the SR should
> be rounded at all. If it doesn't match exactly it should fail so I'll remove the
> rounding here. Not sure what my brain was doing there.

Yeah, rounding is dubious with sample rate.  Many applications will be
able to tolerate *some* variation as there's tolerances in the crystals
if nothing else but intentionally allowing it is a bit different.

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKSCsACgkQJNaLcl1U
h9DXvAf+P9971wrO2YV773UVMXkelPV+MmTYvPVA/VL4bLD1Mg7EU4Q42Xm2TrC+
p6me4v618rDTK6qjyHbVW2naAgUgMEMYWmY53WO50rDBM6CcmLdpp0U0jqZTd2La
/fVKdYNXJf3ZUpoe6OqJ05GpD/Ah3yq4iEdCTHCkiEjsRuSO3PbZxZvlU6QqOXeJ
doBoeBlBU0XT/bjO/W9tzUUVQFtBQWHG19mzuSosxosl4AVMjBzajSITE9QsjGQE
0xRfb1ClDpLFyypsOBhM7cuTuPCcnJvWHbJeKy8lrr8TpZ+LE0AxRLUX/d5oLdqN
0Z+RhTSeFWZpThbExo/oc9/sqBSDaA==
=XOH+
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
