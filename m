Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB04C8764
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfJBLeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 07:34:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfJBLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zdwEezXVISsa9PHkwP5BMlyUlO6t4LLnWgMNEkTlL8E=; b=v1HVyy/usl4yaOLpSL4RXACwj
        xxwrXo5u9Bl33UJWQA9pvEzWDNA/MK2Kua6KDvwtt45nWVxPR9Z2LiVu7W4YViRrQpJrL3RmYIx9l
        wmlEHm3K1tzV2FAZR5+txYchrmO5EzTA94ULKeLXUj5msiqrlNUlkbRpW/Wv9KFmvMFg4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFctL-0000Xe-FZ; Wed, 02 Oct 2019 11:33:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 85F452742D0A; Wed,  2 Oct 2019 12:33:58 +0100 (BST)
Date:   Wed, 2 Oct 2019 12:33:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Message-ID: <20191002113358.GA6538@sirena.co.uk>
References: <20191001142116.1172290-1-arnd@arndb.de>
 <20191001175501.GA14762@sirena.co.uk>
 <CAK8P3a2idD4as-9ns0NrLjYGYSEc0=6A67VaNXDacA3-tJEr0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2idD4as-9ns0NrLjYGYSEc0=6A67VaNXDacA3-tJEr0Q@mail.gmail.com>
X-Cookie: Pardon me while I laugh.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 09:02:22PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 7:55 PM Mark Brown <broonie@kernel.org> wrote:

> > This doesn't apply against current code, please check and resend.

> I looked at "git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> for-next"
> as well as the for-linus branch in the same place, but found no
> conflicting changes
> in there compared to v5.4-rc1. Am I looking at the right tree?

Yes.  I'm just going by what git said here...

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2UiyMACgkQJNaLcl1U
h9C5Qwf/RiC5F7iZ+aTgaYtUrV+CrzlbJV7Gnco8nXr+ykxzFWvEDLB/K5tZ0iKu
DLmW1tuSIklnqAWfXvnNeX+LDvwHExW1dnQoN81M4lJoP0eCeCLE1UJ/uSCwqFLJ
iY2RLbdkYZ5gXgyb8+eGsHPUtoKUPhP89LBHbdoYX9DyV9dzi95jdbpYeRw3Ux8p
3jB20K8VI44zWlmmyClAi+wUiDx1pPizL9JT9QC1oPwzTyLhIXIth6TuAqAVk9Tm
2pytsySr0MFLF1iDo0izxyxPusZnsglcj4eViS3B2mYBXcVoZmRNuO6IYOHa6+3o
9OGn/XEpbRb0Z6lpimUPNRhBY7vB4Q==
=GnRg
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
