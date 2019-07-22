Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5150C6FFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfGVMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 08:38:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfGVMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEkGLo6H5lqpjsiZnQeV/ZHgCI1W32utWFYTDn5ZlaQ=; b=C60VjZZMx6KiWdig5LVdRmLCQ
        K+MLoHwjJlPDly/XGC9L6Z47exQzuYkpc69yEHyy8VH3GuQsdfoFQYNYjj1sgHwUcH05Wytttzin2
        yT5RYa8aETC79fAv52QXA16tbZgC6WnkXYuR8R4O5sALGF1MMDugT1VOBRXPJNUjm+guU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXaV-0007k1-SQ; Mon, 22 Jul 2019 12:38:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5FE33274046A; Mon, 22 Jul 2019 13:38:43 +0100 (BST)
Date:   Mon, 22 Jul 2019 13:38:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] kasan: remove clang version check for KASAN_STACK
Message-ID: <20190722123843.GD4756@sirena.org.uk>
References: <20190719200347.2596375-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <20190719200347.2596375-1-arnd@arndb.de>
X-Cookie: No skis take rocks like rental skis!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2019 at 10:03:31PM +0200, Arnd Bergmann wrote:
> asan-stack mode still uses dangerously large kernel stacks of
> tens of kilobytes in some drivers, and it does not seem that anyone
> is working on the clang bug.

Reviewed-by: Mark Brown <broonie@kernel.org>

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl01rlIACgkQJNaLcl1U
h9AMdwf/cTbheHdxyepR8MP8hqtk3YqkwtBTUpzuDAyZT8PHKcPsQBq6HaTt/Yh5
qhMtyDkazgIc+JMiMCpyGYrS3jvqxMgxbX6QF/tiEOfdK+A/RAH3YrGQxTUI1zYx
jl5L4OqPk3Pa7m4vhaZJ1nq0naBu8dIV38m+fprFauU1UBfTqFHmua1j1pq23HDt
WmSObYpdH5bTVgr06glLOi0CCbNoyenRx21isHoEbiTtDmuoYwtpejj20XyGVhr8
+vk7kCDUNN2vXckLC8E8e5K63/rSeP4MXcQcEvmBXP0dwbgAG0CNoPtH2YEjXm8q
h7o+E/ty9fV8bEfGm4GgnR+Y3BuYlg==
=N10E
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
