Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3923AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390903AbfETOmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:42:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732661AbfETOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:42:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KERweG085645
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:42:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2skvmjcxjn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:42:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 20 May 2019 15:42:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 15:42:45 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KEgiaI44105888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 14:42:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B43A4040;
        Mon, 20 May 2019 14:42:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F027DA404D;
        Mon, 20 May 2019 14:42:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 14:42:43 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] pert/report: Support s390 diag event display on x86
Date:   Mon, 20 May 2019 16:42:42 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19052014-0028-0000-0000-0000036FA2D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052014-0029-0000-0000-0000242F48C3
Message-Id: <20190520144242.53207-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf report fails to display s390 specific event numbered bd000
on an x86 platform. For example on s390 this works without error:

[root@m35lp76 perf]# uname -m
s390x
[root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.549 MB perf.data ]
[root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
[root@m35lp76 perf]#

Transfering this perf.data file to an x86 platform and executing
the same report command produces:

[root@f29 perf]# uname -m
x86_64
[root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
interpreting bpf_prog_info from systems with endianity is not yet supported
interpreting btf from systems with endianity is not yet supported
0x8c890 [0x8]: failed to process type: 68
Error:
failed to process sample

Event bd000 generates auxiliary data which is stored in big endian
format in the perf data file.
This error is caused by missing endianess handling on the x86 platform
when the data is displayed. Fix this by handling s390 auxiliary event
data depending on the local platform endianness.

Output after on x86:

[root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
interpreting bpf_prog_info from systems with endianity is not yet supported
interpreting btf from systems with endianity is not yet supported
[root@f29 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/s390-cpumsf.c | 95 ++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index c215704931dc..884ac79528ff 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -17,8 +17,8 @@
  *	see Documentation/perf.data-file-format.txt.
  * PERF_RECORD_AUXTRACE_INFO:
  *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
- *	record is generated during 'perf record' command. Each record contains up
- *	to 256 entries describing offset and size of the AUXTRACE data in the
+ *	record is generated during 'perf record' command. Each record contains
+ *	up to 256 entries describing offset and size of the AUXTRACE data in the
  *	perf.data file.
  * PERF_RECORD_AUXTRACE_ERROR:
  *	Indicates an error during AUXTRACE collection such as buffer overflow.
@@ -237,10 +237,33 @@ static int s390_cpumcf_dumpctr(struct s390_cpumsf *sf,
 	return rc;
 }
 
-/* Display s390 CPU measurement facility basic-sampling data entry */
+/* Display s390 CPU measurement facility basic-sampling data entry
+ * Data written on s390 in big endian byte order and contains bit
+ * fields across byte boundaries.
+ */
 static bool s390_cpumsf_basic_show(const char *color, size_t pos,
-				   struct hws_basic_entry *basic)
+				   struct hws_basic_entry *basicp)
 {
+	struct hws_basic_entry *basic = basicp;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_basic_entry local;
+	unsigned long word = be64toh(*(unsigned long *)basicp);
+
+	memset(&local, 0, sizeof(local));
+	local.def = be16toh(basicp->def);
+	local.prim_asn = word & 0xffff;
+	local.CL = word >> 30 & 0x3;
+	local.I = word >> 32 & 0x1;
+	local.AS = word >> 33 & 0x3;
+	local.P = word >> 35 & 0x1;
+	local.W = word >> 36 & 0x1;
+	local.T = word >> 37 & 0x1;
+	local.U = word >> 40 & 0xf;
+	local.ia = be64toh(basicp->ia);
+	local.gpp = be64toh(basicp->gpp);
+	local.hpp = be64toh(basicp->hpp);
+	basic = &local;
+#endif
 	if (basic->def != 1) {
 		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
 		return false;
@@ -258,10 +281,22 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 	return true;
 }
 
-/* Display s390 CPU measurement facility diagnostic-sampling data entry */
+/* Display s390 CPU measurement facility diagnostic-sampling data entry.
+ * Data written on s390 in big endian byte order and contains bit
+ * fields across byte boundaries.
+ */
 static bool s390_cpumsf_diag_show(const char *color, size_t pos,
-				  struct hws_diag_entry *diag)
+				  struct hws_diag_entry *diagp)
 {
+	struct hws_diag_entry *diag = diagp;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_diag_entry local;
+	unsigned long word = be64toh(*(unsigned long *)diagp);
+
+	local.def = be16toh(diagp->def);
+	local.I = word >> 32 & 0x1;
+	diag = &local;
+#endif
 	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
 		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
 		return false;
@@ -272,35 +307,51 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
 }
 
 /* Return TOD timestamp contained in an trailer entry */
-static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
+static unsigned long long trailer_timestamp(struct hws_trailer_entry *te,
+					    int idx)
 {
 	/* te->t set: TOD in STCKE format, bytes 8-15
 	 * to->t not set: TOD in STCK format, bytes 0-7
 	 */
 	unsigned long long ts;
 
-	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
-	return ts;
+	memcpy(&ts, &te->timestamp[idx], sizeof(ts));
+	return be64toh(ts);
 }
 
 /* Display s390 CPU measurement facility trailer entry */
 static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 				     struct hws_trailer_entry *te)
 {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_trailer_entry local;
+
+	memset(&local, 0, sizeof(local));
+	local.f = be64toh(te->flags) >> 63 & 0x1;
+	local.a = be64toh(te->flags) >> 62 & 0x1;
+	local.t = be64toh(te->flags) >> 61 & 0x1;
+	local.bsdes = be16toh((be64toh(te->flags) >> 16 & 0xffff));
+	local.dsdes = be16toh((be64toh(te->flags) & 0xffff));
+	memcpy(&local.timestamp, te->timestamp, sizeof(te->timestamp));
+	local.overflow = be64toh(te->overflow);
+	local.clock_base = be64toh(te->progusage[0]) >> 63 & 1;
+	local.progusage2 = be64toh(te->progusage2);
+	te = &local;
+#endif
 	if (te->bsdes != sizeof(struct hws_basic_entry)) {
 		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
 		return false;
 	}
 	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
 		      " dsdes:%d Overflow:%lld Time:%#llx\n"
-		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
+		      "\t\tC:%d TOD:%#lx\n",
 		      pos,
 		      te->f ? 'F' : ' ',
 		      te->a ? 'A' : ' ',
 		      te->t ? 'T' : ' ',
 		      te->bsdes, te->dsdes, te->overflow,
-		      trailer_timestamp(te), te->clock_base, te->progusage2,
-		      te->progusage[0], te->progusage[1]);
+		      trailer_timestamp(te, te->clock_base),
+		      te->clock_base, te->progusage2);
 	return true;
 }
 
