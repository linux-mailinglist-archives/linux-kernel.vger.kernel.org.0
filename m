Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8833E14392B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAUJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgAUJK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:10:29 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AE320882;
        Tue, 21 Jan 2020 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597828;
        bh=oS2a0PPe6kpJPi7wDz0yMJ3mDjuHWrwzkwKrrR93Xr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFz9va9wlhCk5yN2JM6uwXVmE5ZUaPoSTQHNcRAe3qJjq79P9eXtNvwvbardESNFt
         Y+1AVBzXwwnt80j5FRRCSBycIoiTNaXHNAntaM4g8iUR55LHYvVHWp0v9WGrHVoPue
         vvHJ80G/cxYcaV6guJb4n+rabSaTDP6cSwvcB/6A=
Date:   Tue, 21 Jan 2020 10:10:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64: Add gpio bank supply for
 A64-Olinuxino
Message-ID: <20200121091026.qfj2fv47f24wt2tp@gilmour.lan>
References: <20200118152459.17199-1-manu@FreeBSD.Org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qkyp7mkzww2atmw"
Content-Disposition: inline
In-Reply-To: <20200118152459.17199-1-manu@FreeBSD.Org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qkyp7mkzww2atmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jan 18, 2020 at 04:24:59PM +0100, Emmanuel Vadot wrote:
> From: Emmanuel Vadot <manu@freebsd.org>
>
> Add the regulators for each bank on this boards.
> For VCC-PL only add a comment on what regulator is used. We cannot add
> the property without causing a circular dependency as the PL pins are
> used to talk to the PMIC.
>
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

It seems that you sent it twice?

I applied the second. It was not applying properly though, make sure
to base your patches on next.

Maxime

--2qkyp7mkzww2atmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXibAAgAKCRDj7w1vZxhR
xTKtAQCXbI0+R1FPufKESo54exnXgFUfT1peFCWKaDwD+UdsIgD/aaiSWB+xMRBa
tZKKbksmnRwe+WWrnbIGWf1XgYjtnAc=
=UeLO
-----END PGP SIGNATURE-----

--2qkyp7mkzww2atmw--
