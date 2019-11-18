Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB2FFFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfKRH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 02:59:44 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21455 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfKRH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:59:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574063913; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Xk3i65B4Fu5x4VFH4ySsKzvsxbJO8zq+L05B611f30tGjhtITbjeA83awA2Q672Biu6cpGKIsn8umUiousOZLwOEsQxmSX/Wa7929nUDz75yPVUKGBC2cOQtsXcak6injbiGnpTpkh1N6wbfjIn4mNKkbKHrNpIqs/0AxRdHuns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574063913; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rnDOXSZ5PSkKW71tjFE4P0SpeDfoougigqcTZkEQtXI=; 
        b=RnIQVKi4hXA2dQ8ac8gNEsOOTJowF+cpfvkILkMsbyZTXdaVtYolqbrMbp8UwF+mYQiJf7lRhLalRBpzau1Spb0J0ACztNqyiEhuwb1vYKqLgDVPIq93u8ITwBDigz0iKyrmfazFQbPPzPPWPciHxpUzHvBHBFRoiX6cHj+jxDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574063913;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1520; bh=rnDOXSZ5PSkKW71tjFE4P0SpeDfoougigqcTZkEQtXI=;
        b=cpe26RcfhGlm7P/YpwYbB0VyjPEXbGW/F2PpjV214dtdUTxLjbWG/Ui6hXz/9dLk
        wosu0VD+cIhsMExFhUtJoQZDvbWr2Tjjfp8PoE7MuyJnWnoVgfVgL29lTentLPPnXP3
        SSGn7jYKIV+yoj0o1D1/IjaGGV0sgtedLIQF9XOI=
Received: from localhost (195.173.24.136.in-addr.arpa [136.24.173.195]) by mx.zohomail.com
        with SMTPS id 1574063912030754.6313842017521; Sun, 17 Nov 2019 23:58:32 -0800 (PST)
From:   Stephen Brennan <stephen@brennan.io>
To:     stephen@brennan.io
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Message-ID: <20191118075807.165126-3-stephen@brennan.io>
Subject: [PATCH 2/3] hwrng: iproc-rng200: Add support for BCM2711
Date:   Sun, 17 Nov 2019 23:58:06 -0800
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118075807.165126-1-stephen@brennan.io>
References: <20191118075807.165126-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

BCM2711 features a RNG200 hardware random number generator block.
So make the driver available.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Stephen Brennan <stephen@brennan.io>
---
 drivers/char/hw_random/Kconfig        | 2 +-
 drivers/char/hw_random/iproc-rng200.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfi=
g
index 7c7fecfa2fb2..77e848fca531 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -90,7 +90,7 @@ config HW_RANDOM_BCM2835
=20
 config HW_RANDOM_IPROC_RNG200
 =09tristate "Broadcom iProc/STB RNG200 support"
-=09depends on ARCH_BCM_IPROC || ARCH_BRCMSTB
+=09depends on ARCH_BCM_IPROC || ARCH_BCM2835 || ARCH_BRCMSTB
 =09default HW_RANDOM
 =09---help---
 =09  This driver provides kernel-side support for the RNG200
diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random=
/iproc-rng200.c
index 899ff25f4f28..32d9fe61a225 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -213,6 +213,7 @@ static int iproc_rng200_probe(struct platform_device *p=
dev)
 }
=20
 static const struct of_device_id iproc_rng200_of_match[] =3D {
+=09{ .compatible =3D "brcm,bcm2711-rng200", },
 =09{ .compatible =3D "brcm,bcm7211-rng200", },
 =09{ .compatible =3D "brcm,bcm7278-rng200", },
 =09{ .compatible =3D "brcm,iproc-rng200", },
--=20
2.24.0



