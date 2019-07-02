Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602C95D317
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGBPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 11:39:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50385 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGBPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:39:49 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 51AC420016;
        Tue,  2 Jul 2019 15:39:36 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] riscv: Introduce huge page support for 32/64bit
 kernel
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190701175900.4034-1-alex@ghiti.fr>
 <20190701175900.4034-3-alex@ghiti.fr> <20190702132418.GB17480@infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <1596717d-430b-a429-4840-89ca30d654eb@ghiti.fr>
Date:   Tue, 2 Jul 2019 17:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190702132418.GB17480@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 3:24 PM, Christoph Hellwig wrote:
>> +config ARCH_WANT_GENERAL_HUGETLB
>> +	def_bool y
>> +
>> +config SYS_SUPPORTS_HUGETLBFS
>> +	def_bool y
> In a perfect world these would be in mm/Kconfig and only selected
> by the architectures.  But I don't want to force you to clean up all
> that mess first, so:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Thanks, I'll clean that up ;)

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
