Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA8112FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfLDQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 11:19:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:19:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4G4IwD157651
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 16:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2019-08-05;
 bh=+2zTRs6LpqKsIx3JCGf6TrnklJdlbOCqRga11/jRpDQ=;
 b=aP0879N+aFtqTM68y5FD+gVM8Y8XR0VGyi4y/6ubRbXzeeNbygFnFUKTgx+kwdHmW1oP
 GmDRxbSs+GxOPqcoD4M0/dKl/X686gcU2FauuEjR8MiBiqbDjNKeLBN1wc4ySutyZ78I
 ncp2o8+KTiLsZNESAbWqOzreC91/HORNA8kCgohz6fDFQsuNlXrYoyVkt9fvAOwug5ZG
 zZREMjwwOiXhvDopEIvWYU/Vy+lEPuAXCH1fY0ytYFi71Inf92mF9MhxNVfOqI4ZFpUL
 pPlleh06JF81pmZCu2OmXkuZZugF47rXe3CkaRBjjxJfzxWFdF2reEHujrgqxAecOhq1 Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wkfuufmnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:19:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4G42XX050494
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 16:19:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wnvr048yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:19:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4GJfbH015763
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 16:19:41 GMT
Received: from dhcp-10-154-130-168.vpn.oracle.com (/10.154.130.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 08:19:41 -0800
From:   John Donnelly <john.p.donnelly@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: [PATCH ] kernel/crash_core.c - Add crashkernel=auto for x86 and Arm
Message-Id: <174DB3D9-8C97-4022-A5B5-6A3E007440AF@oracle.com>
Date:   Wed, 4 Dec 2019 10:19:40 -0600
Cc:     John Donnelly <john.p.donnelly@oracle.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds crashkernel=3Dauto feature to configure reserved memory for
vmcore creation to both x86 and Arm platform as implemenented in
RH 4.18.0-147.el8 kernels. The values have been adjusted for x86 and
Arm based from 5.4.0 kernel crash testing.

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 12 ++++++++++
 kernel/crash_core.c                       | 28 +++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst =
b/Documentation/admin-guide/kdump/kdump.rst
index ac7e131d2935..7635bbb4ab34 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -285,6 +285,18 @@ This would mean:
     2) if the RAM size is between 512M and 2G (exclusive), then reserve =
64M
     3) if the RAM size is larger than 2G, then reserve 128M
=20
+Or you can use crashkernel=3Dauto if you have enough memory.  The =
threshold
+is 1G on x86_64, 2G on arm64, ppc64 and ppc64le. The threshold is 4G =
for s390x.
+If your system memory is less than the threshold crashkernel=3Dauto =
will not
+reserve memory.
+
+The automatically reserved memory size varies based on architecture.
+The size changes according to system memory size like below:
+    x86_64: 1G-64G:160M,64G-1T:280M,1T-:512M
+    s390x:  4G-64G:160M,64G-1T:256M,1T-:512M
+    arm64:  2G-:768M
+    ppc64:  2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
+
=20
=20
 Boot into System Kernel
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..564aca60e57f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
=20
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -39,6 +40,15 @@ static int __init parse_crashkernel_mem(char =
*cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur =3D cmdline, *tmp;
+	unsigned long long total_mem =3D system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for it's own =
use.
+	 * so we get less than actual system memory size.
+	 * Workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem =3D roundup(total_mem, SZ_128M);
=20
 	/* for each entry of the comma-separated list */
 	do {
@@ -83,13 +93,13 @@ static int __init parse_crashkernel_mem(char =
*cmdline,
 			return -EINVAL;
 		}
 		cur =3D tmp;
-		if (size >=3D system_ram) {
+		if (size >=3D total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
=20
 		/* match ? */
-		if (system_ram >=3D start && system_ram < end) {
+		if (total_mem >=3D start && total_mem < end) {
 			*crash_size =3D size;
 			break;
 		}
@@ -248,6 +258,20 @@ static int __init __parse_crashkernel(char =
*cmdline,
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+
+	if (strncmp(ck_cmdline, "auto", 4) =3D=3D 0) {
+#ifdef CONFIG_X86_64
+		ck_cmdline =3D "1G-64G:160M,64G-1T:280M,1T-:512M";
+#elif defined(CONFIG_S390)
+		ck_cmdline =3D "4G-64G:160M,64G-1T:256M,1T-:512M";
+#elif defined(CONFIG_ARM64)
+		ck_cmdline =3D "2G-:768M";
+#elif defined(CONFIG_PPC64)
+		ck_cmdline =3D =
"2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
+#endif
+		pr_info("Using crashkernel=3Dauto, the size chosen is a =
best effort estimation.\n");
+	}
+
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
--=20
2.20.1


