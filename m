Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0478E43E12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfFMPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:47:25 -0400
Received: from ozlabs.org ([203.11.71.1]:53103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbfFMJbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:31:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45PdlL2KQ2z9s9y;
        Thu, 13 Jun 2019 19:30:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560418254;
        bh=XrUCp/nGJiTOVNopRc79KZ24NsFCQXdQc0ZurAONNHs=;
        h=Date:From:To:Cc:Subject:From;
        b=M+eKg+TXAmi3faiqHHMo66e5jMOzxnGDGvYRgH33OuVinPw08xSIMXacBBmTHoSux
         VnHlZzrll3owvvfwcTlUUwY0e+uCzpZSGxflFVuZ6Bpde9x7djBVE4NHo8XDomhChd
         er+9uB2zdoxJlsDKMEAoo/q8Efj8xqirGMRpuzqDQ8EEt3BUmC9MJMQXMJ7gwhGp+D
         cbvZhr1roJ322VUmYBCGTTFaNH3jxhGctm2QatEVvlstY65m6ilRYlNUBYpyYGXVJX
         TGEY62LHLrMEp4cSsKWimzQa2ov+yAH+YprTT5QjRKb0rB39agScymAePTXEGVuIBY
         pSNNXlKUC7ZaQ==
Date:   Thu, 13 Jun 2019 19:30:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 13
Message-ID: <20190613193054.37bde7fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hjAUk8g8zSBv5kaQ1PPhFT/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hjAUk8g8zSBv5kaQ1PPhFT/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190612:

Removed tree: risc-v-pjw (by maintainer's request)

The net-next tree lost its build failure.

The tty tree gained a build failure so I sued the verison from
next-20190612.

The char-misc tree gained a conflict against the driver-core tree.

The akpm tree lost 3 patches that turned up elsewhere.

Non-merge commits (relative to Linus' tree): 5559
 5942 files changed, 219687 insertions(+), 194300 deletions(-)

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
Merging origin/master (35110e38e6c5 Merge tag 'media/v5.2-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (ec9b4feb1e41 ARC: [plat-hsdk]: unify memory a=
pertures configuration)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (2f4ee151f254 arm64/sve: Fix missing SVE=
/FPSIMD endianness conversions)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (c21f5a9ed85c powerpc/32s: fix booting with CON=
FIG_PPC_EARLY_DEBUG_BOOTX)
Merging s390-fixes/fixes (93c2f55ffc89 s390/ctl_reg: mark __ctl_set_bit and=
 __ctl_clear_bit as __always_inline)
Merging sparc/master (30d1d92a888d Merge tag 'nds32-for-linux-5.2-rc3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (b8003cef2e63 Merge branch 'net-mvpp2-prs-Fixes-for-VID-=
filtering')
Merging bpf/master (01d76b531700 xdp: check device pointer before clearing)
Merging ipsec/master (7c80eb1c7e2b af_key: fix leaks in key_pol_get_resp an=
d dump_sp.)
Merging netfilter/master (8a3dca632538 netfilter: ipv6: nf_defrag: accept d=
uplicate fragments again)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (180aa422ef27 nl80211: fill all policy .type entrie=
s)
Merging rdma-fixes/for-rc (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging sound-current/for-linus (352bcae97f9b ALSA: ice1712: Check correct =
return value to snd_i2c_sendbytes (EWS/DMX 6Fire))
Merging sound-asoc-fixes/for-linus (b914d5e41bbf Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (8ef6d17024b2 Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (1c31ea6be8d9 Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (4d96f255dd76 Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (5f54a85db5df usb: typec: Make sure an alt mo=
de exist before getting its partner)
Merging usb-gadget-fixes/fixes (42cc68868ce9 usb: gadget: udc: lpc32xx: fix=
 return value check in lpc32xx_udc_probe())
Merging usb-serial-fixes/usb-linus (f3dfd4072c3e USB: serial: option: add T=
elit 0x1260 and 0x1261 compositions)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging char-misc.current/char-misc-linus (b7108486d2d6 Merge tag 'soundwir=
e-5.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire=
 into char-misc-linus)
Merging soundwire-fixes/fixes (39194128701b soundwire: intel: set dai min a=
nd max channels correctly)
Merging thunderbolt-fixes/fixes (4f7c2e0d8765 thunderbolt: Make sure device=
 runtime resume completes before taking domain lock)
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
Merging mfd-fixes/for-mfd-fixes (386145601b82 mfd: stmfx: Uninitialized var=
iable in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f532beeeff0c MIPS: uprobes: remove set but n=
ot used variable 'epc')
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
Merging btrfs-fixes/next-fixes (265ab749b7c3 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d8076bdb56af uapi: Wire up the mount API syscalls =
on non-x86 arches [ver #2])
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (8c2eb7b6468a platform/mellanox: mlxreg-hot=
plug: Add devm_free_irq call to remove flow)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (625d7d351887 scsi: hpsa: correct ioaccel2 chainin=
g)
Merging drm-fixes/drm-fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (c5cc0bf870cf drm/i915/perf: f=
ix whitelist on Gen10+)
Merging mmc-fixes/fixes (97bf85b6ec9e mmc: sdhi: disallow HS400 for M3-W ES=
1.2, RZ/G2M, and V3H)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (d0e1f2110a5e riscv: Fix udelay in RV32.)
Merging drm-misc-fixes/for-linux-next-fixes (48eaeb7664c7 drm: add fallback=
 override/firmware EDID modes workaround)
Merging kbuild/for-next (a3dfe2a76497 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (2e96e04d25ca MIPS: use the generic uncached s=
egment support in dma-direct)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (1a42d1d8c766 ARCv2: entry: simplify return to Delay S=
lot via interrupt)
Merging arm/for-next (22bda41880e9 Merge commit 'riscpc^{/ARM: riscpc: enab=
le chained scatterlist support}' into for-next)
Merging arm64/for-next/core (9b6047220590 arm64: mm: avoid redundant READ_O=
NCE(*ptep))
CONFLICT (content): Merge conflict in arch/arm64/include/asm/thread_info.h
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (e2181df95f94 Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (130413736376 ARM: dts: aspeed: Add Microsoft Olymp=
us BMC)
Merging at91/at91-next (32dfd9cfa4c6 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (0e3379645ca5 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (426e1d699857 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1e16bc075913 Merge branch 'fixes' into for-next)
Merging qcom/for-next (13635558b3d9 Merge branches 'arm64-for-5.3', 'driver=
s-for-5.3' and 'dts-for-5.3' into for-next)
Merging renesas/next (dbd83f560eca Merge branches 'arm64-defconfig-for-v5.3=
' and 'arm64-dt-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (4e32fccf4934 Merge branch 'v5.3-clk/next' into f=
or-next)
Merging samsung-krzk/for-next (f8c9d8cbf3e6 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (d84dc98fad98 Merge branch 'for-next/scmi-updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging sunxi/sunxi/for-next (f0776d431adb Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (1cad9fdb86d5 Merge branch for-5.3/arm64/dt into for=
-next)
Merging clk/clk-next (397a7b5ebe4d Merge branch 'clk-fixes' into clk-next)
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
Merging clk-samsung/for-next (2f57b95caf8f clk: samsung: add new clocks for=
 DMC for Exynos5422 SoC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (6b436744a0b7 csky: Fixup no panic in kernel for so=
me traps)
Merging h8300/h8300-next (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linu=
x-nfs.org/~bfields/linux)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f67d667213ba m68k: defconfig: Update defconfigs for =
v5.2-rc1)
Merging m68knommu/for-next (d1fdb6d8f6a4 Linux 5.2-rc4)
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
Merging powerpc/next (a3bf9fbdad60 powerpc/pseries: Fix xive=3Doff command =
line)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (e93c9c99a629 Linux 5.1)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (2980ba6ae8ca s390/kdump: get rid of compile warning)
Merging sh/sh-next (7c04efc8d2ef sh: configs: Remove useless UEVENT_HELPER_=
PATH)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (2ba543d3e7db Merge branch 'xtensa-5.2-fixes=
' into xtensa-for-next)
Merging fscrypt/master (0bb06cac060d fscrypt: remove unnecessary includes o=
f ratelimit.h)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (7b2f936fc828 ceph: fix error handling in ceph_get_caps=
())
Merging cifs/for-next (f02a5871ac4f Add SMB3.1.1 GCM crypto to the encrypt =
and decrypt functions)
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
Merging nfs/linux-next (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging nfs-anna/linux-next (ba851a39c970 NFSv4.1: Fix bug only first CB_NO=
TIFY_LOCK is handled)
Merging nfsd/nfsd-next (4fc2b5fe1cf2 nfsd: fix cleanup of nfsd_reply_cache_=
init on failure)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (5d3211b651a0 ovl: doc: add non-standard c=
orner cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (fe0da9c09b2d fuse: copy_file_range needs to strip set=
uid bits and update timestamps)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (753637b2039f Merge branch 'for-5.3' into for-next)
Merging pci/next (bf593ef5d4c4 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (e070e380c674 Merge branch 'for-linus/pstore=
' into for-next/pstore)
Merging hid/for-next (f3d8631d6a04 Merge branch 'for-5.3/uclogic' into for-=
next)
Merging i2c/i2c/for-next (6bfd4da86e65 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (5e343fbb7176 dt-bindings: i3c: Document dropped suppo=
rt for I2C 10 bit devices)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (3265d9b816d1 hwmon: (pmbus/adm1275) Fix p=
ower sampling support)
Merging jc_docs/docs-next (b640fbad2d8f docs: pci: fix broken links due to =
conversion from pci.txt to pci.rst)
Merging v4l-dvb/master (513dbd35b5d9 media: add SPDX headers to some files)
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (0f5a5712ad1e video: fbdev: pvr2fb: add COMPIL=
E_TEST support)
CONFLICT (modify/delete): drivers/video/fbdev/mxsfb.c deleted in fbdev/fbde=
v-for-next and modified in HEAD. Version HEAD of drivers/video/fbdev/mxsfb.=
c left in tree.
$ git rm -f drivers/video/fbdev/mxsfb.c
Merging pm/linux-next (1a059f234084 Merge branch 'acpi-osl' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (e6abacabb5ac cpufreq: Switch im=
x7d to imx-cpufreq-dt for speed grading)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (03a3e8166524 opp: Don't overwrite rounded clk r=
ate)
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
Merging rdma/for-next (97545b10221a RDMA/hns: Bugfix for posting multiple s=
rq work request)
Merging net-next/master (a842fe1425cb tcp: add optional per socket transmit=
 delay)
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/Makefile
CONFLICT (content): Merge conflict in kernel/bpf/verifier.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/d=
wmac-meson8b.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/d=
wmac-meson.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/cmd.c
Merging bpf-next/master (aee450cbe482 bpf: silence warning messages in core)
Merging ipsec-next/master (4f518e802cca xfrm: remove type and offload_type =
map from xfrm_state_afinfo)
Merging mlx5-next/mlx5-next (8693115af4c2 {IB,net}/mlx5: Constify rep ops f=
unctions pointers)
Merging netfilter-next/master (16e6427c88c5 netfilter: ipv6: Fix undefined =
symbol nf_ct_frag6_gather)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (8b5e07d7ee95 inet_connection_sock: remove unused =
parameter of reqsk_queue_unlink func)
Merging mac80211-next/master (a3ce17d1495b cfg80211: Handle bss expiry duri=
ng connection)
Merging gfs2/for-next (a4262eaf3df3 gfs2: Use IS_ERR_OR_NULL)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (5dc353d306bf mtd: onenand_base: Avoid fall-through =
warnings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.txt
Merging spi-nor/spi-nor/next (92aae4ce8427 mtd: spi-nor: change "error read=
ing JEDEC id" from dbg to err)
Merging crypto/master (7545b6c2087f crypto: chacha20poly1305 - fix atomic s=
leep when using async algorithm)
CONFLICT (content): Merge conflict in drivers/crypto/vmx/vmx.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_xts.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_ctr.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes_cbc.c
CONFLICT (content): Merge conflict in drivers/crypto/vmx/aes.c
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (561564bea324 Merge tag 'omapdrm-5.3' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/tomba/linux into drm-next)
CONFLICT (modify/delete): include/drm/gma_drm.h deleted in drm/drm-next and=
 modified in HEAD. Version HEAD of include/drm/gma_drm.h left in tree.
CONFLICT (modify/delete): drivers/gpu/drm/cirrus/cirrus_drv.h deleted in dr=
m/drm-next and modified in HEAD. Version HEAD of drivers/gpu/drm/cirrus/cir=
rus_drv.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
$ git rm -f drivers/gpu/drm/cirrus/cirrus_drv.h include/drm/gma_drm.h
Merging amdgpu/drm-next (465ab9e02aac drm/amdkfd: Add device to topology af=
ter it is completely inited)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
Merging drm-intel/for-linux-next (70972f51819a drm/i915: kerneldoc warnings=
 squelched)
Merging drm-tegra/drm/tegra/for-next (f3b0d8793c16 drm/tegra: dpaux: Make V=
DD supply optional)
Merging drm-misc/for-linux-next (09cc560951db drm: Tweak drm_encoder_helper=
_funcs.enable kerneldoc)
CONFLICT (modify/delete): drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c =
deleted in HEAD and modified in drm-misc/for-linux-next. Version drm-misc/f=
or-linux-next of drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c left in t=
ree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_audio.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/clk_mg=
r/dcn10/rv1_clk_mgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_ttm=
.c
$ git rm -f drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
Applying: drm/amd/display: merge fix for "drm/amd: drop use of drmp.h in os=
_types.h"
Merging drm-msm/msm-next (981f2aabeae6 drm/msm/a6xx: Rename a6xx_gmu_probe =
to a6xx_gmu_init)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (f8834701bcd2 dt/bindings: drm/komeda:=
 Unify mclk/pclk/pipeline->aclk to one ACLK)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/ko=
meda_dev.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/display/komeda/d7=
1/d71_dev.c
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (9194cd4db668 Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (0356ce3adda0 ALSA: oxfw: configure stream parameter=
 in pcm.hw_params callback)
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (6a4a80ffcfed Merge branch 'asoc-5.3' into asoc=
-next)
Merging modules/modules-next (8d1b73dd25ff kernel: module: Use struct_size(=
) helper)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (51af912e51dd Merge branch 'io_uring-next' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (ef4a8d90b7f4 mmc: sdhi: remove unneeded initialization)
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
Merging regulator/for-next (b402e9027346 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (ba9bfa0e4809 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (2cd4737bc850 ima: prevent a file already =
mmap'ed write to be mmap'ed execute)
Merging selinux/next (464c258aa45b selinux: fix empty write to keycreate fi=
le)
Merging tpmdd/next (31be68564a43 efi: Attempt to get the TCG2 event log in =
the boot stub)
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (d6f11edc3bf7 Merge branches 'iommu/fixes', 'x86/vt-d', =
'x86/amd', 'arm/renesas', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (73c699ffe538 dt-bindings: vendor: Add a bunch =
of vendors)
Merging mailbox/mailbox-for-next (35110e38e6c5 Merge tag 'media/v5.2-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging spi/for-next (c21fc68c5c6b Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (434f93f268c3 Merge branch 'irq/core')
Merging clockevents/clockevents/next (9c0ec9b39e9c clocksource/drivers/tegr=
a: Restore base address before cleanup)
CONFLICT (content): Merge conflict in drivers/clocksource/timer-tegra.c
Merging edac-amd/for-next (2e3633d53c67 EDAC/aspeed: Remove set but not use=
d variable 'np')
Merging irqchip/irq/irqchip-next (b744c3bcff5a irqchip/qcom: Use struct_siz=
e() in devm_kzalloc())
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove useless=
 checks in 'release' method of KVM device)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (6baac53e03c3 platform/x86: touchscreen_dmi: A=
dd info for the CHUWI Hi10 Plus tablet.)
Merging chrome-platform/for-next (81bc8c03e1b0 platform/chrome: cros_ec: Ma=
ke some symbols static)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (25529edef561 Merge tag 'ti-lmu-led-drivers' into for=
-next)
Merging ipmi/for-next (102308f557bc ipmi: ipmb: Fix build error while CONFI=
G_I2C is set to m)
Merging driver-core/driver-core-next (909bad2d9787 ti-st: no need to check =
return value of debugfs_create functions)
Merging usb/usb-next (e137d34f94eb Revert "usb: mtu3: fix up undefined refe=
rence to usb_debug_root")
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (6ef72bc036bc phy: qcom: Add Qualcomm PCIe2 PHY drive=
r)
Merging tty/tty-next (ba3684f99f1b tty: serial: msm_serial: avoid system lo=
ckup condition)
$ git reset --hard HEAD^
Merging next-20190612 version of tty
Merging char-misc/char-misc-next (b0c35cb59f7b misc: mic: scif: fix potenti=
al double free of scif_dev)
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (be1038846b80 docs: soundwire: locking: fix tags for=
 a code-block)
Merging thunderbolt/next (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging staging/staging-next (3300a661a97e staging: rtl8712: removed unused=
 variables from struct _adapter)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (83eb5cfcd5e3 dmaengine: dw-edma: Fix build error wi=
thout CONFIG_PCI_MSI)
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (fef65e1e507c Merge branch 'for-5.2-fixes' into for=
-next)
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
Merging gpio/for-next (698079f06695 Merge branch 'devel' into for-next)
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
Merging coresight/next (7e4fb7e475e2 coresight: etb10: Do not call smp_proc=
essor_id from preemptible)
Merging rtc/rtc-next (110036b4f4db rtc: rx8025: simplify getting the adapte=
r of a client)
Merging nvdimm/libnvdimm-for-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging at24/at24/for-next (9ae9d9bfb72c eeprom: at24: use struct_size() in=
 devm_kzalloc())
Merging ntb/ntb-next (7e84e034125f NTB: Describe the ntb_msi_test client in=
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
Merging akpm-current/current (660a2c1b61e6 include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in include/linux/genalloc.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: proc/sysctl: add shared variables for range check
Applying: proc-sysctl-add-shared-variables-for-range-check-fix
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (39bbfd65dc5f drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/hjAUk8g8zSBv5kaQ1PPhFT/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0CF84ACgkQAVBC80lX
0GxEeQf/RnMloBlzE6KCi24Zz4pKaHULTYI5ZvZ18pfIXAVK/4aD+0jx4aCd6gkM
WkvVGU0coX5PoCfwPRsihiFhVj5qXoaNc/quCP5iGni96kJuPCY7z+oYbz5x8iIT
JlJG1IhPQ9fCBTNrm/zSnQTKtot5GRGcrjAaXxErSVByUnlXns+j17P1RA7hm78E
nQ1bOsWsoVJ/6kUdF9CbJIb17YYgpsL1UMw7HLaylx8yYxiGVNhb8BgCMx5HkJpu
qjiRVKTbsWJhXa36u0+ZFpaGee+O0kiejo4COr/Topw+uW3ba9qwvhtGTxL63E2k
Ayoy3nnBUtsTgJQCkfKPH6Tr3lOZ7Q==
=Fvt3
-----END PGP SIGNATURE-----

--Sig_/hjAUk8g8zSBv5kaQ1PPhFT/--
