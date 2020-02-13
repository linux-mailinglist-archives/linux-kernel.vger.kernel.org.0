Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7479915C8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBMQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 11:56:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgBMQ4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:56:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A922328;
        Thu, 13 Feb 2020 08:56:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15723F6CF;
        Thu, 13 Feb 2020 08:56:50 -0800 (PST)
Date:   Thu, 13 Feb 2020 16:56:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200213165649.GG4333@sirena.org.uk>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
 <20200210155611.lfrddnolsyzktqne@linux-p48b>
 <20200211112015.GA4543@sirena.org.uk>
 <20200213155520.bd332lzo4py27o5k@linux-p48b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20200213155520.bd332lzo4py27o5k@linux-p48b>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 07:55:20AM -0800, Davidlohr Bueso wrote:
> On Tue, 11 Feb 2020, Mark Brown wrote:

> > As I said in reply to the regmap patch I'm really unconvinced that any
> > benefit will outweigh the increased memory costs for that usage.

> I'm not arguing the regmap case; if it's not worth it it's not worth it.
> With that conversion I was merely hoping that sync was used enough for
> it to be considered.

Well, it's used a fair amount but like I say it's mainly used in the
context of working out what I2C or SPI I/O to do so the amount of CPU
time consumed is neither here nor there really, we'd have to be doing
spectacularly badly for it to register.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Ff9AACgkQJNaLcl1U
h9B4Kgf9HCwPNjHtGoW9j5TLEGB7JeXtMLOrBlKxoVQPtiwXtwyokA30Q7tQt5PW
BPQS08kk3rdI+9rD7f+A/ixFnR4M3sfh5eFEvmryjcGoIphnjY2LzH3mvb5l4rIn
E2c9ocqg0yH+LQr1lnbxwt/VUmRFO4DevR8e4QuE8Y3B873vNLOdiCLDP/sHkKuA
bq06AYQiJWLeMWb8w9BAeVc9D42+Y8eRn7/t5WrPUrH0EytPnWC1/NHrpcajheij
zTyykbV6KW1OxQ/w80wqprpQPhHrkOaMRqlsKTCwn1eBLRRQcnAS88o0G4msfnaZ
ev9PLBy6/6DxI5H/NbOOEqu7KWkolQ==
=+5EG
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
