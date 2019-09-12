Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23892B0CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfILKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 06:35:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfILKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:35:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAWq26087452
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:35:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uyh47qddq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:35:45 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 12 Sep 2019 11:35:43 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Sep 2019 11:35:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8CAZeV220709736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:35:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E083AE058;
        Thu, 12 Sep 2019 10:35:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 572CAAE051;
        Thu, 12 Sep 2019 10:35:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.206.179])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Sep 2019 10:35:39 +0000 (GMT)
Date:   Thu, 12 Sep 2019 11:35:36 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: fix typo in memblock doc
References: <20190911030856.18010-1-caoj.fnst@cn.fujitsu.com>
 <20190911144230.GB6429@linux.ibm.com>
 <59f571f6-785c-7f6e-fd03-5cfc76da27be@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f571f6-785c-7f6e-fd03-5cfc76da27be@cn.fujitsu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19091210-4275-0000-0000-00000364D55E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091210-4276-0000-0000-000038772FC3
Message-Id: <20190912103535.GB9062@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=996 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:54:09AM +0800, Cao jin wrote:
> On 9/11/19 10:42 PM, Mike Rapoport wrote:
> > On Wed, Sep 11, 2019 at 11:08:56AM +0800, Cao jin wrote:
> >> elaboarte -> elaborate
> >> architecure -> architecture
> >> compltes -> completes
> >>
> >> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> >> ---
> >>  mm/memblock.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 7d4f61ae666a..0d0f92003d18 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -83,16 +83,16 @@
> >>   * Note, that both API variants use implict assumptions about allowed
> >>   * memory ranges and the fallback methods. Consult the documentation
> >>   * of :c:func:`memblock_alloc_internal` and
> >> - * :c:func:`memblock_alloc_range_nid` functions for more elaboarte
> >> + * :c:func:`memblock_alloc_range_nid` functions for more elaborate
> > 
> > While on it, could you please replace the
> > :c:func:`memblock_alloc_range_nid` construct with
> > memblock_alloc_range_nid()?
> > 
> > And that would be really great to see all the :c:func:`foo` changed to
> > foo().
> > 
> 
> Sure. BTW, do you want convert all the markups too?
> 
>     :c:type:`foo` -> struct foo
>     %FOO -> FOO
>     ``foo`` -> foo
>     **foo** -> foo

The documentation toolchain can recognize now foo() as a function and does
not require the :c:func: prefix for that. AFAIK it only works for
functions, so please don't change the rest of the markup.
 
> -- 
> Sincerely,
> Cao jin
> 
> 

-- 
Sincerely yours,
Mike.

