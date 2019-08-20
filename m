Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21995937
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfHTIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 04:15:32 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56125 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfHTIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:15:31 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 22DCE20014;
        Tue, 20 Aug 2019 08:15:28 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:15:28 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 05/10] ARM: dts: sunxi: a80: Add msgbox node
Message-ID: <20190820081528.7g2lo4njkut5lanu@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n7o7wh4zuzytmrq3"
Content-Disposition: inline
In-Reply-To: <20190820032311.6506-6-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n7o7wh4zuzytmrq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 19, 2019 at 10:23:06PM -0500, Samuel Holland wrote:
> The A80 SoC contains a message box that can be used to send messages and
> interrupts back and forth between the ARM application CPUs and the ARISC
> coprocessor. Add a device tree node for it.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

I think you mentionned that crust has been tested only on the A64 and
the H3/H5, did you test the mailbox on those other SoCs as well?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n7o7wh4zuzytmrq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVusIAAKCRDj7w1vZxhR
xZl6AQD8HGD9lLlZE5lpRO3rM9AAsJfuguGezD9voRojBbNOIQEAuL3z63gP4FU6
hU8YYXOnQQtNXzykQSVqaknuOE/AxwY=
=SehN
-----END PGP SIGNATURE-----

--n7o7wh4zuzytmrq3--
