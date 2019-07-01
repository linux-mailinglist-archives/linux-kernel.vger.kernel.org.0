Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA444826D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfFQM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 08:29:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfFQM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Si8xIwmDMrAT8HXNiwXvhIHU0hreznP4YCiiLf9PZho=; b=m0dfZJr2CkMDRBJCgmiqfO17q
        dK1d5TQRmkt9QT/kcvPkrhHKHmJHQgFPTp7sYviIo8guDXGQCjgbN9SyPAR3SwwKTPzmpWsNzl1kO
        cXQPKY6b90IdQCOlG8kEHuyR3guRkbWnwQE+ADaYTVPG5ToBmaLIn2WtRP2T/Hv5KNSLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcqlS-0001at-LD; Mon, 17 Jun 2019 12:29:34 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 33A7B440046; Mon, 17 Jun 2019 13:29:34 +0100 (BST)
Date:   Mon, 17 Jun 2019 13:29:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] driver core: regmap: Switch to bitmap_zalloc()
Message-ID: <20190617122934.GQ5316@sirena.org.uk>
References: <20190617115403.33241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2VmY8g3XFtK+hx8d"
Content-Disposition: inline
In-Reply-To: <20190617115403.33241-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2VmY8g3XFtK+hx8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 02:54:03PM +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--2VmY8g3XFtK+hx8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hh60ACgkQJNaLcl1U
h9A3+gf/dhDyB0ENXPq2rau8Fw+LxFWczxrWyFPda+bkb/AgAIAZm6CQOic08heH
KYlmngkyFnmCihwkZMKa3yAfGh6qa191tZ9jqRoS8K6CjPYacXjh2YoLTS1kHtlL
LuY0i6ZbHlEUGkaH/vn5zoo1upXo+PQmmfZ8kwWcd90UVLd/LhBGwBGL3me92ZUm
gauVvmsqRq64b9sbJiEFynXAKQqjXvjTGnOdCTP8USoNr9k3c+bpJne1xzLBmlVs
yady6unZioC+JkHMINeTEbZc/c5WdAJb1GsnYW57k7rZpTMQBPgDi77T2qqfWo+I
prfhvTFX9kxPz6wKe10xxLIvj1ubIg==
=biwi
-----END PGP SIGNATURE-----

--2VmY8g3XFtK+hx8d--
