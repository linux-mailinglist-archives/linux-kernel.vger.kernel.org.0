Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2616E176FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 08:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCCHJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 02:09:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgCCHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:09:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02374dWR017479
        for <linux-kernel@vger.kernel.org>; Tue, 3 Mar 2020 02:09:02 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmqaqwch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:09:02 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 3 Mar 2020 07:09:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 07:08:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02378uxH49217582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 07:08:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83BABAE056;
        Tue,  3 Mar 2020 07:08:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4775AAE04D;
        Tue,  3 Mar 2020 07:08:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Mar 2020 07:08:56 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf documentation: Add desription forHEADER_TRACING_DATA
Date:   Tue,  3 Mar 2020 08:08:46 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20030307-0012-0000-0000-0000038C9653
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030307-0013-0000-0000-000021C94B9A
Message-Id: <20200303070846.18335-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_01:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description and layout in the perf.data file for
the header part describing trace data used in commands
perf record -e XXX
where XXX is a probe or tracepoint.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 .../Documentation/perf.data-file-format.txt   | 106 +++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b0152e1095c5..e3f78269e417 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -67,9 +67,113 @@ flags. These define the valid bits:
 
 	HEADER_RESERVED		= 0,	/* always cleared */
 	HEADER_FIRST_FEATURE	= 1,
+
 	HEADER_TRACING_DATA	= 1,
 
-Describe me.
+The header consists of several entries of variable length such as file
+contents of several trace files like 'header_page', 'header_event'.
+Also complete probe/<event-name>/format files are included.
+The numbers in parenthesis are structure members refered to later in
+the description and example.
+
+struct tracing_data {
+	char birthday[3] = { 23, 8, 68 };	Eyecatcher
+	char tracing[12] = "tracing0.6";	Type and version
+	uint8_t bigendian;			Big or little endian platform
+	uint8_t sizelong;			Size of long in bytes
+	uint32_t pagesize:			Pagesize in bytes
+	char hdr_page[12] = "header_page"	Name of file             (1)
+	uint64_t hdr_page_size;			File size in bytes       (1a)
+	char hdr_page_contents[hdr_page_size];	Contents of file         (1b)
+	char hdr_event[13] = "header_event"	Name of file             (2)
+	uint64_t hdr_event_size;		File size in bytes
+	char hdr_page_contents[hdr_event_size];	Contents of file
+	uint32_t ftrace_count;			Number of ftrace entries (3)
+	struct {				Size and content of file
+	    uint64_t file_size;
+	    char file_content[file_size]
+	} ftrace[ftrace_count]			ftrace_count array elements
+	uint32_t event_types;			Number of event types    (4)
+	struct {
+	    char name[];			Name, null terminatedg   (5)
+	    uint32_t count;			Number of probes         (6)
+	    struct {
+	       uint64_t file_size;					 (7)
+	       char file_content[file_size];				 (8)
+	    }[count];				Count always > 0 or omitted
+	}[event_types];
+	uint32_t proc_kallsyms_size;		Always zero
+	uint64_t printk_file_size;		File size in bytes       (9)
+	char printk_format[printk_file_size];	Contents of file
+	uint64_t saved_cmdlines_size;		File size in bytes       (10)
+	char saved_cmdlines[saved_cmdlines_size];	Contents of file
+};
+
+The structure description is straight forward. It contains file name, size
+and contents from
+- /sys/kernel/debug/tracing/events/header_page (1, 1a, 1b)
+and
+- /sys/kernel/debug/tracing/events/header_event (2).
+
+This is followed by a variable length part of format files found in directory
+/sys/kernel/debug/tracing//events/ftrace/*/format for events selected
+by the perf record -e XXX commands. Note member 'ftrace_count' can be zero.
+
+Next are the number of probe types specified by the perf record -e XXXX
+command (4). Each type has stored its name (5), which is a null terminated
+string, and the number of probes (6) belonging to this type. For each
+active probe follows the file size (7) and file contents (8) of that probe.
+
+Finally the file size and contents of two more files is saved:
+- Size of /proc/kallsyms (always hard coded to zero and no file contents)
+- /sys/kernel/debug/tracing/printk_formats (9)
+- /sys/kernel/debug/tracing/saved_cmdlines (10)
+
+Example for the dynamic probes and trace points:
+Consider these probes have been set up:
+ # ./perf probe -l
+  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
+  probe:xxx            (on do_file_open_root:11@fs/namei.c)
+ #
+and this command used for recording:
+ # ./perf record -e probe:vfs_getname -e probe:xxx \
+	-e tcp:tcp_retransmit_skb -- touch /tmp/xxx
+
+This command line leads to two events in directory
+   /sys/kernel/debug/tracing/events/probe/vfs_getname
+   /sys/kernel/debug/tracing/events/probe/xxx
+and a tracepoint in directory
+   /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb.
+
+This results in this event_count (5) layout in the perf.data:
+using command:
+ # od -Ax -t x4z -v perf.data
+
+0011a0 00000000 00000270 726f6265 00000000  >.......probe....<
+             ^^ (4)^^^'' ''(5)''' ''--(6)-
+	     4: # of types --> 2
+	     5: first one named 'probe'
+	     6: 2 probes defined
+0011b0 02000000 00000001 766e616d 653a2078  >........vname: x<
+       --###### (7)##### ##
+             7: first one 'named' xxx with format file size 0x176
+0011c0 78780a49 443a2031 3138360a 666f726d  >xx.ID: 1186.form<
+...
+001320 45432d3e 5f5f7072 6f62655f 69700a00  >EC->__probe_ip..<
+                                        ''
+001330 00000000 0001e36e 616d653a 20766673  >.......name: vfs<
+       ''(7)''' ''''''
+              7: second one named 'vfs_getname' with format file size 0x1e3
+001340 5f676574 6e616d65 0a49443a 20313138  >_getname.ID: 118<
+...
+001510 70617468 6e616d65 290a7463 70000000  >pathname).tcp...<
+                             ''(5 )'--(6)-
+001520 00010000 00000000 05696e61 6d653a20  >.........iname: <
+       ----#### (7)##### ####
+       5: second event type named 'tcp'
+       6: 1 probe defined
+       7: size of format file 0x568
+001530 7463705f 72657472 616e736d 69745f73  >tcp_retransmit_s<
 
 	HEADER_BUILD_ID = 2,
 
-- 
2.23.0

