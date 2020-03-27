Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9EB1950DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgC0GKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 02:10:51 -0400
Received: from foss.arm.com ([217.140.110.172]:40764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgC0GKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF097FA;
        Thu, 26 Mar 2020 23:10:50 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (unknown [10.57.25.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585553F71F;
        Thu, 26 Mar 2020 23:14:51 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: [PATCH v7 0/3] hw_random: introduce Arm CryptoCell TRNG driver
Date:   Fri, 27 Mar 2020 09:10:20 +0300
Message-Id: <1585289423-18440-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm CryptoCell is a hardware security engine.
This patch introduces driver for its TRNG (True Random Number Generator)
engine.

v7 change: in arm-cctrng.yaml, removed unneeded 'minitems'

v6 change: add missing initialization of hwrng quality.

v5 changes:
	1. in arm-cctrng.yaml, fixed error in 'make dt_binding_check'
	2. in cctrng.c, clean up cctrng clock handling

v4 changes: update arm-cctrng.yaml to conform with json-schema standard.

v3 change: removed few unneeded "#ifdef CONFIG_PM" from the code.

v2 changes: fixed 'make dt_bnding_check' errors.

Hadar Gat (3):
  dt-bindings: add device tree binding for Arm CryptoCell trng engine
  hw_random: cctrng: introduce Arm CryptoCell driver
  MAINTAINERS: add HG as cctrng maintainer

 .../devicetree/bindings/rng/arm-cctrng.yaml        |  54 ++
 MAINTAINERS                                        |   9 +
 drivers/char/hw_random/Kconfig                     |  12 +
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/cctrng.c                    | 736 +++++++++++++++++++++
 drivers/char/hw_random/cctrng.h                    |  72 ++
 6 files changed, 884 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/arm-cctrng.yaml
 create mode 100644 drivers/char/hw_random/cctrng.c
 create mode 100644 drivers/char/hw_random/cctrng.h

-- 
2.7.4

