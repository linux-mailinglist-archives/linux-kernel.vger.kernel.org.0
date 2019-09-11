Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECAB04FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfIKUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 16:44:14 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:30342 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbfIKUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:44:14 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BKgCNh005514;
        Wed, 11 Sep 2019 20:43:53 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uxg74nmvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 20:43:53 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 4B97453;
        Wed, 11 Sep 2019 20:43:51 +0000 (UTC)
Received: from [16.116.129.27] (unknown [16.116.129.27])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A2A064A;
        Wed, 11 Sep 2019 20:43:49 +0000 (UTC)
Subject: Re: [PATCH 4/8] x86/platform/uv: Setup UV functions for Hubless UV
 Systems
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
 <20190910145839.975787119@stormcage.eag.rdlabs.hpecorp.net>
 <20190911060702.GD104115@gmail.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <e3a3d64d-87ff-d6de-c550-9a3249b687dd@hpe.com>
Date:   Wed, 11 Sep 2019 13:44:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911060702.GD104115@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_10:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=788 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909110186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2019 11:07 PM, Ingo Molnar wrote:
> 
> * Mike Travis <mike.travis@hpe.com> wrote:
> 
>> +/* Initialize UV hubless systems */
>> +static __init int uv_system_init_hubless(void)
>> +{
>> +	int rc;
>> +
>> +	/* Setup PCH NMI handler */
>> +	uv_nmi_setup_hubless();
>> +
>> +	/* Init kernel/BIOS interface */
>> +	rc = uv_bios_init();
>> +
>> +	return rc;
>> +}

This looks like an excessive cleanup error by me.  The original was:

> +static __init int uv_system_init_hubless(void)
> +{
> +       int rc;
> +
> +       /* Setup PCH NMI handler */
> +       uv_nmi_setup_hubless();
> +
> +       /* Init kernel/BIOS interface */
> +       rc = uv_bios_init();
> +
> +       /* Create user access node if UVsystab available */
> +       if (rc >= 0)
> +               uv_setup_proc_files(1);
> +
> +       return rc;
> +}
> +

Hubbed UV's do not have a non-UV BIOS, but hubless systems in theory 
can.   So uv_bios_init can fail on hubless systems if it has some other 
BIOS (unlikely but possible).  So I removed too much in this cleanup. 
I'll send another patch set to puts this back.

Thanks,
Mike

> 
> Am I the only one who immediately sees the trivial C transformation
> through which this function could lose a local variable and become 4
> lines shorter?
> 
> And this function got two Reviewed-by tags...
> 
> Thanks,
> 
> 	Ingo
> 
