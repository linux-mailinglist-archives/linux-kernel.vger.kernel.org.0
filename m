Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB40997B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfHUNx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:53:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49005 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727918AbfHUNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:53:56 -0400
X-UUID: 36b7aa7f27374b61b88835deaecafba3-20190821
X-UUID: 36b7aa7f27374b61b88835deaecafba3-20190821
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 634670488; Wed, 21 Aug 2019 21:53:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 21:53:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 21:53:43 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v10 00/23] MT8183 IOMMU SUPPORT
Date:   Wed, 21 Aug 2019 21:53:03 +0800
Message-ID: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mainly adds support for mt8183 IOMMU and SMI.

mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt8183 M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                       ----------
                       |        |
                   gals0-rx   gals1-rx
                       |        |
                       |        |
                   gals0-tx   gals1-tx
                       |        |
                      ------------
                       SMI Common
                      ------------
                           |
  +-----+-----+--------+-----+-----+-------+-------+
  |     |     |        |     |     |       |       |
  |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
  |     |     |        |     |     |       |       |
  |     |     |        |     |     |       |       |
  |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
  |     |     |        |     |     |       |       |
larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
disp  vdec   img     cam    venc   img    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional GALS between larb2/3/5/6
and SMI-common. GALS can help synchronize for the modules in different
clock frequency, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it doesn't have
the configuring register, thus it has the special "smi" clock and it
doesn't have the "apb" clock. From the diagram above, we add "gals0"
and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.

From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
Control Unit) is connected with smi-common directly, we can take them
as "larb2", "larb3" and "larb7", and their register spaces are
different with the normal larb.

The dtsi was sent at: [1] https://lore.kernel.org/patchwork/patch/1054099/

Change notes:
v10:
   1) Keep v7s only dealing with the pa32/pa33. Move the special "4gb mode"
    flow into mtk iommu. like v8 did.
   2) Split the "4gb mode" into two patches. one is only for the v7s, the other
    is for mtk iommu.
   3) Add a fixup patch(5/23) for 4gb mode, like v8 did.

v9: https://lists.linuxfoundation.org/pipermail/iommu/2019-August/037925.html
   1) rebase on v5.3-rc1.
   2) In v7s, Use oas to implement MTK 4GB mode. It nearly reconstruct the
      patch, so I don't keep the R-b.

v8: https://lists.linuxfoundation.org/pipermail/iommu/2019-June/037095.html
   1) From the 4GB mode:
      a. Move the patch sequency(Move "iommu/mediatek: Fix iova_to_phys PA
      start for 4GB mode" before "iommu/io-pgtable-arm-v7s: Extend MediaTek
      4G Mode").
      b. Remove the patch "Rename enable_4GB to dram_is_4gb" and Use Evan's
      suggestion.
   2) add a "union" for smi gen1/gen2 base.
   3) Clean up the structure "struct mtk_smi_iommu" since it have only one item,
      suggested from Matthias.

v7: https://lists.linuxfoundation.org/pipermail/iommu/2019-June/036552.html
   1) rebase on v5.2-rc1.
   2) Add fixed tags in patch 20.
   3) Remove shutdown patch. I will send it independently if necessary.

v6: https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033685.html
    1) rebase on v5.0-rc1.
    2) About the register name (VLD_PA_RNG), Keep consistent in the patches.
    3) In the 4GB mode, Always add MTK_4GB_quirk.
    4) Reword some commit message helped from Evan. like common->smi_ao_base is
       completely different from common->base; STANDARD_AXI_MODE reg is completely
       different from CTRL_MISC; commit in the shutdown patch.
    5) Add 2 new patches again:
       iommu/mediatek: Rename enable_4GB to dram_is_4gb
       iommu/mediatek: Fix iova_to_phys PA start for 4GB mode

v5: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html
    1) Remove this patch "iommu/mediatek: Constify iommu_ops" from here as it
       was applied for v5.0.
    2) Again, add 3 preparing patches. Move two property into the plat_data.
       iommu/mediatek: Move vld_pa_rng into plat_data
       iommu/mediatek: Move reset_axi into plat_data
       iommu/mediatek: Refine protect memory definition
    3) Add shutdown callback for mtk_iommu_v1 in patch[19/20].

