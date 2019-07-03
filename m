Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B55E305
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGCLnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 07:43:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35418 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dHtc+HC/gZMsg89GcjEjwooumgr81KnKaASpELhhe/k=; b=nTdK0RmjvwVVsCLNaH9eiQAq9
        o2zDmjgxTuvd5zpxHUekW3Emf4H0kCtejF/OtGRV6CojuZeGcNkPUKr2I+4PXoy+2eQmYVjLvVoaC
        wVAOtCM34t/l0kPKselrnf5A5KW1thg2caQOVX2sHfgo7U33lTPDcRQzyO5kYtYF9NR7o=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hidfJ-0005rp-31; Wed, 03 Jul 2019 11:43:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 64149440046; Wed,  3 Jul 2019 12:43:08 +0100 (BST)
Date:   Wed, 3 Jul 2019 12:43:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] debugfs: log errors when something goes wrong
Message-ID: <20190703114308.GU2793@sirena.org.uk>
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
 <20190703071653.2799-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ImSVV91IQg5ga+3z"
Content-Disposition: inline
In-Reply-To: <20190703071653.2799-2-gregkh@linuxfoundation.org>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ImSVV91IQg5ga+3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2019 at 09:16:53AM +0200, Greg Kroah-Hartman wrote:
> As it is not recommended that debugfs calls be checked, it was pointed
> out that major errors should still be logged somewhere so that
> developers and users have a chance to figure out what went wrong.  To
> help with this, error logging has been added to the debugfs core so that
> it is not needed to be present in every individual file that calls
> debugfs.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ImSVV91IQg5ga+3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0clMgACgkQJNaLcl1U
h9CsxAf/SAu4STWFRIPGShGVgEIX9T3573oTxMdMrJRG6lI2QjpOqsBhcpKKcjqz
oS5JkGIAa3Nju5YF9r3bi4Fyrg4f5SN+kiy25C+IAg99Oar7s0TyIn5xuC02z30A
kBK6MZxKFSnqDa5RqmHx2TPFxb/H8CRza8KAktHI0qa/8qT7vZWVOLfbokSSK7aH
ZNZz6MHxliJC6lYo+c55nYUk39CYxhJ/vROILwwqUWgCZuL2qBIPOuwGzkwyU+jx
gyE3IoAEo9ujYETzGVP2CqIKqe/qHA4vkfKOzj1GB4wVf/yar6UVKGtftIGj4gnV
RdNvU8OVSYUgm3hKQ/jf+FMkxy/2qA==
=JbGm
-----END PGP SIGNATURE-----

--ImSVV91IQg5ga+3z--
