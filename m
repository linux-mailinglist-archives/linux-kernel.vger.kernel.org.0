Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A902F76D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfE3GVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 02:21:37 -0400
Received: from ozlabs.org ([203.11.71.1]:54755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3GVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:21:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45DyCJ5Ctfz9s3l;
        Thu, 30 May 2019 16:21:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559197292;
        bh=7W5PwuFlrZ58nAV7yLmMNyCK0ReXFLiMgc1wh6QSQzc=;
        h=Date:From:To:Cc:Subject:From;
        b=I0RKvg81L2kOr5XdRVgrDKBIGB9Oms8PZrPnjxqmSeFm21VuW3B2NBr9pzTFiYsTR
         hGKMXogHuDQTwvDsysY0K5K2Qp837IpXdQ4t+FEuuPvypDkoHAPCzqxYWxwxgWA1u1
         zcF7pOdaElDh856M9GYhwZhUM873hxL+Q6bwb/adkS7faOCSe+pvpO9VGYr6C/qMQ/
         B/vDIbQzJd638cxsvLvyUHmatYe2FWzMhXa0gO7UaGGZODctk5ubHpRr4Y7jgZDY6I
         AsyhKeW++CuBVbqWRIFfYCPymCkiP5KYi6XlVvFwMcUxSWPydNVxFfBOr2mwTEo3HL
         oc8MPdTLTXAew==
Date:   Thu, 30 May 2019 16:21:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 30
Message-ID: <20190530162132.6081d246@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MTwf+HQ1uKajcMTTMo9yWmn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MTwf+HQ1uKajcMTTMo9yWmn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190529:

The net-next tree gained a conflict against the net tree.

The userns tree gained a conflict against the arc-current tree.

The akpm-current tree lost its build failure but gained another for
which I applied a patch.  It also gained a boot failure so I reverted
2 commits.

Non-merge commits (relative to Linus' tree): 3066
 3378 files changed, 121767 insertions(+), 55837 deletions(-)

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

I am currently merging 291 trees (counting Linus' and 70 trees of bug
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
Merging origin/master (9fb67d643f6f Merge tag 'pinctrl-v5.2-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl)
Merging fixes/master (2bbacd1a9278 Merge tag 'kconfig-v5.2' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (30a28f11b618 kbuild: tar-pkg: enable communic=
ation with jobserver)
Merging arc-current/for-curr (46e04c25e72f ARC: [plat-hsdk] Get rid of inap=
propriate PHY settings)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (1e29ab3186e3 arm64: use the correct fun=
ction type for __arm64_sys_ni_syscall)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (8b909e354870 powerpc/kexec: Fix loading of ker=
nel + initramfs with kexec_file_load())
Merging s390-fixes/fixes (1c2c7029c008 s390/crypto: fix possible sleep duri=
ng spinlock aquired)
Merging sparc/master (54dee406374c Merge tag 'arm64-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/arm64/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fix=
es')
Merging bpf/master (5fac1718e706 selftests: bpf: fix compiler warning in fl=
ow_dissector test)
Merging ipsec/master (7c80eb1c7e2b af_key: fix leaks in key_pol_get_resp an=
d dump_sp.)
Merging netfilter/master (3e66b7cc50ef net: tulip: de4x5: Drop redundant MO=
DULE_DEVICE_TABLE())
Merging ipvs/master (e633508a9528 netfilter: nft_fib: Fix existence check s=
upport)
Merging wireless-drivers/master (6aca09771db4 rtw88: Make some symbols stat=
ic)
Merging mac80211/master (180aa422ef27 nl80211: fill all policy .type entrie=
s)
Merging rdma-fixes/for-rc (619122be3d40 RDMA/hns: Fix PD memory leak for in=
ternal allocation)
Merging sound-current/for-linus (6954158a1640 ALSA: fireface: Use ULL suffi=
xes for 64-bit constants)
Merging sound-asoc-fixes/for-linus (a3d1a521739e Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (38ee2a8cc70e Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (ae920866d4fc Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (be02f18a60ed Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (cd6c84d8f0cd Linux 5.2-rc2)
Merging tty.current/tty-linus (a1ad1cc9704f vt/fbcon: deinitialize resource=
s in visual_init() after failed memory allocation)
Merging usb.current/usb-linus (3ea3091f1bd8 usbip: usbip_host: fix stub_dev=
 lock context imbalance regression)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (f3dfd4072c3e USB: serial: option: add T=
elit 0x1260 and 0x1261 compositions)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging staging.current/staging-linus (e61ff0fba72d staging: kpc2000: Add d=
ependency on MFD_CORE to kconfig symbol 'KPC2000')
Merging char-misc.current/char-misc-linus (bd17cc5a20ae test_firmware: Use =
correct snprintf() limit)
Merging soundwire-fixes/fixes (03ecad90d379 soundwire: stream: fix out of b=
oundary access on port properties)
Merging thunderbolt-fixes/fixes (cd6c84d8f0cd Linux 5.2-rc2)
Merging input-current/for-linus (7c7da40da164 Input: uinput - add compat io=
ctl number translation for UI_*_FF_UPLOAD)
Merging crypto-current/master (357d065a44cd crypto: vmx - ghash: do nosimd =
fallback manually)
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (eff82a263b5c selftests: rtc: rtctest: specif=
y timeouts)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (8243b87c3abb dt-bindings: dma: uart: rename =
binding)
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (b2b5921fe4b3 mtd: rawnand: initialize ntargets=
 with maxchips)
Merging mfd-fixes/for-mfd-fixes (e93c9c99a629 Linux 5.1)
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f532beeeff0c MIPS: uprobes: remove set but n=
ot used variable 'epc')
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc'=
 into fixes)
Merging kvm-fixes/master (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (ef583670a438 hwmon: core: add thermal sensors on=
ly if dev->of_node is present)
Merging nvdimm-fixes/libnvdimm-fixes (52f476a323f9 libnvdimm/pmem: Bypass C=
ONFIG_HARDENED_USERCOPY overhead)
Merging btrfs-fixes/next-fixes (8b1d37b7b32d Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d8076bdb56af uapi: Wire up the mount API syscalls =
on non-x86 arches [ver #2])
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (d6423bd03031 platform/x86: pmc_atom: Add s=
everal Beckhoff Automation boards to critclk_systems DMI table)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (8acf608e602f Revert "scsi: sd: Keep disk read-onl=
y when re-reading partition")
Merging drm-fixes/drm-fixes (cd6c84d8f0cd Linux 5.2-rc2)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (a6315005a2d4 drm/i915/icl: Ad=
d WaDisableBankHangMode)
Merging mmc-fixes/fixes (89f3c365f3e1 mmc: sdhci: Fix SDIO IRQ thread deadl=
ock)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (cd6c84d8f0cd Linux 5.2-rc2)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging drm-misc-fixes/for-linux-next-fixes (95b74ce88943 drm/qxl: drop WAR=
N_ONCE())
Merging kbuild/for-next (2409207a73cc Merge tag 'scsi-fixes' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (aac32e6a1b18 dma-contiguous: use fallback all=
oc_pages for single pages)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (3c0c3c1418e4 ARC: entry: EV_Trap expects r10 (vs. r9)=
 to have exception cause)
Merging arm/for-next (d486065b35e4 Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm64/for-next/core (6127bf372add Merge branch 'for-next/mmiowb' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/co=
re)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (7dd6d6c8a625 Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (130413736376 ARM: dts: aspeed: Add Microsoft Olymp=
us BMC)
Merging at91/at91-next (32dfd9cfa4c6 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (83d02ffe0144 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (891f0f865c37 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc' in=
to fixes)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
Merging qcom/for-next (3c3aa8cb95e6 Revert "drivers: thermal: tsens: Add ne=
w operation to check if a sensor is enabled")
Merging renesas/next (3c6a7fb1f31b Merge branches 'arm-dt-for-v5.3' and 'ar=
m64-dt-for-v5.3' into next)
Merging rockchip/for-next (958bf721f5d2 Merge branch 'v5.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (831c75782772 Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (b848475c0143 Merge branch 'sunxi/clk-for-5.3'=
 into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (c47cf10c6cb2 Merge branch for-5.3/arm64/dt into for=
-next)
Merging clk/clk-next (f191a146bcee Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (6b436744a0b7 csky: Fixup no panic in kernel for so=
me traps)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (fdd20ec8786a Documentation/features/time: Mark m68k =
having modern-timekeeping)
Merging m68knommu/for-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (361686288213 MIPS: replace MBIT_ULL() with BIT_ULL(=
))
Merging nds32/next (ba41cd08d85f math-emu: Use statement expressions to fix=
 Wshift-count-overflow warning)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (029ab28a86e7 parisc: Use implicit space registe=
r selection for loading the coherence index of I/O pdirs)
Merging powerpc/next (8150a153c013 powerpc/64s: Use early_mmu_has_feature()=
 in set_kuap())
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (5d1d046e2868 soc: fsl: qbman_portals: add APIs to ret=
rieve the probing status)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (8fef9900d43f riscv: fix locking violation in page =
fault handler)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (2409207a73cc Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (0542593fff0f Merge branch 'xtensa-for-next'=
 into xtensa-5.2-fixes)
Merging fscrypt/master (5858bdad4d0d fscrypt: don't set policy for a dead d=
irectory)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (00abf69dd24f ceph: flush dirty inodes before proceedin=
g with remount)
Merging cifs/for-next (31fad7d41e73 CIFS: cifs_read_allocate_pages: don't i=
terate through whole page array on ENOMEM)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (1915f44c9cca Merge change to disable fanotify permis=
sion events for proc.)
Merging ext4/dev (cd6c84d8f0cd Linux 5.2-rc2)
Merging f2fs/dev (b1820efff17a f2fs: add error prints for debugging mount f=
ailure)
Merging fuse/for-next (26eb3bae5003 fuse: extract helper for range writebac=
k)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (9fb67d643f6f Merge tag 'pinctrl-v5.2-2' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl)
Merging nfs-anna/linux-next (66d4218f9902 xprtrdma: Use struct_size() in kz=
alloc())
Merging nfsd/nfsd-next (40629c5ec046 locks: Cleanup lm_compare_owner and lm=
_owner_key)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (146d62e5a586 ovl: detect overlapping laye=
rs)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (5cd213b0fec6 xfs: don't reserve per-AG space for an i=
nternal log)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into for=
-next)
Merging pci/next (a188339ca5a3 Linux 5.2-rc1)
Merging pstore/for-next/pstore (6b1be4a047a0 pstore/ram: Improve backward c=
ompatibility with older Chromebooks)
Merging hid/for-next (f32a0c18e370 Merge branch 'for-5.2/fixes' into for-ne=
xt)
Merging i2c/i2c/for-next (85135f9341bc Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (5e343fbb7176 dt-bindings: i3c: Document dropped suppo=
rt for I2C 10 bit devices)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (532454c231d8 hwmon: (tc654) Update to use=
 SPDX-License-Identifier)
Merging jc_docs/docs-next (b0d60bfbb60c kernel-doc: always name missing ker=
neldoc sections)
Merging v4l-dvb/master (3b6471c7becd media: Staging: media: Release the cor=
rect resource in an error handling path)
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (73ee89436047 Merge tag 'v5.2-rc1' of https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into fbdev-for-next)
Merging pm/linux-next (f6491366f1e6 Merge branch 'pm-tools' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (a02177a39344 dt-bindings: imx-c=
pufreq-dt: Document opp-supported-hw usage)
Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of inter=
val)
Merging opp/opp/linux-next (c0ab9e0812da opp: Allocate genpd_virt_devs from=
 dev_pm_opp_attach_genpd())
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (cd6c84d8f0cd Linux 5.2-rc2)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (063b8271ec8f swiotlb-xen: ensure we have a sing=
le callsite for xen_dma_map_page)
Merging rdma/for-next (62a38e704d57 RDMA/efa: Remove check that prevents de=
stroy of resources in error flows)
Merging net-next/master (7da33a8f87a4 Merge branch '100GbE' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jkirsher/next-queue)
CONFLICT (content): Merge conflict in drivers/net/phy/dp83867.c
Merging bpf-next/master (399dc65e9ca0 libbpf: reduce unnecessary line wrapp=
ing)
Merging ipsec-next/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging mlx5-next/mlx5-next (6cc070bdf07c net/mlx5: potential error pointer=
 dereference in error handling)
Merging netfilter-next/master (f4aa80129ff7 cxgb4: Make t4_get_tp_e2c_map s=
tatic)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (62a91990f4c5 Bluetooth: hci_qca: Rename STATE_<fl=
ags> to QCA_<flags>)
Merging mac80211-next/master (a3ce17d1495b cfg80211: Handle bss expiry duri=
ng connection)
Merging gfs2/for-next (d8e126ba276a gfs2: Clean up freeing struct gfs2_sbd)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (84db7797ffd3 mtd: rawnand: fsmc: Use nand_op_trace =
for operation tracing)
Merging spi-nor/spi-nor/next (a188339ca5a3 Linux 5.2-rc1)
Merging crypto/master (0f7a81374060 crypto: crypto4xx - block ciphers shoul=
d only accept complete blocks)
Merging drm/drm-next (14ee642c2ab0 Merge tag 'drm-intel-next-2019-05-24' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging amdgpu/drm-next (75f83f9797a9 drm/amd/display: program manual trigg=
er only for bottom most pipe)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/include/d=
al_asic_id.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_priv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_device=
_queue_manager.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/soc15.c
Merging drm-intel/for-linux-next (7f5f228008e4 drm/i915/gtt: Avoid overflow=
ing the WC stash)
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (d0f29d4980cd drm/sched: Fix make htmldocs =
warnings.)
Merging drm-msm/msm-next (981f2aabeae6 drm/msm/a6xx: Rename a6xx_gmu_probe =
to a6xx_gmu_init)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the loc=
al functions as static)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (38ee2a8cc70e Merge branch 'regmap-5.2' into regmap=
-linus)
Merging sound/for-next (968e8e9fde25 Merge branch 'topic/line6-cleanup' int=
o for-next)
Merging sound-asoc/for-next (b421e4c0ca15 Merge branch 'asoc-5.3' into asoc=
-next)
Merging modules/modules-next (dadec066d8fa module: add stubs for within_mod=
ule functions)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
Merging block/for-next (bd3d12ec1f8c Merge branch 'io_uring-next' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (4bacf4d920ee Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (ed835136ee67 mfd: Use dev_get_drvdata() directly)
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (f405b6c10a21 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (5d99fe052ddd x86/ima: check EFI SetupMode=
 too)
Merging selinux/next (beee56f3543a selinux: remove some no-op BUG_ONs)
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (a02a28008bf7 Merge branches 'iommu/fixes', 'x86/vt-d', =
'x86/amd', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (0223fad3c98a audit: enforce op for string fields)
Merging devicetree/for-next (b361797f3d0b dt-bindings: vendor: Fix simtek v=
endor compatible)
Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for Arm=
ada 37xx rWTM mailbox)
Merging spi/for-next (0cde1d6bc0a5 Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (00d8b7582f55 Merge branch 'core/urgent')
Merging clockevents/clockevents/next (8c9374068ef6 misc: atmel_tclib: Do no=
t probe already used TCBs)
Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more th=
an two controllers for chip select handling")
Merging irqchip/irq/irqchip-next (4770533f71de irqchip/renesas-irqc: Conver=
t to managed initializations)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove useless=
 checks in 'release' method of KVM device)
Merging kvms390/next (2ee567d31a58 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (d10e0cc113c9 xenbus: Avoid deadlock during susp=
end due to open transactions)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (ef071bab655b power: supply: olpc_battery: All=
ow building the driver on non-x86)
Merging chrome-platform/for-next (ac5bdfdc0e1c platform/chrome: cros_ec_spi=
: Request the SPI thread be realtime)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (1916ebfdfbac leds: max77650: Remove set but not used=
 variable 'parent')
Merging ipmi/for-next (2cd0e54489e6 ipmi_ssif: fix unexpected driver unregi=
ster warning)
Merging driver-core/driver-core-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging usb/usb-next (086ebf92aa79 usb: avoid redundant allocation and free=
 of memory)
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (a188339ca5a3 Linux 5.2-rc1)
Merging tty/tty-next (324e8f5f5d9d tty: cpm_uart: drop unused iflag macro)
Merging char-misc/char-misc-next (381e9760ee87 firmware: google: coreboot: =
Drop unnecessary headers)
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (432732b801c8 soundwire: intel_init: add checks on l=
ink numbers)
Merging thunderbolt/next (cd6c84d8f0cd Linux 5.2-rc2)
Merging staging/staging-next (1f48d056287d MAINTAINERS: Add entry for anybu=
ss drivers)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (7b11ef9653d2 dmaengine: stm32: use to_platform_devi=
ce())
Merging cgroup/for-next (18fa84a2db0e cgroup: Use css_tryget() instead of c=
ss_tryget_online() in task_get_css())
Merging scsi/for-next (dda5c4009563 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/scsi/sas.h
CONFLICT (content): Merge conflict in include/scsi/libsas.h
CONFLICT (content): Merge conflict in drivers/scsi/st.c
CONFLICT (content): Merge conflict in drivers/scsi/sr.c
CONFLICT (content): Merge conflict in drivers/scsi/sg.c
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_pm.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_lib.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_ioctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_error.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi.c
CONFLICT (modify/delete): drivers/scsi/osst.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of drivers/scsi/osst.c left in tree.
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_task.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_scsi_host.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_internal.h
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_init.c
CONFLICT (content): Merge conflict in drivers/scsi/hosts.c
$ git rm -f drivers/scsi/osst.c
Merging scsi-mkp/for-next (45bb806aa51a scsi: megaraid_sas: Update driver v=
ersion to 07.708.03.00)
Merging vhost/linux-next (317e03c88c57 iommu/virtio: Add event queue)
Merging rpmsg/for-next (37d3f7e0947c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (73a790c68d7e Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (715ed72801ff gpio: em: Return early on err=
or in em_gio_probe())
Merging pinctrl/for-next (d62895ee9795 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (a89e9b8abf82 signal: Remove the signal number and =
task parameters from force_sig_info)
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (fe48319243a6 selftests/timers: Add missing fflush(s=
tdout) calls)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (95def8fe33ed Merge branch 'for-5.2/fixes' in=
to for-next)
Merging coresight/next (8f35caae1e1f coresight: acpi: Support for platform =
devices)
Merging rtc/rtc-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (b20eb4c1f026 eeprom: at24: drop unnecessary lab=
el)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (7210e060155b gcc-plugins: Fix build failures un=
der Darwin host)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (c8d087d040cf nvmem: Broaden the selection of NVMEM_=
SNVS_LPGPR)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (f4cd7203c1d4 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (08f2abef168d tests: add pidfd_open() tests)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (636a028090a5 include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in drivers/iommu/intel-iommu.c
Applying: fix "mm: move ioremap page table mapping function to mm/"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_PAGE =
is not set
Applying: dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc,free}_c=
ontiguous()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (bbb99f4a999a drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: Revert "fix "mm: move ioremap page table mapping function to mm/""
Applying: Revert "mm/vmalloc: hugepage vmalloc mappings"
Applying: Revert "mm: move ioremap page table mapping function to mm/"

--Sig_/MTwf+HQ1uKajcMTTMo9yWmn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvdmwACgkQAVBC80lX
0Gz6Xwf/esffG8o8d8dBnHJEaT3MyQEvhQDYSjIkyi/OXhm4Y5R0tlPEXU3+vsvs
0Kaa1CyWzSNn8AbQEca4DbUb+OZ0q0v2cIzdZvXZaHfDYjqRC0U22m/63odHr98i
HSVV7cPML/8aarNGZF9ECk2X8X+bmDqtvOxnacquOpxcemCA7z0nYo2Ii1sn7DnE
JGUs1ctwydRlt4m51rCFM+KKmWD3WVHipnyPLDW0c1eACCmDUvb+lU9R4vKRUsPH
j8neOykCOYgcx/J10vS1i79e1TN3nyMeyMffZ/geL+DlA9/69ja0TPb2iIl6dUKo
+Ky0dRbxUa85S5cSuVnBFPa5HxyF7g==
=lld0
-----END PGP SIGNATURE-----

--Sig_/MTwf+HQ1uKajcMTTMo9yWmn--
