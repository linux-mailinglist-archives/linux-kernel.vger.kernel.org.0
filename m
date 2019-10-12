Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047B6D4DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfJLHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 03:33:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbfJLHd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:33:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AEF6B6C2B173B91EFB2B;
        Sat, 12 Oct 2019 15:33:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 12 Oct 2019
 15:33:42 +0800
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <73701e9f-bee1-7ae8-2277-7a3576171cd4@huawei.com>
Date:   Sat, 12 Oct 2019 15:33:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 18:27, Will Deacon wrote:
[...]
> 
> Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
> should get rid of it altogether on arm64. I don't know of any supported
> userspace that supports it or any CPUs that are unable to run little-endian
> binaries.

FWIW, massive telecommunication products (based on ARM64) form Huawei are using
BIG_ENDIAN, and will use BIG_ENDIAN in the near future as well.

Thanks
Hanjun

