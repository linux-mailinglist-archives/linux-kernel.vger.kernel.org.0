Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBE16675E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBTTo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:44:29 -0500
Received: from foss.arm.com ([217.140.110.172]:50330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTTo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:44:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E58B30E;
        Thu, 20 Feb 2020 11:44:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585C93F6CF;
        Thu, 20 Feb 2020 11:44:27 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:44:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Introduce the TLV320ADCx140 codec family
Message-ID: <20200220194425.GJ3926@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <1d2b79f5-a928-adc5-b6f8-e73e0c061f75@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
In-Reply-To: <1d2b79f5-a928-adc5-b6f8-e73e0c061f75@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 01:24:14PM -0600, Dan Murphy wrote:
> On 2/19/20 6:59 AM, Dan Murphy wrote:

> > TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
> > TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
> > TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

> Please let me know if there are any additional review comments on this code
> I have 2 more feature add patches on top of this patch that I developed a
> couple days ago and don't want to submit them for review until this driver
> is integrated.

You posted this just a bit over 24 hours ago...

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4ZgACgkQJNaLcl1U
h9Bvawf+N0d9mAzg22+fazMaFpDweaoHxUZbPEW2IwwhC4GBJ95/Z80s2bfVxRgN
Tdw4akcgXjSzh358u0LZsuAee0G0uNA4KDBLn/SShioH2tdoWpGCtYGNEToJocxS
hhTEk6xnSfIfJz0gOATZZ2JD8+FdbO3d9GxiuAKQnqa04540oaYbE3MfFHn/zb2t
o+756jzCn60wXDG6qX1Nb4vvRwZoenkPku7R8zK9h9dp/8CiPXZm9EDz4dFSifCJ
wv37xTF5niLrs+wdWoXZPv/M7rhP2Y4dT0Vm9lgk56awZqHi1P6SgajisjTTUYHm
ormGVILCOhrjurk/IqptKkPFs31mTQ==
=pCGf
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
