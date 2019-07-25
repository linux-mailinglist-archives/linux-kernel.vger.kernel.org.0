Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2F75733
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfGYSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 14:47:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:47:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PIiWRc181291;
        Thu, 25 Jul 2019 18:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=5qU/Fe+8xOFw3FzqewT52qMNow/Avftd+51eq3XJq7g=;
 b=iBroo4p4xMRs2okfFFxJ85QuFg84tmDCbeqqVwmOYqpyis6gSXWiK8R3MxbQjuF8OFd2
 Fy8CiB64uUlvLeC7ZQ7KngOa6v63fQxjNFEHbhfkcluufO7bTWA7B8588wdrb9D6cJMx
 2znNTgl78/ZmQNajHerbotB2iXb0qE07FVNV6g6sUQMOeOvWuV6l5GaBP42ulHbgzVZt
 Oclq8Qec2CUXwKvykelfF2DnwPkrHgWOAESfkP3/DIyzasW6jHjY3TAeYMqiuGwBPYnQ
 ndNSoh8wt3kPQY4Brh1Aai8YcrupsKHqI6m/QG9a7juaqZMCebsOv3AKOK3uLz69mHog FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61c5w7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 18:47:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PIgt8B189261;
        Thu, 25 Jul 2019 18:47:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tycv73meg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 18:47:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PIl6Zh019097;
        Thu, 25 Jul 2019 18:47:07 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 11:47:06 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 610816A0133; Thu, 25 Jul 2019 14:49:05 -0400 (EDT)
Date:   Thu, 25 Jul 2019 14:49:05 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) for-linus-5.3
Message-ID: <20190725184905.GA28374@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

I've sent you a prior git pull which contained two of the fixes, and this
one expands on the one from Juergen which had been committed a while ago
but hadn't been fully tested until during the merge window so I delayed
until now.

Please git pull the following branch:

git push gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/konrad/swiotlb.git for/linus-5.3

which contains fixes for properly determining if the SWIOTLB is actually enabled on ARM
platforms, compiler fixes, and corruption fix when used with Xen where
we would have inconsistent mappings of multiple PFNs to the same MFN when
destroying long setup DMA buffers.


If you already have pulled 'for-linus-5.2' your git diff stat will be a bit
different.

 drivers/xen/swiotlb-xen.c  | 34 ++++++++++------------------------
 include/linux/page-flags.h |  4 ++++
 2 files changed, 14 insertions(+), 24 deletions(-)


Arnd Bergmann (1):
      swiotlb: fix phys_addr_t overflow warning

Florian Fainelli (2):
      swiotlb: Group identical cleanup in swiotlb_cleanup()
      swiotlb: Return consistent SWIOTLB segments/nr_tbl

Juergen Gross (3):
      xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
      xen/swiotlb: simplify range_straddles_page_boundary()
      xen/swiotlb: remember having called xen_create_contiguous_region()

