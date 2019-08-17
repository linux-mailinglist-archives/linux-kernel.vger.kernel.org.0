Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6B9111D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHQPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 11:03:01 -0400
Received: from mail.efficios.com ([167.114.142.138]:57434 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 11:03:00 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 38F7724985A;
        Sat, 17 Aug 2019 11:02:59 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id An75BZNfvxUZ; Sat, 17 Aug 2019 11:02:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B93D6249857;
        Sat, 17 Aug 2019 11:02:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B93D6249857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566054178;
        bh=OmAHa4Jw71Egrh6MGWwvWAcTuvQtM2ZmoWn32AUV7zU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oDe8upEbbCFoDEbUj2SWOdyvJ5E/rSkjb6ILSIfrHNgQyeV2PN/8TQVykNdV39X7V
         ojGIMH8TUyX7wPFV4JiYrVQoXzz0LDlY88Hw5aJUHqg7aRv4Bh+7kjNdYvu50g70aF
         o2TDzT2vRgYT1yfRU6MT163yiPoi3YotPBlPSkR3OOhC60qawck71GLjPofTpTBIVM
         gSiQ+fO5MKr6WUzTojMCO1tAbUg4OCQMDxldaKplcvoDvSxptc73WuQCAbI+jHEhA3
         lNdq0Y7ngbXSOC0Mh9Q21G+vX9Lf/l/K0DMnXBchPmPM7jj5xLaB0IBoivGKLgfnF8
         nYK3H2GQ0tHOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ub9RZ9aYgD_Q; Sat, 17 Aug 2019 11:02:58 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9D4BA24984D;
        Sat, 17 Aug 2019 11:02:58 -0400 (EDT)
Date:   Sat, 17 Aug 2019 11:02:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <1065930957.23914.1566054178444.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de> <20190816205740.GF10481@google.com> <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com> <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com> <20190817045217.GZ28441@linux.ibm.com> <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com> <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: 4wpubgVcy2E1F8uT/tiCU3F1omvZlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 17, 2019, at 4:44 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> 
> But I'm seeing a lot of WRITE_ONCE(x, constantvalue) kind of things
> and don't seem to find a lot of reason to think that they are any
> inherently better than "x = constantvalue".

If the only states that "x" can take is 1 or 0, then indeed there seems
to be no point in using a WRITE_ONCE() when paired with a READ_ONCE()
other than for documentation purposes.

However, if the state of "x" can be any pointer value, or a reference
count value, then not using "WRITE_ONCE()" to store a constant leaves
the compiler free to perform that store in more than one memory access.
Based on [1], section "Store tearing", there are situations where this
happens on x86 in the wild today when storing 64-bit constants: the
compiler is then free to decide to use two 32-bit immediate store
instructions.

Thanks,

Mathieu

[1] https://lwn.net/Articles/793253/

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
