Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7984CAB0B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 04:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392023AbfIFCtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 22:49:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391203AbfIFCtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:49:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 56F871731D68F0548963;
        Fri,  6 Sep 2019 10:49:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Sep 2019
 10:49:09 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: separate NOCoW and pinfile semantics
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190723023640.GC60778@jaegeuk-macbookpro.roam.corp.google.com>
 <d4d064a2-2b3c-3536-6488-39e7cfdb1ea4@huawei.com>
 <20190729055738.GA95664@jaegeuk-macbookpro.roam.corp.google.com>
 <07cd3aba-3516-9ba5-286e-277abb98e244@huawei.com>
 <20190730180231.GB76478@jaegeuk-macbookpro.roam.corp.google.com>
 <00e70eb1-c4fa-a6c9-69d7-71ff995c7d6c@huawei.com>
 <20190801041435.GB84433@jaegeuk-macbookpro.roam.corp.google.com>
 <d35d5ad7-5622-fbf5-5853-e541f8c26670@huawei.com>
 <20190801222746.GA27597@jaegeuk-macbookpro.roam.corp.google.com>
 <5d566fce-4412-65b2-e9d9-279b648f7551@huawei.com>
 <20190806003749.GB98101@jaegeuk-macbookpro.roam.corp.google.com>
 <b5549a88-6805-99a8-4b0a-3bbf49da794c@huawei.com>
Message-ID: <5c583e7c-bb69-4bfb-9ff8-29182973c359@huawei.com>
Date:   Fri, 6 Sep 2019 10:47:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b5549a88-6805-99a8-4b0a-3bbf49da794c@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/6 9:36, Chao Yu wrote:
>>>> Now WAL mode were set by default in Android, so most of db file are -wal type now.
>>> Will be back again tho.
>> R?
> Q.

Jaegeuk, why we reuse persist mode in Q now?

Thanks,
