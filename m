Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4311814420F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgAUQWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:22:01 -0500
Received: from foss.arm.com ([217.140.110.172]:45460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgAUQWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:22:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B06F30E;
        Tue, 21 Jan 2020 08:22:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5879C3F68E;
        Tue, 21 Jan 2020 08:21:59 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:21:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/38] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200121162157.GD4656@sirena.org.uk>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 07:00:36PM +0300, Mika Westerberg wrote:

> Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> IPC communications with minor differences. This duplication does not make
> much sense so this series reworks the two drivers so that there is only a
> single implementation of the SCU IPC. In addition to that the API will be

This is a 40 (!) patch series and looking at the subjects and diffstat I
can't tell if there's something in particular that you're looking for me
to review?

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nJSUACgkQJNaLcl1U
h9BLZQf/VjNChJv9k7JPur4zWfGS9+F5nNaFNi/af//akiLUMZatxAjyHirSeg4w
ijrObLzU6lw/gTnSukoe7UMUK36nerMpELth4L6PYNl1xUGX3YI/nvNY8kUu3TuA
HqKDeckqzB17Mxqel0BWiieLSNBxtQiNm/kpPnAmXV8lxFKeAcbfJQPlqg3DbYb0
7axbbqExSm8QBYbi4sbsXS+s5rRhVvCF1WBUqIckF8ui+P58pXuTTN1IiCSghXlB
BID9lv+jXGFAdzS0db11i/qpJnLY1Bq7uX6/i4KwhNq+62Mnb+IhxKrxNgoEkQY3
I3vQWHmuJqIED0G0Uqv9o1kZHx4zig==
=d0Tm
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
