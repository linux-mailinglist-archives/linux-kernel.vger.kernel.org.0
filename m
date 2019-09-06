Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BECABD22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfIFP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:59:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:35396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbfIFP7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:59:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C101CAF77;
        Fri,  6 Sep 2019 15:59:46 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] ARM: xen: unexport HYPERVISOR_platform_op
 function
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <20190906153948.2160342-1-arnd@arndb.de>
 <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <742b216d-9219-7ba5-553b-6445513ccedd@suse.com>
Date:   Fri, 6 Sep 2019 17:59:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2019 17:55, Andrew Cooper wrote:
> On 06/09/2019 16:39, Arnd Bergmann wrote:
>> HYPERVISOR_platform_op() is an inline function and should not
>> be exported. Since commit 15bfc2348d54 ("modpost: check for
>> static EXPORT_SYMBOL* functions"), this causes a warning:
>>
>> WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
>>
>> Remove the extraneous export.
>>
>> Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Something is wonky.  That symbol is (/ really ought to be) in the
> hypercall page and most definitely not inline.

It's HYPERVISOR_platform_op_raw that's in the hypercall page afaics.

Jan
