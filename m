Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2DE091E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfJVQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:37:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJVQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ZBKUToM4kIs6IK0jvb//AxftUHAUYBkcNObJNOnlPs=; b=MOGtrGjthGlR3pSbKo+weGsls
        BXeOAuHLQfVk9vCepzkg1OsBEJ7Z4ntOIC+i/GISbKG0FOHh0eKH5L73rHW0dpfQTaV/vry62tU4T
        Hm80vAIAxzNWHehm01jGPvardu0aOwk7J8o+rTauTWKeJRRMR3WKf4LvF67w/MDsqQacY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMx9V-00072t-8z; Tue, 22 Oct 2019 16:36:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B6F652743259; Tue, 22 Oct 2019 17:36:56 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:36:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 16/46] ARM: pxa: tosa: use gpio descriptor for audio
Message-ID: <20191022163656.GN5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D9sZ58tf58331Q5M"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-16-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D9sZ58tf58331Q5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:31PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--D9sZ58tf58331Q5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMCcACgkQJNaLcl1U
h9AS+Af+KFHD1F8v9aWTr2l9IPxxO3sNqMg20rA6oPY9MS9aXMLdK7qrijFp3fn4
i4ST1qYowqgeTOqsC1hZdVKaVBU03Y/vRLLwn3GJSOH0YacQ7zB/FRQHmRESlLJu
MElU0aFph1IXDxzmPQPtxEgpGxilIY+gvHr1xQGlUiQUwluK2bV86cxb2Yq6kAF1
Fi5OLRPu4hWUN/WqDurqBzh5gWBrNliCsE3LBjS1ZtxjsrvY64cyNsRb8Mq3sTZi
R2sybjdMAU8xLBSsgFAA4S/N/8+hPZ7/6y9ot1YrIw+ZUnusvbOgPksE5VXuQofR
EVy8ciepYsBPN6Ub04X5V8aRAkJpog==
=SULd
-----END PGP SIGNATURE-----

--D9sZ58tf58331Q5M--
