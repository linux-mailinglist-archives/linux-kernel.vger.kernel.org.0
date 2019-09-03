Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2BA6758
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfICL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 07:26:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfICL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U+qBIs5DLxlF/W0N9eHDql5Ei2knweaMIyfM7HcjDzo=; b=UGVVLm7dwEwK7IfW+lpy7DzOW
        bpZXBvk7VKM5S15uiWhbWNmZ9YraSxqa6e/gI6km8l5WiHVf7QpwdU4JHVIul3H/9UGOLujl85ZUD
        AFQReKv3bkgldC+aqTIqRPPZHTvdkFa+4dPOjaP/mdbR0XW0GyRBJLPM4lz2ILSnx240g=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i56wh-00088C-Eo; Tue, 03 Sep 2019 11:25:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8A07B2742D32; Tue,  3 Sep 2019 12:25:58 +0100 (BST)
Date:   Tue, 3 Sep 2019 12:25:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: pfuze100-regulator: Variable "val" in
 pfuze100_regulator_probe() could be uninitialized
Message-ID: <20190903112558.GB6247@sirena.co.uk>
References: <20190902221047.20189-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20190902221047.20189-1-yzhai003@ucr.edu>
X-Cookie: The revolution will not be televised.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2019 at 03:10:47PM -0700, Yizhuo wrote:
> In function pfuze100_regulator_probe(), variable "val" could be
> initialized if regmap_read() fails. However, "val" is used to
> decide the control flow later in the if statement, which is
> potentially unsafe.

>  		struct regulator_desc *desc;
> -		int val;
> +		int val = 0;

This just unconditionally assings a value to this variable which will
stop any warnings but there's no analysis explaining why this is a good
fix - are we actually forgetting to check something we should be
checking, are we sure that this is the correct value to use?

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1uTcUACgkQJNaLcl1U
h9BzVAf/RF2EhDgCkjIdcF8TSR7bOFE6Yk7pvCNHI0mh2h9KGVDYGrHAjlIgffHK
fmMs4W3WXKYl8cPEITgeMpLfXtypUm9qrZ7Dw63hxLUfdLUXVrTOHQuFL3h1FZKd
2xrOkSRLAryhqKpclZi4QXFNf7g+FOEbbWoBAcnje1dTqCuwugISWnlZ8vB3meqv
9p8fj3G/neGqeRXEjO19WGGWuxhd/sAzGnXBxESZ0SZryMmG8eywM5pn918eamLK
GabPCZekyBlQfBZycIYiv3FB96sUgT+bOpV36jgyMLZF/2srQMA94Y+jLDxOSwjs
P/ZY6oSBge2NjutbYhs8FQW1tV5wwA==
=JWCy
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
