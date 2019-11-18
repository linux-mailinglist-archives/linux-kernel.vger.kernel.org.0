Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1E100026
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 09:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKRIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 03:14:02 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21839 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:14:01 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2019 03:14:01 EST
ARC-Seal: i=1; a=rsa-sha256; t=1574063907; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=n6ZjxkhAaCYdVbmonyMT0gX8EtdaPseXqA8EVlamRr14hEIO4ZIPQuN3Th/p0tFNLHSlK0iQPaeUNip2/ohWm6MW33vHSoZ8IApAVOQIUs/MnLyAmyCGwuy+TxYLLPjaae5BLQKRdxtJDCJH2s7X/k8ykW64Ep8D6sw3BosQ7Vo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574063907; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=QaA7BDbSdX9jfQDBkM/kSQl2g+5tNndLUXgFesI8JtU=; 
        b=jmPe8liHwyhc+lisp/S0bh1t+B/fnJYcuQwzN8exNKgyt763W7UA2QDkcB0YIXqYdZP724iOHuTAWbTEgokonhFpAR8+R3CJ3hbz++aoUvpH+k/CEUtL90JKiK/zQeSqkPFDIR1eT0g2D+pDGxtrrOLKMVv6uafy8nWU5fnaKXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574063907;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=864; bh=QaA7BDbSdX9jfQDBkM/kSQl2g+5tNndLUXgFesI8JtU=;
        b=gGcgYyBnfcHlRSvkWvOyaMKlDuqnVHD02oQQ6lKwfw9HdpqJzHZ64areSk9yJro2
        nRfGp4wk4iw8ICXEKmystIxgKJ/3oXMM4LdHyCDYkiJc4VeNVGxcZTnm6KBK6RT5grj
        kNawSeC6tTY81TexVMAwtRyTvFukohJOqFzW4xmU=
Received: from localhost (195.173.24.136.in-addr.arpa [136.24.173.195]) by mx.zohomail.com
        with SMTPS id 1574063905483664.0921926369589; Sun, 17 Nov 2019 23:58:25 -0800 (PST)
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
Message-ID: <20191118075807.165126-1-stephen@brennan.io>
Subject: [PATCH 0/3] Raspberry Pi 4 HWRNG Support
Date:   Sun, 17 Nov 2019 23:58:04 -0800
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables support for the HWRNG included on the Raspberry
Pi 4.  It is simply a rebase of Stefan's branch [1]. I went ahead and
tested this out on a Pi 4.  Prior to this patch series, attempting to use
the hwrng gives:

    $ head -c 2 /dev/hwrng
    head: /dev/hwrng: Input/output error

After this patch, the same command gives two random bytes.

[1]: https://github.com/lategoodbye/rpi-zero/tree/bcm2711-hwrng

---

Stefan Wahren (3):
  dt-bindings: rng: add BCM2711 RNG compatible
  hwrng: iproc-rng200: Add support for BCM2711
  ARM: dts: bcm2711: Enable HWRNG support

 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 1 +
 arch/arm/boot/dts/bcm2711.dtsi                              | 5 ++---
 drivers/char/hw_random/Kconfig                              | 2 +-
 drivers/char/hw_random/iproc-rng200.c                       | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

--=20
2.24.0



