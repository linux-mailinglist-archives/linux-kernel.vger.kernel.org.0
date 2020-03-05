Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8539B179F94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 06:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEFtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 00:49:22 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:58986 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgCEFtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:49:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583387357; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=e9oOjtcJtvi7qKpVf2giGi1FIlSAIhOxeJLKzzQB65w=;
 b=lJphYUKrQLKPmCmTFwi45a2n0S/k9dqsDwCTe0bJ5joPJSZHJNubk4CQFRxZjpbUUcZv2ppZ
 v8LKZA4ujo5u6NXTrPuzUF9lkP8T41yeTWnHS/s5Slgn39vVJBE2awwUcOvujwgA13mMgiw/
 4LoQlXicrWOZcKaYIqWIL+3ly78=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6092c8.7fdbddfbdea0-smtp-out-n01;
 Thu, 05 Mar 2020 05:48:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B07C2C447A3; Thu,  5 Mar 2020 05:48:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0371C43383;
        Thu,  5 Mar 2020 05:48:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Mar 2020 11:18:55 +0530
From:   vjitta@codeaurora.org
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, kernel-team@android.com
Subject: Re: [PATCH] mm: slub: reinitialize random sequence cache on slab
 object update
In-Reply-To: <d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz>
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
 <1580383064-16536-1-git-send-email-vjitta@codeaurora.org>
 <d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz>
Message-ID: <da7f86610add1ea78234dfc88178472e@codeaurora.org>
X-Sender: vjitta@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-27 22:23, Vlastimil Babka wrote:
> On 1/30/20 12:17 PM, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>> 
>> Random sequence cache is precomputed during slab object creation
>> based up on the object size and no of objects per slab. These could
>> be changed when flags like SLAB_STORE_USER, SLAB_POISON are updated
>> from sysfs. So when shuffle_freelist is called during slab_alloc it
>> uses updated object count to access the precomputed random sequence
>> cache. This could result in incorrect access of the random sequence
>> cache which could further result in slab corruption. Fix this by
>> reinitializing the random sequence cache up on slab object update.
>> 
>> A sample panic trace when write to slab_store_user was attempted.
> 
> A more complete oops report would have been better, e.g. if anyone was 
> googling
> it, to find this patch.
> 
> Also I was checking where else calculate_sizes() is called and found
> order_store(). So if somebody changes (especially increases) the order,
> shouldn't the reinitialization also be done?

Yes, reinitialization must be done here aswell , will update the patch.

> 
> This is even more nasty as it doesn't seem to require that no objects 
> exist.
> Also there is no synchronization against concurrent allocations/frees? 
> Gasp.

Since, random sequence cache is only used to update the freelist in 
shuffle_freelist
which is done only when a new slab is created incase if objects 
allocations are
done without a need of new slab creation they will use the existing 
freelist which
should be fine as object size doesn't change after order_store() and 
incase if a new
slab is created we will get the updated freelist. so in both cases i 
think it should
be fine.
