Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5241031E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 04:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKTDQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 22:16:55 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21891 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKTDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 22:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574219789; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kvodae3voxGK6Uu7IIOwf4k3vzBXUGaLw0ro2sYcCYzMCP686XxxRA0kizxnb+sDTn9qW/Y7tUbG9/DaLbD/4nlMuHj70e8hUOVNFIFIvxHCwIG4DBucJP/Pv5vzNK9OyluTh6D4doviP1ytZes1qKcUDudHjfMyYqSTK+JH2Ko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574219789; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=MPpuDfBJ/N2KT9uAgt79i/d1NoN4MZ/zhR/qcBRSnjI=; 
        b=MZSkSIM2ovwFFbWRGoc2Vyt7ws8TU102/DL+4zt6ncWEXU2ddgiIBjlloT3fNzAm0frBfc6H6rK1K78jQKsfXgFi24FNqfO0xE2/uYtOVRsraRB/4wcxZoLum6rJtDgryvU6fC4sp3/VHjmutM6UPwL/6T0mHr7EXJMdJE7AhtQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574219789;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1232; bh=MPpuDfBJ/N2KT9uAgt79i/d1NoN4MZ/zhR/qcBRSnjI=;
        b=ikgbbKBNEeLrK+wDYYpKhrLMfCBww/wp4QLGF1GCV9pCgoMcCBkFUB7kLpOuXdmU
        MoFGqV2y4gyzR78K1xt7IxSyRgQtJerUqcmembkcQjdd52iWeJ28Tpdl+BL/KBvWj6v
        mycinkL+HIuACkofmUso9gJIc9CRTXmtq7U7ZddY=
Received: from localhost (c-98-207-184-40.hsd1.ca.comcast.net [98.207.184.40]) by mx.zohomail.com
        with SMTPS id 1574219788314308.2839920954864; Tue, 19 Nov 2019 19:16:28 -0800 (PST)
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
Message-ID: <20191120031622.88949-1-stephen@brennan.io>
Subject: [PATCH v3 0/4] Raspberry Pi 4 HWRNG Support
Date:   Tue, 19 Nov 2019 19:16:18 -0800
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

After this series, the same command gives two random bytes.

Changes in v3:
- drop interrupts from bcm2711 rng node
- move bcm283x rng into bcm2835-common.dtsi
- add reviewed-by tag
- separated out patch 3 into two parts

Changes in v2:
- specify the correct size for the region in the dts, refactor bcm283x rng

---

Stefan Wahren (2):
  dt-bindings: rng: add BCM2711 RNG compatible
  hwrng: iproc-rng200: Add support for BCM2711

Stephen Brennan (2):
  ARM: dts: bcm2835: Move rng definition to common location
  ARM: dts: bcm2711: Enable HWRNG support

 .../devicetree/bindings/rng/brcm,iproc-rng200.txt          | 1 +
 arch/arm/boot/dts/bcm2711.dtsi                             | 7 +++----
 arch/arm/boot/dts/bcm2835-common.dtsi                      | 6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                             | 6 ------
 drivers/char/hw_random/Kconfig                             | 2 +-
 drivers/char/hw_random/iproc-rng200.c                      | 1 +
 6 files changed, 12 insertions(+), 11 deletions(-)

--=20
2.24.0



