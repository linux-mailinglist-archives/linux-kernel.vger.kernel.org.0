Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8489F11D591
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfLLSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:30:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfLLSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:30:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCILdfF065095;
        Thu, 12 Dec 2019 18:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=jdYlNasovEzctO/D5dYLkQh+fKQP1bnYDPj0kFsSE5Y=;
 b=htkMrFA6M2V9m5APanf/ZIvNE8zC7AMFkbbGOotIifbreTkA3TBSx/0WrO8SuSHABDUH
 jE377f7BFwyhyqaUCQyix3dvagOgRJp2WAQKIlADlNo7npkYronyB4+R26QtxXFh19S6
 ewEJzhhMtckB7fhPUmf1PcL46S3uE57/2rGOolAhouMHtQp+KveiV9JmkbQWYiQN2eqt
 +QqkDXRLyn3d4a4oBQ6RLjKfoulqddfv7rjeRACb96hONymMDhqWXdVlnt3wx/u+Jhx3
 Z5lwpwM5vIaLhpRdjSAK5sNBnnSa07A7rUbJ3v4p3J8EDq9aTLLVl84K2YlzeeOeOhCR 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wrw4nhnr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 18:30:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCILFq9146342;
        Thu, 12 Dec 2019 18:30:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wums9tawx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 18:30:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCIU5Rx017566;
        Thu, 12 Dec 2019 18:30:05 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 10:30:05 -0800
Subject: Re: [PATCH] xen/balloon: fix ballooned page accounting without
 hotplug enabled
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20191212141750.1896-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <65142ae8-66ff-56f5-b2ca-9791c6c47289@oracle.com>
Date:   Thu, 12 Dec 2019 13:30:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191212141750.1896-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/19 9:17 AM, Juergen Gross wrote:
> When CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not defined
> reserve_additional_memory() will set balloon_stats.target_pages to a
> wrong value in case there are still some ballooned pages allocated via
> alloc_xenballooned_pages().
>
> This will result in balloon_process() no longer be triggered when
> ballooned pages are freed in batches.
>
> Reported-by: Nicholas Tsirakis <niko.tsirakis@gmail.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


