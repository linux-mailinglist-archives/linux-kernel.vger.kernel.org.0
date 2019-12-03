Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E511001C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 09:28:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VxYjLGtwCDTcs4bHOoBqIWPW0QFsGBkBnVZ5soEijWE=; b=BXzB3IPmvuG64kDV9JxcPH47i
        /glTDJZBPWA2NVSO6v17ptumVhif/XbTMWuiKgdAQqEOA3HNTChL+nIvs8vamiueXHY+5Xty2C7tY
        VUXZ1vOX6We3Q22QAhW35qO+tLrTgJHMg+XnTdhhZLIy49ZJXBBj7RgKWGHEDqBAhh1Tw=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic99j-0002jt-VK; Tue, 03 Dec 2019 14:28:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7D184D002FA; Tue,  3 Dec 2019 14:27:59 +0000 (GMT)
Date:   Tue, 3 Dec 2019 14:27:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add the broadmobi BM818
Message-ID: <20191203142759.GJ1998@sirena.org.uk>
Mail-Followup-To: "Angus Ainslie (Purism)" <angus@akkea.ca>, kernel@puri.sm,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191202174831.13638-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
In-Reply-To: <20191202174831.13638-1-angus@akkea.ca>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 10:48:29AM -0700, Angus Ainslie (Purism) wrote:

>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>   ASoC: gtm601: add the broadmobi interface

These subject styles don't even agree with each other :( - please
try to be consistent with the style for the subsystem (the latter
one matches, the first one doesn't).

Please also try to think about your CC lists when sending
patches, try to understand why everyone you're sending them to is
getting a copy - kernel maintainers get a lot of mail and sending
not obviously relevant patches to random people adds to that.

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mcO4ACgkQJNaLcl1U
h9DGXgf/SJ8t7hSPglwZzxnDVxAte2xNoAVezgY5OPF4s1sm2k7U/h+ivay63+br
Yb0uVbL8I61TWMN8GAcMIRA2lsjzD20/oTcxPMamHvWE+91yTdxvBrWoRpqF3LcI
P8a2CJx3PYIH4nbyML6r53ZnzIF2rc9pGLB3t740Yu3xU87iKqWBWO5Fw3bbA824
BLl2+XQLYFPZ+oLLkpz6BR7xhDpgJ02aO2Fw3LlPtdD82VreneMOCmGYbavz26EN
A9c7HPAiqsyAbJ/t2dHPpIoZ0wihaRr8gPKy4py1EH43ScBAVvWMT0ca+0zpWt++
4aGCqa/WdIz0DOggZWP4JDtiux7z/Q==
=Br5V
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
