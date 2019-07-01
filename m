Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53965A0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF1Q2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 12:28:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1Q2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oagUdOzzDJxA/KC4tIIlqlVHHrLYjT20K+kSrG+HeFo=; b=YHdyvmCd3UwJWLadUxK1fIDPf
        knbuPeGRkdNzNZNNk/2l8ThczhJRFcy4rt0Y2z37LQrANhtoAyhGeyUMSNRWU6TVmMGm4JLN4eW7H
        KCK5SEllXCo7OEwFo/Ru9L0L5EnXzO0uvr56y8Xu78KbEa5sfkhj5kPTKZFnFJPfUk/w0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hgtjO-00075G-PU; Fri, 28 Jun 2019 16:28:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id F1CCE440053; Fri, 28 Jun 2019 15:36:28 +0100 (BST)
Date:   Fri, 28 Jun 2019 15:36:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
Message-ID: <20190628143628.GJ5379@sirena.org.uk>
References: <20190627131639.6394-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline
In-Reply-To: <20190627131639.6394-1-colin.king@canonical.com>
X-Cookie: You need not be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2019 at 02:16:39PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
> break statement, causing it to fall through to a dev_err message.
> Fix this by adding in the missing break statement.

This doesn't apply against current code, please check and resend.

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0WJewACgkQJNaLcl1U
h9DWSwf/fWJcNMzQ0hbKhW6O4MWjfhdLsKRJMZucvTMjF88x6m0tLqengpmOKGCi
dONoVEtGU8VQ+y+HssN7utIBx01H8e3Hs0/uLhUAkqgTdDc3pXPA9hdwqwLIfd+/
I+fNP2IoaU+mToQuD+JmIB2FEHn4KWyZSa7Z/ioV/bj2/tXMOA4zZzZjuqbFJWfi
Ahiz89WLNBqa6QKQs4JtuFb2nbBqZwOged0TNGRSeQoWN+mwlZiq5w7tjETWdJtz
+8mDkTiqgQAuLL2lf86D9K5tqzNZHLaOJ6Vm7/h5W7F4GVG23uEDsrBZm013ZBTW
lcPPI9loppwvqM1I8YMT9noJFqHHFQ==
=e0rj
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--
