Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD21988C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgCaAUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:20:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaAUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:20:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so9500527pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nzstlQpIyRmo1VDCg2iWQAJyN95Yb00537nPa+CVJCU=;
        b=gZ3J4CaoSvY0pAx9b12IkXUUsAj4hJOGdGwXK8xSBf8TwdxNAPx507FelCRgohNBfV
         MDgEkp7PqXQvMYb4xLetmuFxv9WQNA0GjJcwPVGSPu55Q8IxDDnJwHjrqi9Lxfr5QYPN
         fqE04SBjbvkY08Ubf5skIBgDMSJR0LbARqBG2WtX2jaYjaefAtvlOjdGzLfR6/UTCubF
         +lt0dOpBsCY2vKley4ZnzbXOTUkp2KFAv/cvqk9ddutU+vc6EJnEbORiQyXTjdwW9T1T
         kCI13kPKbrOxGbnh69mn0bSSQMcTzvPXj1SPvq6yk+J4bM9eeKHKNYYsu4xTJonoRFI5
         FFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nzstlQpIyRmo1VDCg2iWQAJyN95Yb00537nPa+CVJCU=;
        b=Rthadc1BQFads3F6O3qyk34gBV9ocQ/iKspWGwysWkDiIJyFZMLZ8JOlQoZN/FH1ld
         oxbVU7Pb/L3g7kOJJCHUDm73FJ7HVlYn5Inga6TaG4royBlZlDsBHEEZLD6uPJw4vz98
         7g/yFvhAWVgdlh1ssP30r1A81NGx/6q9HZ2DRFkM2YPqyXycwqhZXYknfDKpK6RCNn2x
         UQ+gF+5MAhd33zlwh1wnE+o88m5LBSgI/1dNeQ81Ij10f9dIU0AyIMgmBOtYl0PlG3n4
         rYp2e/Wyfdlq0JMj8jPF/vuZnTquEBzzJNs1361bLArwYYCo++09EJvUekmB7ZfHI0N3
         O9Vg==
X-Gm-Message-State: ANhLgQ2svFiki0KsXU9Hv3IPq46oaFvSK+/uIPpeVpxErfgRwBhb8j2c
        EMJYJvf/xzY6nzFn95pEVj3hRVc0mG4=
X-Google-Smtp-Source: ADFU+vs2WgX1p7+yezebAWm866yMzqxV0S8XOHv2B+LmfMjIZfh0mO41rhIPlCTm0DQn9h0F6RABGg==
X-Received: by 2002:a05:6a00:c8:: with SMTP id e8mr14715763pfj.131.1585614000257;
        Mon, 30 Mar 2020 17:20:00 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id w127sm11069176pfb.70.2020.03.30.17.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2020 17:19:59 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, kishon@ti.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: Warn about MEM resource size being too big
Date:   Mon, 30 Mar 2020 17:19:47 -0700
Message-Id: <1585613987-8453-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output a warning for MEM resource size with
non-zero upper 32-bits.

ATU programming functions limit the size of
the translated region to 4GB by using a u32 size
parameter. Function dw_pcie_prog_outbound_atu()
does not program the upper 32-bit ATU limit
register. This may result in undefined behavior
for resource sizes with non-zero upper 32-bits.

For example, a 128GB address space starting at
physical CPU address of 0x2000000000 with size of
0x2000000000 needs the following values programmed
into the lower and upper 32-bit limit registers:
 0x3fffffff in the upper 32-bit limit register
 0xffffffff in the lower 32-bit limit register

Currently, only the lower 32-bit limit register is
programmed with a value of 0xffffffff but the upper
32-bit limit register is not being programmed.
As a result, the upper 32-bit limit register remains
at its default value after reset of 0x0. This would
be a problem for a 128GB PCIe space because in
effect its size gets reduced to 4GB.

ATU programming functions can be changed to
specify a u64 size parameter for the translated
region. Along with this change, the internal
calculation of the limit address, the address of
the last byte in the translated region, needs to
change such that both the lower 32-bit and upper
32-bit limit registers can be programmed correctly.

Changing the ATU programming functions is high
impact. Without change, this issue can go
unnoticed. A warning may prompt the user to
look into possible issues.

This limitation also means that multiple ATUs
would need to be used to map larger regions.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 395feb8ca051..37a8c71ef89a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
+	resource_size_t mem_size;
 	u32 hdr_type;
 	int ret;
 
@@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
 			pp->mem->name = "MEM";
-			pp->mem_size = resource_size(pp->mem);
+			mem_size = resource_size(pp->mem);
+			if (upper_32_bits(mem_size))
+				dev_warn(dev, "MEM resource size too big\n");
+			pp->mem_size = mem_size;
 			pp->mem_bus_addr = pp->mem->start - win->offset;
 			break;
 		case 0:
-- 
2.7.4

