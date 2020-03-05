Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1432D17AE96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCES5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:57:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCES5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=90PsQ4qn7idAg8om1vCTJLAiN2890cMWcnF24IYxgDc=; b=fv4ovc1qV3pLntR67dk++yLkwb
        45T5B35drA0dkhLce4yh+6gnblKeOzfzPIOSFOI2LpFQoAMokFXJ7oaInLrFjbLbKEN85r/gaNC6J
        u4400F13PHMp2TsMjbyzThatMdz84ck0N7RKtRL0JLbmulrJr5fRZEKEzXL2amqsxbf+VZEywOxZd
        KqizugKOXlJKSb6+jdP5+1+JCQIqECD2lmV6DcZCa6Dl1P+tB40aGSwAyBjmZaBUPLcn97ZSed22o
        GmRzUPwQp6JGn49ZWxnkOJQxk6cHa4Td9AmO3aaUXw23mB5IRlHLbLwUC7i8tMpKe1QDxSI6CT04S
        1WG/5TSQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9vgP-0007Kr-Ks; Thu, 05 Mar 2020 18:57:21 +0000
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
Date:   Thu, 5 Mar 2020 10:57:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 10:43 AM, Markus Elfring wrote:
>>>> If you would (could) be more concrete (or discrete) in your suggestions,
>>>> I would be glad to comment on them.
>>>
>>> Does this view indicate any communication difficulties?
>>
>> Probably.
>>
>>> Which of the possibly unanswered issues do you find not concrete enough so far?
>>
>> e.g.:
>>>>>  Will the clarification become more constructive for remaining challenges?
> 
> Do you expect that known open issues need to be repeated for each patch revision?

Ideally not, but not very much is ideal.

IOW, it is sometimes required (if one cares enough; sometimes
one just gives up).

> How do you think about the desired tracking of bug reports
> also for this software?

I expect that more users will begin to use it and report problems
as they see fit.  They can use mailing list(s) and/or
bugzilla.kernel.org.  I'm not terribly concerned about it.
Masami seems to be responsive.

thanks.
-- 
~Randy

