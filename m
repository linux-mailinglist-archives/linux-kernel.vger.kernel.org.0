Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B69102AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfKSRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:21:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbfKSRVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:21:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CFE7B307;
        Tue, 19 Nov 2019 17:21:08 +0000 (UTC)
Date:   Tue, 19 Nov 2019 09:16:49 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/4] x86/mm, pat:  Rename pat_rbtree.c to pat_interval.c
Message-ID: <20191119171649.u4ukydhjik4x2rfc@linux-p48b>
References: <20191021231924.25373-1-dave@stgolabs.net>
 <20191021231924.25373-5-dave@stgolabs.net>
 <20191119081705.GA62028@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191119081705.GA62028@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Ingo Molnar wrote:
>
>* Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Considering the previous changes, this is a more proper name.
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>>  arch/x86/mm/{pat_rbtree.c => pat_interval.c} | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  rename arch/x86/mm/{pat_rbtree.c => pat_interval.c} (100%)
>>
>> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_interval.c
>> similarity index 100%
>> rename from arch/x86/mm/pat_rbtree.c
>> rename to arch/x86/mm/pat_interval.c
>
>For some reason this patch was missing the kbuild adjustment for the
>rename of the .c file:

Sorry about that, I don't know how I missed this - the series was
certainly tested. Per the below I assume you don't need a v2 (and
avoid more spam).

Thanks,
Davidlohr
