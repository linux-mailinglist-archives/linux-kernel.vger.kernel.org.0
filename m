Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59961148BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfLEVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:38:43 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:55368 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLEVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:38:43 -0500
Date:   Thu, 05 Dec 2019 21:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1575581920;
        bh=TahmvQxEoJ73UgzTTSfiorqsBl/xE8dToOFM0GMp/Bw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=VlqyezfN2PpyY/eTh6hVirTExN4aeSjp2TwwCzOq35jeGMJ4T7xIFip1WxKH4lBiJ
         9V78X5ck52bhgYf/yJaI5Kde1uMFzzk0iMZfrmcOEndNxhOYES7OkvujNl+WY4fs/+
         LwpwRZ77ALMkJzWb2TWV+pgqNgGhceD0HVquA9ZI=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Don't use cpuid 0x16 leaf to determine cpu speed.
Message-ID: <4Udy8mtfrDyzOi7GIUn2HDFwbr9HwBXLEQ1bPof3yvTKKYfcGlKd9c3RzGq-okmPQz4Gr3N-kapF-jiTJesrU2LGxQ9c_vtz5-2rhyR87Ek=@protonmail.com>
In-Reply-To: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
References: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, it doesn't work. I will follow up with something better
in a couple of days.

I've bisected the bug and it was introduced on
aa297292d708e89773b3b2cdcaf33f01bfa095d8 - I will start from there.

I would appreciate any feedback you have on this topic.

Kind regards,
Krzysztof Piecuch

