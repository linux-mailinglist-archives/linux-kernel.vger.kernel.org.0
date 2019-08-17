Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BE90BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 03:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHQBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 21:25:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:54690 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQBZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 21:25:31 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1EA582C859D;
        Fri, 16 Aug 2019 21:25:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id BdC3s7WjZEA9; Fri, 16 Aug 2019 21:25:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 963FC2C859A;
        Fri, 16 Aug 2019 21:25:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 963FC2C859A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566005129;
        bh=uqTIy28oWerSplIYIKuIISlO9VobuclwHz+JaXKqcuc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IrCxEl6dTs2A22BzAKsFarTyrZi5ILrUMtVN/FUyA8Ij4bn9zNILQrBWlCPsmmkNg
         44J2P5i6oSLq2YRU7UvLNQ1wEQZ8gDBy3SSjnv7xM+Jyd389nNp46Jpx7cHHInbE/6
         NoeScMvJjV9KNR/N5gfyaQAV26MxQon3IYucZ9eXvPkmNJr0hspJ0Wf68N5+K71I/m
         m7tJaLo9E1mFeOi9YKEkHdjbgG/C+EIGowKnVzHqfxeHDK3EuPxaJJP6DMym2Wr5we
         s4BBs57eb59WOy5oBU8R4zpcu5WS2wd24eNv4/Ovs+dZt8T8QFcocS59DMK6aRS+Eb
         ao68k9QN/DB1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A_JMzfzV7V3T; Fri, 16 Aug 2019 21:25:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 769072C8591;
        Fri, 16 Aug 2019 21:25:29 -0400 (EDT)
Date:   Fri, 16 Aug 2019 21:25:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1209741234.23376.1566005129181.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190816164912.078b6e01@oasis.local.home>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <20190816164912.078b6e01@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: nbfLwy+5lp4uRgruZUREyYMsesqZmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 4:49 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 16 Aug 2019 16:44:10 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
>> I am also more on the side of using *_ONCE. To me, by principal, I
>> would be willing to convert any concurrent plain access using _ONCE,
>> just so we don't have to worry about it now or in the future and also
>> documents the access.
>> 
>> Perhaps the commit message can be reworded to mention that the _ONCE
>> is an additional clean up for safe access.
> 
> The most I'll take is two separate patches. One is going to be marked
> for stable as it fixes a real bug. The other is more for cosmetic or
> theoretical issues, that I will state clearly "NOT FOR STABLE", such
> that the autosel doesn't take them.

Splitting this into two separate patches makes perfect sense.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
