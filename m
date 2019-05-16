Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADB20428
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfEPLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:12:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33086 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z2Z7+MFUvBPBnKh5hkeD2cTajetudgmw37iyLkzYbLw=; b=jv3sGed48h6DuIvtRuzJJnlJB
        KnLKxpPh5Uc/p7dSXShIZizO4MmSQ5Btmpo39FOmGYiyf4A0nTs16I6vzNr3m05bc04XTZQSOWkqc
        qp7N5cOb1rUrwd6deezf6NdJ5TCEpJkRWfKCT6B9uE4gQ2k8Dh44BNu7mdvE09ffEpRyU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREJM-00066K-Lr; Thu, 16 May 2019 11:12:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 21D5A1126D45; Thu, 16 May 2019 12:12:32 +0100 (BST)
Date:   Thu, 16 May 2019 12:12:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add reset gpio handling
Message-ID: <20190516111232.GE5598@sirena.org.uk>
References: <VE1PR04MB64790C7A0C1C068503038FDEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64790C7A0C1C068503038FDEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 11:09:27AM +0000, S.j. Wang wrote:

> > You also need a binding document update for this.
> ok, will send v3

Separate patch please, I already applied this and binding docs should be
separate patches anyway.

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdRZ8ACgkQJNaLcl1U
h9DryQf/QN1WnlIxisEBv3q8UfSPHhd4YuCYO0Gzp7QK64Ei6KJL1BYr3LpneK9G
yjzhG4Ix4Diugig2rg/i9boPzcT8DskSS0GV28zhE0cvaSbxVRmQd2oQBMgK44AP
MuU7ZFZh6VQtmOYDUf8d9WQj7vcLs2kGwfiU32xA2865EwVarnwY3SRpmW4YYCc4
twMse4gvRuL4k5RoRvuT05whKNVKwigBzOmDXpIHpkHkg+dQA/pA1fUf7T7HM68f
UkBiRis8BbivxIiE6l+c14GaYamniawMmP17C+66uJCxtNfiiJa4nH7SscKOpmwI
6ZnItmz8SMwfphe48YkFJcvciCYghw==
=CqUE
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
