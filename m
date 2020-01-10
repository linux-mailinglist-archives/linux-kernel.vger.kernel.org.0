Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB8137A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgAJXYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 18:24:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41245 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgAJXYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:24:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so3572601qke.8;
        Fri, 10 Jan 2020 15:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFyCbmRcJzkictrFE2SD0y8t4JRJkbdjTR93qIxxXyI=;
        b=FlWaUU9QcUIin26agRDDzuGc3EP4dX0lfUfR/SgvKTYYbGb+AwDUg9FOLzcuhfFpA5
         oxGYanQ5Cs7iXdBzXL5XUw3g/4gJvgM+HhFX05mXFTHV5KWLo4M4nn2YePWokswDwmRr
         BOPinjx57LP9fL4Atw2KxHVAsWuas3h4gP69ZIaXBN6XLFHoq/idQw+cEACPpFH4sciT
         e9NTSmPiJe8SnCfDLoA5X5JdJC//51IBnEQhX+oGmCfoy6O+I7MbKuL/550Iv9SABXj5
         kkYZ6GKDB0WXmcJYNRogUCq0spE4uIEfN0kgnJWcIazrn1OsXGGQdxIoZPPkoey+mUHF
         jt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFyCbmRcJzkictrFE2SD0y8t4JRJkbdjTR93qIxxXyI=;
        b=X8nzSepgk2PxDCzkUsY6dtVNh9z/nqz8VTY/IGtkorIg4uRsIDAYc8b7r39bMoVjR9
         4k3gn/eoaKriQFpB4w09y+cAgUtsmrG20T6x7FQnf7/G53A79ezzaKhULC1JM0VhFGht
         GnyxcRW5L/LnOzkztxJxF+1xvgjmOQDqN8/ru1KFnbxs8+fxdxqfs4aHnWq14mln5ydu
         hDXeP/M2ABRwdxKUDRxGGxCyV/kEAAct4rs2/QzB6VZOt3e4FOD3FfBdX0tJU/7ARo1B
         Hz/rhiJH+l7BuqfpzKo67216knIa3eSsfHjW9rdeaIPLd0vfLeMyfbO0tisp7MqqKUhP
         ripw==
X-Gm-Message-State: APjAAAX6J//t1a/N0Bhy0lYEvust4mOCzNSfI7a7GLQwRBdVLStq9iIX
        kMWI8c3NxGRCxQ8xUBqm6Sk=
X-Google-Smtp-Source: APXvYqztgfZcQHUpF9GLUXzDXNCsFPgsVw+QDwoimlbYB6vof3FMcbzvmdE34EKFQrLUxaBOy5C+vg==
X-Received: by 2002:a37:6047:: with SMTP id u68mr1060671qkb.389.1578698692935;
        Fri, 10 Jan 2020 15:24:52 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:24:52 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 2/9] Documentation: nfsroot.txt: convert to ReST
Date:   Fri, 10 Jan 2020 20:24:24 -0300
Message-Id: <442d35917351f5260dd8ed7362e9b5f1264ef8ad.1578697871.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578697871.git.dwlsalmeida@gmail.com>
References: <cover.1578697871.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert nfsroot.txt to RST and move it to admin-guide. Content remains
mostly the same.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |   1 +
 .../nfs/nfsroot.rst}                          | 140 +++++++++---------
 2 files changed, 75 insertions(+), 66 deletions(-)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (83%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 2fe77091c25c..ea780cda5549 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -6,3 +6,4 @@ NFS
     :maxdepth: 1
 
     nfs-client
+    nfsroot
diff --git a/Documentation/filesystems/nfs/nfsroot.txt b/Documentation/admin-guide/nfs/nfsroot.rst
similarity index 83%
rename from Documentation/filesystems/nfs/nfsroot.txt
rename to Documentation/admin-guide/nfs/nfsroot.rst
index ae4332464560..9249be637833 100644
--- a/Documentation/filesystems/nfs/nfsroot.txt
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -1,18 +1,24 @@
+===============================================
 Mounting the root filesystem via NFS (nfsroot)
 ===============================================
 
-Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
-Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
-Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
-Updated 2006 by Horms <horms@verge.net.au>
-Updated 2018 by Chris Novakovic <chris@chrisn.me.uk>
+:Authors:
+	Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
+
+	Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+
+	Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
+
+	Updated 2006 by Horms <horms@verge.net.au>
+
+	Updated 2018 by Chris Novakovic <chris@chrisn.me.uk>
 
 
 
 In order to use a diskless system, such as an X-terminal or printer server
 for example, it is necessary for the root filesystem to be present on a
-non-disk device. This may be an initramfs (see Documentation/filesystems/
-ramfs-rootfs-initramfs.txt), a ramdisk (see Documentation/admin-guide/initrd.rst) or a
+non-disk device. This may be an initramfs (see Documentation/filesystems/ramfs-rootfs-initramfs.txt),
+a ramdisk (see Documentation/admin-guide/initrd.rst) or a
 filesystem mounted via NFS. The following text describes on how to use NFS
 for the root filesystem. For the rest of this text 'client' means the
 diskless system, and 'server' means the NFS server.
@@ -20,8 +26,8 @@ diskless system, and 'server' means the NFS server.
 
 
 
-1.) Enabling nfsroot capabilities
-    -----------------------------
+Enabling nfsroot capabilities
+=============================
 
 In order to use nfsroot, NFS client support needs to be selected as
 built-in during configuration. Once this has been selected, the nfsroot
