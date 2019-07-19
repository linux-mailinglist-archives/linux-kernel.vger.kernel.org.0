Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8676D7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 02:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGSAsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 20:48:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfGSAsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:48:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6J0lo5P133219
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:48:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttxpp23fq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:48:44 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 19 Jul 2019 01:48:43 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 01:48:41 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6J0meCY49283430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 00:48:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA68112063;
        Fri, 19 Jul 2019 00:48:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96AED11206E;
        Fri, 19 Jul 2019 00:48:37 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Jul 2019 00:48:37 +0000 (GMT)
References: <20190713060023.8479-1-bauerman@linux.ibm.com> <20190713060023.8479-4-bauerman@linux.ibm.com> <70f8097f-7222-fe18-78b4-9372c21bfc9d@ozlabs.ru> <20190718195850.GU20882@gate.crashing.org> <875znz3ud7.fsf@morokweng.localdomain> <f4cba627-8c40-ce95-0ede-b01edf3546dc@ozlabs.ru>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/13] powerpc/prom_init: Add the ESM call to prom_init
In-reply-to: <f4cba627-8c40-ce95-0ede-b01edf3546dc@ozlabs.ru>
Date:   Thu, 18 Jul 2019 21:48:34 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071900-0060-0000-0000-00000362F0AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011455; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234164; UDB=6.00650361; IPR=6.01015491;
 MB=3.00027788; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-19 00:48:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071900-0061-0000-0000-00004A3500A0
Message-Id: <874l3i4zod.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=729 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 19/07/2019 07:28, Thiago Jung Bauermann wrote:
>>
>> Hello Segher,
>>
>> Thanks for your review and suggestions!
>>
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>>
>>> (Sorry to hijack your reply).
>>>
>>> On Thu, Jul 18, 2019 at 06:11:48PM +1000, Alexey Kardashevskiy wrote:
>>>> On 13/07/2019 16:00, Thiago Jung Bauermann wrote:
>>>>> From: Ram Pai <linuxram@us.ibm.com>
>>>>> +static int enter_secure_mode(unsigned long kbase, unsigned long fdt)
>>>>> +{
>>>>> +	register uint64_t func asm("r3") = UV_ESM;
>>>>> +	register uint64_t arg1 asm("r4") = (uint64_t)kbase;
>>>>> +	register uint64_t arg2 asm("r5") = (uint64_t)fdt;
>>>>
>>>> What does UV do with kbase and fdt precisely? Few words in the commit
>>>> log will do.
>
>
> What about this one? :)

Sorry, I don't have an elaborate answer yet. The non-elaborate answer is
that the ultravisor uses the kbase and fdt as part of integrity checking
of the secure guest.

--
Thiago Jung Bauermann
IBM Linux Technology Center

