Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF0183347
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 15:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCLOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 10:37:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCLOh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B3D30E;
        Thu, 12 Mar 2020 07:37:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E8553F534;
        Thu, 12 Mar 2020 07:37:25 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:37:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200312143723.GF4038@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
 <20200312130037.GG14625@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <20200312130037.GG14625@b29397-desktop>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 01:00:33PM +0000, Peter Chen wrote:
> On 20-03-12 11:47:12, Mark Brown wrote:

> > Which pins exactly is this controlling?  I would not expect a fixed
> > voltage regulator to have pinctrl support, this feels like it's papering
> > over some other issue.

> Sorry, I forget sending dts patch. We use fixed gpio regulator to control
> USB VBus.

Surely it's the GPIO controller that needs pinctrl support then?

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qSSIACgkQJNaLcl1U
h9CbXwf5ARB0Y8aFHjOrTN1l2RTW1H0LLNID3S3ytrszCstjm9doLeGbGO66rVw8
TbK4AvkNzjOKMj96PddwIBcR+Qg74nNeWm/3+oetgAkhhcATT/jbdFfoYgDNQ7ej
m9nVTIID6L50xYqv4uIxKamyn1+q3k/NiR/zN2oZUxKwbNm/vg8CmK613BLskMUK
P2B56gDMPFNCzKewrRyQaEc4NaMFBXoE6ZPYPWwvz0vDSJiOcZm7yKazPKxVpobt
AOU67LR16JYRfi1amY2geV4ZsY5d8fgu0+iN5hrNXxG2KGe9Klq7ANfVKZ5zgQfn
V8xxJUmd+Iv1EspBy2cEMCZ5ffF1DQ==
=ekt7
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
