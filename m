Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26C9182120
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgCKSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 14:47:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40966 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgCKSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:47:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so1667663pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DPFOjS65aX83dVrMyWpNcqxjpN5VgGgj9i7MicV1YwI=;
        b=UQ4e2oDI5aWe4clgsCfMJn2WuqSNV6MSzIXKTA/MELu5S35/wFnW+P2AKgc2Nb8p5F
         a2eEhF7s8OZB9Xp5XOA90hgpheqmMYDAXt/OqRTdUIbi3rbHC9YcB726dO3vpa/sXh13
         ax8fSrNwK3SN+sYW4HuU0cRGr8nNcAbHgK5eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DPFOjS65aX83dVrMyWpNcqxjpN5VgGgj9i7MicV1YwI=;
        b=gX2jaWZH3zTR7DRdQ259oVWlcHSBaRXEySBZrLH2Ci7YVoNLWn57BPK065uksflv3E
         AM2bLmxZPXjGWfAUs1T8JWkhRITXNKM3GE4qs1RtQ0Eovtfjao+X0wfQcB3OV571wNJN
         H/VvSj6MsKtdTB8S1qekVnlFHr6rxR+o81GS8ZrNKbRYff80+yY0vWyizhR5PBTjh0tV
         y1XtPcjxnm+dA7LRovPOgNK+OT0jvilGwmPrjEQvUcnVmST1LWjlY3+1/+o8n+pQf119
         9cgoeViUxAgeUsgNSCQFcGjP9ASeiyb4wsv+7VV54LCRJL50AsHFfu5ddh7V9/5xhhqI
         fxLQ==
X-Gm-Message-State: ANhLgQ0Ouf7BA3JlbDuzXJzD0Irl3DVxT4zuBJDHcxv8I8SXc4N1q0pZ
        2JnWCSM5QZA22FtHuKZ0pO8FSw==
X-Google-Smtp-Source: ADFU+vuXIizjdYkDBMb7S0jL33R8WS1F2EGioRvewyWf29WjT0E9VAqV9sIyR+/A6GtPH+xZPd9U8A==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr4318121pfb.8.1583952441770;
        Wed, 11 Mar 2020 11:47:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm10574451pfp.167.2020.03.11.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:47:20 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:47:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <202003111146.E3FC1924@keescook>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <20200309164931.GA23889@roeck-us.net>
 <202003111020.D543B4332@keescook>
 <04a8c31a-3c43-3dcf-c9fd-82ba225a19f6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a8c31a-3c43-3dcf-c9fd-82ba225a19f6@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:31:13AM -0700, Guenter Roeck wrote:
> On 3/11/20 10:21 AM, Kees Cook wrote:
> > On Mon, Mar 09, 2020 at 09:49:31AM -0700, Guenter Roeck wrote:
> >> On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
> >>> On ARM, we currently only change the value of the stack canary when
> >>> switching tasks if the kernel was built for UP. On SMP kernels, this
> >>> is impossible since the stack canary value is obtained via a global
> >>> symbol reference, which means
> >>> a) all running tasks on all CPUs must use the same value
> >>> b) we can only modify the value when no kernel stack frames are live
> >>>    on any CPU, which is effectively never.
> >>>
> >>> So instead, use a GCC plugin to add a RTL pass that replaces each
> >>> reference to the address of the __stack_chk_guard symbol with an
> >>> expression that produces the address of the 'stack_canary' field
> >>> that is added to struct thread_info. This way, each task will use
> >>> its own randomized value.
> >>>
> >>> Cc: Russell King <linux@armlinux.org.uk>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: Emese Revfy <re.emese@gmail.com>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Laura Abbott <labbott@redhat.com>
> >>> Cc: kernel-hardening@lists.openwall.com
> >>> Acked-by: Nicolas Pitre <nico@linaro.org>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> Since this patch is in the tree, cc-option no longer works on
> >> the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.
> >>
> >> Any idea how to fix that ? 
> > 
> > I thought Arnd sent a patch to fix it and it got picked up?
> > 
> 
> Yes, but the fix is not upstream (it is only in -next), and I missed it.

Ah, yes, I found it again now too; it went through rmk's tree.

For thread posterity:

ARM: 8961/2: Fix Kbuild issue caused by per-task stack protector GCC plugin
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8961/2

-- 
Kees Cook
