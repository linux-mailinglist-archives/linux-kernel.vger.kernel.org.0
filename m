Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58513C50C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgAOOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:12:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KFXkArze8zJeIBlVLCzafX05cLT9WChi59zpvx45JEI=; b=VnC2ZkJK+zIAzFdlmYAGUkp4B
        YOnlMh0H2shJA9M8f+UYIGo9knQopufSYWAhADG9K9mDfOrJLUMCaWxnwCra5g58BROnPquz+dc0X
        K8s/ggOSXhFVmH0mifzZmEQbU5r3JxRBBPrGTkQPL5ccQjEVOU+TVsyBz///98uWod8gM=;
Received: from fw-tnat-cam5.arm.com ([217.140.106.53] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irjPQ-0005v4-8u; Wed, 15 Jan 2020 14:12:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 03CF6D01965; Wed, 15 Jan 2020 14:12:36 +0000 (GMT)
Date:   Wed, 15 Jan 2020 14:12:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [PATCH] regulator: core: fixup regulator_is_equal() helper
Message-ID: <20200115141235.GK3897@sirena.org.uk>
References: <87ftgh8qnn.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2XUWoe1nmt7t49kG"
Content-Disposition: inline
In-Reply-To: <87ftgh8qnn.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2XUWoe1nmt7t49kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 10:17:00AM +0900, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> commit b059b7e0ec320 ("regulator: core: Add regulator_is_equal() helper")
> added regulator_is_equal() helper.
> But it has unneeded ";" if CONFIG_REGULATOR was not defined.
> Thus, we will have this error

Thanks but Stephen already sent a fix.

--2XUWoe1nmt7t49kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4fHdMACgkQJNaLcl1U
h9BPOgf/WuyjqUM5glaD6OPswOvwvOkpVLxzWbIcr66lop2AQP5fx7P6JHYI/LbJ
jCYj2fqq36a2JSabu1JRhOHPDzLOyRjKesLmJjLOrmO+JQufVgvG9TXdU1FavyUh
ACR/LLoEjcngY3KbPiQxmV/wCXueoZlp7nguAsF0rX+ARaTtQYNxqvIQmlnx8iIt
sTImDour8ye/6ac53Gdpzi6mGsajqahhxf97bFU3MIGAywDLlvGzdpoZKwDzlM6f
BHMWiQq1fqjFtPEAEuEOG04VoD8iWRdF+FWnPaSsbvmcbqhVuTCdgZtj6VKzdq6D
BWwtQEcBMF+YoSvi1EbdS4KrqglQTA==
=Pyml
-----END PGP SIGNATURE-----

--2XUWoe1nmt7t49kG--
