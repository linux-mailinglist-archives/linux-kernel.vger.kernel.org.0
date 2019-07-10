Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79DD645A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfGJLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 07:10:58 -0400
Received: from ozlabs.org ([203.11.71.1]:38115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:10:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kGh91TTCz9s8m;
        Wed, 10 Jul 2019 21:10:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562757049;
        bh=c2eUaiws5bzgE4cG9i0//pQzOkmB3pVBQUDk1ermJoE=;
        h=Date:From:To:Cc:Subject:From;
        b=Vo2rojUlVPfcnXjlv+zOuXm4Rj/buNKl9VXUF0q/5vHkeagIF0QcDlZbSjmsNuxft
         /xOysdW8FVG54h0vnF8z8/i+XwJ0l3S1g0ppjyjGQvz+TX6z6K5leNxK5d3fZLYZe+
         oNe7ygEOQx4S9LlDNxxB0RMYb5puyeFnwyvg3nJJQUGOkgGiBvYq7x9fR7IjNJFqqQ
         TUXKZVl6CMYhMgG/lIBIwIZ6mVgwCi5lfrGIbKK/6Ew8oJ0+mScVTQ51DTOn8wugS9
         +vsqlLm3V1Yqoz2Jxpx+mHK1qDbnZPbPhX+bFsRZDjADdJ6qV2tNMhseClaA8OCOfe
         D032WKSZnGp+g==
Date:   Wed, 10 Jul 2019 21:10:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 10
Message-ID: <20190710211046.09c19cfb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uW14g.5gQND/_u8e6V1a.0k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uW14g.5gQND/_u8e6V1a.0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190709:

The m68knommu tree gained a conflict against the m68k-current tree.

The iomap tree gained conflicts against Linus' tree.

The rdma tree still had some build failures for which I applied patches.

The tip tree gained a build failure due to an interaction with the ceph
tree for which I applied a merge fix patch.

The akpm-current tree lost its build failure and gained a conflict
against the iomap tree.

Non-merge commits (relative to Linus' tree): 9460
 8450 files changed, 769339 insertions(+), 270890 deletions(-)

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

I am currently merging 299 trees (counting Linus' and 72 trees of bug
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
Merging origin/master (e9a83bd23220 Merge tag 'docs-5.3' of git://git.lwn.n=
et/linux)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (d93512ef0f0e Makefile: Globally enable =
fall-through warning)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (24a20b0a443f ARC: [plat-hsdk]: Enable AXI DW =
DMAC in defconfig)
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (2659dc8d225c Merge tag 'davinci-fixes-for-=
v5.2-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-=
davinci into arm/fixes)
Merging arm64-fixes/for-next/fixes (aa69fb62bea1 arm64/efi: Mark __efistub_=
stext_offset as an absolute symbol explicitly)
Merging m68k-current/for-linus (f28a1f16135c m68k: Don't select ARCH_HAS_DM=
A_PREP_COHERENT for nommu or coldfire)
Merging powerpc-fixes/fixes (b7cbb5240130 Merge tag 'powerpc-5.2-6' into fi=
xes)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (e858faf556d4 tcp: Reset bytes_acked and bytes_received =
when disconnecting)
Merging bpf/master (9d1bc24b52fb bonding: validate ip header before check I=
PPROTO_IGMP)
Merging ipsec/master (56c5ee1a5823 xfrm interface: fix memory leak on creat=
ion)
Merging netfilter/master (1c5ec78272e3 netfilter: nfnetlink: avoid deadlock=
 due to synchronous request_module)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (2a92b08b1855 mt76: usb: fix rx A-MSDU supp=
ort)
Merging mac80211/master (d2ce8d6bfcfe nl80211: Fix undefined behavior in bi=
t shift)
Merging rdma-fixes/for-rc (4b972a01a7da Linux 5.2-rc6)
Merging sound-current/for-linus (0dcb4efb1095 ALSA: firewire-lib: code refa=
ctoring for local variables)
Merging sound-asoc-fixes/for-linus (0dceaf7c798d Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (ea09b3e21f18 Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (f0386617dca6 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (2337ff45293f Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (4b972a01a7da Linux 5.2-rc6)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (4b972a01a7da Linux 5.2-rc6)
Merging char-misc.current/char-misc-linus (4b972a01a7da Linux 5.2-rc6)
Merging soundwire-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (f0dd687815f9 Input: atmel_mxt_ts - fix lea=
k in mxt_update_cfg())
Merging crypto-current/master (f3880a23564e crypto: stm32/hash - remove int=
erruptible condition for dma)
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (0ecfebd2b524 Linux 5.2)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (c7a87ceb17ae mtd: rawnand: sunxi: Add A23/A33 =
DMA support with extra MBUS configuration)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (a71dcd3757e2 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f2ff671f8941 MAINTAINERS: Correct path to mo=
ved files)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (e644fa18e2ff KVM: arm64/sve: Fix vq_present() mac=
ro to yield a bool)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (5696e4aaabf2 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (75f2d86b20bf fs: VALIDATE_FS_PARSER should default=
 to n)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (5dd6c4933912 scsi: iscsi: set auth_protocol back =
to NULL if CHAP_A value is not supported)
Merging drm-fixes/drm-fixes (a0b2cf792ac9 Merge tag 'imx-drm-fixes-2019-07-=
04' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (d7e8a19b38c8 drm/i915: Don't =
dereference request if it may have been retired when printing)
Merging mmc-fixes/fixes (83293386bc95 mmc: core: Prevent processing SDIO IR=
Qs when the card is suspended)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (0db7f5cd4aeb riscv: mm: Fix code comment)
Merging drm-misc-fixes/for-linux-next-fixes (2f040d27080d drm/panfrost: Fix=
 a double-free error)
Merging kbuild/for-next (3192fe7185c3 Merge branch 'kconfig' into for-next)
CONFLICT (content): Merge conflict in Documentation/kbuild/makefiles.rst
CONFLICT (content): Merge conflict in Documentation/kbuild/kbuild.rst
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (15ffe5e1acf5 dma-mapping: mark dma_alloc_need=
_uncached as __always_inline)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (b7a735f3a606 Merge branch 'for-arm-soc' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (d482e575fbf0 perf: arm_spe: Enable ACPI/Pla=
tform automatic module loading)
Merging arm-soc/for-next (242af9ac5b32 ARM: Document merges)
CONFLICT (modify/delete): arch/arm/include/debug/netx.S deleted in arm-soc/=
for-next and modified in HEAD. Version HEAD of arch/arm/include/debug/netx.=
S left in tree.
CONFLICT (content): Merge conflict in arch/arm/configs/exynos_defconfig
$ git rm -f arch/arm/include/debug/netx.S
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (11343d25a03b Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (a1f5c11ddb7d Merge branches 'dt-for-v5.3', 'defcon=
fig-for-v5.3' and 'soc-for-v5.3' into for-next)
Merging at91/at91-next (7eb505978425 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (2a7f6c1a5376 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (e1b0b32a5ad6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (7376d6a65730 Merge branch 'fixes' into for-next)
Merging qcom/for-next (07c1ef894030 Merge tag 'qcom-dts-for-5.3-2' into ini=
tial-for-5.3)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (13622a50d8db Merge branch 'v5.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (cf6664323e0f Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (0ecfebd2b524 Linux 5.2)
Merging sunxi/sunxi/for-next (6c6b5d7650d9 Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (491933274860 Merge branch 'clk-lochnagar' into clk-ne=
xt)
CONFLICT (content): Merge conflict in drivers/clk/ingenic/Makefile
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
CONFLICT (modify/delete): arch/mips/include/asm/mach-jz4740/clock.h deleted=
 in clk/clk-next and modified in HEAD. Version HEAD of arch/mips/include/as=
m/mach-jz4740/clock.h left in tree.
$ git rm -f arch/mips/include/asm/mach-jz4740/clock.h
Applying: clk: consoldiate the __clk_get_hw() declarations
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9f98b3142d22 csky: Improve string operations perfo=
rmance by glibc code)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f28a1f16135c m68k: Don't select ARCH_HAS_DMA_PREP_CO=
HERENT for nommu or coldfire)
Merging m68knommu/for-next (ad97f9df0fee riscv: add binfmt_flat support)
CONFLICT (content): Merge conflict in arch/m68k/Kconfig
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (c9093486f283 mips/kprobes: Export kprobe_fault_hand=
ler())
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (f4ed27e065b3 parisc: Ensure userspace privilege=
 for ptraced processes in regset functions)
Merging powerpc/next (a2b6f26c264e powerpc/module64: Use symbolic instructi=
ons names.)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (2ebca1cbb4a5 riscv: remove free_initrd_mem)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (499723d12063 docs: s390: s390dbf: typos and formatti=
ng, update crash command)
Merging sh/sh-next (d3023897b437 arch/sh: Check for kprobe trap number befo=
re trying to handle a kprobe trap)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (b482e48d29f1 um: fix build without CONFIG_UML_TIME_=
TRAVEL_SUPPORT)
Merging xtensa/xtensa-for-next (6326b440055f Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (fb2b827702ba afs: Fix loop index mixup in afs_deliver=
_vl_get_entry_by_name_u())
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (80dfdbfd37d2 Merge branch 'for-next-current-v=
5.2-20190705' into for-next-20190705)
Merging ceph/master (d31d07b97a5e ceph: fix end offset in truncate_inode_pa=
ges_range call)
Applying: rbd: fix up for lockdep_assert_held_exclusive rename
Merging cifs/for-next (af164137752b cifs: fix parsing of symbolic link erro=
r response)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
CONFLICT (content): Merge conflict in fs/ecryptfs/keystore.c
Merging ext3/for_next (b6e8e3ba7748 Pull UDF size fix from Steve Magnani.)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (afe71a8074bc f2fs: avoid out-of-range memory access)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (c433a7975cfc Merge tag 'nfs-rdma-for-5.3-1' of git:=
//git.linux-nfs.org/projects/anna/linux-nfs)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (b78fa45d4edb nfsd: Make __get_nfsdfs_client() stati=
c)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (8009ce956c3d ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (211bbf3c38ed xfs: don't update lastino for FSBULKSTAT=
_SINGLE)
CONFLICT (content): Merge conflict in fs/xfs/xfs_aops.c
Merging iomap/iomap-for-next (eec9066e4a22 iomap: move internal declaration=
s into fs/iomap/)
CONFLICT (modify/delete): fs/iomap.c deleted in iomap/iomap-for-next and mo=
dified in HEAD. Version HEAD of fs/iomap.c left in tree.
$ git rm -f fs/iomap.c
Applying: iomap: fix for block changes and split of iomap.c
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (387e3746d01c locks: eliminate false positive=
 conflicts for write lease)
Merging vfs/for-next (54d501b0f382 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in fs/ubifs/super.c
CONFLICT (content): Merge conflict in fs/nfsd/nfsctl.c
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in HEAD=
 and modified in vfs/for-next. Version vfs/for-next of Documentation/filesy=
stems/vfs.txt left in tree.
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Merging printk/for-next (f0cc370ab74d Merge branch 'for-5.3' into for-next)
Merging pci/next (410300e77255 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (4c6d80e1144b pstore: Fix double-free in pst=
ore_mkfile() failure path)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (ede2001569c3 i3c: master: Use struct_size() helper)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9f7546570bcb hwmon: (ina3221) Add of_node=
_put() before return)
Merging jc_docs/docs-next (454f96f2b738 docs: automarkup.py: ignore excepti=
ons when seeking for xrefs)
Merging v4l-dvb/master (f81cbfc4f82a media: allegro: use new v4l2_m2m_ioctl=
_try_encoder_cmd funcs)
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
Merging pm/linux-next (aa9dbec9559c Merge branch 'pm-cpufreq' into linux-ne=
xt)
CONFLICT (content): Merge conflict in Documentation/power/pm_qos_interface.=
rst
Merging cpufreq-arm/cpufreq/arm/linux-next (f9020441dbc3 cpufreq: s5pv210: =
Don't flood kernel log after cpufreq change)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (560d1bcad715 opp: Don't use IS_ERR on invalid s=
upplies)
Merging thermal/next (ff9b011ad143 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (6051531997ed dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (4c7d6dcd3648 RDMA/siw: Fix DEFINE_PER_CPU compilatio=
n when ARCH_NEEDS_WEAK_PER_CPU)
Applying: RDMA/rvt: Do not use a kernel header in the ABI
Applying: RDMA/counters: Make rdma_counter.h compile stand alone
Applying: rdma: attempt to build rdma_counter.h stand alone again
Merging net-next/master (08cc83cc7fd8 net: dsa: add support for BRIDGE_MROU=
TER attribute)
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in HEAD a=
nd modified in net-next/master. Version net-next/master of drivers/infiniba=
nd/hw/nes/nes.c left in tree.
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
$ git rm -f drivers/infiniband/hw/nes/nes.c
Applying: p54: fix up for ktime_get_boot_ns() name change
Applying: Fixup to build SIW issue
Merging bpf-next/master (b14a260e33dd Merge branch 'nfp-tls-fixes-for-initi=
al-TLS-support')
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (1dd7382b1bb6 net/mlx5: Introduce VHCA tunnel d=
evice capability)
Merging netfilter-next/master (0ef1efd1354d netfilter: nf_tables: force mod=
ule load in case select_ops() returns -EAGAIN)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (5adcdab6ae1b Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (9ce67c3235be Bluetooth: btusb: Add protocol suppo=
rt for MediaTek MT7663U USB devices)
Merging mac80211-next/master (17c74d7c5f0d nl80211: fix VENDOR_CMD_RAW_DATA)
Merging gfs2/for-next (bb4cb25dd319 gfs2: Remove unused gfs2_iomap_alloc ar=
gument)
CONFLICT (content): Merge conflict in fs/gfs2/super.c
Merging mtd/mtd/next (46ce10df799f Merge tag 'spi-nor/for-5.3-v2' of gitoli=
te.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next)
CONFLICT (content): Merge conflict in include/linux/platform_data/intel-spi=
.h
CONFLICT (modify/delete): drivers/mtd/spi-nor/stm32-quadspi.c deleted in mt=
d/mtd/next and modified in HEAD. Version HEAD of drivers/mtd/spi-nor/stm32-=
quadspi.c left in tree.
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.h
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-platfor=
m.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-pci.c
CONFLICT (content): Merge conflict in drivers/mtd/nand/raw/mtk_ecc.h
$ git rm -f drivers/mtd/spi-nor/stm32-quadspi.c
Merging nand/nand/next (bce9437a0a48 mtd: rawnand: stm32_fmc2: increase DMA=
 completion timeouts)
Merging spi-nor/spi-nor/next (8d1336c241bd mtd: spi-nor: cadence-quadspi: a=
dd reset control)
Merging crypto/master (f3880a23564e crypto: stm32/hash - remove interruptib=
le condition for dma)
Merging drm/drm-next (4cf643a39221 Merge tag 'drm-next-5.3-2019-06-27' of g=
it://people.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in include/uapi/linux/magic.h
CONFLICT (modify/delete): drivers/gpu/drm/i915/intel_context.c deleted in d=
rm/drm-next and modified in HEAD. Version HEAD of drivers/gpu/drm/i915/inte=
l_context.c left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
cs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
CONFLICT (content): Merge conflict in Documentation/fb/modedb.rst
$ git rm -f drivers/gpu/drm/i915/intel_context.c
Applying: dma-buf: convert to new mount api
Merging amdgpu/drm-next (4518c08d4724 drm/amdgpu: consolidate navi14 IP ini=
t)
Merging drm-intel/for-linux-next (b33c61db7291 drm/i915: Remove unused i915=
_gem_context_lookup_engine)
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (990dee3aa456 drm/komeda: Computing image e=
nhancer internally)
Merging drm-msm/msm-next (648fdc3f6475 drm/msm: add dirty framebuffer helpe=
r)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (4cf643a39221 Merge tag 'drm-next-5.3-=
2019-06-27' of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
Merging etnaviv/etnaviv/next (57bdd4057516 drm/etnaviv: Use devm_platform_i=
oremap_resource())
Merging regmap/for-next (aaccf3863ce2 Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (b89b889a326a Merge branch 'topic/hda-refresh-cleanu=
p' into for-next)
Merging sound-asoc/for-next (a98429acadef Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (93651f80dcb6 modules: fix compile error if do=
n't have strict module rwx)
Merging input/next (593fdd4fb44e Input: gpio_keys_polled - allow specifying=
 name of input device)
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (6a42ac2da18f Merge branch 'for-5.3/block' into for-=
next)
Merging device-mapper/for-next (b9411d73bd3e dm crypt: implement eboiv - en=
crypted byte-offset initialization vector)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (adca963337c7 mmc: sdhci_am654: Add dependency on MMC_SDHC=
I_AM654)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-gx-mmc.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7efd105c27fd mfd: hi655x-pmic: Fix missing return=
 value check for devm_regmap_init_mmio_clk)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
CONFLICT (content): Merge conflict in drivers/gpio/Makefile
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
CONFLICT (content): Merge conflict in drivers/video/backlight/pwm_bl.c
Merging battery/for-next (caa2b557841c power: reset: nvmem-reboot-mode: add=
 CONFIG_OF dependency)
CONFLICT (content): Merge conflict in drivers/power/supply/Makefile
CONFLICT (content): Merge conflict in drivers/power/supply/Kconfig
CONFLICT (modify/delete): Documentation/power/power_supply_class.txt delete=
d in HEAD and modified in battery/for-next. Version battery/for-next of Doc=
umentation/power/power_supply_class.txt left in tree.
$ git rm -f Documentation/power/power_supply_class.txt
Applying: power: supply: update for conversion to .rst
Merging regulator/for-next (0ed4513c9a32 Merge remote-tracking branch 'regu=
lator/topic/coupled' into regulator-next)
Merging security/next-testing (286e47a07799 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (20adf5593389 Merge tag 'keys-acl-20190703' into key=
s-next)
Merging selinux/next (ea74a685ad81 selinux: format all invalid context as u=
ntrusted)
Merging tpmdd/next (e01b46aeb47e tpm: Fix null pointer dereference on chip =
register error path)
Merging watchdog/master (053bc5764bb0 watchdog: ie6xx_wdt: Use spinlock_t i=
nstead of struct spinlock)
CONFLICT (add/add): Merge conflict in Documentation/watchdog/watchdog-param=
eters.rst
CONFLICT (content): Merge conflict in Documentation/watchdog/hpwdt.rst
Merging iommu/next (d95c3885865b Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (b46c820f8f5a sample/mdev/mbochs: remove set but not used=
 variable 'mdev_state')
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (f21ce913a82f dt-bindings: arm: Convert RDA Mic=
ro board/soc bindings to json-schema)
CONFLICT (content): Merge conflict in scripts/dtc/libfdt/Makefile.libfdt
CONFLICT (content): Merge conflict in scripts/dtc/Makefile.dtc
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/ethernet.txt
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (26ac56506b0e Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (82ee3f2ed270 Merge branch 'core/urgent')
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging irqchip/irq/irqchip-next (3dae67ce600c irqchip/gic-pm: Remove PM_CL=
K dependency)
Merging ftrace/for-next (730a95953b1f tracing/kprobe: Check registered stat=
e using kprobe)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (9824c83f92bc Documentation: kvm: document CPUID bit=
 for MSR_KVM_POLL_CONTROL)
Merging kvm-arm/next (1e0cf16cdad1 KVM: arm/arm64: Initialise host's MPIDRs=
 by reading the actual register)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
CONFLICT (content): Merge conflict in Documentation/arm64/silicon-errata.rst
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging xen-tip/linux-next (8b13dee43393 xen/events: fix binding user event=
 channels to cpus)
Merging percpu/for-next (e0afe6d4d12c Merge branch 'for-5.4' into for-next)
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (8e8fe446a91c platform/x86: asus-wmi: Use dev_=
get_drvdata())
Merging chrome-platform/for-next (8c3166e17cf1 mfd / platform: cros_ec_debu=
gfs: Expose resume result via debugfs)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (2605085fba22 dt: leds-lm36274.txt: fix a broken refe=
rence to ti-lmu.txt)
Merging ipmi/for-next (ac499fba98c3 docs: ipmb: place it at driver-api and =
convert to ReST)
Merging driver-core/driver-core-next (c33d442328f5 debugfs: make error mess=
age a bit more verbose)
CONFLICT (content): Merge conflict in net/sunrpc/debugfs.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (content): Merge conflict in drivers/acpi/sleep.c
Applying: merge fix for conflict between the s390 and driver-core tree
Merging usb/usb-next (2bc8bb813cba Merge tag 'usb-ci-v5.3-rc1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (35a4ed0164e9 tty: serial: fsl_lpuart: add imx8qxp sup=
port)
Merging char-misc/char-misc-next (2f4281f4dce1 Merge tag 'soundwire-5.3-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into cha=
r-misc-next)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
CONFLICT (modify/delete): drivers/hwtracing/coresight/of_coresight.c delete=
d in char-misc/char-misc-next and modified in HEAD. Version HEAD of drivers=
/hwtracing/coresight/of_coresight.c left in tree.
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/freescale/fsl,scu.txt
$ git rm -f drivers/hwtracing/coresight/of_coresight.c
Applying: coresight: fix for "bus_find_device: Unify the match callback wit=
h class_find_device"
Applying: coresight: Make the coresight_device_fwnode_match declaration's f=
wnode parameter const
Applying: convert vmwballoon to use the new mount API
Merging extcon/extcon-next (0937fbb7abeb extcon: fsa9480: Fix Kconfig warni=
ng and build errors)
Merging soundwire/next (2aeac95d1a4c soundwire: add module_sdw_driver helpe=
r macro)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (5d1532482943 staging: kpc2000: simplify compa=
rison to NULL in fileops.c)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (5c274ca4cfb2 dmaengine: Revert "dmaengine: fsl-edma=
: add i.mx7ulp edma2 version support")
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
Merging scsi/for-next (8fdf518974b5 Merge branch 'fixes' into for-next)
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
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_srp.c
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
Merging scsi-mkp/for-next (893ca250edfc Merge branch '5.3/scsi-sg' into scs=
i-next)
Merging vhost/linux-next (169a126c6e88 iommu/virtio: Add event queue)
Applying: iommu/virtio: Constify data parameter in viommu_match_node
Merging rpmsg/for-next (ab1291acd4ab Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (9b3b623804a6 Revert "gpio: tegra: Clean-up debugfs i=
nitialisation")
Merging gpio-brgl/gpio/for-next (f360dcd4ef7f gpio: mockup: no need to chec=
k return value of debugfs_create functions)
Merging pinctrl/for-next (35d8510ea3ad pinctrl: aspeed: Fix missed include)
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
Merging pwm/for-next (3d25025ce9c2 pwm: fsl-ftm: Make sure to unlock mutex =
on failure)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (ee8a84c60bcc rseq/selftests: Fix Thumb mode build f=
ailure on arm32)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (2f4281f4dce1 Merge tag 'soundwire-5.3-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-nex=
t)
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (7c40cc44161a Merge branch 'for-5.3/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in include/uapi/linux/virtio_ids.h
Merging at24/at24/for-next (dce91ba39c76 eeprom: at24: modify a comment ref=
erring to platform data)
Merging ntb/ntb-next (d9c53aa440b3 NTB: Describe the ntb_msi_test client in=
 the documentation.)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/next (371975b0b075 fsi/core: Fix error paths on CFAM init)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (341f8ae0f820 dt-bindings: nvmem: SID: Fix the examp=
les node names)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/allwinner,sun4i-a10-sid.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/freescale/fsl,scu.txt
Merging xarray/xarray (91abab83839a XArray: Fix xas_next() with a single en=
try at 0)
Merging hyperv/hyperv-next (765e33f5211a Drivers: hv: vmbus: Break out ISA =
independent parts of mshyperv.h)
CONFLICT (content): Merge conflict in arch/x86/include/asm/mshyperv.h
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (4382fc438ca5 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
CONFLICT (content): Merge conflict in kernel/fork.c
Merging devfreq/for-next (27c17be8e488 PM / devfreq: tegra20: add COMMON_CL=
K dependency)
Merging hmm/hmm (cc5dfd59e375 Merge branch 'hmm-devmem-cleanup.4' into rdma=
.git hmm)
CONFLICT (content): Merge conflict in include/linux/ioport.h
Applying: mm/hmm: fixup for "locking/lockdep: Rename lockdep_assert_held_ex=
clusive() -> lockdep_assert_held_write()"
Applying: drm/amdgpu: adopt to hmm_range_register API change
Applying: fixup! kbuild: remove obj and src from the top Makefile
Merging akpm-current/current (28b56a57efbf selftests/seccomp/seccomp_bpf: u=
pdate for PTRACE_GET_SYSCALL_INFO)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in lib/Makefile
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (modify/delete): fs/iomap.c deleted in HEAD and modified in akpm-c=
urrent/current. Version akpm-current/current of fs/iomap.c left in tree.
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
CONFLICT (content): Merge conflict in arch/x86/Kconfig
CONFLICT (content): Merge conflict in arch/powerpc/mm/book3s64/radix_pgtabl=
e.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/pgtable.h
$ git rm -f fs/iomap.c
Applying: merge fixup for "mm: Add an apply_to_pfn_range interface"
Applying: another fixup for "mm: Add an apply_to_pfn_range interface"
Applying: mm: migrate: fix for fs/iomap.c splitting
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: device-dax: fix memory and resource leak if hotplug fails
Applying: mm/hotplug: make remove_memory() interface usable
Applying: device-dax: "Hotremove" persistent memory that is used like norma=
l RAM
Applying: mm: move MAP_SYNC to asm-generic/mman-common.h
Applying: mm/mmap: move common defines to mman-common.h
Applying: mm: section numbers use the type "unsigned long"
Applying: mm-section-numbers-use-the-type-unsigned-long-fix
Applying: mm-section-numbers-use-the-type-unsigned-long-v3
Applying: drivers/base/memory: Use "unsigned long" for block ids
Applying: mm: make register_mem_sect_under_node() static
Applying: mm/memory_hotplug: rename walk_memory_range() and pass start+size=
 instead of pfns
Applying: mm/memory_hotplug: move and simplify walk_memory_blocks()
Applying: drivers/base/memory.c: Get rid of find_memory_block_hinted()
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix
Applying: mm: clean up is_device_*_page() definitions
Applying: mm: introduce ARCH_HAS_PTE_DEVMAP
Applying: arm64: mm: implement pte_devmap support
Applying: arm64-mm-implement-pte_devmap-support-fix
Applying: mm/sparsemem: introduce struct mem_section_usage
Applying: mm/sparsemem: introduce a SECTION_IS_EARLY flag
Applying: mm/sparsemem: add helpers track active portions of a section at b=
oot
Applying: mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section rem=
oval
Applying: mm/sparsemem: convert kmalloc_section_memmap() to populate_sectio=
n_memmap()
Applying: mm/hotplug: kill is_dev_zone() usage in __remove_pages()
Applying: mm: kill is_dev_zone() helper
Applying: mm/sparsemem: prepare for sub-section ranges
Applying: mm/sparsemem: support sub-section hotplug
Applying: mm: document ZONE_DEVICE memory-model implications
Applying: docs/vm: update ZONE_DEVICE memory model documentation
Applying: mm/devm_memremap_pages: enable sub-section remap
Applying: libnvdimm/pfn: fix fsdax-mode namespace info-block zero-fields
Applying: libnvdimm/pfn: stop padding pmem namespaces to section alignment
Applying: mm/sparsemem: cleanup 'section number' data types
Applying: mm-sparsemem-cleanup-section-number-data-types-fix
Applying: mm: add account_locked_vm utility function
Applying: mm-add-account_locked_vm-utility-function-v3
Applying: mm-add-account_locked_vm-utility-function-v3-fix
Applying: proc/sysctl: add shared variables for range check
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-4
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (cebdb204c94f drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/uW14g.5gQND/_u8e6V1a.0k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lx7YACgkQAVBC80lX
0Gzwagf/RIi7/tlE0q7qFO37hwkyIKN1v2/is3V1TN0GnAM/LX5XxYQEHoW0KAXF
uznwfAPijNgzx5a4OS5AT2SCZ7Ps+0efp13NscU08JzaZYXa4K4A+FTtnzSFAh0S
VZVztDIkqOe/kpGCRRhMbdaF0xUWFhrnc4Ll9S+KZ9WAXdxhROsP3hswtb8eLYJd
xSzkIZLeaidYfsCWeBBM+gVnBYBD0yJDwFte+7QY7YRcrqsL+As9O9ELFxTBOmIZ
E8tIxwJx3F1X8OjDeHzO81vcuqc9NgcDjLHtyGaeMsLk8RUygrjvYB8iO+cm7+l7
BXMgRg54cDxTGTYaTMgWQwReoe9A/w==
=N5zL
-----END PGP SIGNATURE-----

--Sig_/uW14g.5gQND/_u8e6V1a.0k--
