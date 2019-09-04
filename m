Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87FDA9185
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbfIDSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 14:17:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42872 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390136AbfIDSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:17:23 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so44404989iod.9;
        Wed, 04 Sep 2019 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnf8E1B10U/rZLorYmCb+yTjJ2/FF27pXtV4pEIHWJ0=;
        b=L6PKN1h75ntIi1hddTwn5fOXeCxCPppqjd/YrkdL5yYs7EU3vZ5oDR4M/GQBy57/Z8
         xWRRcnQKszDv1BqJs6/5TuEK2B1akvMvgIgk4YgCAA+0xl6Qx7mrHMtG4BoESAE1T/TP
         xHD6WT8kfPQDYULdNTUgikCKoz9lIuMFYGZjJOyhnUJagv52rk+qjBvB4VW/Ji+qSvmn
         5uaNnbHbcRdukqYekxvI5olN9RVutymKyiOnFr4+4940zXpkHjrWCJIKg5uRyqK2DDz5
         p935Nk511rkIgkcSVB+h6j9EMIW+sSej+2hfpcPEvESvHLSdESvaKuif11AkNtXpNEQU
         KejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnf8E1B10U/rZLorYmCb+yTjJ2/FF27pXtV4pEIHWJ0=;
        b=WnL8Ii8uLV7+ubRzpuZqR2PtC2VghNKo+PCEjrbipAw4XhK9UIPMzSnqphoVa+BIMo
         9zYPSa0uhtuf1ev18NYiUojDkoht/Ueqj1jZgMF20EXDngMp/ghBfAQvH8Es5Epv6jDM
         30p0I7TxGyEQkPAB8A0UPXJ9X4mRSqQJbR38JfaAN0y0a8r1zaF338KpgB2EeGxyg/Ln
         XbNJvHLNDxg1AdAVFI1W/4Mj3oB0K9QNvRINhW40VPDxO2SxooHnLDW4gduU8pIivBDD
         f8v9bZ+mvbGxLmmDwjwv9/uC4lpyQSkMGdD58uCABBefL2doDf8qgaT9P/4DijeQb0YD
         qbGA==
X-Gm-Message-State: APjAAAUEE4dKH8lgvH6aRmt6CQ7ZKqISZHQz+vcKAie3/92Pohw2mVdp
        gaD9xU8dbgdUBNxIkIxTHVYE68yuEQ==
X-Google-Smtp-Source: APXvYqyZAEsHdr+O6sWnZYGZk2KlpCsOIz9qthXXldoAac9Gbaef+GHeHMxDxTgj7gaJf5/xLeJDNw==
X-Received: by 2002:a02:a516:: with SMTP id e22mr30362312jam.77.1567621042372;
        Wed, 04 Sep 2019 11:17:22 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.176.185])
        by smtp.googlemail.com with ESMTPSA id s201sm28603484ios.83.2019.09.04.11.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 11:17:21 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
 <20190904040039.GB150430@google.com>
 <20190904081919.GA2349@hirez.programming.kicks-ass.net>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <5bd4f538-f205-1134-d491-5a8727855b51@gmail.com>
Date:   Wed, 4 Sep 2019 20:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904081919.GA2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 10:19 AM, Peter Zijlstra wrote:

>>
>> Adding Paul since RCU faces similar situations, i.e. raising softirq risks
>> scheduler deadlock in rcu_read_unlock_special() -- but RCU's solution is to
>> avoid raising the softirq and instead use irq_work.
> 
> Which is right.
> 

Thanks Joel and Peter for suggesting the irq_work facility.

I was ignorant of the existence of this facility.

It looks like it is the Holy Grail of deferred work, for this particular 
type of problem :)

It looks like it will be possible to both avoid deadlock and also avoid 
the ugly additions to the sched and idle code. In addition, the rest of 
the code will become a lot simpler.

best regards,

Viktor
