Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F4BF03A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbfKERBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 12:01:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388488AbfKERBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:01:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5GwgPf049840
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 12:01:21 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3afaew6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:01:20 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hbathini@linux.ibm.com>;
        Tue, 5 Nov 2019 17:01:15 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 17:01:12 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA5H0b2a15139156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 17:00:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E2D11C04C;
        Tue,  5 Nov 2019 17:01:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 390C011C054;
        Tue,  5 Nov 2019 17:01:10 +0000 (GMT)
Received: from [9.199.51.136] (unknown [9.199.51.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Nov 2019 17:01:09 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] Documentation/ABI: mark /sys/kernel/fadump_* sysfs
 files deprecated
To:     Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
Cc:     corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
References: <20191018130557.2217-1-sourabhjain@linux.ibm.com>
 <20191018130557.2217-4-sourabhjain@linux.ibm.com>
 <f69daa7b-ddb3-8190-c409-28a22c504fed@linux.ibm.com>
 <b1bc42cc-8d80-d104-b1b3-684c08531c78@linux.ibm.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Date:   Tue, 5 Nov 2019 22:31:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b1bc42cc-8d80-d104-b1b3-684c08531c78@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110517-0012-0000-0000-00000360F5A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110517-0013-0000-0000-0000219C4FB8
Message-Id: <d0a34f71-1b78-e387-c3a5-d771995a91f6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/19 2:24 PM, Sourabh Jain wrote:
> 
> 
> On 10/21/19 1:11 PM, Hari Bathini wrote:
>>
>>
>> On 18/10/19 6:35 PM, Sourabh Jain wrote:
>>> The /sys/kernel/fadump_* sysfs files are replicated under
>>
>> [...]
>>
>>> +Note: The following FADump sysfs files are deprecated.
>>> +
>>> +    Deprecated                       Alternative
>>> +    -------------------------------------------------------------------------------
>>> +    /sys/kernel/fadump_enabled           /sys/kernel/fadump/fadump_enabled
>>> +    /sys/kernel/fadump_registered        /sys/kernel/fadump/fadump_registered
>>> +    /sys/kernel/fadump_release_mem       /sys/kernel/fadump/fadump_release_mem
>>
>> /sys/kernel/fadump/* looks tidy instead of /sys/kernel/fadump/fadump_* 
>> I mean, /sys/kernel/fadump/fadump_enabled => /sys/kernel/fadump/enabled and such..
> 
> 
> 
> Could you please confirm whether you want to address the sysfs file path differently or
> actually changing the sysfs file name from fadump_enabled to enabled.

I meant, given the path "/sys/kernel/fadump/", the prefix fadump_ is redundant.
If there are no conventions that we should retain the same file name, I suggest
to drop the fadump_ prefix and just call them enabled, registered, etc..

- Hari

