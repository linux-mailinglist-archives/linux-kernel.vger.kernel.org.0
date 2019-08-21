Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C4984C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfHUTsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:48:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40710 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfHUTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:48:44 -0400
Received: by mail-io1-f66.google.com with SMTP id t6so7067625ios.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/FKUsI28DeU0RstFXTPREgngr4rJSTzC7of+9eSaSg=;
        b=q9iDAGEX9A9tYk1Yt2FvedzkSFMe6vss8hgfcenSCqQ6Sq/xtfbroD62XrV9bz39Vp
         CcANgaPV5Z06k7K7j6rABXBxExeAmH1IeZ1vLnB9AfmKe634584Ovfk8UBtLOLL+0u14
         07XvYxyW4Z16F8N5HGCK0hs/KTDUNqk5/QH9AfAnETRIEzg3P6xPeCAVHNbq3UcaznZD
         iTwH3ISsqo397BbsAbq9ZAHNbUohmVc01rbxJdYhE8rsqCBq54VRQHAaWd5+gTC0y6o7
         Wuq4kAw0YavSoZ2iQ5s8x1lV8J6z0bYravmBVRmujYtpgYrrIELKqXFaq3wW6QUKF83X
         6JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/FKUsI28DeU0RstFXTPREgngr4rJSTzC7of+9eSaSg=;
        b=o+gkF+nhaCEh3qPnOnoQLMDX2UYdMeL+BPa1ofyicT55FSJ58ZR05c91rZT5RxuqYx
         roRKC+9Zi5KN8G6GBLOXWhpszZNciyli3AGmBGLVYH5PfIq6oTwp7CWHkhB+HuUT6Saj
         PiemFcjqh7nNVSvzrq0td4reN8EaYz9qRApoKAkDzsQoUoPSecZIQjMJY0te/EguI2k5
         93ixr2i91pwwdX75kKHo018OjVgtHrnohGyp0PtcS7f816Xz7akX6xr2b5PmjDAqDC1j
         oU9twQVQ5ScrvXkxFW9h1zF9Jdm8gZAi2fUKJgxuFTZYSt2mexAT1QTgsn1hGIBYMu2V
         uvaA==
X-Gm-Message-State: APjAAAWsda8gEm7byiaoUlZmz9BzaZJimS70DNQnzCU4RyjZsqHktWky
        VtM+J+IUl28xDf5n9hfK9h9m4k3hFg1jAnPL/YeCMQ==
X-Google-Smtp-Source: APXvYqyza1onGK2ZL65dtOsaHuiPoV4r7myeGa1KIgljwyyjmR/zF9+g47qeVsrR1uxk1j7Drv/nVRXTvqNv7dE/IUY=
X-Received: by 2002:a02:a809:: with SMTP id f9mr11872478jaj.111.1566416923268;
 Wed, 21 Aug 2019 12:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <1566376002-17121-1-git-send-email-pbonzini@redhat.com> <1566376002-17121-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566376002-17121-4-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Aug 2019 12:48:32 -0700
Message-ID: <CALMp9eQX5m-g=D-J=h86rTrkQCB_BdJi56jGuANrQqv_-gw_Nw@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: use Intel speculation bugs and features as
 derived in generic x86 code
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, jmattson@redhat.com,
        Eduardo Habkost <ehabkost@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 1:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Similar to AMD bits, set the Intel bits from the vendor-independent
> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
> about the vendor and they should be set on AMD processors as well.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
