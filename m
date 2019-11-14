Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F84FCEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 20:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 14:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfKNT13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:27:29 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE1120725;
        Thu, 14 Nov 2019 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573759649;
        bh=tlPXQr9K0JHcO9hjmUxoCvQEtHBTWA1pDKjwjzUu/S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4MqYahsoAugDXrOcIbK0SghUV0BJpL74XNPnwi9gGFRl/NvKf7OmYraXPE7m8btL
         1bX2nsJcJFr8Rw9jTf3aLwf3/gDYESm+Kb0ziXquV/nuPP4EHDdnfaz//z8/Y8fEgw
         cwbBbQD99JPc3Z67N/+MoASCdjiMllV6Tq4eBWsI=
Date:   Thu, 14 Nov 2019 20:27:25 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 0/2] ARM64: dts: allwinner: Add devicetree for pineH64
 modelB
Message-ID: <20191114192725.GX4345@gilmour.lan>
References: <1573746453-5123-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JVdfu60Euw8Ey+/T"
Content-Disposition: inline
In-Reply-To: <1573746453-5123-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JVdfu60Euw8Ey+/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 14, 2019 at 03:47:31PM +0000, Corentin Labbe wrote:
> Hello
>
> Pineh64 have two existing model (A and B) with some hardware difference and
> so need two different DT file.
> But the current situation has only one file for both.
> This serie fix this situation by being more clear on which DT file is
> needed for both model.

sorry I didn't tell you on v1, the prefix for arm64 is lowercase
(unlike arm where it's uppercase).

I've fixed it while applying, thanks!
Maxime
--JVdfu60Euw8Ey+/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXc2qnQAKCRDj7w1vZxhR
xSWVAQCBPr2s0WW9ArMBn4OEKu8Q5C7BaeyG22Vq1rN5Z8PwVgEA533j7d1rP19K
sGwHnhtbWexfClKTTe+6B1qfHaK5jwo=
=AIGJ
-----END PGP SIGNATURE-----

--JVdfu60Euw8Ey+/T--
