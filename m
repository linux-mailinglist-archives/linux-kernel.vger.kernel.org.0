Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F3A71AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfICR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:29:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vPOV2xwpaRhp0OMl1Ga/s7x5wzmL8WG9D2hn+PwaTs8=; b=i32rHdvmlzW0spU4KU2ob0FEP
        xZi0E6SIkJkRqIhsQt8J3l5MBedhNdrVGCRqSGq/ymrk4OsRpAIyxCvZqrc8feD3NvFz78ohTxlr4
        HEe0gLTgCn8k3yfVRkxPq7U6pTYp3P9ii76PtpNjTCJCutoF7JceoA9LbDpNmot64KhDc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5CcY-0000rp-8E; Tue, 03 Sep 2019 17:29:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 408CB2740A97; Tue,  3 Sep 2019 18:29:33 +0100 (BST)
Date:   Tue, 3 Sep 2019 18:29:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ASoC: es8316: support fixed clock rate
Message-ID: <20190903172933.GC7916@sirena.co.uk>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903165322.20791-3-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <20190903165322.20791-3-katsuhiro@katsuster.net>
X-Cookie: You will pass away very quickly.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 01:53:21AM +0900, Katsuhiro Suzuki wrote:
> This patch supports some type of machine drivers that use fixed clock
> rate. After applied this patch, sysclk == 0 means there is no
> constraint of sound rate and other values will set constraints which
> is derived by sysclk setting.

This is to support variable clock rate isn't it?

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1uovwACgkQJNaLcl1U
h9AZzQf9HH0Db1wJ+XWQDgxQgcVuonUvv5+nYIakBUPCwszpWPe2bSJaYOmA//d0
U1FmJCCpd/fKXHa1BfdQsA60q9u08qHcd4k2aWsbx3RwhO69rqPJu5V/OGG9mHL2
XyeyZ5mwLYbSTWEJW+AOfqqHq8gTFrJro9vWc3jfXZXLwxAdLPRZJpeiKYPZR2ZI
b2nyd9MZR4Zm4gTXPzb90ASOHnfe0/N6sFY8m8f/XWRluI1rZ1YySFHIB9ik3YNO
vzU5s7fGrvGcXLpvaFdBhbP/KdZpJo9VUGWNvSopmk1Jep0EfTy1/z5dMiRemHAx
/ruhvBhzpRS5yuFFqpgDj6VidFhPaQ==
=beyQ
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
