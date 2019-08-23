Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679DC9A50D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 03:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfHWBpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 21:45:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733086AbfHWBpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:45:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0225F98E76DC5A62B45A;
        Fri, 23 Aug 2019 09:45:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 23 Aug
 2019 09:45:37 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to writeout dirty inode during
 node flush
References: <20190822121756.107187-1-yuchao0@huawei.com>
 <20190822214955.GA1349@sol.localdomain>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
To:     Eric Biggers <ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <735bd992-a668-f3f2-0ff2-8071e235f4e8@huawei.com>
Date:   Fri, 23 Aug 2019 09:45:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190822214955.GA1349@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/23 5:49, Eric Biggers wrote:
> Thanks, the test passes for me with this patch applied.
> 
> Tested-by: Eric Biggers <ebiggers@kernel.org>
> .

Thanks for the test.

Thanks,
