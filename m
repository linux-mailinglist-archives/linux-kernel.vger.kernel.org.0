Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F466175396
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 07:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCBGPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 01:15:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgCBGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:15:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02269Sgn056544;
        Mon, 2 Mar 2020 01:14:59 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfjf3dyy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 01:14:59 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0226EuIP004680;
        Mon, 2 Mar 2020 06:14:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2yffk6bfnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 06:14:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0226Eu6g48497136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 06:14:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F82FC6057;
        Mon,  2 Mar 2020 06:14:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 004F9C6055;
        Mon,  2 Mar 2020 06:14:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.186])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 06:14:52 +0000 (GMT)
Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
Date:   Mon, 2 Mar 2020 11:44:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/20 4:06 PM, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: kajoljain <kjain@linux.ibm.com>
>> Sent: 2020��2��20�� 17:54
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; acme@kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-perf-users@vger.kernel.org; Jiri Olsa
>> <jolsa@kernel.org>; Alexander Shishkin <alexander.shishkin@linux.intel.com>;
>> Andi Kleen <ak@linux.intel.com>; Kan Liang <kan.liang@linux.intel.com>; Peter
>> Zijlstra <peterz@infradead.org>; Jin Yao <yao.jin@linux.intel.com>; Madhavan
>> Srinivasan <maddy@linux.vnet.ibm.com>; Anju T Sudhakar
>> <anju@linux.vnet.ibm.com>; Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
>> metric group with multiple events incase of overlapping events
>>
>>
>>
>> On 2/17/20 8:41 AM, Joakim Zhang wrote:
>>>
>>>> -----Original Message-----
>>>> From: linux-perf-users-owner@vger.kernel.org
>>>> <linux-perf-users-owner@vger.kernel.org> On Behalf Of Kajol Jain
>>>> Sent: 2020��2��12�� 13:41
>>>> To: acme@kernel.org
>>>> Cc: linux-kernel@vger.kernel.org; linux-perf-users@vger.kernel.org;
>>>> kjain@linux.ibm.com; Jiri Olsa <jolsa@kernel.org>; Alexander Shishkin
>>>> <alexander.shishkin@linux.intel.com>; Andi Kleen
>>>> <ak@linux.intel.com>; Kan Liang <kan.liang@linux.intel.com>; Peter
>>>> Zijlstra <peterz@infradead.org>; Jin Yao <yao.jin@linux.intel.com>;
>>>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com>; Anju T Sudhakar
>>>> <anju@linux.vnet.ibm.com>; Ravi Bangoria
>>>> <ravi.bangoria@linux.ibm.com>
>>>> Subject: [PATCH v4] tools/perf/metricgroup: Fix printing event names
>>>> of metric group with multiple events incase of overlapping events
>>>>
>>>> Commit f01642e4912b ("perf metricgroup: Support multiple events for
>>>> metricgroup") introduced support for multiple events in a metric
>>>> group. But with the current upstream, metric events names are not
>>>> printed properly incase we try to run multiple metric groups with
>> overlapping event.
>>>>
>>>> With current upstream version, incase of overlapping metric events
>>>> issue is, we always start our comparision logic from start.
>>>> So, the events which already matched with some metric group also take
>>>> part in comparision logic. Because of that when we have overlapping
>>>> events, we end up matching current metric group event with already
>> matched one.
>>>>
>>>> For example, in skylake machine we have metric event CoreIPC and
>>>> Instructions. Both of them need 'inst_retired.any' event value.
>>>> As events in Instructions is subset of events in CoreIPC, they endup
>>>> in pointing to same 'inst_retired.any' value.
>>>>
>>>> In skylake platform:
>>>>
>>>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>>>
>>>>  Performance counter stats for 'CPU(s) 0':
>>>>
>>>>      1,254,992,790      inst_retired.any          # 1254992790.0
>>>>
>> Instructions
>>>>                                                   #      1.3
>>>> CoreIPC
>>>>        977,172,805      cycles
>>>>      1,254,992,756      inst_retired.any
>>>>
>>>>        1.000802596 seconds time elapsed
>>>>
>>>> command:# sudo ./perf stat -M UPI,IPC sleep 1
>>>>
>>>>    Performance counter stats for 'sleep 1':
>>>>
>>>>            948,650      uops_retired.retire_slots
>>>>            866,182      inst_retired.any          #      0.7 IPC
>>>>            866,182      inst_retired.any
>>>>          1,175,671      cpu_clk_unhalted.thread
>>>>
>>>> Patch fixes the issue by adding a new bool pointer 'evlist_used' to
>>>> keep track of events which already matched with some group by setting it
>> true.
>>>> So, we skip all used events in list when we start comparision logic.
>>>> Patch also make some changes in comparision logic, incase we get a
>>>> match miss, we discard the whole match and start again with first
>>>> event id in metric event.
>>>>
>>>> With this patch:
>>>> In skylake platform:
>>>>
>>>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>>>
>>>>  Performance counter stats for 'CPU(s) 0':
>>>>
>>>>          3,348,415      inst_retired.any          #      0.3
>> CoreIPC
>>>>         11,779,026      cycles
>>>>          3,348,381      inst_retired.any          # 3348381.0
>>>>
>> Instructions
>>>>
>>>>        1.001649056 seconds time elapsed
>>>>
>>>> command:# ./perf stat -M UPI,IPC sleep 1
>>>>
>>>>  Performance counter stats for 'sleep 1':
>>>>
>>>>          1,023,148      uops_retired.retire_slots #      1.1 UPI
>>>>            924,976      inst_retired.any
>>>>            924,976      inst_retired.any          #      0.6 IPC
>>>>          1,489,414      cpu_clk_unhalted.thread
>>>>
>>>>        1.003064672 seconds time elapsed
>>>>
>>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Jin Yao <yao.jin@linux.intel.com>
>>>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>>>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>>  tools/perf/util/metricgroup.c | 50
>>>> ++++++++++++++++++++++-------------
>>>>  1 file changed, 31 insertions(+), 19 deletions(-)
>>>
>>> Hi Kajol,
>>>
>>> I am not sure if it is good to ask a question here :-)
>>>
>>> I encountered a perf metricgroup issue, the result is incorrect when the
>> metric includes more than 2 events.
>>>
>>> git log --oneline tools/perf/util/metricgroup.c
>>> 3635b27cc058 perf metricgroup: Fix printing event names of metric
>>> group with multiple events f01642e4912b perf metricgroup: Support
>>> multiple events for metricgroup
>>> 287f2649f791 perf metricgroup: Scale the metric result
>>>
>>> I did a simple test, below is the JSON file and result.
>>> [
>>>         {
>>>              "PublicDescription": "Calculate DDR0 bus actual utilization
>> which vary from DDR0 controller clock frequency",
>>>              "BriefDescription": "imx8qm: ddr0 bus actual utilization",
>>>              "MetricName": "imx8qm-ddr0-bus-util",
>>>              "MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ +
>> imx8_ddr0\\/write\\-cycles\\/ )",
>>>              "MetricGroup": "i.MX8QM_DDR0_BUS_UTIL"
>>>         }
>>> ]
>>> ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
>>> #           time             counts unit events
>>>      1.000104250              16720      imx8_ddr0/read-cycles/
>> #  22921.0 imx8qm-ddr0-bus-util
>>>      1.000104250               6201      imx8_ddr0/write-cycles/
>>>      2.000525625               8316      imx8_ddr0/read-cycles/
>> #  12785.5 imx8qm-ddr0-bus-util
>>>      2.000525625               2738      imx8_ddr0/write-cycles/
>>>      3.000819125               1056      imx8_ddr0/read-cycles/
>> #   4136.7 imx8qm-ddr0-bus-util
>>>      3.000819125                303      imx8_ddr0/write-cycles/
>>>      4.001103750               6260      imx8_ddr0/read-cycles/
>> #   9149.8 imx8qm-ddr0-bus-util
>>>      4.001103750               2317      imx8_ddr0/write-cycles/
>>>      5.001392750               2084      imx8_ddr0/read-cycles/
>> #   4516.0 imx8qm-ddr0-bus-util
>>>      5.001392750                601      imx8_ddr0/write-cycles/
>>>
>>> You can see that only the first result is correct, could this be reproduced at
>> you side?
>>
>> Hi Joakim,
>>         Will try to look into it from my side.
> 

