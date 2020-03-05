Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB83179E99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 05:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEE3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 23:29:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgCEE3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:29:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0254OG2D136130
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 23:29:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj3esvx61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:29:10 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maddy@linux.ibm.com>;
        Thu, 5 Mar 2020 04:29:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 04:29:03 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0254T2l162914792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 04:29:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8694FA405B;
        Thu,  5 Mar 2020 04:29:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22171A4054;
        Thu,  5 Mar 2020 04:28:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.31])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 04:28:57 +0000 (GMT)
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yao.jin@linux.intel.com, Robert Richter <robert.richter@amd.com>,
        "Phillips, Kim" <kim.phillips@amd.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302101332.GS18400@hirez.programming.kicks-ass.net>
 <CABPqkBSzwpR6p7UZs7g1vWGCJRLsh565mRMGc6m0Enn1SnkC4w@mail.gmail.com>
From:   maddy <maddy@linux.ibm.com>
Date:   Thu, 5 Mar 2020 09:58:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBSzwpR6p7UZs7g1vWGCJRLsh565mRMGc6m0Enn1SnkC4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030504-0016-0000-0000-000002ED4DBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030504-0017-0000-0000-000033509F71
Message-Id: <feb5e5b1-b1d4-1db4-cd25-c9b1829725f9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/20 1:51 AM, Stephane Eranian wrote:
> On Mon, Mar 2, 2020 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
>>> Modern processors export such hazard data in Performance
>>> Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
>>> Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
>>> AMD[3] provides similar information.
>>>
>>> Implementation detail:
>>>
>>> A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
>>> If it's set, kernel converts arch specific hazard information
>>> into generic format:
>>>
>>>    struct perf_pipeline_haz_data {
>>>           /* Instruction/Opcode type: Load, Store, Branch .... */
>>>           __u8    itype;
>>>           /* Instruction Cache source */
>>>           __u8    icache;
>>>           /* Instruction suffered hazard in pipeline stage */
>>>           __u8    hazard_stage;
>>>           /* Hazard reason */
>>>           __u8    hazard_reason;
>>>           /* Instruction suffered stall in pipeline stage */
>>>           __u8    stall_stage;
>>>           /* Stall reason */
>>>           __u8    stall_reason;
>>>           __u16   pad;
>>>    };
>> Kim, does this format indeed work for AMD IBS?
>
> Personally, I don't like the term hazard. This is too IBM Power
> specific. We need to find a better term, maybe stall or penalty.

Yes, names can be reworked and thinking more on it, how about these
as "pipeline" data instead of "hazard" data.

> Also worth considering is the support of ARM SPE (Statistical
> Profiling Extension) which is their version of IBS.
> Whatever gets added need to cover all three with no limitations.

Thanks for pointing this out. We looked at the ARM SPE spec and it does
provides information like issue latency, translation latency so on.
And AMD IBS provides data like fetch latency, tag to retire latency,
completion to retire latency and so on when using Fetch sampling.
  So yes, will rework the struct definition to include data from ARM SPE
and AMD IBS also. Will post out a newer version soon.

Thanks for the comments
Maddy

