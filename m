Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8EAD8A75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391437AbfJPIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfJPIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:04:23 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CAA12168B;
        Wed, 16 Oct 2019 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571213063;
        bh=rReuVb132ii3iV3YvU4PNL9utgLRGUbc4m/9hSBbvoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKslahbuYYEfHHiHvt1LJUtrJWPfqhT+U1un2c0j+oyJD91TSdrEHjpXKqUUdPIJJ
         mgavniH/wVMdLjNQLohrfunzsw+5485YLEid7Go0xRWtGD7O6wnaocKqQUEKalZxdD
         IBQ8K1DJ/CSH4iz7+Qrrmxnjfi0bKsbH9cBkhfAM=
Date:   Wed, 16 Oct 2019 10:04:20 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel select offset
Message-ID: <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-2-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ms26mvxh6nbjd52"
Content-Disposition: inline
In-Reply-To: <20191016070740.121435-2-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ms26mvxh6nbjd52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs the offset is used to set the mode of the
> connection. As it is to be used elsewhere then it makes sense
> to move it to the main structure.

Elsewhere where, and to do what?

Maxime

--7ms26mvxh6nbjd52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXabPBAAKCRDj7w1vZxhR
xWfVAP9ZDeCUM6YB6ieMATn24AtmYaqNFpUuWyfe7WmRM0R1qAEAkXYiT7NBO4dm
xSC0H+a6BM1oFgGWjOiNULlLMAySTQ4=
=HbkX
-----END PGP SIGNATURE-----

--7ms26mvxh6nbjd52--
