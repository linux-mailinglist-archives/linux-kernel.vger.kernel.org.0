Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3B3B75C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390836AbfFJO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:29:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52760 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388936AbfFJO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2/NqQ9GziQyACvNe8rO0FclnMIOpXZ8VTVPH+dJ3XXU=; b=H8yz6bGemIr3PKdNfZG7Y+xcs
        /VCuDg0n/sRq/XgiLSJA43mwJxFsfx7v/OCieQKyDxhs+6trMhGj6XrZZt3oUtXNJNwecO8M4VP7N
        k0or+VQpTKQidsTSs+BZFfHypE18nAGmcSYohF8k0ECatdTEHSk9X2degWudMtvO/sIss=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1haLIs-0005ug-OE; Mon, 10 Jun 2019 14:29:42 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 37284440046; Mon, 10 Jun 2019 15:29:42 +0100 (BST)
Date:   Mon, 10 Jun 2019 15:29:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fix for v5.2
Message-ID: <20190610142942.GC5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 498209445124920b365ef43aac93d6f1acbaa1b7:

  regulator: core: simplify return value on suported_voltage (2019-05-03 15:34:26 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.2-rc4

for you to fetch changes up to 7d293f56456120efa97c4e18250d86d2a05ad0bd:

  regulator: tps6507x: Fix boot regression due to testing wrong init_data pointer (2019-05-16 17:11:47 +0100)

----------------------------------------------------------------
regulator: Fix for v5.2

Just one driver specific fix here, for a boot regression introduced
during some modernization work on the tps6507x driver.

----------------------------------------------------------------
Axel Lin (1):
      regulator: tps6507x: Fix boot regression due to testing wrong init_data pointer

 drivers/regulator/tps6507x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz+aVUACgkQJNaLcl1U
h9D5ewf+IpUdK5zI5WBpQdS/szpJWn3D7lfeGUV08YY1/f0V7Mk6jP+xsbJnDCm6
M/ozzGsDxOrrPkJZ/UXNNsDzrG/xy2FQ5qrhP10z6Jxp1c9C8DT1dJDyVHkL5S28
8TaJR6HtW1trusIz4AlS9SMYkc2llDFJkQWeTDVALsiNAtD4QlInEI+f1Frlzxx8
GAVkKppcrOb6H1xSbe1DlFvvN6x7UDDbe5vhgqcfzRZMnqAJ5aGuxbZFagggtFEZ
Odr8bu+ZgkuvHG40CX9rr64n6KtsnlyuEjrSLL10e5a9rGuWI5J8JDVgvPL0IGNO
Wbm6pXrclmLN1jwXH5MFHL/TTuOZgA==
=pI5p
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
