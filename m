Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05299E460
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfH0Jed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 05:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfH0Jec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:34:32 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DD8217F5;
        Tue, 27 Aug 2019 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566898471;
        bh=ccm7nUqPvgOcQuTQ/JJPGjonenSfitNN8svivPYeMTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwKJsmjYOsgBrhTnTDNEZ0KVRtYoP7/0SLNj3Ze7UGB0xbuK0zNIHNCNCjCc26MUw
         tpwE5Dhiyj2Z28Q8YtSBvgO7zVVL3uvrD3ojHixwE+ssGC0yP5LDGMr6DJpPIG3AKS
         CH1lM4k+cFEDp6OGLIVHak/oht0VNcJAbecWgyb8=
Date:   Tue, 27 Aug 2019 11:34:29 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v6 2/3] ASoC: sun4i-i2s: Add regmap field to sign extend
 sample
Message-ID: <20190827093429.fkh4cqbygxxyvkk3@flea>
References: <20190826180734.15801-1-codekipper@gmail.com>
 <20190826180734.15801-3-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akegy5smhxynsxc7"
Content-Disposition: inline
In-Reply-To: <20190826180734.15801-3-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--akegy5smhxynsxc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 08:07:33PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>
> This isn't a problem whilst we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

If anything, I'd like to have less regmap_fields rather than more of
them. This is pretty easy to add to one of the callbacks, especially
since the field itself has been completely reworked from one
generation to the other.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--akegy5smhxynsxc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWT5JQAKCRDj7w1vZxhR
xe50AQC8TXvNs/xG05yTE5nduFlJSviusolNw2OzT+nU7+RGNQEAnLeDCfdAFcFV
+5qESFVCyahAR0NhHqHtWgxldOTPwgw=
=hUzD
-----END PGP SIGNATURE-----

--akegy5smhxynsxc7--
