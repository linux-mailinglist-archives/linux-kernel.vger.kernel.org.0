Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373B5CE25D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJGMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:55:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51500 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfJGMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:55:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so12565518wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07pkDqvlKKHcOgPYdRbFQtRb8NppCfxu/ibfZiki8nc=;
        b=JcZuAiErqz0foaXGBUFUKi7xaZHSrDU8/upD1yWSlkIPXmjwxixR0ldM5VmnBqTZZ4
         0g7GO2bVAOPSUmTk6YcXy3orddKaZFm/ZQn4Wy3Lv2BMJifQIkneFPA+ClMG9FAJ8eH9
         nqHYLEIAV7b7++HOS6CR4qWcZMFQig7bJIPGEtUBpKZlUAnwKpLS/lq5r/uWNqa4nWb1
         eD0uEJsgJMvSwQOWsEtKDRPv8iXWD1KcFelcfv+WArLLG3SIBP+XTxX17JDyPGKXx1BU
         8m9PlQd69otiWOzwq1vcjT+dW8hkRIKfxLwFb5WNm53Bv3dM8VjrS0C3BS5c8GvNKZeE
         s93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=07pkDqvlKKHcOgPYdRbFQtRb8NppCfxu/ibfZiki8nc=;
        b=KuRymUTNbpCGozAayG0ljr4AEtAloLAwYJjbxz7kj3EYG8n0cyPHXV+WzLddSacyJG
         dcDayBq/F10hMkCgDzlZalf/15seEbkO10m78PxBaspq7lwfcNpAuEMAFi9V7V7Pq9Yw
         //nibyiS9tu6Mf/iy9Ws+2CX3Jw+XpwzE61Xw/VcmFQ2BUnTB+PhgYRUKwIyN8qpvFMA
         AI8EeGpVudqoYyvaJVjzJDhrgds+V3t0ijaA0fIX0UiJn/6O1RxKC48LoLPWcIJe4+2W
         9MKVa4lphgV3XXD6/sFSf+Io17qG/1e7PyIfMmhU+/0rRPjjKFpxmF/Q+efnGz2/Dhkd
         VYyw==
X-Gm-Message-State: APjAAAWtHqgxCTmERzZlrN8lqPS5iSob8GM16zi85VRrYoIF42pNA5bv
        3XFLS5Omq1Qn2YkYmI0nQMc=
X-Google-Smtp-Source: APXvYqz17Dgq8iF3viIlEWb1QddyC/9aXnGI96/ywqaw+tkx1uQuvmy/2XUcIp/q1LBsdOlUkU/Qnw==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr21006844wmf.46.1570452922209;
        Mon, 07 Oct 2019 05:55:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z125sm28300985wme.37.2019.10.07.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 05:55:21 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:55:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007125519.GA56546@gmail.com>
References: <20191007090225.44108711.6@infradead.org>
 <20191007084443.79370128.1@infradead.org>
 <20191007120756.GE2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007120756.GE2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> IIRC the recordmcount variant from Steve was also rewriting JMP8 to NOP2
> at build time.
>
> I dug this here link out of my IRC logs:
> 
>   https://lore.kernel.org/lkml/1318007374.4729.58.camel@gandalf.stny.rr.com/

Ancient indeed ...

> Looking at that, part of the reason might've been running yet another 
> tool, instead of having one tool do everything.

Yeah - that too wouldn't be a problem with objtool, as we are running it 
anyway, right?

So I can see about 2 valid technical reasons why Linus would have 
objected to that old approach from Steve while finding the objtool 
approach more acceptable.

Basically the main assumption is that we better never run out of 
competent objtool experts... :-)

Thanks,

	Ingo
