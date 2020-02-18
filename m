Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC53816308B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBRTrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:47:21 -0500
Received: from foss.arm.com ([217.140.110.172]:60190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgBRTrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:47:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB3631B;
        Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7148A3F68F;
        Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:47:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200218194718.GO4232@sirena.org.uk>
References: <20200218172140.23740-1-dmurphy@ti.com>
 <20200218172140.23740-3-dmurphy@ti.com>
 <20200218192321.GN4232@sirena.org.uk>
 <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 01:32:05PM -0600, Dan Murphy wrote:
> On 2/18/20 1:23 PM, Mark Brown wrote:
> > On Tue, Feb 18, 2020 at 11:21:40AM -0600, Dan Murphy wrote:

> > > +	if (unlikely(!tx_mask)) {
> > > +		dev_err(component->dev, "tx and rx masks need to be non 0\n");
> > > +		return -EINVAL;
> > > +	}

> > Do you really need the unlikely() annotation here?  This is *hopefully*
> > not a hot path.

> I was copying the code from tlv320aic3x.c as suggested by one our audio guys
> here in TI.

> I can remove it if you desire

It'd be better, they don't really help anything outside of fast paths.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MP0YACgkQJNaLcl1U
h9Dh9wf+J9qWfmd4wHvZLky/0BGP7rVl7P7KEKh++MFibZHsmMtZTT3Tct5YwT6Z
8+a1xAo5dmAz7jbvKvdmJ0+umNHxa0fOwgJusV0p5jU+BwFNNYLUsr3yTf+LRMly
AUaJ7EsuGPdyA5Z3D7KNyaiOrqiy2SCRcJdOwiJky3tIErrbDQ4b7M1ZLSnR4jW1
qyPVAXVlf9Qfy5op5Rb2auSX50TPj5jHwo2wD2ui6/jr0jFs3p1Y/DrLVBNCjeXM
sY22Sz39dw6Dtts+fpWBC+HHl4CTpMWxYah+ZIYLliMzvViKExRYy1ZWPcn1K51Q
q6y+lLbamcgW3ylYxn1BK4BJEhzMGg==
=YobV
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
