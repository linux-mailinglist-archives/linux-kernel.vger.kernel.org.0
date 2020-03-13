Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F071A184688
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCMMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:11:06 -0400
Received: from foss.arm.com ([217.140.110.172]:53952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCMMLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:11:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B04F30E;
        Fri, 13 Mar 2020 05:11:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E92B3F534;
        Fri, 13 Mar 2020 05:11:04 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:11:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200313121103.GD5528@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
 <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk>
 <20200312150330.GH14625@b29397-desktop>
 <20200312150710.GG4038@sirena.org.uk>
 <20200313030851.GI14625@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20200313030851.GI14625@b29397-desktop>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 03:08:48AM +0000, Peter Chen wrote:
> On 20-03-12 15:07:10, Mark Brown wrote:

> > I'd expect that this would be handled by the GPIO driver, the user
> > shouldn't need to care.

> GPIO function is just our case for this fixed regulator, other users for
> this fixed regulator may set pinctrl as other functions.

> Here, it is just save and restore pinctrl value for fixed regulator
> driver, not related to GPIO.

My point is that the fixed regulator doesn't have pins in pinctrl,
whatever is providing the control signal to the fixed voltage regulator
(if there is one) does.  I'd expect this to be being handled on the
producer side rather than the consumer.

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5reFYACgkQJNaLcl1U
h9BkLAf/UjQZovchT5VsEu2wZmG/zizxhNSwmVG50VyoRecV7LId70EWqpobHx93
VezvuWsKQSujw2mZ/xLM+nzGnqkmpe2PdQOsQrdICeAIs8OTz/sxbBX7H69St7rf
X7FSeXLwniI49hGxinNKhwR86PRRrILdvYScNsIKR1quNXHARZDN1n5SNi63a0cA
+lDYYGBA/b0TdTgTY7y7UhawjkEAbNe2CyqvvmEc6eAbjlbLlrF/RAclET0s59vF
FpQOy4hzKm5dgAGQRaAOynJa/KwVEX9Mk/1UJDnY6FmmSyaJ5uC2WjmGGXv/Shz3
bwu1TWYTvu4UbEj+chX/pcX1f7C3YQ==
=a6ht
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