> Thanks Kajol for your help, I look into this issue, but don't know how to fix it.
> 
> The results are always correct if signal event used in "MetricExpr" with "-I" parameters, but the results are incorrect when more than one events used in "MetricExpr".
> 

Hi Joakim,
    So, I try to look into this issue and understand the flow. From my understanding, whenever we do
    calculation of metric expression we don't use exact count we are getting.
    Basically we use mean value of each event in the calculation of metric expression.

So, I am taking same example you refer.

Metric Event: imx8qm-ddr0-bus-util
MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ + imx8_ddr0\\/write\\-cycles\\/ )"

command#: ./perf stat -I 1000 -M imx8qm-ddr0-bus-util

#           time             counts unit events
     1.000104250              16720      imx8_ddr0/read-cycles/    #  22921.0 imx8qm-ddr0-bus-util
     1.000104250               6201      imx8_ddr0/write-cycles/
     2.000525625               8316      imx8_ddr0/read-cycles/    #  12785.5 imx8qm-ddr0-bus-util
     2.000525625               2738      imx8_ddr0/write-cycles/
     3.000819125               1056      imx8_ddr0/read-cycles/    #   4136.7 imx8qm-ddr0-bus-util
     3.000819125                303      imx8_ddr0/write-cycles/
     4.001103750               6260      imx8_ddr0/read-cycles/    #   9149.8 imx8qm-ddr0-bus-util
     4.001103750               2317      imx8_ddr0/write-cycles/
     5.001392750               2084      imx8_ddr0/read-cycles/    #   4516.0 imx8qm-ddr0-bus-util
     5.001392750                601      imx8_ddr0/write-cycles/

