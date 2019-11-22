Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FD010766B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKVR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 12:26:54 -0500
Received: from foss.arm.com ([217.140.110.172]:50254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKVR0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:26:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85757FEC;
        Fri, 22 Nov 2019 09:26:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022DE3F6C4;
        Fri, 22 Nov 2019 09:26:52 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:26:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        pierre-louis.bossart@linux.intel.com, Akshu.Agrawal@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v11 1/6] ASoC: amd:Create multiple I2S platform
 device endpoints
Message-ID: <20191122172651.GF6849@sirena.org.uk>
References: <1574336761-16717-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574336761-16717-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <1574336761-16717-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2019 at 05:15:56PM +0530, Ravulapati Vishnu vardhan rao wrote:
> Creates Platform Device endpoints for multiple
> I2S instances: SP and  BT endpoints device.
> Pass PCI resources like MMIO, irq to the platform devices.

Please when you're posting stuff don't put these RESEND tags on some
patches in the series, they're not helpful - having them in some but not
all patches is inconsistent, you're sending a new version of the series
here.

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3YGloACgkQJNaLcl1U
h9Cv0wf7BLPxHi6VlmnTYgV2HFFERU+rkkk/A78kSRLvCcFbJT+mzHY7PvqTNDSi
G8OoUscWHgFVfVvsfGQV3fscMC9RFpQQJeKsw0/4Z9YPWhrkUZGlSnWJi0oW63oF
lmhUmzsmhCgIlSPHFcDZcNTuY0prLy9zEfQqlnk2zVWBJ5TTpK94bzio19HYKCK2
NgVJx8eFAyGRSDBC2hy2qxOYQ3gOARdwADsmq43KR1oVT2Ru66QZT6V6ZVgFurJr
unKYQoLepbAC4SHNMrMGIvTAdVJKJfl5/8kuRaWOrUCw8XSjerYeG2g1WxJwm/TD
u3Gnrw8NkkWUT3XcAFMbZ+vJcvokjw==
=+sSD
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
