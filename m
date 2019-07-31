Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2D7CC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfGaTJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:09:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q0h1q1Ps3WT4ADvZ0uHnBNddfoh3ovc2T0AVJ6G3rpg=; b=JCX7Z6JoYrTcxV24yYDZ+mc+x
        67E1J8hRtmro53J/KPGYQZtqKoSZa/+dOn9UlZT3ORt3zmUSow5a3qZnMI3Q7/mnUiax16BMO+nhA
        T8faZwIwHvsBuYrVVAdW6m0AgEdrIWPRVgv93y7mrdPE2vTPI7e8pReEcW4nTOTuWBlP4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsty8-00038R-Rx; Wed, 31 Jul 2019 19:09:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5C3972742C99; Wed, 31 Jul 2019 20:08:59 +0100 (BST)
Date:   Wed, 31 Jul 2019 20:08:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: of: Add of_node_put() before return in
 function
Message-ID: <20190731190859.GG4369@sirena.org.uk>
References: <20190724083231.10276-1-nishkadg.linux@gmail.com>
 <20190724154701.GA4524@sirena.org.uk>
 <af559a36-c926-e2a5-a401-aae0f6867a6e@gmail.com>
 <20190726104547.GA4902@sirena.org.uk>
 <8a1fa50a-3d1f-427d-c319-be2c6f5ccb6b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <8a1fa50a-3d1f-427d-c319-be2c6f5ccb6b@gmail.com>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2019 at 06:41:03PM +0530, Nishka Dasgupta wrote:

> My added code is dropping a reference to search, using of_node_put().
> I'm probably misunderstanding this at some point, but I thought search and
> child are two different nodes? Or am I completely misunderstanding what
> you're explaining?

Doh, sorry - missed that it's a different node (there's a lot of these
get mechanically sent).

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B50oACgkQJNaLcl1U
h9DFHQf/fJNd1udMs+NXgRi/3W8tkzGXqNM0oPQDetTbL/gcB/2QSCIS8blYZ2QS
+URsojmiI9FTGUvLgzB+oXM6LDEI4XK2bSyhs3K16LQoJCGfY4PEw/Rc12KWiEVD
K2fDtjO5Az2YVhg0q4CAIpcB4QsvlYwehGlPzaTANfrt/dC+JK+3Cv8Y583ulGyY
x9pJ5+5m9fSbdOcH4K8xT2T4/XUTTDuqXV2GlVlsXny1Q43Mmxb40hg2+xy4kB6m
4W/hUJdotYOaHZcrUC6VY0RnueJCOKXZT6dUHwP1wMxS+SZuIHpQ92IQjJNKsPqD
QjvZfRRHjZb4ukeOp6khW/vKLC3aVg==
=eHDv
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
