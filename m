Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D912794
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfECGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:17:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51028 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n+ye56IaLXU99QFceMc772gcjZpLF08k+xoKec40JUE=; b=Bm4SH5RVru9UOYA/kCSoczHrl
        YcXUdUycVYCIP/dETJiuJH/4wRwCoBSvq7COvRw+QHrbVzd1IrTi3qBzew4kwfSaCGbMSmE5SKLPH
        G2gmkIr5oOPKhCHJhR76GRe1kB3UsG2HdJM7+qdO+h+aD87exew8OtawQLeisbDhIeDks=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRW3-0000Tl-Kh; Fri, 03 May 2019 06:17:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4DC61441D3C; Fri,  3 May 2019 07:17:47 +0100 (BST)
Date:   Fri, 3 May 2019 15:17:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH 1/6] ASoC: hdmi-codec: remove function name debug traces
Message-ID: <20190503061747.GB5107@sirena.org.uk>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
 <20190429132943.16269-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20190429132943.16269-2-jbrunet@baylibre.com>
X-Cookie: All true wisdom is found on T-shirts.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 03:29:38PM +0200, Jerome Brunet wrote:
> Remove the debug traces only showing the function name on entry.
> The same can be obtained using ftrace.

This doesn't apply against current code, please check and resend.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL3QoACgkQJNaLcl1U
h9DTZwf9E0RjhBTjs8Fldz7GoebR5XAWGDHkM+nHkLCu7dcZsFswSBRMPUzk8Kds
rfkiV6GMbmKU91nNmR4ofZ+h/Gfs37/rSiszw2kd5cZAWTnuW454IKvtTqtjgg3d
uiHYtZu77kOlsd2oTI2hhg7QSE2B2TgcB7HnoBqp3XtThnMtK77qSfqphSSNLeGw
hAhoN1Ij28WZOJwMJfCWlQs+n7Eyeie8My057WUsHNab1HFj14BrmcIfj8ic5P45
hu/HrXAPSSKs8XC9hRVyvmxctIh/O0k6D8iUJG/NvZWrbouZshNKz2TicanISl6u
pMRFvnaHlyRYmzDTMcyk7xvLiPW2Ig==
=+amZ
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
