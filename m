Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6491183EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLJJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfLJJr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:47:59 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F862077B;
        Tue, 10 Dec 2019 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575971278;
        bh=D4AC6P6Yy74InbEmSTYhO16RbW/RiPQChSmnYv+Qaq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vktHRO0e7gXqk1Cy7zrhdmFFm+miqbXodEdCmeveI1ZF8MeIaUyXfeU3MAyn5pQg
         DUkVAsDkFI1BrFoYBj1FKxuWnzv+ApvUKWb7+wO/5SQn6uOHnmbp6+pWLXkZHlheFw
         gEogYU9//1tyUNF90Dyld+NS/celYATgequ9sWCQ=
Date:   Tue, 10 Dec 2019 10:47:56 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        georgii.staroselskii@emlid.com, aleksandr.aleksandrov@emlid.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: restore hdmi_con_in node
Message-ID: <20191210094756.izblh6jotzrozazt@gilmour.lan>
References: <1575970087-11667-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3ytm4gh3zbiiwst"
Content-Disposition: inline
In-Reply-To: <1575970087-11667-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3ytm4gh3zbiiwst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 09:28:07AM +0000, Corentin Labbe wrote:
> Compiling today next (20191210) fail to build with
> arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts:53.25-55.4: ERROR (phandle_references): /soc/hdmi@1ee0000/ports/port@1/endpoint: Reference to non-existent node or label "hdmi_con_in"
>
> This patch fixes the build by restoring this node.
>
> Fixes: b120a822ef10 ("ARM: dts: allwinner: Split out non-SoC specific parts of Neutis N5")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

I've squashed it into that patch, thanks!
Maxime

--v3ytm4gh3zbiiwst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXe9pzAAKCRDj7w1vZxhR
xbrgAP466fwwI4Z5SDYusy+EmYVr/WTP7aRe6IEUFCWGYiH/0wD/ZXIjO8PPhwRS
nd4miSulZvCk+n6lo+7jmb8pc/Ahwwk=
=MiLv
-----END PGP SIGNATURE-----

--v3ytm4gh3zbiiwst--
