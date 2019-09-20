Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA3B8AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394820AbfITGUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 02:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394810AbfITGUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:20:23 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F354C20882;
        Fri, 20 Sep 2019 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568960422;
        bh=3T4MBrrvAFoM5nVfdPzS+xVdO3QHAnjJT4ytFIM+Gzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT2ka4Nr4v3hC4nSuZb/06NB6lhQVzdlxhnSSPfNNayqKve2YzN4WH4VeVKY4W0Gc
         fNAtOezhXRjHaXQ9apdMWD0/JySkkD1/VPZW1ifChgNla8HItF8DsQmmqsWo9980Kh
         JcNFloX/JArYE27T3xdjnJuWgm8H+OkvFQdwaDLQ=
Date:   Fri, 20 Sep 2019 08:20:20 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
Message-ID: <20190920062020.zyt5ng6cxtu6muye@gilmour>
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
 <9229663.7SG9YZCNdo@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyakblbkkxwj5w7k"
Content-Disposition: inline
In-Reply-To: <9229663.7SG9YZCNdo@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyakblbkkxwj5w7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 08:53:10PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 18. september 2019 ob 13:05:41 CEST je
> roman.stratiienko@globallogic.com napisal(a):
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > According to Allwinner DE2.0 Specification REV 1.0, vi layer supports t=
he
> > following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888
>
> It's true that DE2 VI layers support those formats, but it wouldn't change
> anything because alpha blending is not supported by those planes. These
> formats were deliberately left out because their counterparts without alp=
ha
> exist, for example ABGR8888 <-> XBGR8888. It would also confuse user, whi=
ch
> would expect that alpha blending works if format with alpha channel is
> selected.

I'm not too familiar with the DE2 code, but why is alpha not working
if the VI planes support formats with alpha?

Thanks!
Maxime

--jyakblbkkxwj5w7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYRvowAKCRDj7w1vZxhR
xRW4AP91J8qXurWjaYEIlShut/9F1o+AH+QFka253dVyQ1XzmQD9GKVxtyQFNqro
T6dUZ4eM7nZmoFWRwll07iRaM6lFVQM=
=cHIh
-----END PGP SIGNATURE-----

--jyakblbkkxwj5w7k--
