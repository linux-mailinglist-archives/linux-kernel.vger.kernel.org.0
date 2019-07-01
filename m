Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078864B680
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfFSKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 06:51:53 -0400
Received: from ozlabs.org ([203.11.71.1]:33201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfFSKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:51:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TMFw1grHz9sNC;
        Wed, 19 Jun 2019 20:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560941508;
        bh=No9euTUgZTjR6UaN6yiQH3tsz5b1ofeFufMmw31D4fA=;
        h=Date:From:To:Cc:Subject:From;
        b=sHB4ZJAw6SrVz8AWwZVI6JITkHPFd6u/P5FiP3P+NgE43UWbXqzvJyCH3xXVj0/cx
         aAvOvcsCJ0BE5ZVMkWbtr3tu+yWGK2qGLjC9ro6o+VK0Kw5N9zfx13Z6tfhgGk2+9Y
         YyWfcztsYOyDJEP+TkaPd3jkmHiZyOvCTxqxFn0RQhw9potlvXBhgtdm3W0Y3S4qYo
         2sNg4Q1GGxBJAblEYu1X607QIhR1ua514j6LG7tsSdrSLwJy9i196uAATmJqRy8j93
         7v2a2FaAZRwzmcjT6BhR/K8gwOZA2+8L+SQncotsxM0N8rKk1gKzYGEMye4J+yq62r
         qLrlbvR+1Mq3g==
Date:   Wed, 19 Jun 2019 20:51:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 19
Message-ID: <20190619205146.7d3543df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DAAhIZ222WVWYON.r9NcMNS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DAAhIZ222WVWYON.r9NcMNS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190618:

The net-next tree gained a build failure due to an interaction with the
kbuild tree for which I applied a fix patch.

The drm tree gained a conflict against the kbuild tree.

The usb tree gained a build failure due to an interaction with the
kbuild tree for which I applied a fix patch.

The akpm-current tree gained a build failure due to an interaction with
the kbuild tree for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 6431
 7003 files changed, 261936 insertions(+), 218938 deletions(-)

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

I am currently merging 294 trees (counting Linus' and 71 trees of bug
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
Merging origin/master (bed3c0d84e7e Merge tag 'for-5.2-rc5-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (d431a90c8a45 ARC: mm: do_page_fault refactor =
#8: release mmap_sem sooner)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (615c48ad8f42 arm64/mm: don't initialize=
 pgd_cache twice)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (82f6e266f812 powerpc/32: fix build failure on =
book3e with KVM)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (72b319dc08b4 tun: wake up waitqueues after IFF_UP is se=
t)
Merging bpf/master (56f0f84e69c7 bpf: fix the check that forwarding is enab=
led in bpf_ipv6_fib_lookup)
Merging ipsec/master (b8d6d0079757 xfrm: fix sa selector validation)
Merging netfilter/master (8a3dca632538 netfilter: ipv6: nf_defrag: accept d=
uplicate fragments again)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (6be8e297f9bc lapb: fixed leak of control-blocks.)
Merging rdma-fixes/for-rc (cc78076af14e IB/hfi1: Correct tid qp rcd to matc=
h verbs context)
Merging sound-current/for-linus (17d304604a88 Revert "ALSA: hda/realtek - I=
mprove the headset mic for Acer Aspire laptops")
Merging sound-asoc-fixes/for-linus (88fbd9343adc Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (2217d05161cb Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (9e0babf2c06c Linux 5.2-rc5)
Merging spi-fixes/for-linus (ca4ad992582c Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (ddd57980a0fd xhci: detect USB 3.2 capable ho=
st controllers correctly)
Merging usb-gadget-fixes/fixes (42cc68868ce9 usb: gadget: udc: lpc32xx: fix=
 return value check in lpc32xx_udc_probe())
Merging usb-serial-fixes/usb-linus (f3dfd4072c3e USB: serial: option: add T=
elit 0x1260 and 0x1261 compositions)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (9b9410766f54 Merge branch 'erofs_fix=
' into staging-linus)
Merging char-misc.current/char-misc-linus (a370003cc301 binder: fix possibl=
e UAF when freeing buffer)
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
Merging mips-fixes/mips-fixes (d6ed083f5cc6 MIPS: Fix bounds check virt_add=
r_valid)
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
Merging scsi-fixes/fixes (625d7d351887 scsi: hpsa: correct ioaccel2 chainin=
g)
Merging drm-fixes/drm-fixes (e14c5873d2a3 Merge branch 'drm-fixes-5.2' of g=
it://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (9e0babf2c06c Linux 5.2-rc5)
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
Merging arm/for-next (2257962024da Merge commit commit 'drm-armada-devel^{/=
drm/armada: no need to check parent of remote}' into for-next)
Merging arm64/for-next/core (8f5c9037a55b arm64/mm: Correct the cache line =
size warning with non coherent device)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (ae9924667a7e MAINTAINERS: Add maintainer en=
try for the imx8 DDR PMU driver)
Merging arm-soc/for-next (e57f4f2c4506 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (cfda88bf7f1c Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (17fb539a4603 Merge branches 'dt-for-v5.3' and 'soc=
-for-v5.3' into for-next)
Merging at91/at91-next (32dfd9cfa4c6 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (beb58dd364d3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (39c69ae7ef17 Merge tag 'drivers_soc_for_5.3' into ne=
xt)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (03fb10f2128a Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1e16bc075913 Merge branch 'fixes' into for-next)
Merging qcom/for-next (7aea6f1c7660 Merge branches 'arm64-for-5.3', 'driver=
s-for-5.3' and 'dts-for-5.3' into for-next)
Merging renesas/next (6cf0b47ff724 Merge branch 'arm64-dt-for-v5.3' into ne=
xt)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (bf0b34ecc3e7 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (0d8bc7b138cb Merge branch 'next/defconfig' i=
nto for-next)
Merging scmi/for-linux-next (d84dc98fad98 Merge branch 'for-next/scmi-updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging sunxi/sunxi/for-next (f0776d431adb Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (cc79a5f3cef6 Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (397a7b5ebe4d Merge branch 'clk-fixes' into clk-next)
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
Merging clk-samsung/for-next (2f57b95caf8f clk: samsung: add new clocks for=
 DMC for Exynos5422 SoC)
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
Merging s390/features (39c00378e337 Update default configuration)
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
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (7b2f936fc828 ceph: fix error handling in ceph_get_caps=
())
Merging cifs/for-next (d677d0b6547d Fix match_server check to allow for aut=
o dialect negotiate)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (3803f4dc265f Merge ext2 bitmap bh leak fix.)
Merging ext4/dev (a49773064bc2 jbd2: fix typo in comment of journal_submit_=
inode_data_buffers)
Merging f2fs/dev (f14f319eb1a1 f2fs: add a rw_sem to cover quota flag chang=
es)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (29f785ff76b6 Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging nfs-anna/linux-next (d3f74a492eac Revert "SUNRPC: Declare RPC timer=
s as TIMER_DEFERRABLE")
Merging nfsd/nfsd-next (4fc2b5fe1cf2 nfsd: fix cleanup of nfsd_reply_cache_=
init on failure)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (253e74833911 ovl: fix typo in MODULE_PARM=
_DESC)
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
Merging pstore/for-next/pstore (e070e380c674 Merge branch 'for-linus/pstore=
' into for-next/pstore)
Merging hid/for-next (b0153147e2d7 Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (bb0fb7686a52 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (5e343fbb7176 dt-bindings: i3c: Document dropped suppo=
rt for I2C 10 bit devices)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (3852d74e3bb4 hwmon: (gpio-fan) Fix sysfs_=
notify and kobject_uevent in fan_alarm_notify)
Merging jc_docs/docs-next (d95ea1a4e1fb docs: Add a document on repository =
management)
Merging v4l-dvb/master (513dbd35b5d9 media: add SPDX headers to some files)
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (0f5a5712ad1e video: fbdev: pvr2fb: add COMPIL=
E_TEST support)
CONFLICT (modify/delete): drivers/video/fbdev/mxsfb.c deleted in fbdev/fbde=
v-for-next and modified in HEAD. Version HEAD of drivers/video/fbdev/mxsfb.=
c left in tree.
$ git rm -f drivers/video/fbdev/mxsfb.c
Merging pm/linux-next (eefb01367c51 Merge branches 'pm-cpufreq' and 'pm-pci=
' into linux-next)
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
Merging swiotlb/linux-next (4aa095ea329d swiotlb: Return consistent SWIOTLB=
 segments/nr_tbl)
Merging rdma/for-next (cbdc666f3e84 RDMA/ipoib: Remove check for ETH_SS_TES=
T)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_std_ty=
pes_cq.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (760f1dc29580 net: stmmac: add sanity check to devi=
ce_property_read_u32_array call)
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
Applying: net: sched: don't use BIT() in uapi headers
Merging bpf-next/master (94079b64255f Merge branch 'bpf-bounded-loops')
Merging ipsec-next/master (8928aa6a007d xfrm: remove empty xfrmi_init_net)
Merging mlx5-next/mlx5-next (82b11f071936 net/mlx5: Expose eswitch encap mo=
de)
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
Merging netfilter-next/master (d7f9b2f18eae netfilter: synproxy: extract SY=
NPROXY infrastructure from {ipt, ip6t}_SYNPROXY)
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
Merging crypto/master (b0d765219fb3 crypto: sahara - Use devm_platform_iore=
map_resource())
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (2454fcea338a Merge tag 'drm-misc-next-2019-06-14' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (modify/delete): include/drm/gma_drm.h deleted in drm/drm-next and=
 modified in HEAD. Version HEAD of include/drm/gma_drm.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (modify/delete): drivers/gpu/drm/cirrus/cirrus_drv.h deleted in dr=
m/drm-next and modified in HEAD. Version HEAD of drivers/gpu/drm/cirrus/cir=
rus_drv.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
$ git rm -f drivers/gpu/drm/cirrus/cirrus_drv.h include/drm/gma_drm.h
Merging amdgpu/drm-next (21a249ca0241 drm/amdgpu: wait to fetch the vbios u=
ntil after common init)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_audio.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
Merging drm-intel/for-linux-next (381f8a20d2f6 drm/i915/psr: Force manual P=
SR exit in older gens)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_csr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (b1622cb3be45 drm/bridge: tfp410: fix use o=
f cancel_delayed_work_sync)
Merging drm-msm/msm-next (d3cb8f3d0fb2 drm/msm/dpu: Remove bogus comment)
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
Merging sound-asoc/for-next (bf7d23f120af Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (bc6f2a757d52 kernel/module: Fix mem leak in m=
odule_add_modinfo_attrs)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (e3bf98fbd085 Merge branch 'for-5.3/block' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (9d767dc55208 Merge branch 'fixes' into next)
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
Merging regulator/for-next (d8e1c6c3b28d Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (ba9bfa0e4809 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (e038f5f691e0 ima: Use designated initiali=
zers for struct ima_event_data)
Merging selinux/next (464c258aa45b selinux: fix empty write to keycreate fi=
le)
Merging tpmdd/next (31be68564a43 efi: Attempt to get the TCG2 event log in =
the boot stub)
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
Merging spi/for-next (691b74070b89 Merge remote-tracking branch 'spi/topic/=
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
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (a2558e247804 platform/x86: hp_accel: Add supp=
ort for HP ProBook 450 G0)
Merging chrome-platform/for-next (10671da7e8e1 platform/chrome: wilco_ec: f=
ix null pointer dereference on failed kzalloc)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (25529edef561 Merge tag 'ti-lmu-led-drivers' into for=
-next)
Merging ipmi/for-next (102308f557bc ipmi: ipmb: Fix build error while CONFI=
G_I2C is set to m)
Merging driver-core/driver-core-next (5669245b57df ARM: omap1: remove unuse=
d variable)
Merging usb/usb-next (d7863de8cdea usb: host: fotg2: add device tree probin=
g)
Applying: USB: fix types in uapi include
Merging usb-gadget/next (d29fcf7078bc usb: gadget: ether: Fix race between =
gether_disconnect and rx_submit)
Merging usb-serial/usb-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (6ef72bc036bc phy: qcom: Add Qualcomm PCIe2 PHY drive=
r)
Merging tty/tty-next (607ea69d2621 serial: 8250: pericom_do_set_divisor can=
 be static)
Merging char-misc/char-misc-next (312d362c6ae4 MAINTAINERS: fpga: hand off =
maintainership to Moritz)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (be1038846b80 docs: soundwire: locking: fix tags for=
 a code-block)
Merging thunderbolt/next (9e0babf2c06c Linux 5.2-rc5)
Merging staging/staging-next (61959885103a staging: rtl8723bs: hal: odm_HWC=
onfig: Unneeded variable: "result". Return "HAL_STATUS_SUCCESS")
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
Merging scsi/for-next (4e9c049f93e9 Merge branch 'misc' into for-next)
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
Merging scsi-mkp/for-next (f3e88ad00f58 scsi: mpt3sas: Update driver versio=
n to 29.100.00.00)
Merging vhost/linux-next (169a126c6e88 iommu/virtio: Add event queue)
Merging rpmsg/for-next (b3e144584ac2 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (c8ecfd6caa1e Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (2674700c4c0e gpio: max732x: use devm_gpioc=
hip_add_data())
Merging pinctrl/for-next (d6e561df50b5 dt-bindings: pinctrl: pic32: Spellin=
g s/configuraion/configuration/)
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8b-gpio=
.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8-gpio.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxl-gp=
io.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxbb-g=
pio.h
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-u300.c
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-coh901.c
CONFLICT (content): Merge conflict in drivers/pinctrl/nomadik/Kconfig
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
Merging livepatching/for-next (eb1bfcffba2c Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (074b8244b52d coresight: replicator: Add terminate e=
ntry for acpi_device_id tables)
Merging rtc/rtc-next (110036b4f4db rtc: rx8025: simplify getting the adapte=
r of a client)
Merging nvdimm/libnvdimm-for-next (cd6c84d8f0cd Linux 5.2-rc2)
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
Merging auxdisplay/auxdisplay (f4cd7203c1d4 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (0560505fbd43 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging hmm/hmm (9b1ae605c8e2 mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for n=
on-blocking)
Merging akpm-current/current (d96d6145d979 mm/page_idle.c: fix oops because=
 end_pfn is larger than max_pfn)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
Applying: Revert "byteorder-sanity-check-toolchain-vs-kernel-endianess-chec=
kpatch-fixes"
Applying: Revert "byteorder: sanity check toolchain vs kernel endianness"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: proc/sysctl: add shared variables for range check
Applying: proc-sysctl-add-shared-variables-for-range-check-fix
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3305df8e2faf drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/DAAhIZ222WVWYON.r9NcMNS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0KE8IACgkQAVBC80lX
0GxQcQgApja+2sUVJ4MRdMlDZkN5p/7TkAE5mcAfwRhFcIGagQpsfuBh9Z7PQsJ+
/K8hFp03blZ1t/guaqClBjgVsm5zdLU+xr7XRRMIABPs4IucWY86jLibip3xcSDF
9NGTAS/DcyEPm2rKiz7GTiPzq+pyQ7ZwSr3urrMvSN649jGIaWHhgPcoHtFbA0cx
yiO8yC0vadb/rljmhfTzV7GAgbe6y26TElS6dx9l5QDl+N0WDg3GLvJabEu/AGtf
h5lmQgaWL2SDx2at7AxM0RPANpKkRjgPZG1WtOTQ449ANtH5yQmKRIT0vZgXW8HX
HM8pABiR0oS6pc9F9Me4jo+kiegZKw==
=9RIp
-----END PGP SIGNATURE-----

--Sig_/DAAhIZ222WVWYON.r9NcMNS--
