Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F2154326
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBFLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 06:32:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59262 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SHuKuVXhQ2joYWvyaHuAjPTNnn5lin5358YGydP+5t4=; b=HCiv7PZ6jf6iaBcHIyxy1mfmV
        +6+tnV0C35zAaFUozTlf+yJeb6rG70fq34x6eITuapmMknM+uCzDZdWo8zesCIgpaWouXfnmcVeIA
        Fh/adKLtITforr3O+cs+cDXT1hFvPCJ9+QdJCp5V5opTRIj0wLbzJo8uj/ieZt+fbd/1E=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izfOq-0001V2-DG; Thu, 06 Feb 2020 11:32:48 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 28ECDD01D7F; Thu,  6 Feb 2020 11:32:48 +0000 (GMT)
Date:   Thu, 6 Feb 2020 11:32:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     support.opensource@diasemi.com,
        Adam.Thomson.Opensource@diasemi.com, axel.lin@ingics.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: da9063: remove redundant return statement
Message-ID: <20200206113248.GL3897@sirena.org.uk>
References: <1580963761-24964-1-git-send-email-gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOHdEyqYAbgZNeC0"
Content-Disposition: inline
In-Reply-To: <1580963761-24964-1-git-send-email-gupt21@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOHdEyqYAbgZNeC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 10:06:01AM +0530, Rishi Gupta wrote:
> The devm_request_threaded_irq() already returns 0 on success
> and negative error code on failure. So return from this itself
> can be used while preserving error log in case of failure.
>=20
> This commit also fixes checkpatch.pl errors & warnings:
> - WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> - WARNING: line over 80 characters
> - ERROR: space prohibited before that ',' (ctx:WxW)
> - ERROR: code indent should use tabs where possible
> - WARNING: Block comments use * on subsequent lines

This should be split into separate patches, each doing one thing
as covered in submitting-patchs.rst.

--BOHdEyqYAbgZNeC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl47+V8ACgkQJNaLcl1U
h9BPKQf/fHvKdeAiBBwX2Gn0hIr6gFUSdbvE1pcAs5EUmIgpEl9xXPDDDoOSWb4s
oZoqxoyCLUBFKnoIwqdVM3GtqLxhqw6fTj4NvgFZ0/NOTiqWefZiQvfH2AFCfv0h
1/eKbCikOVboXctMsS21zWyGWd9MM02ckWnX2rK/32HsNzsbsW9TPm+lvwg34DYG
iIS/8w3tjHjE431ixpkBiZcrpSnM94x8c/WNZEO/K6B+gbgXbZK8zIZJbAjD95yL
2gdu2CwMEvoi4BhiZZ9wx0TSIRbTigPhffuaFOMonUadtnyfxuy4ADR2q7MxzQlU
f4Uzbo8vvdsc7dTw8sWiPd77rOQBfQ==
=WAMp
-----END PGP SIGNATURE-----

--BOHdEyqYAbgZNeC0--
