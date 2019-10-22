Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02ABE0936
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfJVQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:38:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbfJVQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BKcFfApj5RoNNrr6PNcShwRSzBMTqZADkQJDoDqR6ik=; b=VbxtWlr69+jYe4fpFwJUR3x/m
        xF6y8rnYjq2y5yrl4JYSz5aM6gV+LlOxK+Q3HxgUfSVwii3kSkxa8TwPE4z1I0qRCunkheuPrJ2DG
        cI7nUdmZb+r0XO+54Tpeb5HNaPkkmhd+2KLbw7tAX7+uoGjLUB6JCrPUg7m3PXpOJDDKA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxAo-00073r-5r; Tue, 22 Oct 2019 16:38:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AA38F2743259; Tue, 22 Oct 2019 17:38:17 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:38:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 22/46] ARM: pxa: eseries: use gpio lookup for audio
Message-ID: <20191022163817.GS5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-22-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rG09A39trvEtf3rB"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-22-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rG09A39trvEtf3rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:37PM +0200, Arnd Bergmann wrote:
> The three eseries machines have very similar drivers for audio, all
> using the mach/eseries-gpio.h header for finding the gpio numbers.

Acked-by: Mark Brown <broonie@kernel.org>

--rG09A39trvEtf3rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMHgACgkQJNaLcl1U
h9BajAf/VaPUPbuOM5XFe50jUB4C0hAjngOdu3qVFRYIfGYfbBgT1GqUsq1wJUmn
RkRh//A+Sht8MoKnOh4QESjoY9maJv0XU1BQ73dULQRHOVYwuJtlJOd4oKbvkvwb
jdVs5ZvDGbsf6PXnHBC5rqC1P+zBX/CZ8IN3xrJNlS4Z5vNzWj0ALFTiAN528Cxo
qOVAiwLdGdkC56ACLm5xrHDEPaoGMTgWGx9GYV/c71IbeOGjykBWbepnKnK8kH6d
lvggiHydyKe8fb7bTsv6dJEVul14x1DMBg2rWM226ujhoAbY8gt/DHOCT4Jbzc04
X6wwL7joES06ET3LwI91pNukZe8J+Q==
=ldMH
-----END PGP SIGNATURE-----

--rG09A39trvEtf3rB--
