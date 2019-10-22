Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926B1E091F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfJVQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:37:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfJVQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KE3k2qtREHq2WSAx2j2NdF3H3/H8sD/ouUddWgPXv28=; b=eOAcQcS9c6+WTa+FPZOPzXMhe
        SMgi0tuc/9AnHyEr8LTJ0sXnHTPCz5zQxHp1UQvm6z7tgsKUQ0UrZfcnYNszrrsvPI6Oc96pOlZv7
        KpI0AHhvpC6xodzQa47uWAknJaV+4Y8z6bo+FW33y2TIHSSSsSkGNyr3fMb3HS8j7jOQc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMx9p-000736-QP; Tue, 22 Oct 2019 16:37:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 509272743259; Tue, 22 Oct 2019 17:37:17 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:37:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 17/46] ARM: pxa: poodle: use platform data for poodle
 asoc driver
Message-ID: <20191022163717.GO5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-17-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwbuP8dfxhLLLUfV"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-17-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwbuP8dfxhLLLUfV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:32PM +0200, Arnd Bergmann wrote:
> The poodle audio driver shows its age by using a custom
> gpio api for the "locomo" support chip.

Acked-by: Mark Brown <broonie@kernel.org>

--LwbuP8dfxhLLLUfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMDwACgkQJNaLcl1U
h9DXTAf+PkYfGUBycQh1ObnY5bFiUcm4IhRh9mkwhL2PRO3lCRN+TN++wyL3vtDP
j9AV1y/qAcZDELhOX9eGoVocwR9EZdeJCbrFz5DVr9g5E7L41Ay26w36YQ8aWWzj
WHe2vbhfLclIUrnIeEKuEWXwpPXZOq1hC7jJ/ihh2wJGHVIRCO0MkZ+ZqUEUk3E2
86C3Z9OzamRZhOlie6EuqmhSw3gNQQdjjDGTOQvdC7zS2MazZxxNJTpOntv78Bs7
Vp+DtdJ7vT0vr8c7xCfWcWlgv2Bc4mq0ky/YJtIUAXJckc23KDsJjYbuynBlSTXC
eNjL3dLyNzIsUdsHUsh7h6YXjp9vAA==
=dGNL
-----END PGP SIGNATURE-----

--LwbuP8dfxhLLLUfV--
