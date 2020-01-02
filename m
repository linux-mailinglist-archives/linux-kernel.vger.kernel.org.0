Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E412E473
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 10:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgABJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 04:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgABJb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:31:59 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE36217F4;
        Thu,  2 Jan 2020 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577957519;
        bh=z7XbupEIA871TaOOa9+yiI0sdqgjfYz8rikslwugDPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubsJsZ17xJUrhg1PKhxQTkfB5sALfgzZl8fOri0JDQjveIQDoWt3nI2j5l7jMjldx
         v47TqhJihiPYqmgocaKNrG/HqR4EFN5/N6Fwbh6oGjztirkdCNJAOT/dIfsvo+zCSi
         Bi1bjxYxiwUsa2sSd3AMa6fzz57A8Ct77ack0AcI=
Date:   Thu, 2 Jan 2020 10:31:56 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 1/3] ARM: dts: sun8i: R40: Upgrade GICC reg size to 8K
Message-ID: <20200102093156.wrcuqxwbfs2vmwof@gilmour.lan>
References: <20200102012657.9278-1-andre.przywara@arm.com>
 <20200102012657.9278-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mnyeiclhklvtj5r"
Content-Disposition: inline
In-Reply-To: <20200102012657.9278-2-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mnyeiclhklvtj5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2020 at 01:26:55AM +0000, Andre Przywara wrote:
> The GIC used in the R40 SoC is an ARM GIC-400 with virtualization support,
> so let's advertise the full 8K region of the GICC MMIO frame to enable
> KVM's usage of the GIC (as we do already for all other SoCs).
>
> Tested by running KVM on a Bananapi M2 Berry.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks!
Maxime

--2mnyeiclhklvtj5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg24jAAKCRDj7w1vZxhR
xUQbAQClk/beo71p82R7czCIU5RsEyXUGoVfxFTJLmi4mlFOtgD9EYpUhFz6weme
ZRkbXJRgAgmcJQqGp60CsXc/CLTcrg8=
=whv3
-----END PGP SIGNATURE-----

--2mnyeiclhklvtj5r--
