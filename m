Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F995CCFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGBJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 05:52:06 -0400
Received: from ozlabs.org ([203.11.71.1]:42801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfGBJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:52:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dKJw0JHSz9sND;
        Tue,  2 Jul 2019 19:52:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562061120;
        bh=uoMlpo59GiQIAU/ZmyLEcJ8WzKwj5A4NX3klq2pkiCg=;
        h=Date:From:To:Cc:Subject:From;
        b=UVPgh9PdvWrHcoDsAHMbq9/E7JlcNWg15g5EOMogZXMeF0xlNAAUYaKbdusbqD07r
         hmptr7IoiuRm7TqecQFerZBu77D25Sj9U8Fn9wSAeijKuRNZWES8QY0OGJzicbCLiv
         jkAq7YS4+NL7ItJMxtUMuLCer0Ve2wJS7LIzHN7QOheFpMAfD/iAM9hgK8QgQJETKc
         x3kQP8UXYOxCU/tGxrrW5ogrDNNY14Zko6G4Dw45IrVflaHjUlFfjK2V6gIo37/UnA
         ljxDIv6WTUYS3keOv00wkA3DhYMr7A/QDGFw2u+aMuFn4YE1xuX4Arm0/pwsppBBmJ
         eyqxo9AsX3XIw==
Date:   Tue, 2 Jul 2019 19:51:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 2
Message-ID: <20190702195158.79aa5517@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A589tihDE.VJR22jGt1hcYJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A589tihDE.VJR22jGt1hcYJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190701:

New trees: iomap, djw-vfs

The m68knommu tree gained conflicts against the m68k tree.

The xfs tree lost its build failure.

The pm tree lost its build failure.

The rdma tree still had its build failures so I used the version from
next-20190628.

The net-next tree gained a conflict against the net tree.

The mlx5-next tree gained conflicts against Linus' tree.

The tip tree gained a conflict against the btrfs-kdave tree which
required a merge fix patch.

The hmm tree gained build failures due to interactions with the tip and
drm trees for which I added a merge fix patch and disabled a driver.

Non-merge commits (relative to Linus' tree): 10449
 10116 files changed, 811540 insertions(+), 297040 deletions(-)

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
Merging origin/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (9f4a8181aa2f ARCv2: entry: simplify return to=
 Delay Slot via interrupt)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (e73f65930f88 Merge tag 'imx-fixes-5.2-3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fix=
es)
Merging arm64-fixes/for-next/fixes (aa69fb62bea1 arm64/efi: Mark __efistub_=
stext_offset as an absolute symbol explicitly)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (e13e7cd4c0c1 powerpc/64s/exception: Fix machin=
e check early corrupting AMR)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (15d5dfaf4adb sparc: fix unknown type name u_int in ua=
pi header)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (2e6054636816 ipv4: don't set IPv6 only flags to IPv4 ad=
dresses)
Merging bpf/master (0472301a28f6 bpf: fix uapi bpf_prog_info fields alignme=
nt)
Merging ipsec/master (597179b0ba55 ipsec: select crypto ciphers for xfrm_al=
go)
Merging netfilter/master (0e3183cd2a64 net: openvswitch: fix csum updates f=
or MPLS actions)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (2a92b08b1855 mt76: usb: fix rx A-MSDU supp=
ort)
Merging mac80211/master (d2ce8d6bfcfe nl80211: Fix undefined behavior in bi=
t shift)
Merging rdma-fixes/for-rc (4b972a01a7da Linux 5.2-rc6)
Merging sound-current/for-linus (98482377dc72 ALSA: hda: Fix widget_mutex i=
ncomplete protection)
Merging sound-asoc-fixes/for-linus (5485cb024fc6 Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (2217d05161cb Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (5cd4bc8e1469 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (f2542be09fc3 Merge branch 'spi-5.2' into spi-l=
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
Merging input-current/for-linus (abbe3acd7d72 Input: synaptics - enable SMB=
US on T480 thinkpad trackpad)
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
Merging mtd-fixes/mtd/fixes (191f5c2ed4b6 mtd: spi-nor: use 16-bit WRR comm=
and when QE is set on spansion flashes)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f2ff671f8941 MAINTAINERS: Correct path to mo=
ved files)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (b21e31b25304 Merge tag 'kvmarm-fixes-for-5.2-2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (5696e4aaabf2 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (570d7a98e7d6 vfs: move_mount: reject moving kernel=
 internal mounts)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (240b4cc8fd5d scsi: vmw_pscsi: Fix use-after-free =
in pvscsi_queue_lck())
Merging drm-fixes/drm-fixes (665d6d4e3231 Merge tag 'drm-misc-fixes-2019-06=
-26' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (4b972a01a7da Linux 5.2-rc6)
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
Merging kbuild/for-next (cfdee6945bc8 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (ff2437befd8f usb: host: Fix excessive alignme=
nt restriction for local memory allocations)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
CONFLICT (content): Merge conflict in include/linux/dma-iommu.h
CONFLICT (content): Merge conflict in drivers/iommu/dma-iommu.c
CONFLICT (content): Merge conflict in arch/arm64/mm/dma-mapping.c
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (169aa5c2c450 Merge commit commit 'drm-armada-devel^{/=
drm/armada: no need to check parent of remote}' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
CONFLICT (content): Merge conflict in mm/vmalloc.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/module.c
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (d482e575fbf0 perf: arm_spe: Enable ACPI/Pla=
tform automatic module loading)
Merging arm-soc/for-next (f99bcd23eeda ARM: Document merges)
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
Merging scmi/for-linux-next (6fbc7275c7a9 Linux 5.2-rc7)
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
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9f98b3142d22 csky: Improve string operations perfo=
rmance by glibc code)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (69878ef47562 m68k: Implement arch_dma_prep_coherent(=
))
Merging m68knommu/for-next (ad97f9df0fee riscv: add binfmt_flat support)
CONFLICT (content): Merge conflict in arch/m68k/Kconfig
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (a4e5914a7b4f MAINTAINERS: Add myself as Ingenic SoC=
s maintainer)
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (b3d5f311d3cf parisc: asm: psw.h: missing header=
 guard)
Merging powerpc/next (3c25ab35fbc8 KVM: PPC: Book3S HV: Clear pending decre=
menter exceptions on nested guest entry)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (e93c9c99a629 Linux 5.1)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (dbd66558dd28 vfio-ccw: make convert_ccw0_to_ccw1 sta=
tic)
Merging sh/sh-next (d3023897b437 arch/sh: Check for kprobe trap number befo=
re trying to handle a kprobe trap)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (f6282be0f451 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (1eda8bab70ca afs: Add support for the UAE error table)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (64294a3c83b8 Merge branch 'for-next-stale-201=
90701' into for-next-20190701)
Merging ceph/master (59cb2c2b2d01 ceph: don't NULL terminate virtual xattrs)
Merging cifs/for-next (275e35152e71 CIFS: Fix module dependency)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (c036061be907 ecryptfs: Make ecryptfs_xattr_handler s=
tatic)
Merging ext3/for_next (2d2043cbdb20 Pull XGETQSTAT fix from Eric Sandeen.)
Merging ext4/dev (c708b1c6de7f ext4: remove redundant assignment to node)
Merging f2fs/dev (d0121fe006ec f2fs: fix is_idle() check for discard type)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (973ee147a68f nfs: fix out-of-date connectathon talk=
 URL)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (73d30d48749f xfs: remove XFS_TRANS_NOFS)
Merging iomap/iomap-for-next (36a7347de097 iomap: fix page_done callback fo=
r short writes)
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (6ef048fd5955 locks: eliminate false positive=
 conflicts for write lease)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (753637b2039f Merge branch 'for-5.3' into for-next)
Merging pci/next (2f6473d83031 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (a72920efb18f pstore: no need to check retur=
n value of debugfs_create functions)
Merging hid/for-next (16f3c329e5e6 Merge branch 'for-5.3/ish' into for-next)
Merging i2c/i2c/for-next (d5df906ffe59 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
CONFLICT (content): Merge conflict in drivers/i2c/busses/i2c-meson.c
Merging i3c/i3c/next (f467907c1c38 i3c: dw: add limited bus mode support)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (f4f98f5c9540 hwmon: (lm90) Introduce func=
tion to update configuration register)
Merging jc_docs/docs-next (acb6258acc4f doc: RCU callback locks need only _=
bh, not necessarily _irq)
CONFLICT (content): Merge conflict in Documentation/fb/fbcon.rst
Merging v4l-dvb/master (f81cbfc4f82a media: allegro: use new v4l2_m2m_ioctl=
_try_encoder_cmd funcs)
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-vmal=
loc.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
sg.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-dma-=
contig.c
CONFLICT (content): Merge conflict in drivers/media/v4l2-core/videobuf-core=
.c
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (796e2f417ea5 video: fbdev: s3c-fb: fix sparse=
 warnings about using incorrect types)
CONFLICT (modify/delete): drivers/video/fbdev/omap2/omapfb/dss/rfbi.c delet=
ed in fbdev/fbdev-for-next and modified in HEAD. Version HEAD of drivers/vi=
deo/fbdev/omap2/omapfb/dss/rfbi.c left in tree.
CONFLICT (content): Merge conflict in drivers/media/pci/ivtv/ivtvfb.c
$ git rm -f drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
Merging pm/linux-next (f012a132824f Merge branches 'acpica', 'acpi-osl', 'a=
cpi-tables', 'acpi-misc' and 'acpi-tools' into linux-next)
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
Applying: clk: consoldiate the __clk_get_hw() declarations
Merging rdma/for-next (10dcc7448e9e RDMA/hns: fix spelling mistake "attatch=
" -> "attach")
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
$ git reset --hard HEAD^
Merging next-20190628 version of rdma
CONFLICT (content): Merge conflict in include/rdma/ib_verbs.h
CONFLICT (content): Merge conflict in include/linux/mlx5/eswitch.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/cmd.c
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Makefile deleted in 779=
6d2a3bb4037f9c51b8d91d059f1d690ed301f and modified in HEAD. Version HEAD of=
 drivers/infiniband/hw/nes/Makefile left in tree.
CONFLICT (modify/delete): drivers/infiniband/hw/nes/Kconfig deleted in 7796=
d2a3bb4037f9c51b8d91d059f1d690ed301f and modified in HEAD. Version HEAD of =
drivers/infiniband/hw/nes/Kconfig left in tree.
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_std_ty=
pes_cq.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
$ git rm -f drivers/infiniband/hw/nes/Kconfig drivers/infiniband/hw/nes/Mak=
efile
[master ee08fd27c908] next-20190628/rdma
Merging net-next/master (27ba4059e06b net: link_watch: prevent starvation w=
hen processing linkwatch wq)
CONFLICT (content): Merge conflict in net/ipv4/devinet.c
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in HEAD a=
nd modified in net-next/master. Version net-next/master of drivers/infiniba=
nd/hw/nes/nes.c left in tree.
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
$ git rm -f drivers/infiniband/hw/nes/nes.c
Merging bpf-next/master (8daed7677a1d Merge branch 'bpf-lookup-devmap')
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/en_main.c
Applying: net/mlx5e: fix up for "linux/dim: Rename externally used net_dim =
members"
Applying: another fix for "linux/dim: Rename externally used net_dim member=
s"
Merging ipsec-next/master (8928aa6a007d xfrm: remove empty xfrmi_init_net)
Merging mlx5-next/mlx5-next (4a3929b223d0 net/mlx5: E-Switch, Handle UC add=
ress change in switchdev mode)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/eswitch_offloads.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/eswitch.c
Merging netfilter-next/master (97ab78aaba50 netfilter: rename nf_SYNPROXY.h=
 to nf_synproxy.h)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (5adcdab6ae1b Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (954a5a029472 Merge tag 'mlx5e-updates-2019-06-28'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging mac80211-next/master (17c74d7c5f0d nl80211: fix VENDOR_CMD_RAW_DATA)
Merging gfs2/for-next (f29e62eed261 gfs2: replace more printk with calls to=
 fs_info and friends)
Merging mtd/mtd/next (b07079f1642c mtd: hyperbus: Add driver for TI's Hyper=
Bus memory controller)
Merging nand/nand/next (bce9437a0a48 mtd: rawnand: stm32_fmc2: increase DMA=
 completion timeouts)
CONFLICT (content): Merge conflict in drivers/mtd/nand/raw/mtk_ecc.h
Merging spi-nor/spi-nor/next (8d1336c241bd mtd: spi-nor: cadence-quadspi: a=
dd reset control)
CONFLICT (content): Merge conflict in include/linux/platform_data/intel-spi=
.h
CONFLICT (modify/delete): drivers/mtd/spi-nor/stm32-quadspi.c deleted in sp=
i-nor/spi-nor/next and modified in HEAD. Version HEAD of drivers/mtd/spi-no=
r/stm32-quadspi.c left in tree.
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.h
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-platfor=
m.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-pci.c
$ git rm -f drivers/mtd/spi-nor/stm32-quadspi.c
Merging crypto/master (e52d484d9869 crypto/NX: Set receive window credits t=
o max number of CRBs in RxFIFO)
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-ops.c
CONFLICT (content): Merge conflict in drivers/crypto/ccp/ccp-crypto-aes.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (53e155f2bbd4 Merge tag 'drm-msm-next-2019-06-25' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (content): Merge conflict in Documentation/fb/modedb.rst
Applying: drm/amdgpu: drop copy/paste leftover to fix big endian
Merging amdgpu/drm-next (aabf3a951c4e drm/amdkfd: remove duplicated PCIE at=
omics request)
Merging drm-intel/for-linux-next (8759aa4cc1d3 drm/i915/execlists: Refactor=
 CSB state machine)
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (dae1ccee012e drm: panel-orientation-quirks=
: Add extra quirk table entry for GPD MicroPC)
Merging drm-msm/msm-next (648fdc3f6475 drm/msm: add dirty framebuffer helpe=
r)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (8f2501e643bc drm/komeda: Enable write=
back split support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_framebuffer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_crtc.c
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (0a19fcccf3ed Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (b5c21c84705d Merge branch 'for-linus' into for-next)
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (0d65edd5f137 Merge remote-tracking branch 'aso=
c/topic/meson' into asoc-next)
Merging modules/modules-next (93651f80dcb6 modules: fix compile error if do=
n't have strict module rwx)
Merging input/next (5cecc2bccc03 Input: atmel_mxt_ts - fix -Wunused-const-v=
ariable)
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (8d0a4f33a636 Merge branch 'for-5.3/block' into for-=
next)
CONFLICT (modify/delete): Documentation/fault-injection/nvme-fault-injectio=
n.txt deleted in HEAD and modified in block/for-next. Version block/for-nex=
t of Documentation/fault-injection/nvme-fault-injection.txt left in tree.
$ git rm -f Documentation/fault-injection/nvme-fault-injection.txt
Applying: Documentation: nvme: fix for change to rst
Merging device-mapper/for-next (2eba4e640b2c dm verity: use message limit f=
or data block corruption message)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (4f8c162a9570 mmc: sdhci-pci: Add support for Intel EHL)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-gx-mmc.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (b4ddc3e2a3ad mfd: hi655x-pmic: Fix missing return=
 value check for devm_regmap_init_mmio_clk)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
CONFLICT (content): Merge conflict in drivers/video/backlight/pwm_bl.c
Merging battery/for-next (2ffb500d824b power: supply: cros: allow to set in=
put voltage and current limit)
CONFLICT (modify/delete): Documentation/power/power_supply_class.txt delete=
d in HEAD and modified in battery/for-next. Version battery/for-next of Doc=
umentation/power/power_supply_class.txt left in tree.
$ git rm -f Documentation/power/power_supply_class.txt
Applying: power: supply: update for conversion to .rst
Merging regulator/for-next (0188ab1f6aa6 Merge remote-tracking branch 'regu=
lator/topic/coupled' into regulator-next)
Merging security/next-testing (33d39f8e06b4 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (2fa2cf337d6b Merge tag 'keys-acl-20190627' into key=
s-next)
CONFLICT (content): Merge conflict in security/integrity/digsig.c
CONFLICT (content): Merge conflict in fs/ecryptfs/keystore.c
Merging selinux/next (ea74a685ad81 selinux: format all invalid context as u=
ntrusted)
Merging tpmdd/next (166a2809d65b tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (f5eb007e41d4 Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/smmu', 'generic-dma-ops' and 'core' into next)
CONFLICT (content): Merge conflict in drivers/iommu/dma-iommu.c
CONFLICT (content): Merge conflict in arch/arm64/mm/dma-mapping.c
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (9ea6b821cef4 dt-bindings: arm: Limit cpus sche=
ma to only check Arm 'cpu' nodes)
CONFLICT (content): Merge conflict in scripts/dtc/libfdt/Makefile.libfdt
CONFLICT (content): Merge conflict in scripts/dtc/Makefile.dtc
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/ethernet.txt
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (f5fe536b251a Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (9beb21fbb346 Merge branch 'core/debugobjects')
CONFLICT (content): Merge conflict in drivers/hwmon/coretemp.c
Applying: p54: fix up for ktime_get_boot_ns() name change
Applying: locking/lockdep: fix up for "Rename lockdep_assert_held_exclusive=
() -> lockdep_assert_held_write()"
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
Merging irqchip/irq/irqchip-next (0bdd0047ec94 irqchip/mbigen: Stop printin=
g kernel addresses)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (a251fb90ab8a KVM: x86: Fix apic dangling pointer in=
 vcpu)
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
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (568aeeeb69e6 platform/x86: intel_int0002_vgpi=
o: Get rid of custom ICPU() macro)
Merging chrome-platform/for-next (c18e6ea1014c platform/chrome: lightbar: G=
et drvdata from parent in suspend/resume)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (2605085fba22 dt: leds-lm36274.txt: fix a broken refe=
rence to ti-lmu.txt)
Merging ipmi/for-next (ac499fba98c3 docs: ipmb: place it at driver-api and =
convert to ReST)
Merging driver-core/driver-core-next (fb59b7824da8 drivers: s390/cio: Fix c=
ompilation warning about const qualifiers)
CONFLICT (content): Merge conflict in drivers/acpi/sleep.c
Merging usb/usb-next (426d3ff2f5ab usb: renesas_usbhs: Use struct platform_=
callback pointer)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging usb-gadget/next (aa23ce847dda usb: dwc3: remove unused @lock member=
 of dwc3_ep struct)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (84872dc448fe serial: stm32: add RX and TX FIFO flush)
Merging char-misc/char-misc-next (25c7eabed5b2 dt-bindings: imx-ocotp: Add =
i.MX8MM compatible)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
CONFLICT (modify/delete): drivers/hwtracing/coresight/of_coresight.c delete=
d in char-misc/char-misc-next and modified in HEAD. Version HEAD of drivers=
/hwtracing/coresight/of_coresight.c left in tree.
$ git rm -f drivers/hwtracing/coresight/of_coresight.c
Applying: coresight: fix for "bus_find_device: Unify the match callback wit=
h class_find_device"
Applying: coresight: Make the coresight_device_fwnode_match declaration's f=
wnode parameter const
Merging extcon/extcon-next (0937fbb7abeb extcon: fsa9480: Fix Kconfig warni=
ng and build errors)
Merging soundwire/next (2aeac95d1a4c soundwire: add module_sdw_driver helpe=
r macro)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (fbd6b25009ac staging: rtl8712: reduce stack u=
sage, again)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (78efb76ab4df dmaengine: rcar-dmac: Reject zero-leng=
th slave DMA requests)
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
CONFLICT (content): Merge conflict in Documentation/cgroup-v1/blkio-control=
ler.rst
CONFLICT (content): Merge conflict in Documentation/block/bfq-iosched.txt
Merging scsi/for-next (e1b686494236 Merge branch 'misc' into for-next)
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
Merging rpmsg/for-next (acb08ce449bd Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (da6070fc558e Merge tag 'gpio-v5.3-updates-for-linus'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into devel)
CONFLICT (content): Merge conflict in drivers/gpio/Makefile
Merging gpio-brgl/gpio/for-next (f360dcd4ef7f gpio: mockup: no need to chec=
k return value of debugfs_create functions)
Merging pinctrl/for-next (bc87d22918b0 Merge branch 'devel' into for-next)
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
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (877d53c29549 selftests: timestamping: Fix SIOCGSTAM=
P undeclared build failure)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (1a044213fc64 slimbus: core: generate uevent for non=
-dt only)
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (241e39004581 nfsd: replace Jeff by Chuck=
 as nfsd co-maintainer)
Merging at24/at24/for-next (dce91ba39c76 eeprom: at24: modify a comment ref=
erring to platform data)
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
Merging xarray/xarray (91abab83839a XArray: Fix xas_next() with a single en=
try at 0)
Merging hyperv/hyperv-next (674eecb3d35a drivers: hv: Add a module descript=
ion line to the hv_vmbus driver)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (4382fc438ca5 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/pidfd_t=
est.c
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
CONFLICT (content): Merge conflict in kernel/fork.c
Merging devfreq/for-next (f6274181714d PM / devfreq: events: add Exynos PPM=
U new events)
Merging hmm/hmm (5a136b4ae327 mm/hmm: Fix error flows in hmm_invalidate_ran=
ge_start)
Applying: mm/hmm: fixup for "locking/lockdep: Rename lockdep_assert_held_ex=
clusive() -> lockdep_assert_held_write()"
Applying: mm/hmm: mark the AMDGPU driver as broken for now
Merging akpm-current/current (00ef394f7ea9 include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in fs/binfmt_flat.c
CONFLICT (content): Merge conflict in arch/x86/Kconfig
Applying: merge fixup for "mm: Add an apply_to_pfn_range interface"
Applying: another fixup for "mm: Add an apply_to_pfn_range interface"
Applying: powerpc/64s/radix: Define arch_ioremap_p4d_supported()
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm: add account_locked_vm utility function
Applying: mm-add-account_locked_vm-utility-function-v3
Applying: mm-add-account_locked_vm-utility-function-v3-fix
Applying: proc/sysctl: add shared variables for range check
CONFLICT (content): Merge conflict in net/ipv6/sysctl_net_ipv6.c
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
CONFLICT (content): Merge conflict in net/ipv6/sysctl_net_ipv6.c
Applying: proc/sysctl: make firmware loader table conditional
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (d2fbb3622a71 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/A589tihDE.VJR22jGt1hcYJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0bKT4ACgkQAVBC80lX
0GyYJwf+JlD2Unj6Z2A8AHl2LhDvz6776sBpnk6Zs9rjzkDm4MXRcN4IpfKIZW2m
XD/srpnnsIaRY95NrJZR9tDL+V7J/3zjpq4HdXKKw1vTJJ6EA71SOrjTJaLcZFU/
uUytLVrvM+YpiUw7BhEcNykxGiB4QwwIQxxpN98v2A1GjOHW540KRgseWpW79nGx
3Sdm4D5q/iulsbdVk9t9cKIaZZPx0OfUgAOMYON6wCSLFqFCowmTW/aQuLEOi0il
xz25VzVzcvv3nvveLTj90mDFj7s6lozmcEYdd2TK6Go/55YXlEj2DOmHyGKCC9J3
4w9Oink0UMmXUC12A8aKN6JftK9jiw==
=LoL/
-----END PGP SIGNATURE-----

--Sig_/A589tihDE.VJR22jGt1hcYJ--
