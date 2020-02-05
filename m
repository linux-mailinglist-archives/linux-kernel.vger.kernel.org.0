Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB915326F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgBEOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 09:03:57 -0500
Received: from 8bytes.org ([81.169.241.247]:51202 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgBEOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:03:56 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A5C8371; Wed,  5 Feb 2020 15:03:55 +0100 (CET)
Date:   Wed, 5 Feb 2020 15:03:54 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.6
Message-ID: <20200205140344.GA32375@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.6

for you to fetch changes up to e3b5ee0cfb65646f4a915643fe53e0a51829d891:

  Merge branches 'iommu/fixes', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next (2020-01-24 15:39:39 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.6

Including:

	- Allow to compile the ARM-SMMU drivers as modules.

	- Fixes and cleanups for the ARM-SMMU drivers and io-pgtable code
	  collected by Will Deacon. The merge-commit (6855d1ba7537) has all the
	  details.

	- Cleanup of the iommu_put_resv_regions() call-backs in various drivers.

	- AMD IOMMU driver cleanups.

	- Update for the x2APIC support in the AMD IOMMU driver.

	- Preparation patches for Intel VT-d nested mode support.

	- RMRR and identity domain handling fixes for the Intel VT-d driver.

	- More small fixes and cleanups.

----------------------------------------------------------------
Adrian Huang (6):
      iommu/amd: Treat per-device exclusion ranges as r/w unity-mapped regions
      iommu/amd: Remove local variables
      iommu/amd: Fix typos for PPR macros
      iommu/amd: Replace two consecutive readl calls with one readq
      iommu/amd: Remove unused struct member
      iommu/amd: Remove the unnecessary assignment

Ard Biesheuvel (1):
      iommu/arm-smmu: Support SMMU module probing from the IORT

Barret Rhoden (2):
      iommu/vt-d: Mark firmware tainted if RMRR fails sanity check
      iommu/vt-d: Add RMRR base and end addresses sanity check

Greg Kroah-Hartman (1):
      PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()

Jacob Pan (8):
      iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
      iommu/vt-d: Match CPU and IOMMU paging mode
      iommu/vt-d: Reject SVM bind for failed capability check
      iommu/vt-d: Avoid duplicated code for PASID setup
      iommu/vt-d: Fix off-by-one in PASID allocation
      iommu/vt-d: Replace Intel specific PASID allocator with IOASID
      iommu/vt-d: Avoid sending invalid page response
      iommu/vt-d: Misc macro clean up for SVM

Jean-Philippe Brucker (12):
      iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
      dt-bindings: document PASID property for IOMMU masters
      iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
      ACPI/IORT: Parse SSID property of named component node
      iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
      iommu/arm-smmu-v3: Add context descriptor tables allocators
      iommu/arm-smmu-v3: Add support for Substream IDs
      iommu/arm-smmu-v3: Propagate ssid_bits
      iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc() failure
      iommu/arm-smmu-v3: Add second level of context descriptor table
      iommu/arm-smmu-v3: Improve add_device() error handling
      PCI/ATS: Add PASID stubs

Jerry Snitselaar (1):
      iommu/vt-d: Call __dmar_remove_one_dev_info with valid pointer

Joerg Roedel (3):
      iommu/amd: Remove unused variable
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'iommu/fixes', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next

Krzysztof Kozlowski (1):
      iommu: Fix Kconfig indentation

Lu Baolu (16):
      iommu/vt-d: Add Kconfig option to enable/disable scalable mode
      iommu/vt-d: trace: Extend map_sg trace event
      iommu/vt-d: Avoid iova flush queue in strict mode
      iommu/vt-d: Loose requirement for flush queue initializaton
      iommu/vt-d: Identify domains using first level page table
      iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr
      iommu/vt-d: Add PASID_FLAG_FL5LP for first-level pasid setup
      iommu/vt-d: Setup pasid entries for iova over first level
      iommu/vt-d: Flush PASID-based iotlb for iova over first level
      iommu/vt-d: Make first level IOVA canonical
      iommu/vt-d: Update first level super page capability
      iommu/vt-d: Use iova over first level
      iommu/vt-d: debugfs: Add support to show page table internals
      iommu/vt-d: Allow devices with RMRRs to use identity domain
      iommu/vt-d: Unnecessary to handle default identity domain
      iommu/vt-d: Remove unnecessary WARN_ON_ONCE()

Masahiro Yamada (3):
      iommu/arm-smmu-v3: Fix resource_size check
      iommu/arm-smmu-v3: Remove useless of_match_ptr()
      iommu/arm-smmu: Fix -Wunused-const-variable warning

Qian Cai (1):
      iommu/iova: Silence warnings under memory pressure

Robin Murphy (5):
      iommu/io-pgtable-arm: Rationalise TTBRn handling
      iommu/io-pgtable-arm: Improve attribute handling
      iommu/io-pgtable-arm: Rationalise TCR handling
      iommu/io-pgtable-arm: Prepare for TTBR1 usage
      iommu/arm-smmu: Improve SMR mask test

Shameer Kolothum (1):
      iommu/arm-smmu-v3: Populate VMID field for CMDQ_OP_TLBI_NH_VA

Shuah Khan (1):
      iommu/amd: Fix IOMMU perf counter clobbering during init

Suravee Suthikulpanit (2):
      iommu/amd: Check feature support bit before accessing MSI capability registers
      iommu/amd: Only support x2APIC with IVHD type 11h/40h

Thierry Reding (5):
      iommu: Implement generic_iommu_put_resv_regions()
      iommu: arm: Use generic_iommu_put_resv_regions()
      iommu: amd: Use generic_iommu_put_resv_regions()
      iommu: intel: Use generic_iommu_put_resv_regions()
      iommu: virtio: Use generic_iommu_put_resv_regions()

Will Deacon (21):
      drivers/iommu: Export core IOMMU API symbols to permit modular drivers
      iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
      PCI: Export pci_ats_disabled() as a GPL symbol to modules
      drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
      iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
      drivers/iommu: Allow IOMMU bus ops to be unregistered
      Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
      Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
      iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
      iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
      iommu/arm-smmu-v3: Allow building as a module
      iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
      iommu/arm-smmu: Allow building as a module
      iommu/arm-smmu: Update my email address in MODULE_AUTHOR()
      drivers/iommu: Initialise module 'owner' field in iommu_device_set_ops()
      iommu/io-pgtable-arm: Support non-coherent stage-2 page tables
      iommu/io-pgtable-arm: Ensure ARM_64_LPAE_S2_TCR_RES1 is unsigned
      iommu/arm-smmu: Rename public #defines under ARM_SMMU_ namespace
      iommu/io-pgtable-arm: Rationalise VTCR handling
      iommu/arm-smmu-v3: Use WRITE_ONCE() when changing validity of an STE
      iommu/arm-smmu-v3: Return -EBUSY when trying to re-add a device

jimyan (1):
      iommu/vt-d: Don't reject Host Bridge due to scope mismatch

 Documentation/devicetree/bindings/iommu/iommu.txt |   6 +
 drivers/acpi/arm64/iort.c                         |  22 +-
 drivers/iommu/Kconfig                             |  35 +-
 drivers/iommu/Makefile                            |   3 +-
 drivers/iommu/amd_iommu.c                         |  12 +-
 drivers/iommu/amd_iommu_init.c                    |  79 +--
 drivers/iommu/amd_iommu_types.h                   |   7 +-
 drivers/iommu/arm-smmu-impl.c                     |   2 +-
 drivers/iommu/arm-smmu-v3.c                       | 600 ++++++++++++++++------
 drivers/iommu/arm-smmu.c                          | 334 +++++++-----
 drivers/iommu/arm-smmu.h                          | 228 ++++----
 drivers/iommu/dmar.c                              |  44 +-
 drivers/iommu/intel-iommu-debugfs.c               |  75 +++
 drivers/iommu/intel-iommu.c                       | 369 +++++++++----
 drivers/iommu/intel-pasid.c                       |  97 +---
 drivers/iommu/intel-pasid.h                       |   6 +
 drivers/iommu/intel-svm.c                         | 171 +++---
 drivers/iommu/io-pgtable-arm-v7s.c                |  22 +-
 drivers/iommu/io-pgtable-arm.c                    | 164 +++---
 drivers/iommu/io-pgtable.c                        |   2 +-
 drivers/iommu/iommu-sysfs.c                       |   5 +
 drivers/iommu/iommu.c                             |  51 +-
 drivers/iommu/iova.c                              |   2 +-
 drivers/iommu/ipmmu-vmsa.c                        |   2 +-
 drivers/iommu/msm_iommu.c                         |   4 +-
 drivers/iommu/mtk_iommu.c                         |   4 +-
 drivers/iommu/of_iommu.c                          |  25 +-
 drivers/iommu/qcom_iommu.c                        |  25 +-
 drivers/iommu/virtio-iommu.c                      |  14 +-
 drivers/pci/ats.c                                 |   2 +
 drivers/pci/pci.c                                 |   1 +
 include/linux/intel-iommu.h                       |  25 +-
 include/linux/io-pgtable.h                        |  27 +-
 include/linux/iommu.h                             |  19 +-
 include/linux/pci-ats.h                           |   3 +
 include/trace/events/intel_iommu.h                |  48 +-
 36 files changed, 1706 insertions(+), 829 deletions(-)

Please pull.

Thanks,

	Joerg

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl46y0AACgkQK/BELZcB
GuOukxAA3mY+BpqTPAiU638EIg/4FRdLHn9eN0Ywwo0PCwVms5bBLIAJlyo58qcq
xBi2vXcyF52jkYYFDsausYojyCR+d/OSitQ5Pa/Ce9K4lnAOT4GsV9LdW/Tv3/1o
UAxcetJAe5k6VWPJtDku4A+aqOM4NB4593nnjboPeJs5PWloec1xJnFB425S8IJV
DZvgfk+ki46euK0ru4ZF0JFFFTPjNdRCn5DV+GHe8nmEJ6agN6ZA7SoN1AnuCpQ6
Xm61muiYWjvsfowkMkCniK9bNyP+VHZOM5D9cRjANIS9PqQzJmbAjoXTrmatyHRJ
94vU4SqfIapV0hCXhtwjkF1bgcf1W54BnF3qAEscGbqNPznPyf8YlD1mGY2Ws8P1
JduBwLIB1RBsZTm/szVLLoqbH1wABz2hLIfemG9rIeFoK5NnwZCYKQyv8hQQu7e5
XUrH88VybKoKxtpDdkycJV2F+gkp0KTJdl8Wq4pD5wGOICuxGwH1X8VKFupbVDXc
+w0if2Y0a/LoV9zIs2QKMv7AukT898G+cvWIF2u/qTqxoZ17tBGgKbyBlzn371q3
bJlo16efhqTdTYmBZi/1TkzOc1Mn1tS187RmotxTOBAngu/sadfrMsYBRT/AwJeV
e/a+7TYnLIXnoUq1u5khcGIIHefYUzFKeZdH7WzmOic8wHtSOpM=
=cy10
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
