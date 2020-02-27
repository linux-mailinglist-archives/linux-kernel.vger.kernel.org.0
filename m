Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6817F172ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgB0WFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:05:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729501AbgB0WFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:05:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RM0R5L019760;
        Thu, 27 Feb 2020 17:03:54 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqfwgr7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 17:03:54 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01RM2gs7019168;
        Thu, 27 Feb 2020 22:03:53 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2ydcmm0htc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 22:03:53 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RM3qmt52298088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 22:03:52 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69BB56A09A;
        Thu, 27 Feb 2020 22:03:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1B86A099;
        Thu, 27 Feb 2020 22:03:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 22:03:51 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 3/3] tpm: ibmvtpm: Add support for TPM 2
Date:   Thu, 27 Feb 2020 17:03:46 -0500
Message-Id: <20200227220346.15976-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227220346.15976-1-stefanb@linux.vnet.ibm.com>
References: <20200227220346.15976-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_07:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
version of TPM is connected through the vio_device_id.

In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag
and get the command codes attributes table. The driver does
not need the timeouts and durations, though.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm.h         | 1 +
 drivers/char/tpm/tpm2-cmd.c    | 2 +-
 drivers/char/tpm/tpm_ibmvtpm.c | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 5620747da0cf..ad55c9824338 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -226,6 +226,7 @@ int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
+int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..b6a0ee6bb03a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -613,7 +613,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	return rc;
 }
 
-static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
+int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 {
 	struct tpm_buf buf;
 	u32 nr_commands;
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index eee566eddb35..b6e61691a943 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
 static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 	{ "IBM,vtpm", "IBM,vtpm"},
+	{ "IBM,vtpm", "IBM,vtpm20"},
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
@@ -672,6 +673,11 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
+	if (!strcmp(id->compat, "IBM,vtpm20")) {
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
+		tpm2_get_cc_attrs_tbl(chip);
+	}
+
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
-- 
2.23.0

