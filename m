Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3453D15D84F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 14:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgBNNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 08:22:14 -0500
Received: from foss.arm.com ([217.140.110.172]:33038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNNWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:22:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70E61FB;
        Fri, 14 Feb 2020 05:22:13 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ABF23F68F;
        Fri, 14 Feb 2020 05:22:13 -0800 (PST)
Date:   Fri, 14 Feb 2020 13:22:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5/9] ASoC: meson: aiu: add hdmi codec control support
Message-ID: <20200214132211.GK4827@sirena.org.uk>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
 <20200213155159.3235792-6-jbrunet@baylibre.com>
 <20200213182157.GJ4333@sirena.org.uk>
 <1j36bdfgx1.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QxIEt88oQPsT6QmF"
Content-Disposition: inline
In-Reply-To: <1j36bdfgx1.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxIEt88oQPsT6QmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 02:16:10PM +0100, Jerome Brunet wrote:
> On Thu 13 Feb 2020 at 19:21, Mark Brown <broonie@kernel.org> wrote:

> >> +#ifdef CONFIG_DEBUG_FS
> >> +	component->debugfs_prefix = debugfs_prefix;
> >> +#endif

> > You really shouldn't be doing this as it could conflict with something
> > the machine driver wants to do however it's probably not going to be an
> > issue in practice as it's not like there's going to be multiple SoCs in
> > the card at once and if there were there'd doubltess be other issues.

> I'm not sure I understand (and I'd prefer to :) )

> As you said before, initially the there was supposed to be a 1:1 mapping
> between device and component. The component name is directly derived
> from the device name, and the debugfs directory is created from component name.

I understand why you're doing it but that feature is intended for the
use of cards when they're integrating components, not for devices
trying to register multiple components on the same device.  This means
that a card that tries to use the feature will conflict with what the
driver is doing, but like I say there's no obvious use case for a card
doing that.

> Instead of addressing the debugfs side effect, maybe  we could just make
> sure that each component name is unique within ASoC ? I'd be happy submit
> something if you think this can helpful.

That'd be better.

--QxIEt88oQPsT6QmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GnwIACgkQJNaLcl1U
h9ConAf/ZGIifJ2A3GT7/6hgGBOd30DCPyZ8wpzAq0wHv/ihVoH/uLJqlLiRVglQ
Nqx0WU3HNlkMaHwiGc/1rp2fiXdZ1hzXQsCcHMX+0vQyLVRqtsITAVkHauL9RVE8
U+DlOVSjkI7k4jPw9NQgATNCA0a5cw1WMzorwS6WNeLMUS3eqQdqxBZeLgwTqtdz
zRg9Fwb/c9xmCJgQ8PdybSvDTxW0G9Mx/0BWAfeJqSUTk/2tQjpODkaGQP1fH/Az
keB6n64qi+KoaIGZNUVEfiLL2zJ0w49nfDKyb1n5KndN0+iOVbk9jxRtnDaGajYF
/ZLH5B59EjOw9RfRJTsAvNs2GO8JIA==
=YJRb
-----END PGP SIGNATURE-----

--QxIEt88oQPsT6QmF--
