Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5958B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF0Tzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 15:55:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Tza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665329; x=1593201329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oQMIBe4X+ZjTJgO+RVN0FBG87NxgHXHIhEqoSO1Ulas=;
  b=CryAIpE7+zwyO+o322PXl//j8b5VCcQKz9oQOaOC3/d0IUUrIwryqw3N
   g61y8O00V+AIUH1SPAaO3X7EGXSGSpqiU8uZNuS6SuxW36J66wRz1Lkve
   Unpgn4qQYfUcZwLquSnFTbbGmAMrEKe+UobFKzT2z0a5rhRuVfCl7UGBl
   +8AnduDvPPKw0ykDy7EEYV39uO1sUFip+FAtaCLOLaTwwRa1MOgqX9GEW
   WRIj5UIB7cwGqhTXPmLIa3FD55vEP8AhzgGvJZIKn/2y0G4yw6Vd6Ijda
   2zPa0bIDHu4lJMmxGKNKVrgu3XWPYwto5VCDXJ42m80KJdh+Kg7LgG0Yp
   g==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927466"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:29 +0800
IronPort-SDR: HMKH8QWbrWA6J9efJC2ADmscU6l3hO1gBEJziRdcJQcolMfWrDdrLPr1/ifNyZxMNS79tfKiXL
 DNl6cVcsvxn8GS2946Q969mSUFrpNtQifoL57TiVMvM1Ovz8OFZtYzYP32v4XeXJfGvoIyXdny
 JZM0mA1qXHh25i3XKj6Uo9EvMvRKtnFD1BfcLLLQiD7oaiXlu6l/YIQWg99C/TQxjnUtm1Ckad
 ly/oEjptJ2skpvqHFesbGUlv7FjQCfUDzwz8FTqZZX59DqVjVJjCSJe0epdoHBzo815kdKRKAP
 cbEkItu0kzHjAubj4kPvTVPv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:42 -0700
IronPort-SDR: VKMKNLoNwcVlcafpKYKocVIPgXmwVxuRxjJwhvS06W1GGyBrtK7utAxstFIXBnWKdzCF1x8wsK
 XJZctog61N4/pDEuD0ioEVUe5arFvGOiD+0uQOXuasKnvmvKaP5h/TGkH6UL8gbfz0YoH51WFH
 xrSwRYbO/moGR7R87FJCQ97cpTUvhwbD5ewCvzhOpnTniTpRB+KlumuU7I2vU8/O4gvbAauHLz
 cgrRMGMuG4NbZ/B6aDXGUTCFMTaGyew2ePpYxLxvH6dLfxOxh3jbGPfnhFGwCTZ/6aqR+81OZT
 sHw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 7/7] MAINTAINERS: Add an entry for generic architecture topology
Date:   Thu, 27 Jun 2019 12:53:02 -0700
Message-Id: <20190627195302.28300-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

arm and arm64 shared lot of CPU topology related code. This was
consolidated under driver/base/arch_topology.c by Juri. Now RISC-V
is also started sharing the same code pulling more code from arm64
into arch_topology.c

Since I was involved in the review from the beginning, I would like
to assume maintenance for the same.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..453d2eebcff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6594,6 +6594,13 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-gemtek*
 
+GENERIC ARCHITECTURE TOPOLOGY
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/base/arch_topology.c
+F:	include/linux/arch_topology.h
+
 GENERIC GPIO I2C DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 S:	Supported
-- 
2.21.0

