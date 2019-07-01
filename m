Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00B4E69D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfFULBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:01:32 -0400
Received: from ozlabs.org ([203.11.71.1]:40009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfFULBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:01:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VbMy6CJnz9s00;
        Fri, 21 Jun 2019 21:01:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561114879;
        bh=/7ECkEQkJmwDMPkACu/N2eo+0RVoFQG1xsPLI4kAWXg=;
        h=Date:From:To:Cc:Subject:From;
        b=UzXYxYcIeASacOHKgph0liPHUDY8MVNAW6azBbFn51y60JwtHyv/LaREwDL/+c3oX
         rY5/MyB1fHt7scjHNPbYb96nevL8aXLf0U9R8l1N2CKqZFXj1P8mK/F5WNNgbPhUFC
         LEhuMh3WQ5g0TABo5Ne73b8KixpLzmhBVij2VWFw994t4bNd57JyNTxXyAkpaRz9gt
         PHVmndtKgwhJ3JF4vjL7/lfNRgBcy4lYOJ9GT0lsjZokz0H7QSFTi8tddI6yhsGhTl
         t4tPZzJfUHKFoj4hXNRzUGudH5vmefel7dTdMDqZJ7UoGVhpEcfoWZH8TAC9+7ssHS
         dM4LaALJwy/EQ==
Date:   Fri, 21 Jun 2019 21:01:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 21
Message-ID: <20190621210117.0c2c7a3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2qNd.ejqdZ1WaHObKfVvI4R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2qNd.ejqdZ1WaHObKfVvI4R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190620:

The samsung-krzk tree gained a conflict against the arm tree.

The fbdev tree still had its build failure so I used the version from
next-20190619.

The net-next tree still had its build failure for which I reverted a commit.

The block tree gained a build failure so I used the version from
next-20190620.

The kvms390 tree gained a conflict against Linus' tree.

The nvdimm tree lost its build failure.

The akpm-current tree lost its build failure.

Non-merge commits (relative to Linus' tree): 7054
 7400 files changed, 287263 insertions(+), 246107 deletions(-)

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

I am currently merging 296 trees (counting Linus' and 71 trees of bug
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
Merging origin/master (4ae004a9bca8 Merge tag 'ovl-fixes-5.2-rc6' of git://=
git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (ec9b4feb1e41 ARC: [plat-hsdk]: unify memory a=
pertures configuration)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm64-fixes/for-next/fixes (615c48ad8f42 arm64/mm: don't initialize=
 pgd_cache twice)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (500871125920 KVM: PPC: Book3S HV: Invalidate E=
RAT when flushing guest TLB entries)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (85f9aa7565bd inet: clear num_timeout reqsk_alloc())
Merging bpf/master (56f0f84e69c7 bpf: fix the check that forwarding is enab=
led in bpf_ipv6_fib_lookup)
Merging ipsec/master (b8d6d0079757 xfrm: fix sa selector validation)
Merging netfilter/master (85f9aa7565bd inet: clear num_timeout reqsk_alloc(=
))
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (6be8e297f9bc lapb: fixed leak of control-blocks.)
Merging rdma-fixes/for-rc (7a5834e456f7 RDMA/efa: Handle mmap insertions ov=
erflow)
Merging sound-current/for-linus (17d304604a88 Revert "ALSA: hda/realtek - I=
mprove the headset mic for Acer Aspire laptops")
Merging sound-asoc-fixes/for-linus (bce2c75dd03f Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (2217d05161cb Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (934670c20b85 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (639a25e80d40 Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (d28bdaff5e26 Merge tag 'fixes-for-v5.2-rc5' =
of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (aed2a2628352 USB: serial: option: add s=
upport for GosunCn ME3630 RNDIS mode)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (9b9410766f54 Merge branch 'erofs_fix=
' into staging-linus)
Merging char-misc.current/char-misc-linus (6f828c55e267 Merge tag 'misc-hab=
analabs-fixes-2019-06-20' of git://people.freedesktop.org/~gabbayo/linux in=
to char-misc-linus)
Merging soundwire-fixes/fixes (39194128701b soundwire: intel: set dai min a=
nd max channels correctly)
Merging thunderbolt-fixes/fixes (0d53827d7c17 thunderbolt: Implement CIO re=
set correctly for Titan Ridge)
Merging input-current/for-linus (9843f3e08e21 Input: synaptics - enable SMB=
us on ThinkPad E480 and E580)
Merging crypto-current/master (7829a0c1cb9c crypto: hmac - fix memory leak =
in hmac_init_tfm())
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (b2b5921fe4b3 mtd: rawnand: initialize ntargets=
 with maxchips)
Merging mfd-fixes/for-mfd-fixes (cd49b84d61b2 mfd: stmfx: Uninitialized var=
iable in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (637dfa0fad6d MIPS: have "plain" make calls b=
uild dtbs for selected platforms)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (f6192c664e21 Merge commit '79499bb11db508' into f=
ixes)
Merging kvm-fixes/master (f8d221d2e0e1 Merge tag 'kvm-s390-master-5.2-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-maste=
r)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (48b5b6d53b28 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (52f476a323f9 libnvdimm/pmem: Bypass C=
ONFIG_HARDENED_USERCOPY overhead)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d728cf79164b fs/namespace: fix unprivileged mount =
propagation)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (5589b08e5be4 scsi: qla2xxx: Fix hardlockup in abo=
rt command during driver remove)
Merging drm-fixes/drm-fixes (e14c5873d2a3 Merge branch 'drm-fixes-5.2' of g=
it://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (475df5d0f3eb drm/i915: Don't =
clobber M/N values during fastset check)
Merging mmc-fixes/fixes (83293386bc95 mmc: core: Prevent processing SDIO IR=
Qs when the card is suspended)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (259931fd3b96 riscv: remove unused barrier defin=
es)
Merging drm-misc-fixes/for-linux-next-fixes (74b67efa8d7b drm: return -EFAU=
LT if copy_to_user() fails)
Merging kbuild/for-next (fdbbd6421d2e Merge branch 'kbuild' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (591fcf3b301b iommu/dma: Apply dma_{alloc,free=
}_contiguous functions)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (1a42d1d8c766 ARCv2: entry: simplify return to Delay S=
lot via interrupt)
Merging arm/for-next (edfda3d502e2 Merge commit commit 'drm-armada-devel^{/=
drm/armada: no need to check parent of remote}' into for-next)
Merging arm64/for-next/core (8f5c9037a55b arm64/mm: Correct the cache line =
size warning with non coherent device)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (ae9924667a7e MAINTAINERS: Add maintainer en=
try for the imx8 DDR PMU driver)
Merging arm-soc/for-next (e57f4f2c4506 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (6aff64e5783f Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (17fb539a4603 Merge branches 'dt-for-v5.3' and 'soc=
-for-v5.3' into for-next)
Merging at91/at91-next (7eb505978425 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (beb58dd364d3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (03fb10f2128a Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1e16bc075913 Merge branch 'fixes' into for-next)
Merging qcom/for-next (ed26b50d39eb Merge tag 'qcom-arm64-for-5.3' into ini=
tial-for-5.3)
Merging renesas/next (d4895f3752d9 Merge branches 'arm-dt-for-v5.3', 'arm-d=
efconfig-for-v5.3', 'arm64-dt-for-v5.3' and 'dt-bindings-for-v5.3' into nex=
t)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (bf0b34ecc3e7 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (c454b622bd68 Merge branch 'next/defconfig' i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm/configs/exynos_defconfig
Merging scmi/for-linux-next (d84dc98fad98 Merge branch 'for-next/scmi-updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging sunxi/sunxi/for-next (f0776d431adb Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (45e6a49ed350 Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (e520e32f4117 Merge branch 'clk-fixes' into clk-next)
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (69fb22551ba7 dt-bindings: csky: Add csky PMU bindi=
ngs)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f67d667213ba m68k: defconfig: Update defconfigs for =
v5.2-rc1)
Merging m68knommu/for-next (b75d252a6322 riscv: add binfmt_flat support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (65eb3e4c1426 MIPS: configs: Remove useless UEVENT_H=
ELPER_PATH)
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (d2ba3b1714d7 parisc: Fix module loading error w=
ith JUMP_LABEL feature)
Merging powerpc/next (e610a466d16a powerpc/pseries/mobility: rebuild cachei=
nfo hierarchy post-migration)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (e93c9c99a629 Linux 5.1)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (96e5aaf91406 s390/cio: move struct node_descriptor t=
o cio.h)
Merging sh/sh-next (7c04efc8d2ef sh: configs: Remove useless UEVENT_HELPER_=
PATH)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (61474c3685e1 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0bb06cac060d fscrypt: remove unnecessary includes o=
f ratelimit.h)
Merging afs/afs-next (ee102584efd5 fs/afs: use struct_size() in kzalloc())
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (7b2f936fc828 ceph: fix error handling in ceph_get_caps=
())
Merging cifs/for-next (9cc5c49bf860 fix copy file range when beyond size of=
 source file)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (c036061be907 ecryptfs: Make ecryptfs_xattr_handler s=
tatic)
Merging ext3/for_next (a846d996a243 Pull nameremove cleanups from Amir.)
Merging ext4/dev (c708b1c6de7f ext4: remove redundant assignment to node)
Merging f2fs/dev (2e8cd5175790 f2fs: print kernel message if filesystem is =
inconsistent)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (29f785ff76b6 Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging nfs-anna/linux-next (d3f74a492eac Revert "SUNRPC: Declare RPC timer=
s as TIMER_DEFERRABLE")
Merging nfsd/nfsd-next (b8f73eb8b491 nfs: fix out-of-date connectathon talk=
 URL)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (f5b999c03f4c xfs: remove unused flag arguments)
Merging file-locks/locks-next (6ef048fd5955 locks: eliminate false positive=
 conflicts for write lease)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (753637b2039f Merge branch 'for-5.3' into for-next)
Merging pci/next (fbc6e0dd8d4e Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (a72920efb18f pstore: no need to check retur=
n value of debugfs_create functions)
Merging hid/for-next (b0153147e2d7 Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (bb0fb7686a52 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (f467907c1c38 i3c: dw: add limited bus mode support)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (7bdae67c800d hwmon: Convert remaining dri=
vers to use SPDX identifier)
Merging jc_docs/docs-next (0f48a2441613 doc-rst: Add missing newline at end=
 of file)
CONFLICT (content): Merge conflict in Documentation/fb/fbcon.rst
Merging v4l-dvb/master (513dbd35b5d9 media: add SPDX headers to some files)
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (4d0664ab8810 Merge branch 'topic/remove-fbcon=
-notifiers' of git://anongit.freedesktop.org/drm/drm-misc into fbdev-for-ne=
xt)
$ git reset --hard HEAD^
Merging next-20190619 version of fbdev
CONFLICT (modify/delete): drivers/video/fbdev/mxsfb.c deleted in 0f5a5712ad=
1e3b8472b1c1459681dadad9277067 and modified in HEAD. Version HEAD of driver=
s/video/fbdev/mxsfb.c left in tree.
$ git rm -f drivers/video/fbdev/mxsfb.c
[master 30efd00c4cbd] next-20190619/fbdev
Merging pm/linux-next (1e58e132e8d1 Merge branch 'powercap' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (d3df18a97e58 cpufreq: add drive=
r for Raspberry Pi)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (cd7ea582866f opp: Make dev_pm_opp_set_rate() ha=
ndle freq =3D 0 to drop performance votes)
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (6051531997ed dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (696de2e9ccec RDMA/netlink: Resort policy array)
CONFLICT (content): Merge conflict in include/rdma/ib_verbs.h
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/cmd.c
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Makefile deleted in rdm=
a/for-next and modified in HEAD. Version HEAD of drivers/infiniband/hw/nes/=
Makefile left in tree.
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Kconfig deleted in rdma=
/for-next and modified in HEAD. Version HEAD of drivers/infiniband/hw/nes/K=
config left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_std_ty=
pes_cq.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
$ git rm -f drivers/infiniband/hw/nes/Kconfig drivers/infiniband/hw/nes/Mak=
efile
Merging net-next/master (dca73a65a683 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/bpf/bpf-next)
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in HEAD a=
nd modified in net-next/master. Version net-next/master of drivers/infiniba=
nd/hw/nes/nes.c left in tree.
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
$ git rm -f drivers/infiniband/hw/nes/nes.c
Applying: Revert "macb: Add support for SiFive FU540-C000"
Merging bpf-next/master (dca73a65a683 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/bpf/bpf-next)
Merging ipsec-next/master (8928aa6a007d xfrm: remove empty xfrmi_init_net)
Merging mlx5-next/mlx5-next (82b11f071936 net/mlx5: Expose eswitch encap mo=
de)
Merging netfilter-next/master (7e6daf50e1f4 netfilter: bridge: prevent UAF =
in brnf_exit_net())
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (877cd9ffbc9c Merge branch 'net-dsa-use-switchdev-=
attr-and-obj-handlers')
Merging mac80211-next/master (f464100f5766 selftests/net: fix warnings in T=
FO key rotation selftest)
Merging gfs2/for-next (a4262eaf3df3 gfs2: Use IS_ERR_OR_NULL)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (5dc353d306bf mtd: onenand_base: Avoid fall-through =
warnings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.txt
Merging spi-nor/spi-nor/next (92aae4ce8427 mtd: spi-nor: change "error read=
ing JEDEC id" from dbg to err)
Merging crypto/master (576d152ccc56 crypto: nx - no need to check return va=
lue of debugfs_create functions)
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (52d2d44eee80 Merge v5.2-rc5 into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
Merging amdgpu/drm-next (70a1efac712c Revert "drm/amd/display: Enable fast =
plane updates when state->allow_modeset =3D true")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_audio.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
Merging drm-intel/for-linux-next (b32fa8111563 drm/i915/gtt: Defer address =
space cleanup to an RCU worker)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_csr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (b1622cb3be45 drm/bridge: tfp410: fix use o=
f cancel_delayed_work_sync)
Merging drm-msm/msm-next (2aa317672597 drm/msm: Re-order uninit function to=
 work during probe defer)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (8f2501e643bc drm/komeda: Enable write=
back split support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_dev.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/d7=
1/d71_dev.c
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (0a19fcccf3ed Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (15d472ecc510 ALSA: firewire-motu: code refactoring =
for pcm.hw_params/hw_free callbacks)
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (f1a783c2bfcd Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (bc6f2a757d52 kernel/module: Fix mem leak in m=
odule_add_modinfo_attrs)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (7c3fcf91afc0 Merge branch 'for-5.3/block' into for-=
next)
$ git reset --hard HEAD^
Merging next-20190620 version of block
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (4f8c162a9570 mmc: sdhci-pci: Add support for Intel EHL)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (a65d642f93f8 mfd: madera: Add supply mapping for =
MICVDD)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (bcb271f661d5 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (ba9bfa0e4809 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (8c655784e2cf integrity: Fix __integrity_i=
nit_keyring() section mismatch)
Merging keys/keys-next (4a486e0b3656 Merge tag 'keys-misc-20190619' into ke=
ys-next)
Merging selinux/next (464c258aa45b selinux: fix empty write to keycreate fi=
le)
Merging tpmdd/next (3ba18a217340 tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (5a4c44728eb6 Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/renesas', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (1bdd44579a54 dt-bindings: Add missing newline =
at end of file)
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (738c1f9266a3 Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (434f93f268c3 Merge branch 'irq/core')
Merging clockevents/clockevents/next (21c768d5ef2f clocksource/drivers/arm_=
arch_timer: Extract elf_hwcap use to arch-helper)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
Merging irqchip/irq/irqchip-next (0bdd0047ec94 irqchip/mbigen: Stop printin=
g kernel addresses)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (f8d221d2e0e1 Merge tag 'kvm-s390-master-5.2-2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-master)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (a2558e247804 platform/x86: hp_accel: Add supp=
ort for HP ProBook 450 G0)
Merging chrome-platform/for-next (d096aa3eb604 Input: cros_ec_keyb: mask ou=
t extra flags in event_type)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (25529edef561 Merge tag 'ti-lmu-led-drivers' into for=
-next)
Merging ipmi/for-next (102308f557bc ipmi: ipmb: Fix build error while CONFI=
G_I2C is set to m)
Merging driver-core/driver-core-next (d2527682160a firmware: arm_scmi: Use =
the correct style for SPDX License Identifier)
Merging usb/usb-next (b119deca1e01 USB: fix types in uapi include)
Merging usb-gadget/next (aa23ce847dda usb: dwc3: remove unused @lock member=
 of dwc3_ep struct)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (5c9dc6379f53 phy: renesas: rcar-gen3-usb2: fix imbal=
ance powered flag)
Merging tty/tty-next (607ea69d2621 serial: 8250: pericom_do_set_divisor can=
 be static)
Merging char-misc/char-misc-next (1a044213fc64 slimbus: core: generate ueve=
nt for non-dt only)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (be1038846b80 docs: soundwire: locking: fix tags for=
 a code-block)
Merging thunderbolt/next (9e0babf2c06c Linux 5.2-rc5)
Merging staging/staging-next (2f1539b24e2a staging: rtl8712: r8712_setMacAd=
dr_cmd(): Change return type)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (0eaab70a7a1b dmagengine: pl330: add code to get res=
et property)
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
CONFLICT (content): Merge conflict in Documentation/cgroup-v1/blkio-control=
ler.rst
Merging scsi/for-next (87c05682cea6 Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_spi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_fc.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport.h
CONFLICT (content): Merge conflict in include/scsi/scsi_bsg_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/sas_ata.h
CONFLICT (content): Merge conflict in include/scsi/sas.h
CONFLICT (content): Merge conflict in include/scsi/libsas.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi_tcp.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi.h
CONFLICT (content): Merge conflict in include/scsi/libfcoe.h
CONFLICT (content): Merge conflict in include/scsi/libfc.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_proto.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_if.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_ms.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fcp.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fcoe.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_fc2.h
CONFLICT (content): Merge conflict in include/scsi/fc/fc_encaps.h
CONFLICT (content): Merge conflict in drivers/scsi/st.c
CONFLICT (content): Merge conflict in drivers/scsi/sr.c
CONFLICT (content): Merge conflict in drivers/scsi/sg.c
CONFLICT (content): Merge conflict in drivers/scsi/ses.c
CONFLICT (content): Merge conflict in drivers/scsi/sd_zbc.c
CONFLICT (content): Merge conflict in drivers/scsi/sd_dif.c
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_spi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_sas.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_iscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_fc.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_trace.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_pm.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_logging.c
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
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_host_smp.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_ata.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi_tcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_rport.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_npiv.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_lport.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_libfc.h
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_libfc.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_frame.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_fcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_exch.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_elsct.c
CONFLICT (content): Merge conflict in drivers/scsi/libfc/fc_disc.c
CONFLICT (content): Merge conflict in drivers/scsi/hosts.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_transport.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe_ctlr.c
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe.h
CONFLICT (content): Merge conflict in drivers/scsi/fcoe/fcoe.c
$ git rm -f drivers/scsi/osst.c
Merging scsi-mkp/for-next (7cbc991b966c Merge branch '5.3/scsi-sg' into scs=
i-next)
Merging vhost/linux-next (169a126c6e88 iommu/virtio: Add event queue)
Merging rpmsg/for-next (b3e144584ac2 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (c8ecfd6caa1e Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (2674700c4c0e gpio: max732x: use devm_gpioc=
hip_add_data())
Merging pinctrl/for-next (7de3a67d5751 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8b-gpio=
.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8-gpio.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxl-gp=
io.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxbb-g=
pio.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8b=
.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xl.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xbb.c
Merging pinctrl-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (fe48319243a6 selftests/timers: Add missing fflush(s=
tdout) calls)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (074b8244b52d coresight: replicator: Add terminate e=
ntry for acpi_device_id tables)
CONFLICT (content): Merge conflict in drivers/hwtracing/coresight/coresight=
-tmc-etr.c
CONFLICT (content): Merge conflict in drivers/hwtracing/coresight/coresight=
-etm3x.c
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (241e39004581 nfsd: replace Jeff by Chuck=
 as nfsd co-maintainer)
Merging at24/at24/for-next (9ae9d9bfb72c eeprom: at24: use struct_size() in=
 devm_kzalloc())
Merging ntb/ntb-next (d9c53aa440b3 NTB: Describe the ntb_msi_test client in=
 the documentation.)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (c8d087d040cf nvmem: Broaden the selection of NVMEM_=
SNVS_LPGPR)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
Merging xarray/xarray (12fd2aee6db7 XArray tests: Add check_insert)
Merging hyperv/hyperv-next (703a70908255 Drivers: hv: vmbus: Break out ISA =
independent parts of mshyperv.h)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (ec8dce301980 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging hmm/hmm (9b1ae605c8e2 mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for n=
on-blocking)
Merging akpm-current/current (56ba580d3fea include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: proc/sysctl: add shared variables for range check
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (52959ac8d68b drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/2qNd.ejqdZ1WaHObKfVvI4R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MuP0ACgkQAVBC80lX
0GwSkAf/dwkvTG24Mt7pll9P5zc9BeYDQ6Xh2+5k7BIhTNLz6vm0TfQkCjinB6oP
vnHg2f7YyG5Uy1xkZgwqjbH1IcadhHyTGV+BKrGRUpKR2WdnIMBZ8+CA477974CV
hzbtYpZjAccZg4oDQu/zj7Mg1CJ0LeaLofV5gqr7hC3swAqbNpD0eb74tlltk0bO
7+hmzAo89RjBInDUBtLu3miyXCTZVK/l9V3K6yNaS87w+eZ4r8r7ZRG/06zpq3Ni
i3RgFIrH9w1hIhBWakO0F5VsL93T9TgW1clEONcNKaZbJfZjkc8VIXD4TkfHymL6
F91mqVhgfwCvxmroshZ7Es66R6RcHw==
=xiQ2
-----END PGP SIGNATURE-----

--Sig_/2qNd.ejqdZ1WaHObKfVvI4R--
