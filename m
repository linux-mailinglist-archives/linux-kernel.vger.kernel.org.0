Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE89B0392
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfIKSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 14:25:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbfIKSZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:25:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62098AC28;
        Wed, 11 Sep 2019 18:25:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org
Cc:     f.fainelli@gmail.com, will@kernel.org, linux-mm@kvack.org,
        robin.murphy@arm.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: [PATCH v6 0/4] Raspberry Pi 4 DMA addressing support
Date:   Wed, 11 Sep 2019 20:25:42 +0200
Message-Id: <20190911182546.17094-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
this series attempts to address some issues we found while bringing up
the new Raspberry Pi 4 in arm64 and it's intended to serve as a follow
up of these discussions:
v5: https://lkml.org/lkml/2019/9/9/170
v4: https://lkml.org/lkml/2019/9/6/352
v3: https://lkml.org/lkml/2019/9/2/589
v2: https://lkml.org/lkml/2019/8/20/767
v1: https://lkml.org/lkml/2019/7/31/922
RFC: https://lkml.org/lkml/2019/7/17/476

The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
only address the first GB: their DMA address range is
0xc0000000-0xfc000000 which is aliased to the first GB of physical
memory 0x00000000-0x3c000000. Note that only some peripherals have these
limitations: the PCIe, V3D, GENET, and 40-bit DMA channels have a wider
view of the address space by virtue of being hooked up trough a second
interconnect.

Part of this is solved on arm32 by setting up the machine specific
'.dma_zone_size = SZ_1G', which takes care of reserving the coherent
memory area at the right spot. That said no buffer bouncing (needed for
dma streaming) is available at the moment, but that's a story for
another series.

Unfortunately there is no such thing as 'dma_zone_size' in arm64. Only
ZONE_DMA32 is created which is interpreted by dma-direct and the arm64
arch code as if all peripherals where be able to address the first 4GB
of memory.

In the light of this, the series implements the following changes:

- Create both DMA zones in arm64, ZONE_DMA will contain the first 1G
  area and ZONE_DMA32 the rest of the 32 bit addressable memory. So far
  the RPi4 is the only arm64 device with such DMA addressing limitations
  so this hardcoded solution was deemed preferable.

- Properly set ARCH_ZONE_DMA_BITS.

- Reserve the CMA area in a place suitable for all peripherals.

This series has been tested on multiple devices both by checking the
zones setup matches the expectations and by double-checking physical
addresses on pages allocated on the three relevant areas GFP_DMA,
GFP_DMA32, GFP_KERNEL:

- On an RPi4 with variations on the ram memory size. But also forcing
  the situation where all three memory zones are nonempty by setting a 3G
  ZONE_DMA32 ceiling on a 4G setup. Both with and without NUMA support.

- On a Synquacer box[1] with 32G of memory.

- On a Cavium ThunderX2 with 256GB of memory.

- On an ACPI based Huawei TaiShan server[2] with 256G of memory.

- On a QEMU virtual machine running arm64's OpenSUSE Tumbleweed.

That's all.

Regards,
Nicolas

[1] https://www.96boards.org/product/developerbox/
[2] https://e.huawei.com/en/products/cloud-computing-dc/servers/taishan-server/taishan-2280-v2

---

Changes in v6:
- Fix bug in max_zone_phys()

Changes in v5:
- Fix issue with swiotlb initialization

Changes in v4:
- Rebased to linux-next
- Fix issue when NUMA=n and ZONE_DMA=n
- Merge two max_zone_dma*_phys() functions

Changes in v3:
- Fixed ZONE_DMA's size to 1G
- Update mmzone.h's comment to match changes in arm64
- Remove all dma-direct patches

Changes in v2:
- Update comment to reflect new zones split
- ZONE_DMA will never be left empty
- Try another approach merging both ZONE_DMA comments into one
- Address Christoph's comments
- If this approach doesn't get much traction I'll just drop the patch
  from the series as it's not really essential

Nicolas Saenz Julienne (4):
  arm64: mm: use arm64_dma_phys_limit instead of calling
    max_zone_dma_phys()
  arm64: rename variables used to calculate ZONE_DMA32's size
  arm64: use both ZONE_DMA and ZONE_DMA32
  mm: refresh ZONE_DMA and ZONE_DMA32 comments in 'enum zone_type'

 arch/arm64/Kconfig            |  4 ++
 arch/arm64/include/asm/page.h |  2 +
 arch/arm64/mm/init.c          | 71 +++++++++++++++++++++++++----------
 include/linux/mmzone.h        | 45 ++++++++++++----------
 4 files changed, 83 insertions(+), 39 deletions(-)

-- 
2.23.0

