Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9FFAA00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 07:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 01:03:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbfKMGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:03:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAD5wZ7Y070716;
        Wed, 13 Nov 2019 01:02:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8bd2hcqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 01:02:32 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAD5wkCa071288;
        Wed, 13 Nov 2019 01:02:31 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8bd2hcpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 01:02:31 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAD5p9D5012664;
        Wed, 13 Nov 2019 06:02:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 2w5n36dcqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 06:02:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAD62SMP62980558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 06:02:28 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CFA86E058;
        Wed, 13 Nov 2019 06:02:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FF46E056;
        Wed, 13 Nov 2019 06:02:23 +0000 (GMT)
Received: from [9.199.46.219] (unknown [9.199.46.219])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 06:02:23 +0000 (GMT)
Subject: Re: [PATCH 04/16] libnvdimm: Move nd_numa_attribute_group to
 device_type
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87h839tpo9.fsf@linux.ibm.com>
 <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <738e328b-9a9b-b297-8379-f0d72d06c5c9@linux.ibm.com>
Date:   Wed, 13 Nov 2019 11:32:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 6:56 AM, Dan Williams wrote:
> On Tue, Nov 12, 2019 at 1:23 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> A 'struct device_type' instance can carry default attributes for the
>>> device. Use this facility to remove the export of
>>> nd_numa_attribute_group and put the responsibility on the core rather
>>> than leaf implementations to define this attribute.
>>>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>>
>> can we also expose target_node in a similar way? This allows application
>> to better understand the node locality of the SCM device.
> 
> It is already exported for device-dax instances. See
> DEVICE_ATTR_RO(target_node) in drivers/dax/bus.c. I did not see a use
> case for it to be exported for other nvdimm device types.
> 

some applications do want to access the fsdax namspace as different 
mount points based on numa affinity. If can differentiate the two 
regions with different target_node and same numa_node, that will help 
them better isolate these mounts.

-aneesh
