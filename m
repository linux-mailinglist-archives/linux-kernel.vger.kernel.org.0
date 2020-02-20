Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8C166685
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTSpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 13:45:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTSpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:45:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1D230E;
        Thu, 20 Feb 2020 10:45:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4263F3F6CF;
        Thu, 20 Feb 2020 10:45:46 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:45:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: Replace zero-length array with flexible-array
 member
Message-ID: <20200220184544.GG3926@sirena.org.uk>
References: <20200220132420.GA29765@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20200220132420.GA29765@embeddedor>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 07:24:20AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:

Acked-by: Mark Brown <broonie@kernel.org>

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O09cACgkQJNaLcl1U
h9DNEgf7BrKTKxuld5LZ1ebYWQJO+bT5mSr17NAdXnhaLEAAeUHxhfI5Ly6MIjJm
Ljf8W2CHdYozlV3dzreRlVvjGdalVC8VGeF9HN1RXX2MTezDOQ5ub12AGbyLohp1
sNU6Ha8v/4P6XulizOdBNUbFmRCN1nVYSiRlxClmcU6rx0gvqt6V3ESYe5EGOUr8
EtuCOc7oHDe3neSdQwxZZgM0xWkmATg9k0HHF7b2lr9iR5GMKBdZWOAxl83kX9ac
a8kUwJMR+e8YOTbzY+8WCmjf7QSlmu5GOSS/AtM02zpADdHfcqfi649gelkmP4YR
y9AUYhYmxJcLsSK2z58Gms5JyYOLrQ==
=x8F5
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
