Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29D513256B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgAGL5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 06:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAGL5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:57:41 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FF2207E0;
        Tue,  7 Jan 2020 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578398260;
        bh=AI+VfAqTa9UCq8IvejkTKMbTJBx1EJ58qhLOA9wGowE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A55wtQnfkltHy8t1jJOI3SXpwJjrT4aTNOuU48IslkaNiRawRyKfRrMyRh5XKdhJP
         jmi9V4548UnWlidEPJux/55Vln5PPtfMHeF2zXnhQS1Pl+sewNtKIUrcKeyzoDMtip
         h2uzk/OjTAIk/DCvrzzPMg4EnDoUndAgwVYCSTNE=
Date:   Tue, 7 Jan 2020 12:57:37 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: use PTR_ERR_OR_ZERO macro.
Message-ID: <20200107115737.ybaxsjyvfaledfje@gilmour>
References: <20200106140052.30747-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yo7cidopzvqnu2id"
Content-Disposition: inline
In-Reply-To: <20200106140052.30747-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yo7cidopzvqnu2id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jan 06, 2020 at 05:00:52PM +0300, Wambui Karuga wrote:
> Replace the use of IS_ERR and PTR_ZERO macros by returning the
> PTR_ERR_OR_ZERO macro.
> Changes suggested by coccinelle.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Unfortunately, that patch came up a number of time and shouldn't have
been a coccinelle script in the first place.

I've sent a patch to remove that script:
https://lore.kernel.org/lkml/20200107073629.325249-1-maxime@cerno.tech/

Maxime

--yo7cidopzvqnu2id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhRyIwAKCRDj7w1vZxhR
xYDqAP4n1dm9IQoXmI7Bx40vuU1hQtG4nyx+pIljTVCbkWCjFQD9G8aJvCqjVRId
JX/7qRsTP2Iifrmf5iMSo3e4cGz8NwA=
=ilwZ
-----END PGP SIGNATURE-----

--yo7cidopzvqnu2id--
