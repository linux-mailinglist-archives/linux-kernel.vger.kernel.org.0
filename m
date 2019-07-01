Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85AD3C12F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbfFKCQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 22:16:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfFKCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:16:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B2CnTe032050
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:16:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t1yh5q98q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:16:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 11 Jun 2019 03:16:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 03:16:11 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5B2GA9H49479802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 02:16:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 282D1A4068;
        Tue, 11 Jun 2019 02:16:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256E9A4054;
        Tue, 11 Jun 2019 02:16:05 +0000 (GMT)
Received: from [9.102.1.214] (unknown [9.102.1.214])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 02:16:04 +0000 (GMT)
Subject: Re: [PATCH RESEND 1/2] tools/perf: Add arch neutral function to
 choose event for perf kvm record
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190610064518.949-1-anju@linux.vnet.ibm.com>
 <20190610151642.GT21245@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 11 Jun 2019 07:46:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610151642.GT21245@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061102-0016-0000-0000-00000287E5CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061102-0017-0000-0000-000032E5109A
Message-Id: <fb887226-52c9-3714-009f-c1c8a49197c9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/19 8:46 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 10, 2019 at 12:15:17PM +0530, Anju T Sudhakar escreveu:
>> 'perf kvm record' uses 'cycles'(if the user did not specify any event) as
>> the default event to profile the guest.
>> This will not provide any proper samples from the guest incase of
>> powerpc architecture, since in powerpc the PMUs are controlled by
>> the guest rather than the host.
>>
>> Patch adds a function to pick an arch specific event for 'perf kvm record',
>> instead of selecting 'cycles' as a default event for all architectures.
>>
>> For powerpc this function checks for any user specified event, and if there
>> isn't any it returns invalid instead of proceeding with 'cycles' event.
> 
> Michael, Ravi, Maddy, could you please provide an Acked-by, Reviewed-by
> or Tested-by?

Code looks fine to me but cross-build fails for aarch64:

  builtin-kvm.c:1513:12: error: no previous prototype for 'kvm_add_default_arch_event' [-Werror=missing-prototypes]
   int __weak kvm_add_default_arch_event(int *argc __maybe_unused,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  mv: cannot stat './.builtin-kvm.o.tmp': No such file or directory

With the build fix:
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

