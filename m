Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B6C23DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfI3PDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 11:03:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46496 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3PDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:03:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UEx3l6150699;
        Mon, 30 Sep 2019 15:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=xUuFXmqvfleEJJEdP5FBqV4BfhJYOFzKCFhPdSETcIU=;
 b=VOiN/9h5NGU2G6ijg6n/NjH/n9Y1UPUBOG3V7hXN1eoaqoiUm28GznSb/b5fQfQHMhL3
 7DHa9R4OZziesJMX+nKebDmhPnZ5sihGkGN0nJOSdHglyGdHyQeoICCelQAlEqGRe+CW
 u8at4YduydG/hmANRC1VRO9HLqN2+8WurAtkVSwQ0ah5KJJL3gBCcrMrbE4s7ivIX/HN
 BJnZuJunYJm0hOSYCI1aLfodw4tqilT5t9aD20SDHaA+XbB69JRWQiIfEGKKwJCf14MX
 wUUzEGVwhFF6S0/v9q+tS/SNQt/WCynwI9vmr0By3UloaMwrqOewKyy5mWDLHlgN2ND4 rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxufvv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 15:03:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UEwv40048832;
        Mon, 30 Sep 2019 15:01:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vahngvtwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 15:01:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8UF1Ghh008206;
        Mon, 30 Sep 2019 15:01:16 GMT
