Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AADAF0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfIJSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 14:21:20 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:38234 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIJSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:21:20 -0400
Received: by mail-pg1-f175.google.com with SMTP id d10so10158647pgo.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=He18b5RVxxpe8smLyrpLpEIbfLqZ+paKB0vO+pHwR0g=;
        b=xqDdzksClH+VzDniz0I3kbc4+dbzzazVKzgT6Ff4DZMABzndDy97UPPfDYpirqRCml
         PFu9R4FCQtPyGcxX/uYeajB/GMRFM0mZUbiZDKp83Aky9HTCz45hCcdFFkDt+V2HvzYI
         TfNIAcMWT4/Z38wIcFGpNBTsAjEeuCKY5GHcu/2ZO9zytYqipZbjE6Pr1OmE2xFFJNpK
         jGApnEkDxlX0I2fd6Kv4CSpKDI5HI1r7tfX8JMs0XYpDeZRO2KhFEAeTVCP8v/l80S7J
         haD3WvPie8GxrBV3FQyZcasYkmMDtrDImkPwXs4nib/c5wR/YXhvjZfcP7BG5/yvZREU
         obew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=He18b5RVxxpe8smLyrpLpEIbfLqZ+paKB0vO+pHwR0g=;
        b=AIJY3icefRDOajPrvUD8XchpeqFVmbN4PKyCbEPNQtq8GrU6MY9cn3R8YJ4EaRXN4d
         w2VL/h6/sRdnZyafpXOoliplmY8xZrJV4rCLcnCI7r4kg+QZyHN+8u7oK79BIdNjBWkE
         07/RPiwoNM8y7zLznCadPk3rQxSm1LhaF1vpoI3/uIx1lWQEs0NIDs1pEfwTMfk3+f7Q
         KuVxBCBPO3X8GKsIcRcwiKsiTqMcRGdJHFEdyvFaFZWZpbTu7G8ebd2H/pzPYjuUCEwb
         o5CJbPb3SvJDGHsyD/De+FO49AL3uf4kUAFyGOjhiDMHOFcuAC1Qlayc+eeonoFAFK0l
         63Sw==
X-Gm-Message-State: APjAAAVQYpWW0ghhjBLovKLjtTZLRBOkGWQCsrCdXrEgIxZ0IKMTVDkP
        zXU9tI7bX93+k23mzq1kXg0V1Q==
X-Google-Smtp-Source: APXvYqxEGGAanfl9SlthPWRKT+GwrUUtorAPx3HUFq4hKMuGjQSTQz95q8I0tLNAn4ATjGR8vVobqw==
X-Received: by 2002:a62:3893:: with SMTP id f141mr21107527pfa.221.1568139679352;
        Tue, 10 Sep 2019 11:21:19 -0700 (PDT)
Received: from ?IPv6:2600:380:b456:5481:e4d0:d8e2:e397:e69f? ([2600:380:b456:5481:e4d0:d8e2:e397:e69f])
        by smtp.gmail.com with ESMTPSA id g2sm20935834pfm.32.2019.09.10.11.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 11:21:17 -0700 (PDT)
Subject: Re: [block/for-next] iocost: Fix incorrect operation order during
 iocg free
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Dave Jones <davej@codemonkey.org.uk>
References: <20190910161525.GT2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2222732f-09f7-1434-31a6-b591630d2efb@kernel.dk>
Date:   Tue, 10 Sep 2019 12:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910161525.GT2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 10:15 AM, Tejun Heo wrote:
> ioc_pd_free() first cancels the hrtimers and then deactivates the
> iocg.  However, the iocg timer can run inbetween and reschedule the
> hrtimers which will end up running after the iocg is freed leading to
> crashes like the following.
> 
>    general protection fault: 0000 [#1] SMP
>    ...
>    RIP: 0010:iocg_kick_delay+0xbe/0x1b0
>    RSP: 0018:ffffc90003598ea0 EFLAGS: 00010046
>    RAX: 1cee00fd69512b54 RBX: ffff8881bba48400 RCX: 00000000000003e8
>    RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881bba48400
>    RBP: 0000000000004e20 R08: 0000000000000002 R09: 00000000000003e8
>    R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003598ef0
>    R13: 00979f3810ad461f R14: ffff8881bba4b400 R15: 25439f950d26e1d1
>    FS:  0000000000000000(0000) GS:ffff88885f800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f64328c7e40 CR3: 0000000002409005 CR4: 00000000003606e0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <IRQ>
>     iocg_delay_timer_fn+0x3d/0x60
>     __hrtimer_run_queues+0xfe/0x270
>     hrtimer_interrupt+0xf4/0x210
>     smp_apic_timer_interrupt+0x5e/0x120
>     apic_timer_interrupt+0xf/0x20
>     </IRQ>
> 
> Fix it by canceling hrtimers after deactivating the iocg.

Applied, thanks.

-- 
Jens Axboe

