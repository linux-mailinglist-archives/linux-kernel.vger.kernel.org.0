Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04C101929
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 07:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKSGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 01:14:46 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21825 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSGOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:14:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574144058; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FDZb191bVzzsmEhPHuSDRaaVt7KFIt6KQmswEHW57HA+Cvb8V+jTzRidED3Tjz7Xm96HWmBJ7KUDXQFl/wjoCpoaPSqhcNZQRr+QI1U97jojCKx5XpR+c1FKu2C/BpuLbqkIk0+59jlaUXPiT8tqqwLVOT0XK8sQTd8miJsEwcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574144058; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=c7L5ybwI41MQuUShcRtA57Ge+Ip1hk0Hb3ub23HMqaQ=; 
        b=EVXnrACu/oK4Kz7ddwHdXs5N6VnpFcWRdQG9wf0BHjbCuxoDJM7S4BjU6QO8iYXtX681eQb1ErHkAvTEanYfEATZCIxq1Wkgi6i04HB+ajTd5RHK+VyHNi62Sfs6BEwZqyDs6yUQcFAUFTfV0iDJqtna60s3e/2DS9IpQH8AMpo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574144058;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1186; bh=c7L5ybwI41MQuUShcRtA57Ge+Ip1hk0Hb3ub23HMqaQ=;
        b=cwmy2wB55tgQXK/vQOWlD0swe4jSvp7d9+e6rK8Bvpfqq1lWyISr2Q+caX1K0uKJ
        iN4iRAVa+khnM2t8o0YWkT58iS9CLOjGLSYm89a2+NqqcvA+if0BGcX+3P3U22kjJqV
        gaYUl4LZ9JiVjTQYu9Gxf29gt7KjG/K0mdCxuxT0=
Received: from localhost (195.173.24.136.in-addr.arpa [136.24.173.195]) by mx.zohomail.com
        with SMTPS id 1574144058311185.86846931854632; Mon, 18 Nov 2019 22:14:18 -0800 (PST)
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
Message-ID: <20191119061407.69911-1-stephen@brennan.io>
Subject: [PATCH v2 0/3] Raspberry Pi 4 HWRNG Support
Date:   Mon, 18 Nov 2019 22:14:04 -0800
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

Changes in v2:
- specify the correct size for the region in the dts, refactor bcm283x rng

---

Stefan Wahren (2):
  dt-bindings: rng: add BCM2711 RNG compatible
  hwrng: iproc-rng200: Add support for BCM2711

Stephen Brennan (1):
  ARM: dts: bcm2711: Enable HWRNG support

 .../devicetree/bindings/rng/brcm,iproc-rng200.txt     |  1 +
 arch/arm/boot/dts/bcm2711.dtsi                        |  6 +++---
 arch/arm/boot/dts/bcm2835.dtsi                        |  1 +
 arch/arm/boot/dts/bcm2836.dtsi                        |  1 +
 arch/arm/boot/dts/bcm2837.dtsi                        |  1 +
 arch/arm/boot/dts/bcm283x-common.dtsi                 | 11 +++++++++++
 arch/arm/boot/dts/bcm283x.dtsi                        |  6 ------
 drivers/char/hw_random/Kconfig                        |  2 +-
 drivers/char/hw_random/iproc-rng200.c                 |  1 +
 9 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-common.dtsi

--=20
2.24.0



