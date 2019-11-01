Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3326EC5A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 16:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfKAPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 11:32:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfKAPcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:32:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BC87B0D3691E2CB7247;
        Fri,  1 Nov 2019 23:32:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 23:32:12 +0800
Message-ID: <5DBC4FFB.5030200@huawei.com>
Date:   Fri, 1 Nov 2019 23:32:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com> <20191031110304.GE21133@nazgul.tnic> <5DBACB61.90809@huawei.com> <20191031154916.GA24152@nazgul.tnic> <5DBB03B0.5060003@huawei.com> <20191101084524.GA29724@nazgul.tnic>
In-Reply-To: <20191101084524.GA29724@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 16:45, Borislav Petkov wrote:
> On Thu, Oct 31, 2019 at 11:54:24PM +0800, zhong jiang wrote:
>> Yep,  WARN_ONCE alway return true in that case.
> Are you sure it does that always?
>
WARN_ONCE will alway return true if its condition is true.:-)

