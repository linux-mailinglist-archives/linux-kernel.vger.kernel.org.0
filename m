Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5115D2CC36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfE1Qiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:38:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfE1Qiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:38:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SGXXVo150029
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 12:38:49 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ss6w1n115-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 12:38:49 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nathanl@linux.ibm.com>;
        Tue, 28 May 2019 17:38:48 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 17:38:46 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SGcjKd20316458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:38:45 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37FA9BE051;
        Tue, 28 May 2019 16:38:45 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCDFBE04F;
        Tue, 28 May 2019 16:38:45 +0000 (GMT)
Received: from localhost (unknown [9.41.179.236])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 May 2019 16:38:44 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Gen Zhang <blackgod016574@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlpar: Fix a missing-check bug in dlpar_parse_cc_property()
In-Reply-To: <20190526024240.GA14546@zhanggen-UX430UQ>
References: <20190526024240.GA14546@zhanggen-UX430UQ>
Date:   Tue, 28 May 2019 11:38:44 -0500
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052816-0004-0000-0000-000015153B8B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011175; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209865; UDB=6.00635602; IPR=6.00990894;
 MB=3.00027088; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 16:38:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052816-0005-0000-0000-00008BD7075B
Message-Id: <87blzm4jqj.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gen Zhang <blackgod016574@gmail.com> writes:
> In dlpar_parse_cc_property(), 'prop->name' is allocated by kstrdup().
> kstrdup() may return NULL, so it should be checked and handle error.
> And prop should be freed if 'prop->name' is NULL.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 1795804..c852024 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -61,6 +61,10 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
>  
>  	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>  	prop->name = kstrdup(name, GFP_KERNEL);
> +	if (!prop->name) {
> +		dlpar_free_cc_property(prop);
> +		return NULL;
> +	}

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

