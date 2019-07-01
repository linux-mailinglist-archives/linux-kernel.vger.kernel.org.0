Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2E1C16F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 06:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfENEfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 00:35:11 -0400
Received: from ozlabs.org ([203.11.71.1]:55491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENEfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:35:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4534bt06r8z9sBp;
        Tue, 14 May 2019 14:35:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557808506;
        bh=0Lh+ilcg6a9yyxuJ0+pLMi+hmobW3LO2bO8SilpSinQ=;
        h=Date:From:To:Cc:Subject:From;
        b=roaRPSaRjFioCRc3qXlkfX5HAzdSWOvwuO49XF9no6mVmQTyzSIfnHX2WTqWHgbY7
         dTKzwkmv4mHSFm+vGAolcCBUN9o04K9WXHI2rXZCWTWUyNepg5mJ9C8S2a9aVolf44
         4E3XdUbLvY3dz+amjhoR6to/3SQ3caBM+ZjIDNb5BTztGuHwNY7O/mjuL1Z9OSTepS
         3/qAPcOZBlxVV0X/Ev9T6PXp0gTUIFoA4p5k5az8Zd4H+PEg6ZYWDtsJIZowXcM6zs
         9Giep2HX43oBFIfAMSmUQAr0NldxAa7+FxR1QyxX2eGXJkgkLg9ONoldRCV5NROkJM
         QRFYRqeudvA9w==
Date:   Tue, 14 May 2019 14:35:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 14
Message-ID: <20190514143502.5d62cc13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MqQdP_HxdBrzjZL.CCVrD8="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MqQdP_HxdBrzjZL.CCVrD8=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v5.3 material to your linux-next included
trees/branches until after v5.2-rc1 has been released.

Changes since 20190513:

The thermal-soc tree still had its build failure for which I applied a
patch.

Non-merge commits (relative to Linus' tree): 2499
 2385 files changed, 77440 insertions(+), 25834 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 298 trees (counting Linus' and 69 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (a13f0655503a Merge tag 'iommu-updates-v5.2' of ssh:/=
/gitolite.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging fixes/master (d15da9d3fb74 kernel/compat.c: mark expected switch fa=
ll-throughs)
Merging kspp-gustavo/for-next/kspp (ccaa75187a5f memstick: mark expected sw=
itch fall-throughs)
Merging kbuild-current/fixes (a2d635decbfa Merge tag 'drm-next-2019-05-09' =
of git://anongit.freedesktop.org/drm/drm)
Merging arc-current/for-curr (ea4bb8f4c41b ARC: mm: SIGSEGV userspace tryin=
g to access kernel virtual memory)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (4e69ecf4da1e arm64/module: ftrace: deal=
 with place relative nature of PLTs)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (12f363511d47 powerpc/32s: Fix BATs setting wit=
h CONFIG_STRICT_KERNEL_RWX)
Merging sparc/master (b970afcfcabd Merge tag 'powerpc-5.2-1' of ssh://gitol=
ite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (d4c26eb6e721 net: ethernet: stmmac: dwmac-sun8i: enable=
 support of unicast filtering)
Merging bpf/master (69dda13fdaff Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/bpf/bpf)
Merging ipsec/master (9b3040a6aafd ipv4: Define __ipv4_neigh_lookup_noref w=
hen CONFIG_INET is disabled)
Merging netfilter/master (d4c26eb6e721 net: ethernet: stmmac: dwmac-sun8i: =
enable support of unicast filtering)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (7a0f8ad5ff63 Merge ath-current from git://=
git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mac80211/master (5f05836831f6 net/sched: avoid double free on match=
all reoffload)
Merging rdma-fixes/for-rc (2557fabd6e29 RDMA/hns: Bugfix for mapping user d=
b)
Merging sound-current/for-linus (ed180abba7f1 ALSA: hda: Fix race between c=
reating and refreshing sysfs entries)
Merging sound-asoc-fixes/for-linus (28776b33e575 Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (1d6106cafb37 Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (c7b5128f72ef Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (3de0496378eb Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (9c9c5fc89b09 PCI/LINK: Add Kconfig option (d=
efault off))
Merging driver-core.current/driver-core-linus (d7a02fa0a8f9 Merge tag 'upst=
ream-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubif=
s)
Merging tty.current/tty-linus (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of=
 ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging usb.current/usb-linus (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of=
 ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (e6f32efb1b12 phy: sun4i-usb: Make sure to disable PHY0 p=
assby for peripheral mode)
Merging staging.current/staging-linus (d7a02fa0a8f9 Merge tag 'upstream-5.2=
-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging char-misc.current/char-misc-linus (d7a02fa0a8f9 Merge tag 'upstream=
-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (e93c9c99a629 Linux 5.1)
Merging input-current/for-linus (14e0c7317ed5 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (cbc22b062106 Revert "crypto: caam/jr - Remov=
e extra memory barrier during job ring dequeue")
Merging ide/master (b970afcfcabd Merge tag 'powerpc-5.2-1' of ssh://gitolit=
e.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (37624b58542f Linux 5.1-rc7)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/mtd/fixes (9a8f612ca0d6 mtd: rawnand: marvell: Clean the =
controller state before each operation)
Merging mfd-fixes/for-mfd-fixes (a05a2e7998ab mfd: sun6i-prcm: Allow to com=
pile with COMPILE_TEST)
Merging v4l-dvb-fixes/fixes (7afa8db323e3 media: vsp1: Add support for miss=
ing 16-bit RGB555 formats)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (a1e8783db8e0 MIPS: perf: ath79: Fix perfcoun=
t IRQ assignment)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (1ba12322e2f0 Merge branch 'am5-sdio-fixes' into f=
ixes)
Merging kvm-fixes/master (e8ab8d24b488 KVM: nVMX: Fix size checks in vmx_se=
t_nested_state)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (b88c5049219a hwmon: (occ) Fix extended status bi=
ts)
Merging nvdimm-fixes/libnvdimm-fixes (c4703ce11c23 libnvdimm/namespace: Fix=
 label tracking error)
Merging btrfs-fixes/next-fixes (0b341c8bfa6d Merge branch 'misc-next' into =
next-fixes)
Merging vfs-fixes/fixes (05883eee857e do_move_mount(): fix an unsafe use of=
 is_anon_ns())
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (e93c9c99a629 Linux 5.1)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (144ec97493af scsi: aic7xxx: fix EISA support)
Merging drm-fixes/drm-fixes (e93c9c99a629 Linux 5.1)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (f5c58ba18ab8 drm/i915: Restor=
e correct bxt_ddi_phy_calc_lane_lat_optim_mask() calculation)
Merging mmc-fixes/fixes (dc4060a5dc25 Linux 5.1-rc5)
Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupported =
when relevant)
Merging gnss-fixes/gnss-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging hyperv-fixes/hyperv-fixes (69c8caafb72d hv: tools: fixed Python pep=
8/flake8 warnings for lsvmbus)
Merging drm-misc-fixes/for-linux-next-fixes (ab042b824c11 Revert "drm/qxl: =
drop prime import/export callbacks")
Merging kbuild/for-next (9562de4dcfaf Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (13bf5ced9377 dma-mapping: add a Kconfig symbo=
l to indicate arch_dma_prep_coherent presence)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/Kbuild
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (3d3c616177cc Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm64/for-next/core (6127bf372add Merge branch 'for-next/mmiowb' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/co=
re)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (c19ddad91159 ARM: Document merges)
CONFLICT (content): Merge conflict in drivers/rtc/rtc-omap.c
CONFLICT (content): Merge conflict in drivers/misc/Makefile
CONFLICT (content): Merge conflict in drivers/misc/Kconfig
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ven=
dor-prefixes.txt
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (64d04a7813d5 Merge branch 'v5.2/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (ac650130c227 Merge branches 'at91-soc', 'at91-dt' a=
nd 'at91-defconfig' into at91-next)
CONFLICT (content): Merge conflict in arch/arm/mach-at91/pm.c
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (d9c3322a2906 Merge branch 'imx/defconfig' into fo=
r-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (891f0f865c37 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (481df0abf8cf Merge branch 'omap-for-v5.2/ti-sysc' in=
to for-next)
Merging reset/reset/next (21a5d26b8164 reset: Switch to SPDX license identi=
fier for reset-simple)
Merging qcom/for-next (1d31c0b1a28a Merge tag 'qcom-arm64-for-5.2-1' into r=
eally-done-for-5.2)
Merging renesas/next (982700f80241 Merge branch 'arm-dt-for-v5.2' into next)
Merging rockchip/for-next (9c539071723e Merge branch 'v5.2-clk/next' into f=
or-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (831c75782772 Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (613c4ce8fddb Merge branch 'sunxi/dt-for-5.2' =
into sunxi/for-next)
Merging tegra/for-next (0c0ffecf65fd Merge branch for-5.2/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (c1157f60d72e Merge branch 'clk-parent-rewrite-1' into=
 clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (d2adb7b6249a csky: Select intc & timer drivers)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (fdd20ec8786a Documentation/features/time: Mark m68k =
having modern-timekeeping)
Merging m68knommu/for-next (37624b58542f Linux 5.1-rc7)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (81fca03ae741 MIPS: SGI-IP22: provide missing dma_ma=
sk/coherent_dma_mask)
CONFLICT (content): Merge conflict in arch/mips/sgi-ip27/ip27-irq.c
Merging nds32/next (d4d45d2d7790 MAINTAINERS: update nds32 git repo path)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (4e617c86ba9b parisc: Use __ro_after_init in ini=
t.c)
Merging powerpc/next (8150a153c013 powerpc/64s: Use early_mmu_has_feature()=
 in set_kuap())
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (e23fc917f04f RISC-V: Avoid using invalid intermedi=
ate translations)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (a698e1372800 s390/qdio: optimize state inspection of=
 HW-owned SBALs)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (0542593fff0f Merge branch 'xtensa-for-next'=
 into xtensa-5.2-fixes)
Merging fscrypt/master (2c58d548f570 fscrypt: cache decrypted symlink targe=
t in ->i_link)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (00abf69dd24f ceph: flush dirty inodes before proceedin=
g with remount)
Merging cifs/for-next (14e25977f988 cifs: use the right include for signal_=
pending())
Merging configfs/for-next (35399f87e271 configfs: fix possible use-after-fr=
ee in configfs_register_group)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (91e9f2c1d861 Merge quota fix from Chengguang.)
Merging ext4/dev (15f0d8d0bafb unicode: add missing check for an error retu=
rn from utf8lookup())
Merging f2fs/dev (2777e654371d f2fs: fix to avoid accessing xattr across th=
e boundary)
Merging fuse/for-next (9031a69cf9f0 fuse: clean up fuse_alloc_inode)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of ssh://=
gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging nfs-anna/linux-next (5940d1cf9f42 SUNRPC: Rebalance a kref in auth_=
gss.c)
Merging nfsd/nfsd-next (6f4f7839e924 auth_gss: fix deadlock that blocks rpc=
sec_gss_exit_net when use-gss-proxy=3D=3D1)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (acf3062a7e1c ovl: relax WARN_ON() for ove=
rlapping layers use case)
Merging ubifs/linux-next (04d37e5a8b1f ubi: wl: Fix uninitialized variable)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (8869a2d297cb Merge remote-tracking branch 'korg/iomap=
-5.2-merge' into for-next)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into for=
-next)
Merging pci/next (747a14a7d6c7 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (0be6a6927254 pstore/ram: Improve backward c=
ompatibility with older Chromebooks)
Merging hid/for-next (eb18d1215405 Merge branch 'for-5.2/logitech' into for=
-next)
Merging i2c/i2c/for-next (8d1d950a6072 Merge branch 'i2c/for-5.2' into i2c/=
for-next)
Merging i3c/i3c/next (476c7e1d34f2 i3c: Fix a shift wrap bug in i3c_bus_set=
_addr_slot_status())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (39abe9d88b30 hwmon: (lm75) Add support fo=
r TMP75B)
Merging jc_docs/docs-next (afbd4d42470e Merge branch 'x86' into docs-next)
Merging v4l-dvb/master (1199fa8c0ddd media: tegra-cec: fix cec_notifier_par=
se_hdmi_phandle return check)
Merging v4l-dvb-next/master (9e98c678c2d6 Linux 5.1-rc1)
Merging fbdev/fbdev-for-next (d4a5611743a6 video: fbdev: Use dev_get_drvdat=
a())
Merging pm/linux-next (ee3fd765dc39 Merge branch 'pm-domains' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (8db82563451f cpufreq: armada-37=
xx: fix frequency calculation for opp)
Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of inter=
val)
Merging opp/opp/linux-next (2f36bde0fc8f OPP: Introduce dev_pm_opp_find_fre=
q_ceil_by_volt())
Merging thermal/next (fc15b6af30c9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (be827ffd38ea thermal: rcar_gen3_thermal: Fix to s=
how correct trip points number)
CONFLICT (content): Merge conflict in MAINTAINERS
Applying: thermal: use "static inline" for stub function
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (063b8271ec8f swiotlb-xen: ensure we have a sing=
le callsite for xen_dma_map_page)
Merging rdma/for-next (b79656ed44c6 RDMA/ipoib: Allow user space differenti=
ate between valid dev_port)
Merging net-next/master (63863ee8e2f6 Merge tag 'gcc-plugins-v5.2-rc1' of s=
sh://gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux)
Applying: xfrm4: fix up for moved _decode_session4
Merging bpf-next/master (80f232121b69 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net-next)
Merging ipsec-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/davem/net)
Merging mlx5-next/mlx5-next (91a40a48d52d net/mlx5: Fix broken hca cap offs=
et)
Merging netfilter-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (f9b628d61fae rtw88: add license for M=
akefile)
Merging bluetooth/master (62a91990f4c5 Bluetooth: hci_qca: Rename STATE_<fl=
ags> to QCA_<flags>)
Merging mac80211-next/master (80f232121b69 Merge git://git.kernel.org/pub/s=
cm/linux/kernel/git/davem/net-next)
Merging gfs2/for-next (fb19ccf017a4 gfs2: Fix error path kobject memory lea=
k)
Merging mtd/mtd/next (3008ba870938 mtd: part: fix incorrect format specifie=
r for an unsigned long long)
Merging nand/nand/next (1c14fe2167ef mtd: nandsim: switch to exec_op interf=
ace)
Merging spi-nor/spi-nor/next (e43f53c22a93 spi-nor: intel-spi: Add support =
for Intel Comet Lake SPI serial flash)
Merging crypto/master (e59f755ceb6d crypto: ccree - use a proper le32 type =
for le32 val)
Merging drm/drm-next (c01ad0fe1d57 Merge branch 'drm-next-5.2' of git://peo=
ple.freedesktop.org/~agd5f/linux into drm-next)
Merging amdgpu/drm-next (963040e6ae2d drm/amd/display: Make some functions =
static)
Merging drm-intel/for-linux-next (c36beba6b296 drm/i915: Seal races between=
 async GPU cancellation, retirement and signaling)
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (197b23e9aeea drm/panfrost: Add missing _fi=
ni() calls in panfrost_device_fini())
Merging drm-msm/msm-next (b02872df58ac drm/msm/a6xx: Don't enable GPU state=
 code if dependencies are missing)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the loc=
al functions as static)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (a136e5257f67 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (ed180abba7f1 ALSA: hda: Fix race between creating a=
nd refreshing sysfs entries)
Merging sound-asoc/for-next (7c64b35f0023 Merge branch 'asoc-5.2' into asoc=
-next)
Merging modules/modules-next (dadec066d8fa module: add stubs for within_mod=
ule functions)
CONFLICT (content): Merge conflict in include/linux/module.h
Merging input/next (7f7a0208369f Merge tag 'ib-mfd-gpio-input-leds-power-v5=
.2' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging block/for-next (e35d0b782065 Merge branch 'for-5.2/block-post' into=
 for-next)
Merging device-mapper/for-next (05d6909ea9d6 dm integrity: whitespace, codi=
ng style and dead code cleanup)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (0a49a619e7e1 mmc: sdhci-pci: Fix BYT OCP setting)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (3834d6ed8892 mfd: Use dev_get_drvdata() directly)
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (c8f3c9fe83ca power: supply: ucs1002: Fix build er=
ror without CONFIG_REGULATOR)
Merging regulator/for-next (e2a23affe6a6 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (a2ffe5774e8e selftests/kexec: update get_=
secureboot_mode)
Merging selinux/next (35a196bef449 proc: prevent changes to overridden cred=
entials)
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (b5531563e8a0 Merge branches 'arm/tegra', 'arm/mediatek'=
, 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (70c4cf17e445 audit: fix a memory leak bug)
Merging devicetree/for-next (2a656cb5a4a3 of: unittest: Remove error printi=
ng on OOM)
Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for Arm=
ada 37xx rWTM mailbox)
Merging spi/for-next (a815ae41f5fb Merge remote-tracking branch 'spi/topic/=
bpw-check' into spi-next)
Merging tip/auto-latest (f8d6805068ad Merge branch 'WIP.x86/fpu' into auto-=
latest)
Merging clockevents/clockevents/next (8c9374068ef6 misc: atmel_tclib: Do no=
t probe already used TCBs)
Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more th=
an two controllers for chip select handling")
Merging irqchip/irq/irqchip-next (16e32c3cde77 iommu/dma-iommu: Remove iomm=
u_dma_map_msi_msg())
Merging ftrace/for-next (03197fc02b35 tracing: kdb: Allow ftdump to skip al=
l but the last few entries)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (3a1e5e4a2c7a Revert "KVM: doc: Document the life cy=
cle of a VM and its resources")
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (0caecf5b0019 KVM: PPC: Book3S HV: XIVE: Clear=
 escalation interrupt pointers on device close)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging kvms390/next (b2d0371d2e37 KVM: s390: vsie: Return correct values f=
or Invalid CRYCB format)
Merging xen-tip/linux-next (fe846979d305 xen/arm: Use p2m entry with lock p=
rotection)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (6456fd731517 platform/x86: Add support for Ba=
sin Cove power button)
Merging chrome-platform/for-next (28f808702156 platform/chrome: cros_ec_spi=
: Always add of_match_table)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (0db37915d912 leds: avoid races with workqueue)
Merging ipmi/for-next (a2d635decbfa Merge tag 'drm-next-2019-05-09' of git:=
//anongit.freedesktop.org/drm/drm)
Merging driver-core/driver-core-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-=
rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging usb/usb-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of ssh://gi=
tolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (7f6fc50242d1 USB: serial: f81232: implement br=
eak control)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (708310711e6c dt-bindings: phy-qcom-qmp: Tweak qcom,m=
sm8998-qmp-ufs-phy)
Merging tty/tty-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of ssh://gi=
tolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging char-misc/char-misc-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1'=
 of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic detec=
t if running when driver is removed)
Merging soundwire/next (4abbd783d126 soundwire: intel: fix implicit header =
use of module.h/export.h)
Merging thunderbolt/next (37209783c73a thunderbolt: Make priority unsigned =
in struct tb_path)
Merging staging/staging-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of =
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (f33e7bb3eb92 dmaengine: tegra210-adma: restore chan=
nel status)
Merging cgroup/for-next (2781a652edd4 Merge branch 'for-5.2' into for-next)
Merging scsi/for-next (7004db783df5 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (d4023db71108 scsi: qla2xxx: Avoid that lockdep c=
omplains about unsafe locking in tcm_qla2xxx_close_session())
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (aa32fb4804f7 iommu/virtio: Add event queue)
CONFLICT (content): Merge conflict in drivers/pci/of.c
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0fbee1df2078 gpio: Update documentation)
Merging gpio-brgl/gpio/for-next (b0d2569d8276 gpio: mlxbf: remove unused in=
cluding <linux/version.h>)
Merging pinctrl/for-next (e0e31695b53b pinctrl: mcp23s08: Do not complain a=
bout unsupported params)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (37e1677330bd ktest: introduce REBOOT_RETURN_CODE to=
 confirm the result of REBOOT)
Merging random/dev (b7d5dc21072c random: add a spinlock_t to struct batched=
_entropy)
Merging kselftest/next (27d79a2b2bf0 selftests: fix bpf build/test workflow=
 regression when KBUILD_OUTPUT is set)
CONFLICT (content): Merge conflict in tools/testing/selftests/rseq/rseq-s39=
0.h
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (591be2f7f7b5 Merge branch 'for-5.2/core' int=
o for-next)
Merging coresight/next (78e6427b4e7b coresight: funnel: Support static funn=
el)
Merging rtc/rtc-next (dacb6a4035a0 rtc: snvs: Use __maybe_unused instead of=
 #if CONFIG_PM_SLEEP)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R1E=
X24016)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (259799ea5a9a gcc-plugins: arm_ssp_per_task_plug=
in: Fix for older GCC < 6)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (7cc10c5cb143 gnss: ubx: add u-blox,neo-6m compatibl=
e)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (80471330ec58 slimbus: fix a NULL pointer derefere=
nce in of_qcom_slim_ngd_register)
Merging nvmem/for-next (889ba60c36ce nvmem: core: add NVMEM_SYSFS Kconfig)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (b586627e10f5 kdb: do a sanity check on the c=
pu in kdb_per_cpu())
Merging pidfd/for-next (eb364bbe6791 samples: show race-free pidfd metadata=
 access)
CONFLICT (content): Merge conflict in samples/Makefile
CONFLICT (content): Merge conflict in kernel/fork.c
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (b78fc46079e4 ipc-do-cyclic-id-allocation-for-=
the-ipc-object-fix)
CONFLICT (content): Merge conflict in mm/vmalloc.c
CONFLICT (content): Merge conflict in lib/dynamic_debug.c
CONFLICT (content): Merge conflict in lib/Makefile
CONFLICT (content): Merge conflict in kernel/fork.c
CONFLICT (content): Merge conflict in include/linux/dynamic_debug.h
CONFLICT (content): Merge conflict in fs/sync.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/umem.c
CONFLICT (modify/delete): arch/s390/mm/gup.c deleted in HEAD and modified i=
n akpm-current/current. Version akpm-current/current of arch/s390/mm/gup.c =
left in tree.
CONFLICT (content): Merge conflict in arch/powerpc/platforms/Kconfig.cputype
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
CONFLICT (content): Merge conflict in arch/powerpc/mm/book3s64/iommu_api.c
CONFLICT (content): Merge conflict in arch/nios2/Kconfig
CONFLICT (content): Merge conflict in arch/mips/kernel/setup.c
CONFLICT (content): Merge conflict in arch/m68k/Kconfig
$ git rm -f arch/s390/mm/gup.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: fs/coda/psdev.c: remove duplicate header
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs/cachefiles/namei.c: remove duplicate header
Applying: fs/block_dev.c: Remove duplicate header
Applying: treewide: replace #include <asm/sizes.h> with #include <linux/siz=
es.h>
Applying: arch: remove <asm/sizes.h> and <asm-generic/sizes.h>
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm-rename-ambiguously-named-memorystat-counters-and-functions-fix
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/virt/fsl_hypervisor.c: dereferencing error pointers in io=
ctl
Applying: drivers/virt/fsl_hypervisor.c: prevent integer overflow in ioctl
Applying: mm: memcontrol: make cgroup stats and events query API explicitly=
 local
Applying: mm-memcontrol-make-cgroup-stats-and-events-query-api-explicitly-l=
ocal-fix
Applying: mm: memcontrol: move stat/event counting functions out-of-line
Applying: mm: memcontrol: fix recursive statistics correctness & scalabilty
Applying: mm: memcontrol: fix NUMA round-robin reclaim at intermediate level
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (8510f4aaff81 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/MqQdP_HxdBrzjZL.CCVrD8=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaRXYACgkQAVBC80lX
0GwGCAf9ELPUsPC6wq5Jvvb0c9Rq3BWJXThVbbWbMxuVWX0QXHlGak6iAw5Uq8aV
9xaS55tZTKfG3nKZmyTQ/6yYaBjimVujJJ3SqblDMLQbM8ZYO/sRqXc6pZKRA177
yXaqtxrV612101su12WMcfXdGpVW/mySRv+3yM8e3oyQQc8O/q7v3+74ctJ8xucJ
/7gV0au1/emU+ZvQAFsSMcuSivEPRztO3FWX+W0vSK/RqOgd8Jvtsy67k2MotTIw
TBQ7j4INKiqfdgdZy2+9GSzKvDkAtNmWBlbCJxSbjyEIROZAW9EgUK1t6q7vLVjV
7brp5MdzC8vegYCfFP5OFUedFSf4ug==
=LGmd
-----END PGP SIGNATURE-----

--Sig_/MqQdP_HxdBrzjZL.CCVrD8=--
