Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2761E13D0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 01:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbgAPAIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 19:08:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgAPAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:08:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G07JSI023046;
        Wed, 15 Jan 2020 19:07:54 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbptb5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 19:07:53 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00G05geX001963;
        Thu, 16 Jan 2020 00:07:52 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2xj8nhst1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 00:07:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G07pKQ55116190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 00:07:51 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5533D6E04E;
        Thu, 16 Jan 2020 00:07:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2515A6E050;
        Thu, 16 Jan 2020 00:07:50 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.45.110])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 00:07:49 +0000 (GMT)
Subject: Re: [PATCH v2] Fix display of Maximum Memory
To:     Michael Bringmann <mwb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
References: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <7f8f6e88-8187-d690-13cb-dae0e47c313b@linux.ibm.com>
Date:   Wed, 15 Jan 2020 16:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_03:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 6:53 AM, Michael Bringmann wrote:
> Correct overflow problem in calculation+display of Maximum Memory
> value to syscfg where 32bits is insufficient.
> 

Probably needs the following Fixes tag:

Fixes: 772b039fd9a7 ("powerpc/pseries: Export maximum memory value")

otherwise,

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/lparcfg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index e33e8bc..f00411c 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -433,12 +433,12 @@ static void parse_em_data(struct seq_file *m)
> 
>  static void maxmem_data(struct seq_file *m)
>  {
> -	unsigned long maxmem = 0;
> +	u64 maxmem = 0;
> 
> -	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
> -	maxmem += hugetlb_total_pages() * PAGE_SIZE;
> +	maxmem += (u64)drmem_info->n_lmbs * drmem_info->lmb_size;
> +	maxmem += (u64)hugetlb_total_pages() * PAGE_SIZE;
> 
> -	seq_printf(m, "MaxMem=%ld\n", maxmem);
> +	seq_printf(m, "MaxMem=%llu\n", maxmem);
>  }
> 
>  static int pseries_lparcfg_data(struct seq_file *m, void *v)
> 

