Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E971698
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfGWKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:54:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfGWKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=54OGDPzbTVRnFs7M9+ELk+zaVEsYitF7+XOsw5tSXoQ=; b=gdEqR1ffy8Rz7XxT8xKeOkF0R
        HKEMh+Mx+eE5rJa06M40xWrhWcTvxm7Zok7S/10KFE8gTOgobwTBkcvfGhqDg8soxHNNQecpxfPz1
        70lkGim2feviIbRB8smOPaF8/YBGqeqhMVGeESeXNjn1zjaC9JXIah5JP5U5Uo5TWX+k0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsRF-0003F4-Hp; Tue, 23 Jul 2019 10:54:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0BC5E2742B59; Tue, 23 Jul 2019 11:54:32 +0100 (BST)
Date:   Tue, 23 Jul 2019 11:54:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: act8865: support regulator-pull-down property
Message-ID: <20190723105432.GB5365@sirena.org.uk>
References: <d02d7285ef26f59ce43a3097e342eea081b98444.1563819128.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <d02d7285ef26f59ce43a3097e342eea081b98444.1563819128.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 08:13:29PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> AC8865 has internal 1.5k pull-down resistor that can be enabled when LDO
> is shut down.

This changelog...

>  static const struct regulator_ops act8865_ldo_ops =3D {
> +	.list_voltage		=3D regulator_list_voltage_linear_range,
> +	.map_voltage		=3D regulator_map_voltage_linear_range,
> +	.get_voltage_sel	=3D regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	=3D regulator_set_voltage_sel_regmap,

=2E..doesn't obviously match this code change which looks to be
implementing voltage setting (as well as the pull down stuff but still).

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0252gACgkQJNaLcl1U
h9CkZAf/Y7myUs5rkE1Jbv3lFZz230lwya8td+EF8ZKZVKoiuZS4DmWOq8ED4sIV
dAc0R1HBBeQtDSYoHZmKz77EOztQJvowoPtqXPTXo8VZ8uNn7RftcJp/GdI3xCoz
dCmizo2edNOHeHbNzg18LXWN2UnKbVVFczupk4gbA8ops6O4V5MMwJs3RN3s5vyW
3dqfw43uFuvLOUucSt1SJXx6IJBKaev4vtO8gZhOfHSkq2U425eIvhpckb8hWEH+
TN6Vc8RHnXTqm+IN1MNUFNILzgYTIHzEo4v7WYceZDqldybOyTb7zPJ3cYceKsnJ
0Au4mMppp2+zxrePxos/uid07pVKLg==
=hFaR
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
