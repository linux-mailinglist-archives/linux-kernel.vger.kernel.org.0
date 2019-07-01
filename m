Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FED4A9B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfFRSXV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jun 2019 14:23:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730245AbfFRSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:23:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIMi1c141721
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:23:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t731bp2e5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:23:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 18 Jun 2019 19:23:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 19:23:14 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IINDrb52691166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 18:23:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5554111C05B;
        Tue, 18 Jun 2019 18:23:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E438611C050;
        Tue, 18 Jun 2019 18:23:12 +0000 (GMT)
Received: from localhost (unknown [9.85.74.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 18:23:12 +0000 (GMT)
Date:   Tue, 18 Jun 2019 23:53:11 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] powerpc/ftrace: Update ftrace_location() for powerpc
 -mprofile-kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190618114509.5b1acbe5@gandalf.local.home>
        <1560881411.p0i6a1dkwk.naveen@linux.ibm.com>
In-Reply-To: <1560881411.p0i6a1dkwk.naveen@linux.ibm.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19061818-0016-0000-0000-0000028A2FFF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061818-0017-0000-0000-000032E7827C
Message-Id: <1560881840.vz9llflvnf.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao wrote:
> Steven Rostedt wrote:
>> On Tue, 18 Jun 2019 20:17:04 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> 
>>> @@ -1551,7 +1551,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>>>  	key.flags = end;	/* overload flags, as it is unsigned long */
>>>  
>>>  	for (pg = ftrace_pages_start; pg; pg = pg->next) {
>>> -		if (end < pg->records[0].ip ||
>>> +		if (end <= pg->records[0].ip ||
>> 
>> This breaks the algorithm. "end" is inclusive. That is, if you look for
>> a single byte, where "start" and "end" are the same, and it happens to
>> be the first ip on the pg page, it will be skipped, and not found.
> 
> Thanks. It looks like I should be over-riding ftrace_location() instead.  
> I will update this patch.

I think I will have ftrace own the two instruction range, regardless of 
whether the preceding instruction is a 'mflr r0' or not. This simplifies 
things and I don't see an issue with it as of now. I will do more 
testing to confirm.

- Naveen


--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -951,6 +951,16 @@ void arch_ftrace_update_code(int command)
 }
 
 #ifdef CONFIG_MPROFILE_KERNEL
+/*
+ * We consider two instructions -- 'mflr r0', 'bl _mcount' -- to be part
+ * of ftrace. When checking for the first instruction, we want to include
+ * the next instruction in the range check.
+ */
+unsigned long ftrace_location(unsigned long ip)
+{
+	return ftrace_location_range(ip, ip + MCOUNT_INSN_SIZE);
+}
+
 /* Returns 1 if we patched in the mflr */
 static int __ftrace_make_call_prep(struct dyn_ftrace *rec)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 21d8e201ee80..122e2bb4a739 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1573,7 +1573,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  * the function tracer. It checks the ftrace internal tables to
  * determine if the address belongs or not.
  */
-unsigned long ftrace_location(unsigned long ip)
+unsigned long __weak ftrace_location(unsigned long ip)
 {
 	return ftrace_location_range(ip, ip);
 }