@@ -34,8 +40,8 @@ DHCP, BOOTP and RARP is safe.
 
 
 
-2.) Kernel command line
-    -------------------
+Kernel command line
+===================
 
 When the kernel has been loaded by a boot loader (see below) it needs to be
 told what root fs device to use. And in the case of nfsroot, where to find
@@ -44,19 +50,17 @@ This can be established using the following kernel command line parameters:
 
 
 root=/dev/nfs
-
   This is necessary to enable the pseudo-NFS-device. Note that it's not a
   real device but just a synonym to tell the kernel to use NFS instead of
   a real device.
 
 
 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
-
   If the `nfsroot' parameter is NOT given on the command line,
-  the default "/tftpboot/%s" will be used.
+  the default ``"/tftpboot/%s"`` will be used.
 
   <server-ip>	Specifies the IP address of the NFS server.
-		The default address is determined by the `ip' parameter
+		The default address is determined by the ip parameter
 		(see below). This parameter allows the use of different
 		servers for IP autoconfiguration and NFS.
 
@@ -66,7 +70,8 @@ nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 		IP address.
 
   <nfs-options>	Standard NFS options. All options are separated by commas.
-		The following defaults are used:
+		The following defaults are used::
+
 			port		= as given by server portmap daemon
 			rsize		= 4096
 			wsize		= 4096
@@ -79,13 +84,11 @@ nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 			flags		= hard, nointr, noposix, cto, ac
 
 
-ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
-   <dns0-ip>:<dns1-ip>:<ntp0-ip>
-
+ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns0-ip>:<dns1-ip>:<ntp0-ip>
   This parameter tells the kernel how to configure IP addresses of devices
   and also how to set up the IP routing table. It was originally called
-  `nfsaddrs', but now the boot-time IP configuration works independently of
-  NFS, so it was renamed to `ip' and the old name remained as an alias for
+  nfsaddrs, but now the boot-time IP configuration works independently of
+  NFS, so it was renamed to ip and the old name remained as an alias for
   compatibility reasons.
 
   If this parameter is missing from the kernel command line, all fields are
@@ -93,17 +96,17 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
   this means that the kernel tries to configure everything using
   autoconfiguration.
 
-  The <autoconf> parameter can appear alone as the value to the `ip'
+  The <autoconf> parameter can appear alone as the value to the ip
   parameter (without all the ':' characters before).  If the value is
   "ip=off" or "ip=none", no autoconfiguration will take place, otherwise
   autoconfiguration will take place.  The most common way to use this
   is "ip=dhcp".
 
   <client-ip>	IP address of the client.
-
   		Default:  Determined using autoconfiguration.
 
-  <server-ip>	IP address of the NFS server. If RARP is used to determine
+  <server-ip>	IP address of the NFS server.
+		If RARP is used to determine
 		the client address and this parameter is NOT empty only
 		replies from the specified server are accepted.
 
@@ -115,19 +118,19 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
 		(see below).
 
 		Default: Determined using autoconfiguration.
-		         The address of the autoconfiguration server is used.
+		The address of the autoconfiguration server is used.
 
   <gw-ip>	IP address of a gateway if the server is on a different subnet.
-
 		Default: Determined using autoconfiguration.
 
-  <netmask>	Netmask for local network interface. If unspecified
-		the netmask is derived from the client IP address assuming
-		classful addressing.
+  <netmask>	Netmask for local network interface.
+		If unspecified the netmask is derived from the client IP address
+		assuming classful addressing.
 
 		Default:  Determined using autoconfiguration.
 
-  <hostname>	Name of the client. If a '.' character is present, anything
+  <hostname>	Name of the client.
+		If a '.' character is present, anything
 		before the first '.' is used as the client's hostname, and anything
 		after it is used as its NIS domain name. May be supplied by
 		autoconfiguration, but its absence will not trigger autoconfiguration.
@@ -138,21 +141,21 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
   		Default: Client IP address is used in ASCII notation.
 
   <device>	Name of network device to use.
-
 		Default: If the host only has one device, it is used.
-			 Otherwise the device is determined using
-			 autoconfiguration. This is done by sending
-			 autoconfiguration requests out of all devices,
-			 and using the device that received the first reply.
-
-  <autoconf>	Method to use for autoconfiguration. In the case of options
-                which specify multiple autoconfiguration protocols,
+		Otherwise the device is determined using
+		autoconfiguration. This is done by sending
+		autoconfiguration requests out of all devices,
+		and using the device that received the first reply.
+
+  <autoconf>	Method to use for autoconfiguration.
+		In the case of options
+		which specify multiple autoconfiguration protocols,
 		requests are sent using all protocols, and the first one
 		to reply is used.
 
 		Only autoconfiguration protocols that have been compiled
 		into the kernel will be used, regardless of the value of
-		this option.
+		this option::
 
                   off or none: don't use autoconfiguration
 				(do static IP assignment instead)
@@ -221,7 +224,6 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
 
 
 nfsrootdebug
-
   This parameter enables debugging messages to appear in the kernel
   log at boot time so that administrators can verify that the correct
   NFS mount options, server address, and root path are passed to the
@@ -229,36 +231,32 @@ nfsrootdebug
 
 
 rdinit=<executable file>
-
   To specify which file contains the program that starts system
   initialization, administrators can use this command line parameter.
   The default value of this parameter is "/init".  If the specified
   file exists and the kernel can execute it, root filesystem related
-  kernel command line parameters, including `nfsroot=', are ignored.
+  kernel command line parameters, including 'nfsroot=', are ignored.
 
   A description of the process of mounting the root file system can be
