Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBC8347E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfHFO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:57:29 -0400
Received: from foss.arm.com ([217.140.110.172]:34660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732976AbfHFO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B6EC344;
        Tue,  6 Aug 2019 07:57:28 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05F93F706;
        Tue,  6 Aug 2019 07:57:26 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] irqdomain/debugfs: Fix uses of irq_domain_alloc_fwnode
Date:   Tue,  6 Aug 2019 15:57:08 +0100
Message-Id: <20190806145716.125421-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently noticed that all irq_domain_alloc_fwnode were passing a VA
to it, which is unfortunate as this is designed to appear in debugfs
(and we don't like to leak VAs). Disaster was avoided thanks to our
____ptrval____ friend, but it remains that the whole thing is pretty
useless if you have more than a single domain (they all have the same
name and creation fails).

In order to sort it out, change all users of irq_domain_alloc_fwnode
to pass the PA of the irqchip the domain will be associated with. One
notable exception is the HyperV PCI controller driver which has no PA
to associate with. This is solved by using a named fwnode instead,
using the device GUID.

Finally, irq_domain_alloc_fwnode() is changed to pa a pionter to a PA,
which can be safely advertised in debugfs.

Marc Zyngier (8):
  irqchip/gic-v3: Register the distributor's PA instead of its VA in
    fwnode
  irqchip/gic-v3-its: Register the ITS' PA instead of its VA in fwnode
  irqchip/gic: Register the distributor's PA instead of its VA in fwnode
  irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode
  irqchip/ixp4xx: Register the base PA instead of its VA in fwnode
  gpio/ixp4xx: Register the base PA instead of its VA in fwnode
  PCI: hv: Allocate a named fwnode instead of an address-based one
  irqdomain/debugfs: Use PAs to generate fwnode names

 drivers/gpio/gpio-ixp4xx.c          |  2 +-
 drivers/irqchip/irq-gic-v2m.c       |  2 +-
 drivers/irqchip/irq-gic-v3-its.c    |  2 +-
 drivers/irqchip/irq-gic-v3.c        |  2 +-
 drivers/irqchip/irq-gic.c           |  2 +-
 drivers/irqchip/irq-ixp4xx.c        |  2 +-
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 include/linux/irqdomain.h           |  6 +++---
 kernel/irq/irqdomain.c              |  9 +++++----
 9 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.20.1

