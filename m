Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34DC17495
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEHJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 05:08:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Aib6HTiLuLq3IOQEcLw5qxrpTVa/aIw58NppbNDNzU=; b=Mfclx3ovQKJk5LB9wMJbRMZPY
        vQdOOMJbXKNQAqsBlgHOkOFw5aO6gdCR8qVWhf5R4nEYHiVRtxkn0lWmOm2RcYCM81y5nylHXXO16
        22aa/t1UOmAuPxOEvryBR2UuNsDXcD5mm4E+vsHUUwZxITuYK1o2PiU7ztkAQ9ZJv9kbE=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIYh-0007fu-GV; Wed, 08 May 2019 09:08:17 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 978A9440010; Wed,  8 May 2019 10:07:44 +0100 (BST)
Date:   Wed, 8 May 2019 18:07:44 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] sound: soc-acpi: fix implicit header use of
 module.h/export.h
Message-ID: <20190508090744.GH14916@sirena.org.uk>
References: <1555168518-15287-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tWM9UXbZ96wBxVrF"
Content-Disposition: inline
In-Reply-To: <1555168518-15287-1-git-send-email-paul.gortmaker@windriver.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tWM9UXbZ96wBxVrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 13, 2019 at 11:15:18AM -0400, Paul Gortmaker wrote:
> This file is implicitly relying on an instance of including
> module.h from <linux/acpi.h>.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--tWM9UXbZ96wBxVrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSnF8ACgkQJNaLcl1U
h9CcZwf/SJDxYk/RhEeQvuk6luA2tLFhaUGBULpMDQGXhLfUZxlIvxdj+0jPLOCf
EgUPL5dsbxgCINxlOh364cUO+2cWkcnaOofIxyqxeRClje6weZv6KNaoy2cUA/Ki
yUXKV2NRGRU8aVAtCEyzFsQkMRAlub6HTG+reEg2lpOnsj0+vIMah+MuEayAH62H
cM4jRVhKZ181zgi8P5Njzd5e4XRRRHUwaZqoV0SrrscBzPN2jK1bGJCC3e7EDDLz
fEImdwhFWkV9yiPbo6rcC2wF49cEMsT10ZTQuC2LNtLq+I9n0TCyJpnCbxY7O6qO
mZ4shgw9xL0Yyk9GlNV5St278WWiuA==
=1Sdv
-----END PGP SIGNATURE-----

--tWM9UXbZ96wBxVrF--
