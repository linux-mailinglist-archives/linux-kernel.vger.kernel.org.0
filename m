Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D00AE941
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfIJLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:38:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59738 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfIJLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dHsV/RZwls+pHHVDbGZCAK0HFYsQemt5oRt7DrcnlWg=; b=wksF6c6S+zT5Y0cM11IjPsTuP
        LpIXR4wYPcts1I3/JK/nEWllT9nXWCSBAs943ICstbB8zZ+0TUFj8X5Zq1xmQmlnCJhjZEkA8hbk3
        VxGGGPiaBvoWAT8ezRiV3LD7Tg3cEvUgpj8yvP9sFPQFBAi1jAx3NTbzJnk4Kol98jFH0=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7eT4-00070T-Cb; Tue, 10 Sep 2019 11:37:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4B64ED02D76; Tue, 10 Sep 2019 12:37:53 +0100 (BST)
Date:   Tue, 10 Sep 2019 12:37:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH] tas2770: add tas2770 smart PA dt bindings
Message-ID: <20190910113753.GO2036@sirena.org.uk>
References: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Content-Disposition: inline
In-Reply-To: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpolVoprVozDR81Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2019 at 03:06:03PM +0800, shifu0704@thundersoft.com wrote:

> + - ti,left-slot:   - Sets TDM RX left time slots.
> + - ti,right-slot:  - Sets TDM RX right time slots.

This looks like it's duplicating things that are normally done
with the set_tdm_slot() callback.  Otherwise the binding looks
good.

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl13ixAACgkQJNaLcl1U
h9Bzigf/QbdVHbADoNlxGIhXNjlodxB2+bXhJ+BOngKzGbZFOfmv6pyKAz/RWIps
hlFrlJ1zF0V9g3qkuoiapWwq+jMZBnLVEXmMn7Y0oLXeck5AaWyv0PI178l6Qu8h
Pd37fRgJme/Ks6Fz9uH0xDaTl+93bSV9fR2nioiLi9C9GsU6fBE+YTEizQuPL1Lc
MEHUL3KlTh8qaMNpiqowHRNoy9VwzwkYF7mdmYe3XOKimJOb7l4VNb1mhPhBxoUI
b6hmfiS5lIb0d894W/u30vabn52L263Chhtnp3yKvUe+cE0PacHCoEdjrH9P6dr3
yBjOWhfmWmIxQQ2RsWveZ//xCi5vgg==
=Tj+k
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--
