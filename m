Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88C32CA78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfE1PmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:42:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfE1PmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:42:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A53B968E89E32545B015;
        Tue, 28 May 2019 23:42:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 23:41:57 +0800
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
To:     Sven Van Asbroeck <thesven73@gmail.com>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
 <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com>
Date:   Tue, 28 May 2019 23:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 22:35, Sven Van Asbroeck wrote:
> On Tue, May 28, 2019 at 10:31 AM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
>>
> 
> checkpatch.pl errors remain:
> 
> $ ./scripts/checkpatch.pl < ~/Downloads/YueHaibing.eml
> ERROR: DOS line endings
> #92: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
> +^Iselect REGMAP_MMIO^M$

This seems text/plain messages have crlf set when saved as .eml file,

I do check my v2 patch is not crlf ending, but when save as eml file in

my thunderbird, it becomes crlf ending.

> 
> total: 1 errors, 0 warnings, 0 checks, 7 lines checked
> 
> 

