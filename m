Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C643220155
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEPIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 04:31:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53567 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:31:12 -0400
X-Originating-IP: 80.215.246.107
Received: from localhost (unknown [80.215.246.107])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6532D20003;
        Thu, 16 May 2019 08:31:05 +0000 (UTC)
Date:   Thu, 16 May 2019 10:31:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] drm/sun4i: Fix sun8i HDMI PHY initialization
Message-ID: <20190516083104.rr2ewg3dd4aej67b@flea>
References: <20190514204337.11068-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nxc66wpttvnorf5q"
Content-Disposition: inline
In-Reply-To: <20190514204337.11068-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nxc66wpttvnorf5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 10:43:35PM +0200, Jernej Skrabec wrote:
> I received a report that 4K resolution doesn't work if U-Boot video
> driver is disabled. It turns out that HDMI PHY clock driver was
> initialized prematurely, before reset line was deasserted and clocks
> enabled. U-Boot video driver masked the issue because it set pixel
> clock correctly.
>
> In the process of researching the bug, I also found out that few bits
> in HDMI PHY registers were not set correctly. While there is no
> noticeable change (4K resolution works with both settings), I've
> added fix anyway, to be conformant with vendor documentation.

Applied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nxc66wpttvnorf5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0fyAAKCRDj7w1vZxhR
xUAXAP9xICklXvpieTeqdcZC4XE/+a2QALTSkxog1dIwU2z9hgEA9W1tdHngDaMj
jYInZNsuhpQY0H7zxkIQTeX7MeX2Ogs=
=TN7Y
-----END PGP SIGNATURE-----

--nxc66wpttvnorf5q--