If you see we have a function called 'update_stats' in file util/stat.c where we do this calculation
and updating stats->mean value. And this mean value is what we are using actually in our
metric expression calculation.

We call this function in each iteration where we update stats->mean and stats->n for each event.
But one weird issue is, for very first event, stat->n is always 1 that is why we are getting 
mean same as count.
So this is the reason for single event you get exact aggregate of metric expression.
So doesn't matter how many events you have in your metric expression, every time
you take exact count for first one and normalized value for rest which is weird.

According to update_stats function:  We are updating mean as:

stats->mean += delta / stats->n where,  delta = val - stats->mean. 

If we take write-cycles here. Initially mean = 0 and n = 1.

1st iteration: n=1, write cycle : 6201 and mean = 6201  (Final agg value: 16720 + 6201 = 22921)
2nd iteration: n=2, write cycles:  6201 + (2738 - 6201)/2 =  4469.5  (Final aggr value: 8316 + 4469.5 = 12785.5)
3rd iteration: n=3, write cycles: 4469.5 + (303 - 4469.5)/3 = 3080.6667 (Final aggr value: 1056 + 3080.6667 = 4136.7)

Andi and Jiri, I am not sure if its expected behavior. I mean shouldn't we either take mean value of each event 
or take n as 1 for each event. And one more question, Should we add an option to say whether user want exact aggregate or
this normalize aggregate to remove the confusion? I try to find it out if we already have one but didn't get.
Please let me know if my understanding is fine.

Thanks,
Kajol


> Hope you can find the root cause :-)
> 
> Best Regards,
> Joakim Zhang
>> Thanks,
>> Kajol
>>>
>>> Thanks a lot!
>>>
>>> Best Regards,
>>> Joakim Zhang
>>>