@@ -327,13 +378,13 @@ static bool s390_cpumsf_validate(int machine_type,
 	*dsdes = *bsdes = 0;
 	if (len & (S390_CPUMSF_PAGESZ - 1))	/* Illegal size */
 		return false;
-	if (basic->def != 1)		/* No basic set entry, must be first */
+	if (be16toh(basic->def) != 1)	/* No basic set entry, must be first */
 		return false;
 	/* Check for trailer entry at end of SDB */
 	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
 					      - sizeof(*te));
-	*bsdes = te->bsdes;
-	*dsdes = te->dsdes;
+	*bsdes = be16toh(te->bsdes);
+	*dsdes = be16toh(te->dsdes);
 	if (!te->bsdes && !te->dsdes) {
 		/* Very old hardware, use CPUID */
 		switch (machine_type) {
@@ -495,19 +546,27 @@ static bool s390_cpumsf_make_event(size_t pos,
 static unsigned long long get_trailer_time(const unsigned char *buf)
 {
 	struct hws_trailer_entry *te;
-	unsigned long long aux_time;
+	unsigned long long aux_time, progusage2;
+	bool clock_base;
 
 	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
 					      - sizeof(*te));
 
-	if (!te->clock_base)	/* TOD_CLOCK_BASE value missing */
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	clock_base = be64toh(te->progusage[0]) >> 63 & 0x1;
+	progusage2 = be64toh(te->progusage[1]);
+#else
+	clock_base = te->clock_base;
+	progusage2 = te->progusage2;
+#endif
+	if (!clock_base)	/* TOD_CLOCK_BASE value missing */
 		return 0;
 
 	/* Correct calculation to convert time stamp in trailer entry to
 	 * nano seconds (taken from arch/s390 function tod_to_ns()).
 	 * TOD_CLOCK_BASE is stored in trailer entry member progusage2.
 	 */
-	aux_time = trailer_timestamp(te) - te->progusage2;
+	aux_time = trailer_timestamp(te, clock_base) - progusage2;
 	aux_time = (aux_time >> 9) * 125 + (((aux_time & 0x1ff) * 125) >> 9);
 	return aux_time;
 }
-- 
2.19.1

