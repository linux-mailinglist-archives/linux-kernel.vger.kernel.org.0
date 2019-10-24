Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCFACE2910
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 05:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437377AbfJXDsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 23:48:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29994 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392934AbfJXDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:48:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O3l4Yj116734
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 23:48:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vt3kjgq16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 23:48:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 24 Oct 2019 04:47:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 04:47:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O3ls3l59506718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 03:47:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA365AE058;
        Thu, 24 Oct 2019 03:47:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 144A4AE055;
        Thu, 24 Oct 2019 03:47:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 03:47:50 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
Date:   Wed, 23 Oct 2019 22:47:14 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024034717.70552-1-nayna@linux.ibm.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102403-0020-0000-0000-0000037D810D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102403-0021-0000-0000-000021D3C52C
Message-Id: <20191024034717.70552-6-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

process_buffer_measurement() is limited to measuring the kexec boot
command line. This patch makes process_buffer_measurement() more
generic, allowing it to measure other types of buffer data (e.g.
blacklisted binary hashes or key hashes).

process_buffer_measurement() may be called directly from an IMA
hook or as an auxiliary measurement record. In both cases the buffer
measurement is based on policy. This patch modifies the function to
conditionally retrieve the policy defined PCR and template for the IMA
hook case.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/ima/ima.h      |  3 ++
 security/integrity/ima/ima_main.c | 51 ++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3689081aaf38..a65772ffa427 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -217,6 +217,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, enum ima_hooks func,
+				int pcr);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 60027c643ecd..fe0b704ffdeb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -626,14 +626,14 @@ int ima_load_data(enum kernel_load_data_id id)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
  * @eventname: event name to be used for the buffer entry.
- * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * @func: IMA hook
+ * @pcr: pcr to extend the measurement
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-static void process_buffer_measurement(const void *buf, int size,
-				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, enum ima_hooks func,
+				int pcr)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -642,19 +642,38 @@ static void process_buffer_measurement(const void *buf, int size,
 					    .filename = eventname,
 					    .buf = buf,
 					    .buf_len = size};
-	struct ima_template_desc *template_desc = NULL;
+	struct ima_template_desc *template = NULL;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash = {};
 	int violation = 0;
-	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
+	u32 secid;
 
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
-				&template_desc);
-	if (!(action & IMA_MEASURE))
-		return;
+	if (func) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0, func,
+					&pcr, &template);
+		if (!(action & IMA_MEASURE))
+			return;
+	}
+
+	if (!pcr)
+		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+
+	if (!template) {
+		template = lookup_template_desc("ima-buf");
+		ret = template_desc_init_fields(template->fmt,
+						&(template->fields),
+						&(template->num_fields));
+		if (ret < 0) {
+			pr_err("template %s init failed, result: %d\n",
+			       (strlen(template->name) ?
+				template->name : template->fmt), ret);
+			return;
+		}
+	}
 
 	iint.ima_hash = &hash.hdr;
 	iint.ima_hash->algo = ima_hash_algo;
@@ -664,7 +683,7 @@ static void process_buffer_measurement(const void *buf, int size,
 	if (ret < 0)
 		goto out;
 
-	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0)
 		goto out;
 
@@ -686,13 +705,9 @@ static void process_buffer_measurement(const void *buf, int size,
  */
 void ima_kexec_cmdline(const void *buf, int size)
 {
-	u32 secid;
-
-	if (buf && size != 0) {
-		security_task_getsecid(current, &secid);
+	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   current_cred(), secid);
-	}
+					   KEXEC_CMDLINE, 0);
 }
 
 static int __init init_ima(void)
-- 
2.20.1

