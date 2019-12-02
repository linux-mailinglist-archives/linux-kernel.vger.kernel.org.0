Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E387E10EFE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfLBTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 14:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfLBTQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:16:33 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493AF214AF;
        Mon,  2 Dec 2019 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575314192;
        bh=a6t1Y8SGT7pSf3rULBWUhEZkTYHWD3R+C5WYp9Mtkqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2Qw9kdE+gwwP5bF0EJCih5sClV0MRDEfGH2vmu0pZD+l+jrBimZsJuztk5/991Ly
         O251kVtz1NxT0EIr05Rf7TdQP5wwUdFeh5vB9/ZrhbT5HMZVijUUorG7SIdjYGMxnS
         rQZ1PdHUKNI9lPCYhEjoGJ8ApOJ87xvVy1RrJ8pU=
Date:   Mon, 2 Dec 2019 20:16:30 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: olinuxino: Add bank
 supply regulators
Message-ID: <20191202191630.55itysenwpxdrhfj@gilmour.lan>
References: <20191129113941.20170-1-stefan@olimex.com>
 <20191129113941.20170-3-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e67e634t6wlkd7vk"
Content-Disposition: inline
In-Reply-To: <20191129113941.20170-3-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e67e634t6wlkd7vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2019 at 01:39:40PM +0200, Stefan Mavrodiev wrote:
> Allwinner A64 SoC has separate supplies for PC, PD, PE, PG and PL. This
> patch adds regulators for them to the pinctrl node.
>
> Exception is PL which is used by the RSB bus. To avoid circular
> dependencies, VCC-PL is omitted.
>
> On boards with eMMC, VCC-PC is supplied by ELDO1, instead of DCDC1.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Queued for 5.6, thanks!
Maxime

--e67e634t6wlkd7vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXeVjDgAKCRDj7w1vZxhR
xS4NAQDZhesDivpERrXEzobJO+Q/JbNqNrZlcfOynVfPsfUvkAEAiDtcDNlVg4f3
Bw029YZyhs6d/m38NqQXo2VJx6QRDwg=
=6lca
-----END PGP SIGNATURE-----

--e67e634t6wlkd7vk--
