Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42437217E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392074AbfGWV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 17:28:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41467 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfGWV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:28:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so19779765pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkrR7KYfNoDcAsYt1Gds+pf2LHdaFmbB4lpahf+T2Jw=;
        b=rRggj3sqxFwgCm8YCh/vX3qfGKm5VRHubQNgfCYrbYx+7P5SMvmD64K0V5ZVN6YsDn
         2+DzM2o70B26hCVEcR9DrviwigZ6nrSQq1TBWd9R225/QVL6NqFAniAV+25CkUMZP01d
         u2LnYPnZMnbEZub2w98kUHNolyW7+g0oxX5In2CX2ZK5kWCIqCI8JRTP2zTcCT5bTAsk
         bK+TlK2evbV8J5jTc+KJw+YdkZfaYkN5SUDIQ5u7+kqW9K7f2LLqvPHa0y35PtzMU/GA
         Y54teCzp2hGNXhcwth8mh+8FLrvXGukyMpOwlnI8M//Bfey7qLHxVsTqFBImmA1GfSlz
         v/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkrR7KYfNoDcAsYt1Gds+pf2LHdaFmbB4lpahf+T2Jw=;
        b=MZ9H6m+w3FOYnH/Lw7nYX+YpCOmdgKVfhGcopEtTojgoOO26mUMFtdjQv9QDdK3NyU
         QVDag8SJmcm8pSaWk8e9CuH+GvvutRVxlFz6mSWM95KlRDubsaIZ5XzGtO7k4PtWUIqv
         FyIK8fQuv0pRzeT9DsNbxmXiJFd8kMKb/L09YI89pr7UrA5ObMDh0WFbH6B8we8mXleT
         OeraXnCCvANO+s1IwJp7KTntwCTNtMD+kkrxhbjp8AVchrI2uXZclu0zR8YVAWdb2m2g
         13kYRVADgj54cpLiLRb0wuzbGDRbwOU+2m6nlmVFgVwaw2aWSz/Ox59/1Z/LmL9p625C
         wmfQ==
X-Gm-Message-State: APjAAAUrtgyW7aNCaJDelrOW930b/+yYyRsBPbqF/D3SQTUki8JptUgO
        o6no2TifaAlid8y3KXSaf3BD1vfL6KqFAP+m0+hLpw==
X-Google-Smtp-Source: APXvYqyk35NJ1AMLcOio8BVcbDn442Y/nw305L+RX1QTpaRR6e6aBGPHKYXdZEBwQl12v829wWFaMtIrSL7Vg7eeBWY=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr84880063pjs.73.1563917305632;
 Tue, 23 Jul 2019 14:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190722213250.238685-1-ndesaulniers@google.com>
 <20190722213250.238685-2-ndesaulniers@google.com> <CAKwvOdm3iyeJfuivhQJqXB9FfC0zHgrfgoN_qW4poEyfcw3C9A@mail.gmail.com>
 <CAMVonLjd3DoKQatdraG0t8X_F9Au-fA_vL2RSNfNPNbqvXWCDA@mail.gmail.com>
In-Reply-To: <CAMVonLjd3DoKQatdraG0t8X_F9Au-fA_vL2RSNfNPNbqvXWCDA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jul 2019 14:28:14 -0700
Message-ID: <CAKwvOdkJ2_E4e-mePb4JrQWqS7xYeKGKpcBr_VeGKaytuD_YrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
To:     Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:59 PM Vaibhav Rustagi
<vaibhavrustagi@google.com> wrote:
> The changes suggested will cause undefined symbols while loading the new kernel.
> On doing 'nm purgatory.ro', I found below undefined symbols:
>
> U bmcp
> U __stack_chk_fail

Thanks for the report, a v3: https://lkml.org/lkml/2019/7/23/864
(Tested v3 with defconfig, defconfig+CONFIG_FUNCTION_TRACER,
+CONFIG_STACKPROTECTOR_STRONG, and allyesconfig)
-- 
Thanks,
~Nick Desaulniers
