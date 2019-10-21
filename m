Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B62DEA72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfJULJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 07:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfJULJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:09:50 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC302206C2;
        Mon, 21 Oct 2019 11:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571656189;
        bh=3tGyLnRu5V+1lH+Ll8Ur/m9/FJeaK074rwaJRpkHO5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKoe/9B429mheTKTi5QgSOptvY37IUxuEzhlKdj8OOpRR71TeCPMBzSQVH2wr8tMn
         627KrX1KKFNGqVrWevkhBmp+XildRYXcozhMXLj3DkZhVrzfiobl0vH0tnevaYMwVQ
         pk6FMnIwOZ4pxMtD6AwQZ9FC8rihThFaauVPlIUE=
Date:   Mon, 21 Oct 2019 13:09:46 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     megous@megous.com
Cc:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: orange-pi-3: Enable USB 3.0
 host support
Message-ID: <20191021110946.gxmib3to7n7v2vof@gilmour>
References: <20191020134229.1216351-1-megous@megous.com>
 <20191020134229.1216351-5-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w4fbeowpggjvqztj"
Content-Disposition: inline
In-Reply-To: <20191020134229.1216351-5-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4fbeowpggjvqztj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 20, 2019 at 03:42:29PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Enable Allwinner's USB 3.0 phy and the host controller. Orange Pi 3
> board has GL3510 USB 3.0 4-port hub connected to the SoC's USB 3.0
> port. All four ports are exposed via USB3-A connectors. VBUS is
> always on, since it's powered directly from DCIN (VCC-5V) and
> not switchable.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Those last two patches are fine with me, I'll merge them once the phy
driver will be merged.

Maxime

--w4fbeowpggjvqztj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXa2R+gAKCRDj7w1vZxhR
xfNsAQCCC1sgS5gZhICtsezIsL40SwcFqJ7uiTtlTkak8UZExgEAq65tLkT+Xmn6
J12MqeTnjfEE6VZ7LKlcv3VYjv3TCQA=
=1SeF
-----END PGP SIGNATURE-----

--w4fbeowpggjvqztj--
