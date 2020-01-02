Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95012E4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 11:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgABKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 05:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgABKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:08:36 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB4020866;
        Thu,  2 Jan 2020 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577959715;
        bh=x+kRT2D1Kn7Lf5nh9cGLkMkzex1mV1+rt2WXH85GIi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcZ1gTpS9ZvXDi5jA7DNk42YY4dfQY3uFvtZSH2ldAvzg3sN5DkND5yikXFrXrilf
         u7+WxXig3U6Hsn0lVM/SpchgomNPm5q/PDKX0Nz8JE76d7i9AXfIDxawh1z+WtzFLh
         7jpbHCGZPpfvOtRr9TGddKUETlpqoBTc+hlhOY2Y=
Date:   Thu, 2 Jan 2020 11:08:32 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     roman.stratiienko@globallogic.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: Re: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane
 size as mixer frame.
Message-ID: <20200102100832.c5fc4imjdmr7otam@gilmour.lan>
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
 <20200101204750.50541-2-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eij2leiodiz6sky6"
Content-Disposition: inline
In-Reply-To: <20200101204750.50541-2-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eij2leiodiz6sky6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jan 01, 2020 at 10:47:50PM +0200, roman.stratiienko@globallogic.com wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>
> According to DRM documentation the only difference between PRIMARY
> and OVERLAY plane is that each CRTC must have PRIMARY plane and
> OVERLAY are optional.
>
> Allow PRIMARY plane to have dimension different from full-screen.
>
> Fixes: 5bb5f5dafa1a ("drm/sun4i: Reorganize UI layer code in DE2")
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

So it applies to all the 4 patches you've sent, but this lacks some
context.

There's a few questions that should be answered here:
  - Which situation is it fixing?
  - What tool / userspace stack is it fixing?
  - What happens with your fix? Do you set the plane at coordinates
    0,0 (meaning you'll crop the top-lef corner), do you center it? If
    the plane is smaller than the CTRC size, what is set on the edges?

Thanks!
Maxime

--eij2leiodiz6sky6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg3BIAAKCRDj7w1vZxhR
xRAgAP9QwzO6tt8HxHevGLJBWJuDC9qBUkk3iJWXTPHclJfsRwEA+VsyeUKuAxRL
/ZAvWo9lYy6wvymqssndD03TUld2Pwc=
=T74d
-----END PGP SIGNATURE-----

--eij2leiodiz6sky6--
