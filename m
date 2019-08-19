Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B092569
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHSNpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHSNpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:45:02 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A882082C;
        Mon, 19 Aug 2019 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566222302;
        bh=7s+QAxWZgZe7HRkO1x02uj1NiJnc7PUsEVk5JR96e28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGp/YMZtzX9YLBWtpC+C5a8zm1QMGR8zibIrX4pb7X41iQPIP4iA7uQyPkCJXnQbv
         xfCkWQHkKEdw6T8xIyMkpwkEqsMNw8eqji6wRXF3lBKko5c0SQUx9f64WmJTcI9qLs
         2zrjD6TudyOAnzxxGZaWsSiVzGLGc531zvEC0v0U=
Date:   Mon, 19 Aug 2019 15:44:59 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce Tanix TX6 box DT
Message-ID: <20190819134459.vgqaxekwkj423pyk@flea>
References: <20190816205342.29552-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="czkf5do6ez7nazvr"
Content-Disposition: inline
In-Reply-To: <20190816205342.29552-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czkf5do6ez7nazvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 10:53:40PM +0200, Jernej Skrabec wrote:
> This series adds support for Tanix TX6 box:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 4GiB DDR3 RAM (3GiB useable)
> - 100Mbps EMAC via AC200 EPHY
> - Cdtech 47822BS Wifi/BT
> - 2x USB 2.0 Host and 1x USB 3.0 Host
> - HDMI port
> - IR receiver
> - 64GiB eMMC
> - 5V/2A DC power supply
>
> Patch 1 adds compatible strings to dt bindings documentation.
>
> Patch 2 adds Tanix TX6 DT.

Applied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--czkf5do6ez7nazvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVqn2wAKCRDj7w1vZxhR
xVyBAPoCHTWn7mwS2Vjc+4SW3htnMaF+Tsx7LHIOKuzGpyPjigEAyA75QveVmE7q
ryci36c243oW6/wVymR/Yj730Z2otw0=
=nYs9
-----END PGP SIGNATURE-----

--czkf5do6ez7nazvr--
