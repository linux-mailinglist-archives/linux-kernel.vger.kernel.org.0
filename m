Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13FCBEC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfIZHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 03:06:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfIZHG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:06:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D85F44A1F95793E87A90;
        Thu, 26 Sep 2019 15:06:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 15:06:53 +0800
Subject: Re: [PATCH] riscv: move flush_icache_range/user_range() after
 flush_icache_all()
To:     Andreas Schwab <schwab@suse.de>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
References: <20190926022938.58568-1-wangkefeng.wang@huawei.com>
 <mvm8sqb4khw.fsf@suse.de>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <52697712-e91f-c5a1-0db0-6b3517e37cce@huawei.com>
Date:   Thu, 26 Sep 2019 15:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mvm8sqb4khw.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/26 14:52, Andreas Schwab wrote:
> https://lore.kernel.org/linux-riscv/mvm7e9spggv.fsf@suse.de/
> 
> Andreas.
> 
Hi Andreas, my change is wrong.

For no SMP,  lkdtm built ok because flush_icache_all() is defined as local_flush_icache_all() macro,
but for SMP, the reason of build error is that flush_icache_all() implementation is not exported as
you mentioned in your patch,  and this does make allmodconfig broken.

LKDTM is used to test the different dumping mechanisms by inducing system failures at predefined
crash points, riscv will enable kernel dump in the future, this module is useful to test this mechanism.

so, it's necessary to fix it, right, any comment, thanks.

