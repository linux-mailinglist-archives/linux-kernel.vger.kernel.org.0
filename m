Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CB126DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 06:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfECE16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 00:27:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35676 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfECE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hirmFxMWxTe8SvSlfv6UKmH6ZLra2U80Aw6D8pbteKA=; b=kSYuTYG+34olIoQ8l3LjWqqda
        lIOJLqMIwpq9+7seT5ZdLRiKdRc390u5YcQ8Fwsam3XEW9MjXMB8STya8NdLgoXH3phgTaihHhUCF
        TeSrl2rB5jaPvdVgZhB++HmmmC9EkXwOlNiOCjXTpb79MogT+it7fnJc6/pslmHpxEQGM=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMPnU-0000Lu-Kk; Fri, 03 May 2019 04:27:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9D2FF441D3C; Fri,  3 May 2019 05:27:31 +0100 (BST)
Date:   Fri, 3 May 2019 13:27:31 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190503042731.GX14916@sirena.org.uk>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
 <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fXEoLLey27Fs/d6"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fXEoLLey27Fs/d6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:

> I am checking, but I don't know why this patch failed in your side. I=20
> Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, =
all are
> Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/bro=
onie/sound.git.

> I can't reproduce your problem. Is there any my operation wrong?

The error message I got was:

Applying: ASoC: fsl_esai: Add pm runtime function
error: patch failed: sound/soc/fsl/fsl_esai.c:9
error: sound/soc/fsl/fsl_esai.c: patch does not apply
Patch failed at 0001 ASoC: fsl_esai: Add pm runtime function

which is the header addition.  I can't spot any obvious issues visually
looking at the patch, only thing I can think is some kind of whitespace
damage somewhere.

--7fXEoLLey27Fs/d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzLwzAACgkQJNaLcl1U
h9AAiQf9HER7t18a/h1Xns+qrJ2Gt/oRnh2FQEPHz/ajt0N1I2kyvwnDMxXjU34Q
FKJHEqKuZ0uke450rOvpVifBPhnbxhdkqVCKjT4sW0fyznHNxy9PQ0/3L25J0v1J
pPEBlTC98wytk8rkdrJqwY3gBV6lzaO/2s+dntb+7w9jqadwDz/QvpGBY3rFGCtd
D2vBoMjd3MhCZRZv2VuVfPuV/xtmdS+/wwhiE9Wo8Q8+55wfgN+7mNaYAkyofhUS
3l0RLeg4aXFJvltKO0oHlToG+emSt5i06hp0QQfTFuUKYe/d9xVKb7z8Icas0mMf
LhcnV09lhAjvRs4boOmGzenukdsmxw==
=jyVv
-----END PGP SIGNATURE-----

--7fXEoLLey27Fs/d6--