Received: from tomti.i.net-space.pl (/10.175.194.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 08:01:15 -0700
Date:   Mon, 30 Sep 2019 17:01:10 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     hpa@zytor.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
Message-ID: <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-2-daniel.kiper@oracle.com>
 <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909300154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909300154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:04:23AM -0700, hpa@zytor.com wrote:
> On July 4, 2019 9:36:10 AM PDT, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >The relationships between the headers are analogous to the various data
> >sections:
> >
> >  setup_header = .data
> >  boot_params/setup_data = .bss
> >
> >What is missing from the above list? That's right:
> >
> >  kernel_info = .rodata
> >
> >We have been (ab)using .data for things that could go into .rodata or
> >.bss for
> >a long time, for lack of alternatives and -- especially early on --
> >inertia.
> >Also, the BIOS stub is responsible for creating boot_params, so it
> >isn't
> >available to a BIOS-based loader (setup_data is, though).
> >
> >setup_header is permanently limited to 144 bytes due to the reach of
> >the
> >2-byte jump field, which doubles as a length field for the structure,
> >combined
> >with the size of the "hole" in struct boot_params that a protected-mode
> >loader
> >or the BIOS stub has to copy it into. It is currently 119 bytes long,
> >which
> >leaves us with 25 very precious bytes. This isn't something that can be
> >fixed
> >without revising the boot protocol entirely, breaking backwards
> >compatibility.
> >
> >boot_params proper is limited to 4096 bytes, but can be arbitrarily
> >extended
> >by adding setup_data entries. It cannot be used to communicate
> >properties of
> >the kernel image, because it is .bss and has no image-provided content.
> >
> >kernel_info solves this by providing an extensible place for
> >information about
> >the kernel image. It is readonly, because the kernel cannot rely on a
> >bootloader copying its contents anywhere, but that is OK; if it becomes
> >necessary it can still contain data items that an enabled bootloader
> >would be
> >expected to copy into a setup_data chunk.
> >
> >This patch does not bump setup_header version in arch/x86/boot/header.S
> >because it will be followed by additional changes coming into the
> >Linux/x86 boot protocol.
> >
> >Suggested-by: H. Peter Anvin <hpa@zytor.com>
> >Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> >Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> >Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> >---
> >v2 - suggestions/fixes:
> >   - rename setup_header2 to kernel_info,
> >     (suggested by H. Peter Anvin),
> >   - change kernel_info.header value to "InfO" (0x4f666e49),
> >   - new kernel_info description in Documentation/x86/boot.rst,
> >     (suggested by H. Peter Anvin),
> >   - drop kernel_info_offset_update() as an overkill and
> >     update kernel_info offset directly from main(),
> >     (suggested by Eric Snowberg),
> >   - new commit message
> >     (suggested by H. Peter Anvin),
> >   - fix some commit message misspellings
> >     (suggested by Eric Snowberg).
> >---
> >Documentation/x86/boot.rst             | 89
> >++++++++++++++++++++++++++++++++++
> > arch/x86/boot/Makefile                 |  2 +-
> > arch/x86/boot/compressed/Makefile      |  4 +-
> > arch/x86/boot/compressed/kernel_info.S | 12 +++++
> > arch/x86/boot/header.S                 |  1 +
> > arch/x86/boot/tools/build.c            |  5 ++
> > arch/x86/include/uapi/asm/bootparam.h  |  1 +
> > 7 files changed, 111 insertions(+), 3 deletions(-)
> > create mode 100644 arch/x86/boot/compressed/kernel_info.S
> >
> >diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> >index 08a2f100c0e6..a934a56f0516 100644
> >--- a/Documentation/x86/boot.rst
> >+++ b/Documentation/x86/boot.rst
> >@@ -68,8 +68,25 @@ Protocol 2.12	(Kernel 3.8) Added the xloadflags
> >field and extension fields
> > Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
> > 		xloadflags to support booting a 64-bit kernel from 32-bit
> > 		EFI
> >+
> >+Protocol 2.14:	BURNT BY INCORRECT COMMIT
> >ae7e1238e68f2a472a125673ab506d49158c1889
> >+		(x86/boot: Add ACPI RSDP address to setup_header)
> >+		DO NOT USE!!! ASSUME SAME AS 2.13.
> >+
> >+Protocol 2.15:	(Kernel 5.3) Added the kernel_info.
> >=============	============================================================
> >
> >+.. note::
> >+     The protocol version number should be changed only if the setup
> >header
> >+     is changed. There is no need to update the version number if
> >boot_params
> >+     or kernel_info are changed. Additionally, it is recommended to
> >use
> >+     xloadflags (in this case the protocol version number should not
> >be
> >+     updated either) or kernel_info to communicate supported Linux
> >kernel
> >+     features to the boot loader. Due to very limited space available
> >in
> >+     the original setup header every update to it should be considered
> >+     with great care. Starting from the protocol 2.15 the primary way
> >to
> >+     communicate things to the boot loader is the kernel_info.
> >+
> >
> > Memory Layout
> > =============
> >@@ -207,6 +224,7 @@ Offset/Size	Proto		Name			Meaning
> > 0258/8		2.10+		pref_address		Preferred loading address
> > 0260/4		2.10+		init_size		Linear memory required during initialization
> > 0264/4		2.11+		handover_offset		Offset of handover entry point
> >+0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
> >===========	========	=====================	============================================
> >
> > .. note::
> >@@ -855,6 +873,77 @@ Offset/size:	0x264/4
> >
> >   See EFI HANDOVER PROTOCOL below for more details.
> >
> >+============	==================
> >+Field name:	kernel_info_offset
> >+Type:		read
> >+Offset/size:	0x268/4
> >+Protocol:	2.15+
> >+============	==================
> >+
> >+  This field is the offset from the beginning of the kernel image to
> >the
> >+  kernel_info. It is embedded in the Linux image in the uncompressed
> >+  protected mode region.
> >+
> >+
> >+The kernel_info
> >+===============
> >+
> >+The relationships between the headers are analogous to the various
> >data
> >+sections:
> >+
> >+  setup_header = .data
> >+  boot_params/setup_data = .bss
> >+
> >+What is missing from the above list? That's right:
> >+
> >+  kernel_info = .rodata
> >+
> >+We have been (ab)using .data for things that could go into .rodata or
> >.bss for
> >+a long time, for lack of alternatives and -- especially early on --
> >inertia.
> >+Also, the BIOS stub is responsible for creating boot_params, so it
> >isn't
> >+available to a BIOS-based loader (setup_data is, though).
> >+
> >+setup_header is permanently limited to 144 bytes due to the reach of
> >the
> >+2-byte jump field, which doubles as a length field for the structure,
> >combined
> >+with the size of the "hole" in struct boot_params that a
> >protected-mode loader
> >+or the BIOS stub has to copy it into. It is currently 119 bytes long,
> >which
> >+leaves us with 25 very precious bytes. This isn't something that can
> >be fixed
> >+without revising the boot protocol entirely, breaking backwards
> >compatibility.
> >+
> >+boot_params proper is limited to 4096 bytes, but can be arbitrarily
> >extended
> >+by adding setup_data entries. It cannot be used to communicate
> >properties of
> >+the kernel image, because it is .bss and has no image-provided
> >content.
> >+
> >+kernel_info solves this by providing an extensible place for
> >information about
> >+the kernel image. It is readonly, because the kernel cannot rely on a
> >+bootloader copying its contents anywhere, but that is OK; if it
> >becomes
> >+necessary it can still contain data items that an enabled bootloader
> >would be
> >+expected to copy into a setup_data chunk.
> >+
> >+It is recommended to not store large data chunks, e.g. strings,
> >directly in the
> >+kernel_info struct. Such data should be placed outside of it and
> >pointed from
> >+the kernel_info structure using offsets from the beginning of the
> >structure,
> >+the kernel_info.header field.
> >+
> >+
> >+Details of the kernel_info Fields
> >+=================================
> >+
> >+============	========
> >+Field name:	header
> >+Offset/size:	0x0000/4
> >+============	========
> >+
> >+  Contains the magic number "InfO" (0x4f666e49).
> >+
> >+============	========
> >+Field name:	size
> >+Offset/size:	0x0004/4
> >+============	========
> >+
> >+  This field contains the size of the kernel_info including
> >kernel_info.header.
> >+  It should be used by the boot loader to detect supported fields in
> >the kernel_info.
> >+
> >
> > The Image Checksum
> > ==================
> >diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> >index e2839b5c246c..c30a9b642a86 100644
> >--- a/arch/x86/boot/Makefile
> >+++ b/arch/x86/boot/Makefile
> >@@ -87,7 +87,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
> >
> > SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
> >
> >-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
> >\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define
> >ZO_\2 0x\1/p'
> >+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
> >\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define
> >ZO_\2 0x\1/p'
> >
> > quiet_cmd_zoffset = ZOFFSET $@
> >       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
> >diff --git a/arch/x86/boot/compressed/Makefile
> >b/arch/x86/boot/compressed/Makefile
> >index 6b84afdd7538..fad3b18e2cc3 100644
> >--- a/arch/x86/boot/compressed/Makefile
> >+++ b/arch/x86/boot/compressed/Makefile
> >@@ -72,8 +72,8 @@ $(obj)/../voffset.h: vmlinux FORCE
> >
> > $(obj)/misc.o: $(obj)/../voffset.h
> >
> >-vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/head_$(BITS).o
> >$(obj)/misc.o \
> >-	$(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
> >+vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o
> >$(obj)/head_$(BITS).o \
> >+	$(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
> > 	$(obj)/piggy.o $(obj)/cpuflags.o
> >
> > vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
> >diff --git a/arch/x86/boot/compressed/kernel_info.S
> >b/arch/x86/boot/compressed/kernel_info.S
> >new file mode 100644
> >index 000000000000..3f1cb301b9ff
> >--- /dev/null
> >+++ b/arch/x86/boot/compressed/kernel_info.S
> >@@ -0,0 +1,12 @@
> >+/* SPDX-License-Identifier: GPL-2.0 */
> >+
> >+	.section ".rodata.kernel_info", "a"
> >+
> >+	.global kernel_info
> >+
> >+kernel_info:
> >+        /* Header. */
> >+	.ascii	"InfO"
> >+        /* Size. */
> >+	.long	kernel_info_end - kernel_info
> >+kernel_info_end:
> >diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> >index 850b8762e889..ec6a25a43148 100644
> >--- a/arch/x86/boot/header.S
> >+++ b/arch/x86/boot/header.S
> >@@ -557,6 +557,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred
> >load addr
> >
> > init_size:		.long INIT_SIZE		# kernel initialization size
> > handover_offset:	.long 0			# Filled in by build.c
> >+kernel_info_offset:	.long 0			# Filled in by build.c
> >
> ># End of setup header
> >#####################################################
> >
> >diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> >index a93d44e58f9c..55e669d29e54 100644
> >--- a/arch/x86/boot/tools/build.c
> >+++ b/arch/x86/boot/tools/build.c
> >@@ -56,6 +56,7 @@ u8 buf[SETUP_SECT_MAX*512];
> > unsigned long efi32_stub_entry;
> > unsigned long efi64_stub_entry;
> > unsigned long efi_pe_entry;
> >+unsigned long kernel_info;
> > unsigned long startup_64;
> >
> >/*----------------------------------------------------------------------*/
> >@@ -321,6 +322,7 @@ static void parse_zoffset(char *fname)
> > 		PARSE_ZOFS(p, efi32_stub_entry);
> > 		PARSE_ZOFS(p, efi64_stub_entry);
> > 		PARSE_ZOFS(p, efi_pe_entry);
> >+		PARSE_ZOFS(p, kernel_info);
> > 		PARSE_ZOFS(p, startup_64);
> >
> > 		p = strchr(p, '\n');
> >@@ -410,6 +412,9 @@ int main(int argc, char ** argv)
> >
> > 	efi_stub_entry_update();
> >
> >+	/* Update kernel_info offset. */
> >+	put_unaligned_le32(kernel_info, &buf[0x268]);
> >+
> > 	crc = partial_crc32(buf, i, crc);
> > 	if (fwrite(buf, 1, i, dest) != i)
> > 		die("Writing setup failed");
> >diff --git a/arch/x86/include/uapi/asm/bootparam.h
> >b/arch/x86/include/uapi/asm/bootparam.h
> >index 60733f137e9a..b05318112452 100644
> >--- a/arch/x86/include/uapi/asm/bootparam.h
> >+++ b/arch/x86/include/uapi/asm/bootparam.h
> >@@ -86,6 +86,7 @@ struct setup_header {
> > 	__u64	pref_address;
> > 	__u32	init_size;
> > 	__u32	handover_offset;
> >+	__u32	kernel_info_offset;
> > } __attribute__((packed));
> >
> > struct sys_desc_table {
>
> I should like to make make things a bit more stringent: additional
> data should be made offsets from the kernel_info structure *and they
> should live in the .rodata.kernel_info section*. We should add a size

OK.

> field for the entire .kernel_info section, thus ensuring it is a
> single self-contained blob.

.rodata.kernel_info contains its total size immediately behind the
"InfO" header. Do you suggest that we should add the size of
.rodata.kernel_info into setup_header too?

Daniel
