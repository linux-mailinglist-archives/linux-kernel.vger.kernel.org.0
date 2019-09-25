Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123DDBDCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbfIYLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 07:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfIYLFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:05:24 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB592082F;
        Wed, 25 Sep 2019 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569409523;
        bh=/puB6B6PVKDxmNtkS5LQbtyHN2zHMrrYX7SAlqLe9sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wp8VnmbJnm8bwlyysvBz9wNIDjnZd8LK2RmHB52rb6eQLRXmGXgsE8IZeKZ7pjeys
         a1kY7TiE8A8mvxThlGZTR3n9GahOVvDMCtkQMXjLEzGr6YL3m8zKjfmNt0FefMAl+p
         gpqhM3Eb9aDPKCau92d2cKNWhWnhwGFoVV9NzHks=
Date:   Wed, 25 Sep 2019 13:05:21 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 2/2] crypto: sun4i-ss: enable pm_runtime
Message-ID: <20190925110521.ad3igh3dkhtzl22d@gilmour>
References: <20190924080832.18694-1-clabbe.montjoie@gmail.com>
 <20190924080832.18694-3-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="epxq7jf6b7rjqwnd"
Content-Disposition: inline
In-Reply-To: <20190924080832.18694-3-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--epxq7jf6b7rjqwnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2019 at 10:08:32AM +0200, Corentin Labbe wrote:
> This patch enables power management on the Security System.
> sun4i-ss now depends on PM because it simplify code and prevent some ifdef.
> But this is not a problem since arch maintainer want ARCH_SUNXI to
> depend on PM in the future.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--epxq7jf6b7rjqwnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYtJ8QAKCRDj7w1vZxhR
xbUxAP9Pd7pxZ4HyWKEAjwRXgd0MYbOY1Igq24YqzLBkqoyWgAEAyOOvUiM/YyHN
RXo0PiTmebIKKPZ+S6FfAI3GeLQdEwk=
=/Pb0
-----END PGP SIGNATURE-----

--epxq7jf6b7rjqwnd--
