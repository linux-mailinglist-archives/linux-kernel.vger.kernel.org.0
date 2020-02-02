Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FC14FD0C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgBBMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 07:23:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 07:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yQDGYskfy6d4Ic5b9Ykr6AUmvD96h/wBFQChrF6vatc=; b=pBnPvZMG0NcIWoli8sT3UHktF
        anTG1iGY05tgNOsFyX5hIPPW/VTGfNYm8/2uCi0UVzUXNa26rMqY4TiyUMAwOtQ1rjxEchHCJyqu1
        pX82Pfnfb5HOo4BY6OSK2nF20SNSe7qQ4Mpn5idNjKkhfVE8fJHCMn2R5YIgdx+YrOO7I=;
Received: from [151.216.144.116] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyEHx-0006xw-Bz; Sun, 02 Feb 2020 12:23:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EE321D00D65; Sun,  2 Feb 2020 12:23:44 +0000 (GMT)
Date:   Sun, 2 Feb 2020 12:23:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Robin.Murphy@arm.com" <Robin.Murphy@arm.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Message-ID: <20200202122344.GV3897@sirena.org.uk>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "system-dt@lists.openampproject.org" <system-dt@lists.openampproject.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "Robin.Murphy@arm.com" <Robin.Murphy@arm.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus>
 <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus>
 <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
 <548b1427-cf6e-319a-36e2-c3e9363b930d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jz2RIiWkXBLiaBi"
Content-Disposition: inline
In-Reply-To: <548b1427-cf6e-319a-36e2-c3e9363b930d@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jz2RIiWkXBLiaBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2020 at 12:48:33PM -0800, Florian Fainelli wrote:

> Like Robin and Sudeep here, I do not understand why the kernel should
> have any business in this, let alone allowing blocks to change owners,
> that sounds contrary to the purpose of a firewall being controlled under
> an untrusted entity (Linux).

Can we rely on there being a more trusted level of software than
Linux on a system?  It wasn't standard to have anything on 32 bit
Arm systems as far as I remember so you could end up with some IP
blocks intended to support TrustZone sitting idle.

--4jz2RIiWkXBLiaBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl42v1AACgkQJNaLcl1U
h9Ad2Qf/Z89ElUT49FpCeQbf2hYD+rbmBZfToVl5iOvMgypip56DLpLz7Z9pg+fM
XNUGFiieZuTdvl02zzZNBQxe/G3sdoWmFREGsjq7rhCuoD8DZCYfZa/YYhOm7ME4
7txqcaZqSxKc1PQg1A6TNr/ItFpaWJ9sJPr61uOnPE0dDASNagjEARUNlV2wqW3f
z3HmQn3H7y+qffq+pHj11fNLLAMjs90PKztzqOFrhSUe5CBphAYH4mGFk9hpVZUq
r1kMsN6SjmINlLZ/XI1b03U3QnQMJLjVoDjtBpLKc5MQZMfuqx/Q6X/6Pp4RXUfJ
2mrNWRU65pMJeuVGwmd5Brs59iLTgA==
=jc/v
-----END PGP SIGNATURE-----

--4jz2RIiWkXBLiaBi--
