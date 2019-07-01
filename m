Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68C72E4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfE2SqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 14:46:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2SqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:46:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIhrIS067356;
        Wed, 29 May 2019 18:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Up1cNIFFuc0gcQ797CpxaLKPJsnQBzZUtc04vOlvi54=;
 b=MkI1d9HHwYgDzT6yM0ArD2VvvJiVyJKogI3qHgMF5OOb6TnaxCvoh1YuSLdW+nBIqERC
 U1SYmdCwrcXdlol6VeT+n+mx9DLHBBJBIcCl6rsHhYMvJOVTpiRJsYuATL/ydWy38yHa
 aXWEvLqnZlAv+mNnRq0Dzm18CHEDldJe0y3IsVOoxV8u3XI/ZRmzotN7PNTUcjSeAP5h
 B6JIHb2Z8/LRzle5FbDPk15hARZ57J65H7aksS8TtquiU2xqcuflhb1jJtO+7Arkcyub
 N5l/kHvnr7jRk+Vu8oXxHuLWYkYiom6mteVeM63Rsr4+EOJspR6aon/BCv9KTg4BFlK6 uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2spxbqbr4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:45:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIi2Uu062527;
        Wed, 29 May 2019 18:45:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sr31ved92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:45:48 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TIjihN008886;
        Wed, 29 May 2019 18:45:44 GMT
Received: from [192.168.1.222] (/71.63.128.209) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 29 May 2019 11:44:52 -0700
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <81a37f9c-4a85-c18d-b882-f361c4998d45@oracle.com>
Date:   Wed, 29 May 2019 11:44:50 -0700 (PDT)
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: hugetlb: soft-offline: fix wrong return value of
 soft offline
References: <1558937200-18544-1-git-send-email-n-horiguchi@ah.jp.nec.com>
In-Reply-To: <1558937200-18544-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/19 11:06 PM, Naoya Horiguchi wrote:
> Soft offline events for hugetlb pages return -EBUSY when page migration
> succeeded and dissolve_free_huge_page() failed, which can happen when
> there're surplus hugepages. We should judge pass/fail of soft offline by
> checking whether the raw error page was finally contained or not (i.e.
> the result of set_hwpoison_free_buddy_page()), so this behavior is wrong.
> 
> This problem was introduced by the following change of commit 6bc9b56433b76
> ("mm: fix race on soft-offlining"):
> 
>                     if (ret > 0)
>                             ret = -EIO;
>             } else {
>     -               if (PageHuge(page))
>     -                       dissolve_free_huge_page(page);
>     +               /*
>     +                * We set PG_hwpoison only when the migration source hugepage
>     +                * was successfully dissolved, because otherwise hwpoisoned
>     +                * hugepage remains on free hugepage list, then userspace will
>     +                * find it as SIGBUS by allocation failure. That's not expected
>     +                * in soft-offlining.
>     +                */
>     +               ret = dissolve_free_huge_page(page);
>     +               if (!ret) {
>     +                       if (set_hwpoison_free_buddy_page(page))
>     +                               num_poisoned_pages_inc();
>     +               }
>             }
>             return ret;
>      }
> 
> , so a simple fix is to restore the PageHuge precheck, but my code
> reading shows that we already have PageHuge check in
> dissolve_free_huge_page() with hugetlb_lock, which is better place to
> check it.  And currently dissolve_free_huge_page() returns -EBUSY for
> !PageHuge but that's simply wrong because that that case should be
> considered as success (meaning that "the given hugetlb was already
> dissolved.")

Hello Naoya,

I am having a little trouble understanding the situation.  The code above is
in the routine soft_offline_huge_page, and occurs immediately after a call to
migrate_pages() with 'page' being the only on the list of pages to be migrated.
In addition, since we are in soft_offline_huge_page, we know that page is
a huge page (PageHuge) before the call to migrate_pages.

IIUC, the issue is that the migrate_pages call results in 'page' being
dissolved into regular base pages.  Therefore, the call to
dissolve_free_huge_page returns -EBUSY and we never end up setting PageHWPoison
on the (base) page which had the error.

It seems that for the original page to be dissolved, it must go through the
free_huge_page routine.  Once that happens, it is possible for the (dissolved)
pages to be allocated again.  Is that just a known race, or am I missing
something?

> This change affects other callers of dissolve_free_huge_page(),
> which are also cleaned up by this patch.

It may just be me, but I am having a hard time separating the fix for this
issue from the change to the dissolve_free_huge_page routine.  Would it be
more clear or possible to create separate patches for these?

-- 
Mike Kravetz
