Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0AD5A05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfJNDo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 23:44:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729621AbfJNDo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:44:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9E3g4ac140853
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:44:26 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vm96v9c0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:44:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 14 Oct 2019 04:44:24 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Oct 2019 04:44:21 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9E3hnBm27263402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 03:43:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84F66A405C;
        Mon, 14 Oct 2019 03:44:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDEA0A406A;
        Mon, 14 Oct 2019 03:44:18 +0000 (GMT)
Received: from [9.124.31.69] (unknown [9.124.31.69])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Oct 2019 03:44:18 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
 <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
 <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
 <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
 <8d0ad57b-72ad-b77c-d558-86b46982ddeb@linux.ibm.com>
 <b1defb08-6983-b909-9011-71753905fa02@c-s.fr>
Date:   Mon, 14 Oct 2019 09:14:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b1defb08-6983-b909-9011-71753905fa02@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101403-0016-0000-0000-000002B7C5F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101403-0017-0000-0000-00003318DD19
Message-Id: <65e1c9b3-5cdf-1e51-0086-23cdc4e14bb1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/19 1:01 PM, Christophe Leroy wrote:
> 
> 
> Le 10/10/2019 à 08:25, Ravi Bangoria a écrit :
>>
>>
>> On 10/10/19 10:14 AM, Ravi Bangoria wrote:
>>>
>>>>> @Christophe, Is patch5 works for you on 8xx?
>>>>>
>>>>
>>>> Getting the following :
>>>>
>>>> root@vgoip:~# ./ptrace-hwbreak
>>>> test: ptrace-hwbreak
>>>> tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
>>>> PTRACE_SET_DEBUGREG, WO, len: 1: Ok
>>>> PTRACE_SET_DEBUGREG, WO, len: 2: Ok
>>>> PTRACE_SET_DEBUGREG, WO, len: 4: Ok
>>>> PTRACE_SET_DEBUGREG, WO, len: 8: Ok
>>>> PTRACE_SET_DEBUGREG, RO, len: 1: Ok
>>>> PTRACE_SET_DEBUGREG, RO, len: 2: Ok
>>>> PTRACE_SET_DEBUGREG, RO, len: 4: Ok
>>>> PTRACE_SET_DEBUGREG, RO, len: 8: Ok
>>>> PTRACE_SET_DEBUGREG, RW, len: 1: Ok
>>>> PTRACE_SET_DEBUGREG, RW, len: 2: Ok
>>>> PTRACE_SET_DEBUGREG, RW, len: 4: Ok
>>>> PTRACE_SET_DEBUGREG, RW, len: 8: Ok
>>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
>>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
>>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
>>>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>>>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
>>>> failure: ptrace-hwbreak
>>>>
>>>
>>> Thanks Christophe. I don't have any 8xx box. I checked qemu and it seems
>>> qemu emulation for 8xx is not yet supported. So I can't debug this. Can
>>> you please check why it's failing?
>>
>> PPC_PTRACE_SETHWDEBUG internally uses DAWR register and probably 8xx does
>> not emulate DAWR logic, it only uses DABR to emulate double-word watchpoint.
>> In that case, all testcases that uses PPC_PTRACE_SETHWDEBUG should be
>> disabled for 8xx. I'll change [PATCH 5] accordingly and resend.
> 
> I think the MODE_EXACT ones are OK with the 8xx at the time being.

Ok. I'll disable other tests for 8xx.

Also, I was bit wrong in above point. Actually, PPC_PTRACE_SETHWDEBUG with RANGE
breakpoint also support DABR but the length will be 8 only. So I've to change my
patch 1 also a bit (ptrace stuff). I'll resend the series with these changes.

> 
>>
>> Also, do you think I should fix hw_breakpoint_validate_len() from [PARCH 1]
>> for 8xx? I re-checked you recent patch* to allow any address range size for
>> 8xx. With that patch, hw_breakpoint_validate_len() won't get called at all
>> for 8xx.
> 
> At the time being, the 8xx emulates DABR so it has the same limitations as BOOK3S.
> My patch needs to be rebased on top of your series and I think it needs some modifications, as it seems it doesn't properly handle size 1 and size 2 breakpoints at least.
> So I think that you should leave your Patch1 as is, and I'll modify the validate_len() logic while rebasing my patch.

Sure. Thanks for helping!

Ravi

