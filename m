Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A774E93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfGYMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:55:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGYMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T6VBY4zfiy3MSxSKbCuz8zMQX5tnpNzxcWkHlxGBC1w=; b=FFdsSjhRbkNH5xwbBGATMKGW4
        HVVY+8OydWs93YxTv3Cm32qq9W92+AZZynxhgJNA1HFLYmdzdoqkKtRnUw+vTYGncKTgKNAn+biXT
        5O7xXBeHXNy7D5iNtkRunzSBAtQhxk5KkduTa+RStmcbbSn1u13jq3C8qZxkpPqDXfFgE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqdHT-0002oT-Ky; Thu, 25 Jul 2019 12:55:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A616F2742B52; Thu, 25 Jul 2019 13:55:34 +0100 (BST)
Date:   Thu, 25 Jul 2019 13:55:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/6] ASoC: codec2codec: deal with params when necessary
Message-ID: <20190725125534.GB4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
 <20190724162405.6574-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20190724162405.6574-4-jbrunet@baylibre.com>
X-Cookie: Jenkinson's Law:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2019 at 06:24:02PM +0200, Jerome Brunet wrote:

> Also, params does not need to be dynamically allocated as it does not
> need to survive the event.

It's dynamically allocated because it's a pretty large structure and so
the limited stack sizes the kernel has make it a bit uncomfortable to
put it on the stack.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05psUACgkQJNaLcl1U
h9BPRQf/TWxfdv1adKppGIBtuqwmpBS+DoFYnHcZDpi77bESSWpws7sxnJQocVHi
R4/NkWuIBihp5crQr4F1z7G68tmtVTxFRDni9rutYtQxaVloBZ9OFkesJLaaLG5Y
7e/uDcl2Q7Dlw7jo7NsboC1WTLq3vCDRpioZja9GjL6X/YNxLAmcoQEA3EeWvwtp
2cvDAI/Ah34hsYvfQwyaIFKPzS5UNcPdkb3MN03010mqR3xmVTnJTvWQp7A0l2sd
tliUrBzMtpqW3gTD5ZCjI6dHOp6eeI7BZ26v49WUJtOpawsibdFpkGI4PdZeeuf0
1wJevZvP7lpr4zNMaCWpLwA5LkAY3A==
=XabL
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
