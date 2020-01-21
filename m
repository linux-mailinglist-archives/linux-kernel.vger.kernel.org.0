Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903FB14391E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAUJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUJIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:08:25 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F5A20882;
        Tue, 21 Jan 2020 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597704;
        bh=V/N4fJDuFow+RDfqLPVuw2V+0R91MFUR/t+PMQloXb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/9yZ47/q3p0PhEQaxR5nGPIUsC9W0grdwpmH//oUnfRmSwE/oJlRnHIomBQvU24t
         BIfJppGmOTDGZ1WHvvC9dmji0hbzU91zAO0lRosPwvVyQheFQXaITv/nzQsr1HYRNR
         o1OO29wAsE/eSjbp/bqysGFzr5lkwy4FSi9I7ya4=
Date:   Tue, 21 Jan 2020 10:08:22 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 9/9] arm64: dts: allwinner: pinebook: Fix 5v0 boost
 regulator
Message-ID: <20200121090822.77pjto5xh4hoybej@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-9-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qackdqofuyqe3hmn"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-9-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qackdqofuyqe3hmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:31:04AM -0600, Samuel Holland wrote:
> Now that AXP803 GPIO support is available, we can properly model
> the hardware. Replace the use of GPIO0-LDO with a fixed regulator
> controlled by GPIO0. This boost regulator is used to power the
> (internal and external) USB ports, as well as the speakers.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--qackdqofuyqe3hmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/hgAKCRDj7w1vZxhR
xfofAPYyu4j1NVQCLPclIpVo8s1pk99EUtMOVuQYEBl0ifMZAP9MEShdqJiLf4xw
l8v1MunFWBbjeNlIadaab/Zpxm2VBA==
=qHzz
-----END PGP SIGNATURE-----

--qackdqofuyqe3hmn--
