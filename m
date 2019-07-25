Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B364E7564E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfGYRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 13:53:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfGYRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:53:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PHnKbJ049589;
        Thu, 25 Jul 2019 17:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DskHihDhKZA/Fq49qJO0doPSez/fz+BiwP1T46flO+o=;
 b=TNR0nbQwsPhmhhzkN0XUOm5DyKGABJasfZRd7Z3WKP6L/vhGuqsUMHlInDffuEh7W28Z
 KIDc+dm+C3T+9II5FiOqa3IwgwVXtha/9m8rsk/+yatq4RDhFIZ4RJ7DdD5zmfDpvEx6
 mjK126Mt2HCph8FaAipzai7ur36yOS7bBasUUtAhNgnS2R1lCSd1V1AYvEBt9JisQYPg
 7CZK3qM2LbHPH7ILg4tMxPgmeAzoyJVR3vUqGC7jPc/OR5SM/siA1YRGejnRuUFkeJV5
 EzkFQ86fGGOcZ4fO1wBBbmb83ipXRzZIWN9TueKgFQ5C6D+M554PToE4ThICS1Pp42jW jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tx61c5n0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:53:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PHrOv6172739;
        Thu, 25 Jul 2019 17:53:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tx60yf6jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:53:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PHrl8Q017808;
        Thu, 25 Jul 2019 17:53:48 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 10:53:47 -0700
Subject: Re: [PATCH] mm/hugetlb.c: check the failure case for find_vma
To:     Navid Emamdoost <navid.emamdoost@gmail.com>, emamd001@umn.edu
Cc:     kjlu@umn.edu, smccaman@umn.edu, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190725013944.20661-1-navid.emamdoost@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <44c005c2-2b4f-d1da-0437-fe4c90f883ae@oracle.com>
Date:   Thu, 25 Jul 2019 10:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725013944.20661-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250211
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 6:39 PM, Navid Emamdoost wrote:
> find_vma may fail and return NULL. The null check is added.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  mm/hugetlb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ede7e7f5d1ab..9c5e8b7a6476 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4743,6 +4743,9 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>  {
>  	struct vm_area_struct *vma = find_vma(mm, addr);
> +	if (!vma)
> +		return (pte_t *)pmd_alloc(mm, pud, addr);
> +

Hello Navid,

You should not mix declarations and code like this.  I am surprised that your
compiler did not issue a warning such as:

mm/hugetlb.c: In function ‘huge_pmd_share’:
mm/hugetlb.c:4815:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  struct address_space *mapping = vma->vm_file->f_mapping;
  ^~~~~~

While it is true that the routine find_vma can return NULL.  I do not
believe it is possible here within the context of huge_pmd_share.  Why?

huge_pmd_share is called from huge_pte_alloc to allocate a page table
entry for a huge page.  So, the calling code is attempting to populate
page tables.  There are three callers of huge_pte_alloc: hugetlb_fault,
copy_hugetlb_page_range and __mcopy_atomic_hugetlb.  In each of these
routines (or their callers) it has been verified that address is within
a vma.  In addition, mmap_sem is held so that vmas can not change.
Therefore, there should be no way for find_vma to return NULL here.

Please let me know if there is something I have overlooked.  Otherwise,
there is no need for such a modification.
-- 
Mike Kravetz

>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
>  			vma->vm_pgoff;
> 
