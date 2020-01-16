Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E813D898
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgAPLJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:09:20 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F242072B;
        Thu, 16 Jan 2020 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579172959;
        bh=vc1eS1Q2QThKXCZG9OTh32DIlaGsAXxxnnsQoKtmYG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDxpSI2IleBtE1CP1lydmOJTLtN7qR5EhtKAWBT4SkcqCQ2C003S4z7BH19ajI/AI
         m5y7zO0Nf4rerc+XhY4KkohEtm4qxtLBLSHZXBZV41BQjzBH3csEeLZabpO4Kwp+h2
         qFuR9y7c0+3Q5scHUGWukt1ME/1H3mxhDZX4KR7I=
Date:   Thu, 16 Jan 2020 11:09:14 +0000
From:   Will Deacon <will@kernel.org>
To:     yeyunfeng <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, willy@infradead.org,
        ard.biesheuvel@arm.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] arm64: mm: support setting page attributes for debug
 situation
Message-ID: <20200116110914.GA16345@willie-the-truck>
References: <5a3ab728-b895-0930-9540-5e9c586e8858@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3ab728-b895-0930-9540-5e9c586e8858@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:47:41PM +0800, yeyunfeng wrote:
> When rodata_full is set or pagealloc debug is enabled, block mappings or
> contiguou hints are no longer used for linear address area. Therefore,
> support setting page attributes in this case is useful for debugging
> memory corruption problems.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  arch/arm64/mm/pageattr.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Although I can kind of see what you're getting at, I'm not keen on merging
this without a user. If you're just referring to random debug hacks, then I
think this change could be part of those too.

Will
