Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE43F43B67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfFMP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:28:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728928AbfFML2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:28:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB2461C04B2F61064578;
        Thu, 13 Jun 2019 19:28:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 19:27:54 +0800
Subject: Re: [PATCH 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
To:     Dave Young <dyoung@redhat.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-2-chenzhou10@huawei.com>
 <20190612084551.GA24575@dhcp-128-65.nay.redhat.com>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>,
        <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <takahiro.akashi@linaro.org>, <horms@verge.net.au>,
        <linux-arm-kernel@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <681c9884-4b8b-be87-2d78-d5f53ab23f34@huawei.com>
Date:   Thu, 13 Jun 2019 19:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190612084551.GA24575@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2019/6/12 16:45, Dave Young wrote:
> Other than the comments from James, can you move the function into
> kernel/crash_core.c, we already have some functions moved there for
> sharing.

Sure.

Thanks,
Chen Zhou

