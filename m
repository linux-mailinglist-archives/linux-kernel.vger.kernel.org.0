Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1166CEBCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfJGS3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:29:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yl70Oot1t06uboGKIaxzSOy9Y0hQUh2wOeALq6ArFjs=; b=bYyFSrHUmXNp+KhxzMxxvfVVB
        inmk6mETl7SSgkcFUhJSFe5RJHsk3bllb9BLtfN51sRZl76cZ4RaZAgNUX3h+FSXDNcsPPxt0xiyh
        B+mVRH75svGlFV9tLSadsXh1ZFO19JL+H1GpWEhY/MYXOW0Fhv3N9grSP421OhihRvyV0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHXkq-0004J6-SL; Mon, 07 Oct 2019 18:29:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1FAA1274162F; Mon,  7 Oct 2019 19:29:08 +0100 (BST)
Date:   Mon, 7 Oct 2019 19:29:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191007182907.GB5614@sirena.co.uk>
References: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20191007093429.qekysnxufvkbirit@pengutronix.de>
X-Cookie: Death to all fanatics!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2019 at 11:34:29AM +0200, Marco Felsch wrote:

> Sorry that won't fix my problem. If I drop the regulator-boot-on state
> the fixed-regulator will disable this regulator but disable/enable this
> regulator is only valid during suspend/resume. I don't say that my fix
> is correct but we should fix this.

I'm having a bit of trouble parsing this but it sounds like you want the
regulator to be always on in which case you should use the property
specifically for that.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2bg/MACgkQJNaLcl1U
h9AQyAgAhaE0zTQ3E+XqQpHTgiDjY+4Fli/jzRMKzOgpJe/Dhb/SZ+ZUJ71oCOdq
4i6GiVeAl7hDydIMgGrJ9tlNKvRA/iF7tD4fhI3FE0UdWD/5TkGq05otqT7Uad97
uwXgBFdrUOGgYZPQXovdyzJ51yLmS1UM/5gAB5lfwTs1U4SdgFGn417oJoV+0qXX
Fto634EXX6Z/W8DITYzm50c5dQzeaqb87e60NCAeSHguyst2KTPsto/b8T+ghZrg
X8+GXIIIxmX+wTMeLEIHSELJ7S/eReSVQD9Rmdce3Tg1kkNIjfnDTiIZsoCQiYbl
b5moGZ4fNUrJEpWGv1HPQnhcRTmxXw==
=UGD8
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
