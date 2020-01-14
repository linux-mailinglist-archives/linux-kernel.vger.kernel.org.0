Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5D13B1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgANSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 13:23:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+h0CL9kl7jogSNq843OLtDbbNXSIqEzJytJbnlV5otk=; b=UXskS0/Fb+exO7A5sNyeKg1Dq
        0jHH8od8g+os3EgoWdlZiMy4/ArdW6Q9TBlaB5qz+YZk+WkGn0fVzFYh+H4yZonBs9I+ICpoShzFi
        ka6PCWH19L+ilyIdbM8MUIQAHakm0wy4Ruy/s5cRqnFxF0NJ0Sf4lX/Bda42mDukOrv+gIktpS0H5
        FEmTZ1qk9Hcl2au5L6p95GtQGwed1IdymKwqUohSkrEpjJTrBQfbEv1v2awPUhJYcRkNo2RdyODSu
        GNJ/17TUNvfzOB51PAK305PnoRC6h5QHP2iRk8Idb1cWhyfzZAKRD9XWyoGcWliNm2c4MoDuhjHqC
        tdJmwlJ1w==;
Received: from [2603:3004:32:9a00::7442]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irQqU-0005A6-HR; Tue, 14 Jan 2020 18:23:18 +0000
Subject: Re: asm-generic: fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
References: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
 <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d3e79b2-8fb3-36ab-ac4a-520d34cef395@infradead.org>
Date:   Tue, 14 Jan 2020 10:23:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjwSC9H1bkEg-0t0cCU0mO+e0gBH8VQn5LG0XL2rpKnfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 10:18 AM, Linus Torvalds wrote:
> On Tue, Jan 14, 2020 at 8:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
>> tags/asm-generic-5.5
> 
> Pulled.
> 
> However, I noticed that your email doesn't match my usual git pull
> search terms (which are "git" and "pull" - shocking, I know), so had
> this been during the merge window or some other very busy time for me,
> I might not have noticed the email in a timely manner..
> 
> Mind adding "git pull" somewhere? Preferably perhaps to the subject
> line itself, ie a "[GIT PULL]" prefix, because that's also what the
> pr-tracking-bot looks for (well, it's _one_ of the things the bot
> looks for, it might have noticed your email even without it because of
> the pull-request patterns in the body).

and because it's documented in Documentation/process/submitting-patches.rst ...

-- 
~Randy
