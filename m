Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1761563
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGGPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 11:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfGGPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:10:38 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEA620989
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2019 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562512237;
        bh=xpjZays0fQz+tdQac2BxpVV4yuHltHrUK2Qlejw3t5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ejEE4w2gmL5oreRSNJIl4iFxkYVy7+Q/91X9ZHIJU+7gsykAiYZTWThbBEF4GW5lq
         CS9+uT3r1D/XjvQnpYigSTDN97aC8igH/e9QASDuwqDup9dpLNNZQuev5gpcxKluLL
         DAmfLVRy3Swbnj7vZ4vPZY9GwF1cY/2R6OsSNl7c=
Received: by mail-wr1-f54.google.com with SMTP id x4so14375146wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 08:10:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUxchX93UzLz7c3SReJeb8muTZO/6gKnE8Y64FPMBQmoggmUrg1
        udyi6GyzIMjeHUvWN9MNIFaTZT5zXjC76ZIFecKfsA==
X-Google-Smtp-Source: APXvYqw+k3iYXGxPMTy+3S+t3ZxJC1gyM6jkZQcintuOqFkquPK/8lghtkO7nlxnfBnR7yQBpnCufZ/VfIaTQVP4kL4=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr13241473wrm.265.1562512235959;
 Sun, 07 Jul 2019 08:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
In-Reply-To: <20190704200050.534802824@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 7 Jul 2019 08:10:24 -0700
X-Gmail-Original-Message-ID: <CALCETrXvTvFBaQB-kEe4cRTCXUyTbWLbcveWsH-kX4j915c_=w@mail.gmail.com>
Message-ID: <CALCETrXvTvFBaQB-kEe4cRTCXUyTbWLbcveWsH-kX4j915c_=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Despire the current efforts to read CR2 before tracing happens there
> still exist a number of possible holes:
>
>   idtentry page_fault             do_page_fault           has_error_code=1
>     call error_entry
>       TRACE_IRQS_OFF
>         call trace_hardirqs_off*
>           #PF // modifies CR2
>
>       CALL_enter_from_user_mode
>         __context_tracking_exit()
>           trace_user_exit(0)
>             #PF // modifies CR2
>
>     call do_page_fault
>       address = read_cr2(); /* whoopsie */
>
> And similar for i386.
>
> Fix it by pulling the CR2 read into the entry code, before any of that
> stuff gets a chance to run and ruin things.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

Subject to the discussion as to whether this is the right approach at all.