v4: http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016205.html
    1) Add 3 preparing patches. Seperate some minor meaningful code into
       a new patch according to Matthias's suggestion.
       memory: mtk-smi: Add gals support         
       iommu/mediatek: Add larb-id remapped support 
       iommu/mediatek: Add bclk can be supported optionally       
    2) rebase on "iommu/mediatek: Make it explicitly non-modular"
       which was applied.
       https://lore.kernel.org/patchwork/patch/1020125/
    3) add some comment about "mediatek,larb-id" in the commit message of
       the patch "mtk-smi: Get rid of need_larbid".
    4) Fix bus_sel value.

v3: https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031121.html
    1) rebase on v4.20-rc1.
    2) In the dt-binding, add a minor string "mt7623" which also use gen1
       since Matthias added it in v4.20.
    3) About v7s:
       a) for paddr_to_pte, change the param from "arm_v7s_io_pgtable" to
          "arm_pgtable_cfg", according to Robin suggestion.
       b) Don't use CONFIG_PHYS_ADDR_T_64BIT.
       c) add a little comment(pgtable address still don't over 4GB) in the
          commit message of the patch "Extend MediaTek 4GB Mode".
    4) add "iommu/mediatek: Constify iommu_ops" into this patchset. this may
       be helpful for review and merge.
       https://lists.linuxfoundation.org/pipermail/iommu/2018-October/030637.html

v2: https://lists.linuxfoundation.org/pipermail/iommu/2018-September/030164.html
    1) Fix typo in the commit message of dt-binding.
    2) Change larb2/larb3 to the special larbs.
    3) Refactor the larb-id remapped array(larbid_remapped), then we
    don't need add the new function(mtk_iommu_get_larbid).
    4) Add a new patch for v7s two helpers(paddr_to_iopte and
    iopte_to_paddr).
    5) Change some comment for MTK 4GB mode.

v1: base on v4.19-rc1.
http://lists.infradead.org/pipermail/linux-mediatek/2018-September/014881.html

Yong Wu (23):
  dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
  iommu/mediatek: Use a struct as the platform data
  memory: mtk-smi: Use a general config_port interface
  memory: mtk-smi: Use a struct for the platform data for smi-common
  iommu/mediatek: Fix iova_to_phys PA start for 4GB mode
  iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
    helpers
  iommu/io-pgtable-arm-v7s: Use ias/oas to check the valid iova/pa
  iommu/io-pgtable-arm-v7s: Rename the quirk from MTK_4GB to MTK_EXT
  iommu/io-pgtable-arm-v7s: Extend to support PA[33:32] for MediaTek
  iommu/mediatek: Adjust the PA for the 4GB Mode
  iommu/mediatek: Add bclk can be supported optionally
  iommu/mediatek: Add larb-id remapped support
  iommu/mediatek: Refine protect memory definition
  iommu/mediatek: Move reset_axi into plat_data
  iommu/mediatek: Move vld_pa_rng into plat_data
  memory: mtk-smi: Add gals support
  iommu/mediatek: Add mt8183 IOMMU support
  iommu/mediatek: Add mmu1 support
  memory: mtk-smi: Invoke pm runtime_callback to enable clocks
  memory: mtk-smi: Add bus_sel for mt8183
  iommu/mediatek: Fix VLD_PA_RNG register backup when suspend
  memory: mtk-smi: Get rid of need_larbid
  iommu/mediatek: Clean up struct mtk_smi_iommu

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 ++-
 .../memory-controllers/mediatek,smi-common.txt     |  12 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   4 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |  80 ++++--
 drivers/iommu/mtk_iommu.c                          | 168 +++++++++----
 drivers/iommu/mtk_iommu.h                          |  21 +-
 drivers/iommu/mtk_iommu_v1.c                       |   6 +-
 drivers/memory/mtk-smi.c                           | 268 ++++++++++++++-------
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 ++++++++++
 include/linux/io-pgtable.h                         |   9 +-
 include/soc/mediatek/smi.h                         |   5 -
 11 files changed, 553 insertions(+), 180 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

-- 
1.9.1

