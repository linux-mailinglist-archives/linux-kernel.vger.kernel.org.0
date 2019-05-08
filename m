Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD217294
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEHH3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 03:29:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfEHH3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DOa23I4UKBHZ1W38uU+fjqv/wzB43+8sCcMuITglHe0=; b=CTehFDYv97sYYAFGFVlNog7IH
        9cXlHMjG+fKKPjitK0eaxCy0iAdLsEBfQlyN5bsgiRxL99XTliEzX1CkGyDqaMUOBxSwouljdqQhy
        Kx7/Xx18u9qAmBgsY8YTwlL+eXxUAv8mlOYc1+vIlt6Gq/QAV1xMVhnraoU+1qPvkn2BM=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOH0d-0007Jj-63; Wed, 08 May 2019 07:28:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BCDAB440010; Wed,  8 May 2019 07:50:16 +0100 (BST)
Date:   Wed, 8 May 2019 15:50:16 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug
 traces
Message-ID: <20190508065016.GP14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n02m2kg9dRU2PhYI"
Content-Disposition: inline
In-Reply-To: <20190506095815.24578-2-jbrunet@baylibre.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n02m2kg9dRU2PhYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 11:58:12AM +0200, Jerome Brunet wrote:
> Remove the debug traces only showing the function name on entry.
> The same can be obtained using ftrace.

This is not a bug fix and so shouldn't be the first patch in the series
in order to avoid dependencies from it on anything later in the series
that is actually a fix.

--n02m2kg9dRU2PhYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSfCcACgkQJNaLcl1U
h9Bw1gf9EiD4X5wN34SmEnGb2xWc86eupYpTqZNCNgAwqJjCRLZcuhCDZA1TI9PU
xowIZkIHkls3NAK5Dd7B3amCe7gLoi6a+SqDDc6rUOLBh31xb4TOUjV1dWU5XpNZ
h6frDMTNAcFeLzRzGYPQwlJLsEXiyA1AxbkMWaqNcElsgWLyXX/wzLErByMf+YB3
ZtkamXUgEXbl2cg0SkOYY2jDX7n9K/lsyB4Lg+DEPBWg3CaeT3BaKfdZtMU69xwQ
LfYL1et4cDwIS9+HpmFWOo9YffqBkgl7gwUFxZ61pc9ud3Xg4pT9XgkU7gcOMQtL
hiqbJbWz4GYqbHE/kQTxbOGNYG02nQ==
=xAAv
-----END PGP SIGNATURE-----

--n02m2kg9dRU2PhYI--
