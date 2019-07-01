Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958E927553
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 07:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfEWFPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 01:15:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbfEWFPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:15:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N59SUi028323
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:15:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2snmye0htv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:15:16 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 23 May 2019 06:15:15 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 06:15:12 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4N5FBwT38535290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 05:15:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CD3AC065;
        Thu, 23 May 2019 05:15:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6841AC05E;
        Thu, 23 May 2019 05:15:08 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.216.227])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 23 May 2019 05:15:08 +0000 (GMT)
References: <20190521044912.1375-1-bauerman@linux.ibm.com> <20190521044912.1375-12-bauerman@linux.ibm.com> <20190521051507.GD29120@lst.de>
User-agent: mu4e 1.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/12] powerpc/pseries/svm: Force SWIOTLB for secure guests
In-reply-to: <20190521051507.GD29120@lst.de>
Date:   Thu, 23 May 2019 02:15:04 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052305-0072-0000-0000-00000432235B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011146; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207291; UDB=6.00634029; IPR=6.00988272;
 MB=3.00027013; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-23 05:15:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052305-0073-0000-0000-00004C53FAC6
Message-Id: <87y32xzr8n.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=947 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Christoph,

Thanks for reviewing the patch!

Christoph Hellwig <hch@lst.de> writes:

>> diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
>> new file mode 100644
>> index 000000000000..45d5e4d0e6e0
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/mem_encrypt.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * SVM helper functions
>> + *
>> + * Copyright 2019 IBM Corporation
>> + */
>> +
>> +#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
>> +#define _ASM_POWERPC_MEM_ENCRYPT_H
>> +
>> +#define sme_me_mask	0ULL
>> +
>> +static inline bool sme_active(void) { return false; }
>> +static inline bool sev_active(void) { return false; }
>> +
>> +int set_memory_encrypted(unsigned long addr, int numpages);
>> +int set_memory_decrypted(unsigned long addr, int numpages);
>> +
>> +#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
>
> S/390 seems to be adding a stub header just like this.  Can you please
> clean up the Kconfig and generic headers bits for memory encryption so
> that we don't need all this boilerplate code?

Yes, that's a good idea. Will do.

>>  config PPC_SVM
>>  	bool "Secure virtual machine (SVM) support for POWER"
>>  	depends on PPC_PSERIES
>> +	select SWIOTLB
>> +	select ARCH_HAS_MEM_ENCRYPT
>>  	default n
>
> n is the default default, no need to explictly specify it.

Indeed. Changed for the next version.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

