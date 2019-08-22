Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE17994EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfHVN0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387656AbfHVN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:26:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MDPGsu045983
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:26:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhuce1ps4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:26:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 22 Aug 2019 14:26:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 14:26:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MDQ5uY47710246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 13:26:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78A7D4C04E;
        Thu, 22 Aug 2019 13:26:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12A4D4C050;
        Thu, 22 Aug 2019 13:26:05 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Aug 2019 13:26:04 +0000 (GMT)
Date:   Thu, 22 Aug 2019 16:26:03 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/init-mm.c: use CPU_BITS_NONE to initialize .cpu_bitmap
References: <20190822075207.26400-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822075207.26400-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082213-0012-0000-0000-0000034182BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082213-0013-0000-0000-0000217BAE03
Message-Id: <20190822132602.GF18872@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 22, 2019 at 09:52:07AM +0200, Rasmus Villemoes wrote:
> init_mm is sizeof(long) larger than it needs to be. Use the
> CPU_BITS_NONE macro meant for this, which will initialize just the
> indices 0...(BITS_TO_LONGS(NR_CPUS)-1) and hence make the array size
> actually BITS_TO_LONGS(NR_CPUS).

I've sent a similar patch [1] a week or so ago, it's in -mm tree.

[1] https://lore.kernel.org/linux-mm/1565703815-8584-1-git-send-email-rppt@linux.ibm.com/
 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  mm/init-mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index a787a319211e..fb1e15028ef0 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -35,6 +35,6 @@ struct mm_struct init_mm = {
>  	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
>  	.user_ns	= &init_user_ns,
> -	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
> +	.cpu_bitmap	= CPU_BITS_NONE,
>  	INIT_MM_CONTEXT(init_mm)
>  };
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.

