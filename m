Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3469AF5EFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 13:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKIMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 07:23:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbfKIMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 07:23:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA9C6bEa098521
        for <linux-kernel@vger.kernel.org>; Sat, 9 Nov 2019 07:23:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5q7g91yr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 07:23:53 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Sat, 9 Nov 2019 12:23:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Nov 2019 12:23:49 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA9CNmOj42598576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Nov 2019 12:23:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58DEEA404D;
        Sat,  9 Nov 2019 12:23:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C42DA4040;
        Sat,  9 Nov 2019 12:23:46 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.97])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Nov 2019 12:23:46 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 0/4] reorganize and add FADump sysfs files
Date:   Sat,  9 Nov 2019 17:53:35 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19110912-0016-0000-0000-000002C229B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110912-0017-0000-0000-00003323B3F6
Message-Id: <20191109122339.20484-1-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=817 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911090131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, FADump sysfs files are present inside /sys/kernel directory.
But as the number of FADump sysfs file increases it is not a good idea to
push all of them in /sys/kernel directory. It is better to have separate
directory to keep all the FADump sysfs files.

The patch series reorganizes the FADump sysfs files and avail all the
existing FADump sysfs files present inside /sys/kernel into a new
directory /sys/kernel/fadump. Currently, all the FADump sysfs files
are replicated into a new directory to maintain the backward compatibility
and will eventually get removed in future. In addition to this a new FADump
sys interface is added to get the amount of memory reserved by FADump for
saving the crash dump.

Changelog:

v1->v2:
 - Move fadump_release_opalcore sysfs to FADump Kobject instead of
   replicating.
 - Changed the patch order 1,2,3,4 -> 2,1,3,4 (First add the ABI doc for
   exisiting sysfs file then replicate them under FADump kobject).

v2->v3:
 - Remove the fadump_ prefix from replicated FADump sysfs file names.

Sourabh Jain (4):
  Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
  powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
  Documentation/ABI: mark /sys/kernel/fadump_* sysfs files deprecated
  powerpc/fadump: sysfs for fadump memory reservation

 .../ABI/obsolete/sysfs-kernel-fadump_enabled  | 10 ++++
 .../obsolete/sysfs-kernel-fadump_registered   | 11 ++++
 .../obsolete/sysfs-kernel-fadump_release_mem  | 11 ++++
 .../sysfs-kernel-fadump_release_opalcore      |  9 ++++
 Documentation/ABI/testing/sysfs-kernel-fadump | 48 +++++++++++++++++
 .../powerpc/firmware-assisted-dump.rst        | 20 ++++++-
 arch/powerpc/kernel/fadump.c                  | 53 +++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-core.c    | 10 ++--
 8 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

-- 
2.17.2

