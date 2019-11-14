Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C063FB7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfKMScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 13:32:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbfKMScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CDkBZwULnSajnBmTWsW53vklHTHzXFO1u7/zlRZ/bow=; b=uO2/C9W7g+pjJzGe9QdZ/a+Aa
        Y5FVrmOpMmHSGGHa1fw7jjieZ80SDON4PdWV7aF/X2uAlLBDn8+KdP4pXDFau8zY0Qm+RfH2Gg0oi
        LE4XsmIp8v4ZTCcpxoaWI/EFh/0+AJxaRHZhshIhk5CHXZPS2CHj8xsUXbiurealn6VIc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUxR6-0004HW-It; Wed, 13 Nov 2019 18:32:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D3DA7274303A; Wed, 13 Nov 2019 18:32:11 +0000 (GMT)
Date:   Wed, 13 Nov 2019 18:32:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191113183211.GB4402@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20191113182643.23885-1-andreas@kemnade.info>
X-Cookie: Type louder, please.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2019 at 07:26:43PM +0100, Andreas Kemnade wrote:
> LDO9 and LDO10 were listed with the same enable bits.
> That looks insane and there are no provisions in the code for handling such
> a special case. Also other out-of-tree drivers use a separate bit to
> enable it.

This definitely looks like a bug but without a datasheet or testing it's
worrying guessing at the register bit to use for the enable for the
second LDO...

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3MTCsACgkQJNaLcl1U
h9AjAQgAgUFL9zZM8B3gIkvEHDBDp0+PFbXgC/xEmdNFbMEUKrJg5E+F1421qkqu
ObE6PYM8J2xAk/LTCIJWv+L5Sc2xdavMUbp8SxcuYdaPE15s4dwwrvI74wTw2xF0
aPx0g3lhs4u0WWrvfrGXTRDXZSaQzgjiAg371pdQE0oiMcBb+cELbNaZ1zjJmbxB
bjVZdVFqMN213A2ajHBdMo9fZMX04G4M7R3rtnONc9fopC/f4dAzrRnBvQzgaXIe
qDXP4zmhMnndb9F+iv9GYDAoaTq7mV0mmpdgIUB6gEmlykdS/Rbc4dfGellOL+H9
7JL1nRNO6aO8D5TQgL9Gww3V0QqVoQ==
=7+ws
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
