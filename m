Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1716A7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBXOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 09:05:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbgBXOFK (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:05:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ODxM0Y116452
        for <Linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:05:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b7asfg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:05:09 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 24 Feb 2020 14:05:07 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 14:05:03 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01OE525U31785430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 14:05:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 710544C046;
        Mon, 24 Feb 2020 14:05:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2036F4C04A;
        Mon, 24 Feb 2020 14:04:58 +0000 (GMT)
Received: from [9.199.54.250] (unknown [9.199.54.250])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 14:04:57 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
 <20200224135141.GH16664@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 24 Feb 2020 19:34:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224135141.GH16664@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022414-4275-0000-0000-000003A4FF8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022414-4276-0000-0000-000038B912B1
Message-Id: <e8f944f5-0cca-44d3-dec2-3985e72bacc8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_04:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/20 7:21 PM, Jiri Olsa wrote:
> On Mon, Feb 24, 2020 at 06:55:12PM +0530, Ravi Bangoria wrote:
>> Hi Jin,
>>
>> On 2/24/20 7:52 AM, Jin Yao wrote:
>>> For perf report on stripped binaries it is currently impossible to do
>>> annotation. The annotation state is all tied to symbols, but there are
>>> either no symbols, or symbols are not covering all the code.
>>>
>>> We should support the annotation functionality even without symbols.
>>>
>>> This patch fakes a symbol and the symbol name is the string of address.
>>> After that, we just follow current annotation working flow.
>>>
>>> For example,
>>>
>>> 1. perf report
>>>
>>> Overhead  Command  Shared Object     Symbol
>>>     20.67%  div      libc-2.27.so      [.] __random_r
>>>     17.29%  div      libc-2.27.so      [.] __random
>>>     10.59%  div      div               [.] 0x0000000000000628
>>>      9.25%  div      div               [.] 0x0000000000000612
>>>      6.11%  div      div               [.] 0x0000000000000645
>>>
>>> 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
>>>
>>> Annotate 0x0000000000000628
>>> Zoom into div thread
>>> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
>>> Browse map details
>>> Run scripts for samples of symbol [0x0000000000000628]
>>> Run scripts for all samples
>>> Switch to another data file in PWD
>>> Exit
>>>
>>> 3. Select the "Annotate 0x0000000000000628" and ENTER.
>>>
>>> Percent│
>>>          │
>>>          │
>>>          │     Disassembly of section .text:
>>>          │
>>>          │     0000000000000628 <.text+0x68>:
>>>          │       divsd %xmm4,%xmm0
>>>          │       divsd %xmm3,%xmm1
>>>          │       movsd (%rsp),%xmm2
>>>          │       addsd %xmm1,%xmm0
>>>          │       addsd %xmm2,%xmm0
>>>          │       movsd %xmm0,(%rsp)
>>>
>>> Now we can see the dump of object starting from 0x628.
>>
>> If I press 'a' on address, it's not annotating. But if I annotate
>> by pressing enter, like you explained, it works. Is it intentional?
> 
> I saw that too, but I thought it's unrelated issue,
> because we played with that just recently
> 
> if you go through the 'enter' way and back, then the
> next time 'a' works ;-)

Yes.

I liked the series so I was trying out the patches. Just reporting issues I found...

jump/call arrows are also screwed up.. Like jump instruction is showing call arrows.
But these all are minor issues and can be fixed later on. I don't mind ;)

Ravi

