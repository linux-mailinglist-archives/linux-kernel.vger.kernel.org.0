Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E731996F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgCaNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 09:03:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgCaND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:03:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C5D31B;
        Tue, 31 Mar 2020 06:03:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9483F71E;
        Tue, 31 Mar 2020 06:03:28 -0700 (PDT)
Date:   Tue, 31 Mar 2020 14:03:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        kai.vehmanen@linux.intel.com, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/5] ASoC: SOF: imx: fix undefined reference issue
Message-ID: <20200331130327.GE4802@sirena.org.uk>
References: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
 <20200319194957.9569-3-daniel.baluta@oss.nxp.com>
 <20200331122540.GD4802@sirena.org.uk>
 <CAEnQRZD_Hjp2vsouUURuZ_zgAnnUXynq_L5YgCZAN4pFkcmGWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <CAEnQRZD_Hjp2vsouUURuZ_zgAnnUXynq_L5YgCZAN4pFkcmGWQ@mail.gmail.com>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2020 at 03:41:57PM +0300, Daniel Baluta wrote:
> On Tue, Mar 31, 2020 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:

> > This has you as the author but you list a signoff by Pierre before you?

> Patch was initially designed by Pierre [1] when in the internal SOF
> tree we already had the I.MX8M patches.
> Whereas, in the current patch series I firstly fix the i.MX8 then I
> add support for i.MX8M.

> Should I go back and put Pierre as original author?

Yes, if you're forwarding a patch someone else wrote you should keep
their authorship.

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6DP54ACgkQJNaLcl1U
h9BNCwf8DKshKqaUb3H081iRZrUHWAJSZU+DnmiD5ENcYbns3F/gJNUhdt8nItvh
VRWzN4wsKM2ELUd0ktdzcRaxxQS52CBuw0JkJAsVMlOZ2UxE3hYBSe6HrT6gAvpf
BKcnouJmHOot/rGlw/Z+NtyCxEDQkqz24/+Jv63z6PRrnwb3DHDBJLhP8+FlJ2We
cKTS1TR290aRfdmPaXyPTiwxGolcGzf5ulXnmgi/0/ytRGd59Yi8IwbC/Cm1sbh7
rG+PE9vO5P2oHG8TBUUBAcGqO0nLtzn2UdkF6EVzM7IqcPr+QWeIdv9Fgo1b4BN8
h44Bx4448w4dpDXA6nidWLq33Zbe6Q==
=Aux6
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
