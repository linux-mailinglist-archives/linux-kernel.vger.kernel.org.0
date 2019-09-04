Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1555DA7D53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfIDIIQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 04:08:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727787AbfIDIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:08:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x848871c041123
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 04:08:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ut67a637w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:08:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 4 Sep 2019 09:07:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 09:07:54 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8487rWX47186058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 08:07:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62606A4057;
        Wed,  4 Sep 2019 08:07:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12C64A4051;
        Wed,  4 Sep 2019 08:07:53 +0000 (GMT)
Received: from localhost (unknown [9.124.35.94])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 08:07:52 +0000 (GMT)
Date:   Wed, 04 Sep 2019 13:37:50 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ftrace: Fix NULL pointer dereference in
 t_probe_next()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
        <05e021f757625cbbb006fad41380323dbe4e3b43.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190830164706.453a119e@gandalf.local.home>
In-Reply-To: <20190830164706.453a119e@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19090408-0008-0000-0000-00000310D94C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090408-0009-0000-0000-00004A2F2DBF
Message-Id: <1567584434.0m0xodpunl.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu,  4 Jul 2019 20:04:41 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> 
>>  kernel/trace/ftrace.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 7b037295a1f1..0791eafb693d 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3093,6 +3093,10 @@ t_probe_next(struct seq_file *m, loff_t *pos)
>>  		hnd = &iter->probe_entry->hlist;
>>  
>>  	hash = iter->probe->ops.func_hash->filter_hash;
>> +
>> +	if (!hash)
>> +		return NULL;
>> +
>>  	size = 1 << hash->size_bits;
>>  
>>   retry:
> 
> OK, I added this, but I'm also adding this on top:

Thanks, the additional comments do make this much clearer.

Regards,
Naveen

