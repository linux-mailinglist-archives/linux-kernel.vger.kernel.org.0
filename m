Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E1B52A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfIQQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 12:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbfIQQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:13:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HGCJC3064345;
        Tue, 17 Sep 2019 12:13:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v327r9n33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 12:13:02 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8HGCK2k064389;
        Tue, 17 Sep 2019 12:13:02 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v327r9n2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 12:13:02 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8HGAZsW013676;
        Tue, 17 Sep 2019 16:13:01 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 2v0t9asvr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 16:13:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HGCx3p45154578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 16:12:59 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 978C2136072;
        Tue, 17 Sep 2019 16:12:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D0D513606E;
        Tue, 17 Sep 2019 16:12:57 +0000 (GMT)
Received: from [9.199.41.201] (unknown [9.199.41.201])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 16:12:56 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] powerpc/mm: Conditionally call H_BLOCK_REMOVE
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190916095543.17496-1-ldufour@linux.ibm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <1ba1bfc7-66c2-5298-2ef2-4117cb72ee13@linux.ibm.com>
Date:   Tue, 17 Sep 2019 21:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916095543.17496-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 3:25 PM, Laurent Dufour wrote:
> Since the commit ba2dd8a26baa ("powerpc/pseries/mm: call H_BLOCK_REMOVE"),
> the call to H_BLOCK_REMOVE is always done if the feature is exhibited.
> 
> However, the hypervisor may not support all the block size for the hcall
> H_BLOCK_REMOVE depending on the segment base page size and actual page
> size.
> 
> When unsupported block size is used, the hcall H_BLOCK_REMOVE is returning
> H_PARAM, which is triggering a BUG_ON check leading to a panic like this:
> 
> The PAPR document specifies the TLB Block Invalidate Characteristics which
> tells for each couple segment base page size, actual page size, the size of
> the block the hcall H_BLOCK_REMOVE is supporting.
> 
> Supporting various block sizes doesn't seem needed at that time since all
> systems I was able to play with was supporting an 8 addresses block size,
> which is the maximum through the hcall, or none at all. Supporting various
> size would complexify the algorithm in call_block_remove() so unless this
> is required, this is not done.
> 
> In the case of block size different from 8, a warning message is displayed
> at boot time and that block size will be ignored checking for the
> H_BLOCK_REMOVE support.
> 
> Due to the minimal amount of hardware showing a limited set of
> H_BLOCK_REMOVE supported page size, I don't think there is a need to push
> this series to the stable mailing list.
> 
> The first patch is reading the characteristic through the hcall
> ibm,get-system-parameter and record the supported block size for each page
> size.  The second patch is changing the check used to detect the
> H_BLOCK_REMOVE availability to take care of the base page size and page
> size couple.
> 
> Changes since V1:
> 
>   - Remove penc initialisation, this is already done in
>     mmu_psize_set_default_penc()
>   - Add details on the TLB Block Invalidate Characteristics's buffer format
>   - Introduce #define instead of using direct numerical values
>   - Function reading the characteristics is now directly called from
>     pSeries_setup_arch()
>   - The characteristics are now stored in a dedciated table static to lpar.c
> 

you can use

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

for the series.

-aneesh
