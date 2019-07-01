Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2114B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEFNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:49:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I9EiUjZlbYKmooOFJUET9HVO4ocU1gDF+rwLUJaLGx8=; b=IpcmFoi3IrhULEHGeRD7blImW
        YiKOp6ScN0OaVEqHyJZwEtdSZv7ONiqBHdwFF5mwV3p9W7HWjJPLZwYkcnum4sf1LqcOko2CujeVw
        ItzPS1eVBnk4B2vLOsTYbTBILiY20VSV6ryN0ux2dEiWp58G7rqhrzbbcnt7BI4MmLkWg=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNdzK-0001ii-60; Mon, 06 May 2019 13:49:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2481744000C; Mon,  6 May 2019 14:48:56 +0100 (BST)
Date:   Mon, 6 May 2019 22:48:56 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: Applied "ASoC: sprd: Add reserved DMA memory support" to the
 asoc tree
Message-ID: <20190506134856.GP14916@sirena.org.uk>
References: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
 <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
 <CAMz4kuLK_XS93Wpq+BkXVAJA3M+vFnL8pR0gR7aRpYxBzwLv9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s33OSBZCP+C8M/FY"
Content-Disposition: inline
In-Reply-To: <CAMz4kuLK_XS93Wpq+BkXVAJA3M+vFnL8pR0gR7aRpYxBzwLv9w@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s33OSBZCP+C8M/FY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 03:37:39PM +0800, Baolin Wang wrote:

> I did not find this patch in your sound git tree and the linux-next
> tree, so could you check if you missed this patch? Or did I miss
> anything? Thanks a lot.

Something seems to have gone wrong at some point which caused some
patches to go AWOL, not sure what.  I thought I'd caught all of them but
I guess not this one, I restored it now.

--s33OSBZCP+C8M/FY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQO0cACgkQJNaLcl1U
h9DxWwf/Z4m9LSBTKOW0ZcozXoq+zc8N1up5BJlh6maPOLrNHFrLRSNN70sdMwzu
KsGvHfwhVyXjm9iS0c7cCo08wFeiez/RvVdDNqi3GIiNg7YfmnyJeyca59Fz23EC
9oJFIRnOYAzQ/jb/2MbrnimwVVEvyo1gGwWa0Hge5nR/Y8kxN3S0GptO6UQGbYqb
V6CiaramWldvBYJ+qvp2Sl55gty02bYy9ZXIU+3c/a9f6bMK/UNl8e7suhAEmTtS
5kXaB27gDIFbBqX34uYtB7LAZ0sv7aIwDlmT7U/ijB4c2DH7I4YGNzmP4k9+3CUm
ayYVK3lDdxGhLOQLOaTLfP4T4b6zVQ==
=2eW6
-----END PGP SIGNATURE-----

--s33OSBZCP+C8M/FY--
