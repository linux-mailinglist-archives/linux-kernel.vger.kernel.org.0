Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02F819B8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbgDAX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 19:29:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:29:20 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJmnL-00028F-Fy; Thu, 02 Apr 2020 01:29:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EB0EC100D52; Thu,  2 Apr 2020 01:29:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
In-Reply-To: <20200401230105.GF648829@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com> <87d08rosof.fsf@nanos.tec.linutronix.de> <20200401230105.GF648829@xz-x1>
Date:   Thu, 02 Apr 2020 01:29:14 +0200
Message-ID: <87wo6yokdx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 01, 2020 at 10:30:08PM +0200, Thomas Gleixner wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> > @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>> >  			continue;
>> >  		}
>> >  
>> > -		pr_warn("isolcpus: Error, unknown flag\n");
>> > -		return 0;
>> > +		str = strchr(str, ',');
>> > +		if (str)
>> > +			/* Skip unknown sub-parameter */
>> > +			str++;
>> > +		else
>> > +			return 0;
>> 
>> Just looked at it again because I wanted to apply this and contrary to
>> last time I figured out that this is broken:
>> 
>>      isolcpus=nohz,domain1,3,5
>> 
>> is a malformatted option, but the above will make it "valid" and result
>> in:
>> 
>>      HK_FLAG_TICK and a cpumask of 3,5.
>
> I would think this is no worse than applying nothing - I read the
> first "isalpha()" check as something like "the subparameter's first
> character must not be a digit", so to differenciate with the cpu list.
> If we keep this, we can still have subparams like "double-word".

It _is_ worse. If the intention is to write 'nohz,domain,1,3,5' and
that missing comma morphs it silently into 'nohz,3,5' then this is
really a step backwards. The upstream version would tell you that you
screwed up.

>>  static int __init housekeeping_isolcpus_setup(char *str)
>>  {
>>  	unsigned int flags = 0;
>> +	char *par;
>> +	int len;
>>  
>>  	while (isalpha(*str)) {
>>  		if (!strncmp(str, "nohz,", 5)) {
>> @@ -169,8 +171,17 @@ static int __init housekeeping_isolcpus_
>>  			continue;
>>  		}
>>  
>> -		pr_warn("isolcpus: Error, unknown flag\n");
>> -		return 0;
>> +		/*
>> +		 * Skip unknown sub-parameter and validate that it is not
>> +		 * containing an invalid character.
>> +		 */
>> +		for (par = str, len = 0; isalpha(*str); str++, len++);
>> +		if (*str != ',') {
>> +			pr_warn("isolcpus: Invalid flag %*s\n", len, par);
>
> ... this will dump "isolcpus: Invalid flag domain1,3,5", is this what
> we wanted?  Maybe only dumps "domain1"?

No, it will dump: "domain1" at least if my understanding of is_alpha()
and the '%*s' format option is halfways correct

> For me so far I would still prefer the original one, giving more
> freedom to the future params and the patch is also a bit easier (but I

Again. It does not matter whether the patch is easier or not. What
matters is correctness and usability. Silently converting a typo into
something else is horrible at best.

> definitely like the pr_warn when there's unknown subparams).  But just
> let me know your preference and I'll follow yours when repost.

Enforcing a pure 'is_alpha()' subparam space is not really a substantial
restriction. Feel free to extend it by adding '|| *str == '_' if you
really think that provides a value. 

Thanks,

        tglx
