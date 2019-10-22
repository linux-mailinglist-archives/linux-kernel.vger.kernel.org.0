Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB9E0937
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfJVQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:38:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34244 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfJVQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bsylmx/HNBO7oRMVXVNwiEyRC4cckwd84bjAM8mOb0k=; b=tvMimewQkFDL1nlGaO6PkBOA9
        Uz7PsgZsauauop8auYsA+ghDMICgo2GT8QSnMV8A8V9+ieTunlHA+7J23r62K6HvzUsmO3lkD7Fzq
        b8iU+yUyOvY2SUgQlWyNhKtR45P6HZSX0S9MMuW/jKwjP/Ct7+R6gr8L85x3g5wwLrv7A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxB2-000742-Ce; Tue, 22 Oct 2019 16:38:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DC3042743259; Tue, 22 Oct 2019 17:38:31 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:38:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 23/46] ARM: pxa: z2: use gpio lookup for audio device
Message-ID: <20191022163831.GT5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-23-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EmW68jKGQIhj8inv"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-23-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EmW68jKGQIhj8inv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:38PM +0200, Arnd Bergmann wrote:
> The audio device is allocated by the audio driver, and it uses a gpio
> number from the mach/z2.h header file.

Acked-by: Mark Brown <broonie@kernel.org>

--EmW68jKGQIhj8inv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMIcACgkQJNaLcl1U
h9AZ6wf+NeOxr9MNvwixJZADUIwYW+QadpN3eAfqqY58BvEqVnkDjruFpIZbmXSC
VEjT32396OacS57CequHpHFX0DpuykmnBIetGlt/lPUczLOUOwtyyHXwM9wOhGr1
cBB14AbepdJGFcFpyZtM340gSCawyWqZUbp6p0TH63HoYzcO3CL4kIB8dJWOhC+j
2bYM8XBRhlBqqVv052oG7xP6IwZS99me4hkg3nnCcAFc5lR3nfg7QUaKN1O+Nh8g
UdVkFvIhdkOS3r31q6AmAnDKPYAhN432virDNtx7ySFB0T3meatGmMRT+c1aHTRN
9t3W9zkNbk+Ec0xQcDT8f9dJkriSSg==
=AnlZ
-----END PGP SIGNATURE-----

--EmW68jKGQIhj8inv--
