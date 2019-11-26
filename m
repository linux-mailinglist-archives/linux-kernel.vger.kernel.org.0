Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A302109F90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfKZNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 08:52:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727374AbfKZNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:52:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQDn0h4049806;
        Tue, 26 Nov 2019 08:51:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wh5608b33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 08:51:58 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAQDn81p050645;
        Tue, 26 Nov 2019 08:51:58 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wh5608b26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 08:51:57 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAQDj5hq025781;
        Tue, 26 Nov 2019 13:51:57 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 2wevd6kfa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 13:51:57 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQDpue332440640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:51:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 905FE112063;
        Tue, 26 Nov 2019 13:51:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B756112061;
        Tue, 26 Nov 2019 13:51:56 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.3.141])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 13:51:56 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 3F88C2E2F7D; Tue, 26 Nov 2019 19:21:53 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat11@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv/opal-sensor-groups: Add documentation for the sysfs interfaces
Date:   Tue, 26 Nov 2019 19:21:14 +0530
Message-Id: <1574776274-22355-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_03:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Commit bf9571550f52 ("powerpc/powernv: Add support to clear sensor
groups data") added a mechanism to clear sensor-group data via a sysfs
interface. However, the ABI for that interface has not been
documented.

This patch documents the ABI for the sysfs interface for sensor-groups
and clearing the sensor-groups.

This patch was originally sent by Shilpasri G Bhat on the mailing list:
https://lkml.org/lkml/2018/8/1/85

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 .../ABI/testing/sysfs-firmware-opal-sensor-groups   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
new file mode 100644
index 0000000..3a2dfe5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -0,0 +1,21 @@
+What:		/sys/firmware/opal/sensor_groups
+Date:		August 2017
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sensor groups directory for POWER9 powernv servers
+
+		Each folder in this directory contains a sensor group
+		which are classified based on type of the sensor
+		like power, temperature, frequency, current, etc. They
+		can also indicate the group of sensors belonging to
+		different owners like CSM, Profiler, Job-Scheduler
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/clear
+Date:		August 2017
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to clear the min-max of all the sensors
+		belonging to the group.
+
+		Writing 1 to this file will clear the minimum and
+		maximum values of all the sensors in the group.
+		In POWER9, the min-max of a sensor is the historical minimum
+		and maximum value of the sensor cached by OCC.
-- 
1.9.4

