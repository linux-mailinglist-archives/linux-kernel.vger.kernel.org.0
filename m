Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A430D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfEaLXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 07:23:50 -0400
Received: from mail1.windriver.com ([147.11.146.13]:64077 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:23:50 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x4VBNZNC029641
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 31 May 2019 04:23:35 -0700 (PDT)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 31 May
 2019 04:23:34 -0700
Subject: Re: Userspace woes with 5.1.5 due to TIPC
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Mihai Moldovan <ionic@ionic.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4ad776cb-c597-da1d-7d5e-af39ded17c40@ionic.de>
 <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
 <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
 <3cc60b11-2b63-3bfc-2be8-569f2b0ce7cf@windriver.com>
 <CH2PR15MB3575E1402F1FF4418C8C67139A190@CH2PR15MB3575.namprd15.prod.outlook.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <5498070b-c6e4-30e5-dea4-5767fe50f617@windriver.com>
Date:   Fri, 31 May 2019 19:13:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CH2PR15MB3575E1402F1FF4418C8C67139A190@CH2PR15MB3575.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 7:02 PM, Jon Maloy wrote:
> This was the very reason the broken patch was introduced. AFAIK there is no problem after the corrected version of that patch was applied.

I have prepared for our patches on net-next tree. But when I checked my
patches on net tree, it's found that the issue has been fixed with
commit 526f5b851a96566803ee4bee60d0a34df56c77f8 ("tipc: fix modprobe
tipc failed after switch order of device registration"). There are four
commits which were introduced recently, and their names are quite
similar, and the fix is not merged into net-next tree, which makes me
misunderstood the issue status.

Anyway, it looks like failing to insert TIPC module has been resolved.
But I have not validated the fix by create multiple TIPC namespace, so I
am not sure whether it works normally.

Thanks,
Ying
