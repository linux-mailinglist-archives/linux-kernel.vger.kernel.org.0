Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC4A3616
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfH3Lzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:55:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfH3Lzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:55:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UBrkx2133927;
        Fri, 30 Aug 2019 11:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TtrLLU1GIdSPJmXiACh2hG5cwJbVveNPNY/SeFtoPUA=;
 b=FZ0EekVQb9qQXrF+Jgc63Dt/JxSoTZnX7sK6a3UMBWQCQTUZoXy0NO9teMUY1x7Hjz0e
 VkeJriitwGHGvQzqBt9ts1Nb4YeydVR9LR9Epjf2Kt0uP6A+4vDEwQd2qhL1DjJ1yTH9
 3T02BMWnq3d+LURGKMhZ8U3zlhy4cA00kIvYbUsMCoGkk95kAnLSrh5j51ybVQ1hy2AD
 oLYQ4DDGLJbHFT6S9sVjYU4SN+LLWXWanxng2hcHKBskaEBG++hU5dsFbB5uSfIBj9bB
 muEKbmBBXCWVnbzIXK70QGJ2qdkC7Qu+gU+O9ZZomUExiJOjlhTBwiUc2c2EISB9SWEV lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uq38x01cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:55:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UBrdCr137639;
        Fri, 30 Aug 2019 11:55:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uphav3en9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:55:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7UBtL1J028456;
        Fri, 30 Aug 2019 11:55:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 04:55:20 -0700
Date:   Fri, 30 Aug 2019 14:55:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v3 6/7] erofs: remove all likely/unlikely annotations
Message-ID: <20190830115509.GN23584@kadam>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-6-gaoxiang25@huawei.com>
 <4f2d6464-39f0-4134-f7ba-eec3b09b22d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2d6464-39f0-4134-f7ba-eec3b09b22d8@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:25:13PM +0800, Chao Yu wrote:
> On 2019/8/30 11:36, Gao Xiang wrote:
> > As Dan Carpenter suggested [1], I have to remove
> > all erofs likely/unlikely annotations.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20190829154346.GK23584@kadam/
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> I suggest we can modify this by following good example rather than removing them
> all, at least, the fuzzed random fields of disk layout handling should be very
> rare case, I guess it's fine to use unlikely.

No, no...  It's the opposite.  Only use those annotations on fast paths
where it's going to show up in benchmarks.  On fast paths then remove
all the debug code and really optimize the heck out of the code.  We
sacrifice readability for speed in places where it matters.

regards,
dan carpenter

