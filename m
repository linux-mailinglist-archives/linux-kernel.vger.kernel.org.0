Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41812D561
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 01:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLaA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 19:59:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLaA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aWSBqhxb0lE9SfM+h9fKMV7nyuX+MBH/ozYu/Tw/9UQ=; b=SChRRsQAz2wMeqlwHeMNImY2G
        FlRsfTK+1oNFu6/CMoC7myWAtiYCm5Gpg3iEv4kytwFoeb8V2+SqCWAiAp8bFKA4HcCmeVl1qoTzH
        3gLiAigOsgBWWghXDEcyxHmE9jno6TPkJyOmS5ZMcWSntg4MNPIi6TOeebKaPNwCH1m/9aIqNneCS
        AVyMKkS2RYoWn1i/9gEOYWSSfUJ8IzhwSNyrqLsmCivn98y06sL3x7xXeiPm1cTy/T2IUTARV6V4c
        4k5c7H+Sw0u8p6fM/Ok5MnWSEtVwSseSKkqWJJky22PAOh0aLPeWIjT+UjBUeKQ8ORQjtdo/XoPTK
        NMJBp7sCQ==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im5sw-0002mF-J6; Tue, 31 Dec 2019 00:59:46 +0000
Subject: Re: Why is CONFIG_VT forced on?
To:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
Date:   Mon, 30 Dec 2019 16:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 4:53 PM, Rob Landley wrote:
> 
> 
> On 12/30/19 6:36 PM, Randy Dunlap wrote:
>> On 12/30/19 4:30 PM, Rob Landley wrote:
>>> On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
>>> terminal), but the help doesn't mention a "selects", and I didn't spot anything
>>> obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".
>>>
>>> Congratulations, you've reinvented "come from". I'm mostly familiar with the
>>> kconfig plumbing from _before_ you made it turing complete: how do I navigate this?
>>>
>>> I'm guessing "stick printfs into the menuconfig binary" is the recommended next
>>> step for investigating this? Or is there a trick I'm missing?
>>
>> I've never had to resort to that trick.
>>
>>> Rob
>>>
>>
>> config VT
>> 	bool "Virtual terminal" if EXPERT
>> 	depends on !UML
>> 	select INPUT
>> 	default y
>> 	^^^^^^^^^^^^^^^^^^^
>>
>> That's all it takes ^^^^^^^^^^^^^^^^.
> 
> Try to switch it off. It won't let you, it's forced on by something else. The
> help doesn't say what. (That select means it's forcing CONFIG_INPUT on?)
> 
>> Does that explain it?  Maybe I don't understand the problem.
> 
> It's possible I don't either. I can disable it when when I start from
> allnoconfig and then switch CONFIG_TTY on (at which point it defaults to y, but
> can be disabled).


#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set

But first you must set/enable EXPERT.  See the bool prompt.


-- 
~Randy