-  found in:
-
-    Documentation/driver-api/early-userspace/early_userspace_support.rst
-
-
+  found in Documentation/driver-api/early-userspace/early_userspace_support.rst
 
 
-3.) Boot Loader
-    ----------
+Boot Loader
+===========
 
 To get the kernel into memory different approaches can be used.
 They depend on various facilities being available:
 
 
-3.1)  Booting from a floppy using syslinux
+- Booting from a floppy using syslinux
 
 	When building kernels, an easy way to create a boot floppy that uses
 	syslinux is to use the zdisk or bzdisk make targets which use zimage
       	and bzimage images respectively. Both targets accept the
      	FDARGS parameter which can be used to set the kernel command line.
 
-	e.g.
+	e.g::
+
 	   make bzdisk FDARGS="root=/dev/nfs"
 
    	Note that the user running this command will need to have
@@ -267,32 +265,36 @@ They depend on various facilities being available:
      	For more information on syslinux, including how to create bootdisks
      	for prebuilt kernels, see http://syslinux.zytor.com/
 
-	N.B: Previously it was possible to write a kernel directly to
-	     a floppy using dd, configure the boot device using rdev, and
-	     boot using the resulting floppy. Linux no longer supports this
-	     method of booting.
+	.. note::
+		Previously it was possible to write a kernel directly to
+		a floppy using dd, configure the boot device using rdev, and
+		boot using the resulting floppy. Linux no longer supports this
+		method of booting.
 
-3.2) Booting from a cdrom using isolinux
+- Booting from a cdrom using isolinux
 
      	When building kernels, an easy way to create a bootable cdrom that
      	uses isolinux is to use the isoimage target which uses a bzimage
      	image. Like zdisk and bzdisk, this target accepts the FDARGS
      	parameter which can be used to set the kernel command line.
 
-	e.g.
+	e.g::
+
 	  make isoimage FDARGS="root=/dev/nfs"
 
      	The resulting iso image will be arch/<ARCH>/boot/image.iso
      	This can be written to a cdrom using a variety of tools including
      	cdrecord.
 
-	e.g.
+	e.g::
+
 	  cdrecord dev=ATAPI:1,0,0 arch/x86/boot/image.iso
 
      	For more information on isolinux, including how to create bootdisks
      	for prebuilt kernels, see http://syslinux.zytor.com/
 
-3.2) Using LILO
+- Using LILO
+
 	When using LILO all the necessary command line parameters may be
 	specified using the 'append=' directive in the LILO configuration
 	file.
@@ -300,15 +302,19 @@ They depend on various facilities being available:
 	However, to use the 'root=' directive you also need to create
 	a dummy root device, which may be removed after LILO is run.
 
-	mknod /dev/boot255 c 0 255
+	e.g::
+
+	  mknod /dev/boot255 c 0 255
 
 	For information on configuring LILO, please refer to its documentation.
 
-3.3) Using GRUB
+- Using GRUB
+
 	When using GRUB, kernel parameter are simply appended after the kernel
 	specification: kernel <kernel> <parameters>
 
-3.4) Using loadlin
+- Using loadlin
+
 	loadlin may be used to boot Linux from a DOS command prompt without
 	requiring a local hard disk to mount as root. This has not been
 	thoroughly tested by the authors of this document, but in general
@@ -317,7 +323,8 @@ They depend on various facilities being available:
 
 	Please refer to the loadlin documentation for further information.
 
-3.5) Using a boot ROM
+- Using a boot ROM
+
 	This is probably the most elegant way of booting a diskless client.
 	With a boot ROM the kernel is loaded using the TFTP protocol. The
 	authors of this document are not aware of any no commercial boot
@@ -326,7 +333,8 @@ They depend on various facilities being available:
 	etherboot, both of which are available on sunsite.unc.edu, and both
 	of which contain everything you need to boot a diskless Linux client.
 
-3.6) Using pxelinux
+- Using pxelinux
+
 	Pxelinux may be used to boot linux using the PXE boot loader
 	which is present on many modern network cards.
 
@@ -342,8 +350,8 @@ They depend on various facilities being available:
 
 
 
-4.) Credits
-    -------
+Credits
+=======
 
   The nfsroot code in the kernel and the RARP support have been written
   by Gero Kuhlmann <gero@gkminix.han.de>.
-- 
2.24.1

