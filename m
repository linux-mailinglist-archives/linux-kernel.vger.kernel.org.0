Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E1EC0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 10:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKAJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 05:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKAJl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:41:57 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5BE217D9;
        Fri,  1 Nov 2019 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572601316;
        bh=tEMJDPD00qXngI6LNp82zMonWmqPFzQMshTm9haaMwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4LcTFQcq15Pdfx0F4HWMJvnLB9+5sFUyNt+YnR3X/x9KnMu3CsmsYaFhvIvHfVED
         J7Llp+Sn66+amL0hdii5JbGnqB3Zv7R+ITTvwid8t300uB5t/fPDHAKx9O1vx/NQeZ
         3e+Lwrj/tcrsBG5d1cOJki/zekq7lS/AT5PzyRjM=
Date:   Fri, 1 Nov 2019 10:05:41 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts
 pins
Message-ID: <20191101090541.y356ypmhanin3b5p@hendrix>
References: <20191031231104.30725-1-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4gbx4puw3y3iu37l"
Content-Disposition: inline
In-Reply-To: <20191031231104.30725-1-karlp@tweak.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4gbx4puw3y3iu37l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 11:11:02PM +0000, Karl Palsson wrote:
> uart1 and uart3 had existing pin definitions for the rts/cts pairs.
> Add definitions for uart2 as well.
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>

Applied, thanks!
Maxime

--4gbx4puw3y3iu37l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbv1ZQAKCRDj7w1vZxhR
xd40AQDPwX5hGxm0kGpRus9G/8bkcIVDkTuXYQklkfz7XM6+/wEA+kFUT6fxMRzD
KMKiaMvuxl/UINB+1nYB7yRZi4THnAQ=
=cI1M
-----END PGP SIGNATURE-----

--4gbx4puw3y3iu37l--
