Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D811179D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 02:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgCEBc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 20:32:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35311 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCEBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:32:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id a12so4216396ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HMQNCh8vMtS8huYgq84r8uqSM6EgoeBWcfhHoxj7sA=;
        b=IbscVJ4P70dNoJjjSR0QiV/DyYCq0hXkFodHCfvHSxBXyWsHSZDZVJYNFDKigPj3pa
         /FSMSZQxoZ/t/FqRwj6NlivaAFdFFpyI1SJKTu641gQhaIAC3YWjxmAgttClTiN5dqhf
         ygGh6rSsQgCs/kJDBUiulDZKftNDr9hn5nR7sQDEVKitG2bDUQmKhjn4P4jzuJClcyLS
         v3CULB+B/zhm1+0QmZcuseDR/X4PHSQQyIciQum5yjkZn656il4KIfbe9V/9mdZotVqk
         ikRJxdhyBI6yU2XE9+3fS/4YsEp+Srpz0YpR4hplPmyYJcMqmeqttkV477ENMM0UMb0w
         uvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HMQNCh8vMtS8huYgq84r8uqSM6EgoeBWcfhHoxj7sA=;
        b=LnGwu90vz3+zllVo/Rjz77fzmOZkeOsShurwMr1efsFj6zkbUR+NNMsAXkS/vrbKCV
         ZBXEaWr0daZrXgpwJVCcn2CbXVaBYpdnyUDK1rlttsvAI58LVUIn+hB66B/EEzVOSM1M
         w2ypIQxQfoIkHc7hNvVP0elQW0RzNpx439NJZ62Zl2FP+3UplspNEl/P3OXSKewg/akC
         R14ar8uUUHGoTBCVrYnmz/pbVY56XK5GGI5RO59NAa/80BelmUJcO1kYYUDBo1rusqWn
         nLlreDin9gUZRoo0lhd9D004J7aqhmWKVkKjn9O3nbk21nofSjaWPiaqWqAw4Pdt0SyW
         n3eA==
X-Gm-Message-State: ANhLgQ3qzvBOH6Xzu0Jz78bKtPYolHn4I9XXlhNppcFh2lvpE8g/eajg
        suuKUijM1txcJo4JK3c8jjZS26zwL4AjcSORdT0VxA==
X-Google-Smtp-Source: ADFU+vsibVaPx3bCAeKU5DVQeMFImZ4CyqmQaagmYYNUnD0GWRvQYDrsCxTC7PSAw+0kuQYYjGN6XW79WiaDgbR0B78=
X-Received: by 2002:a2e:6a09:: with SMTP id f9mr3438236ljc.107.1583371975482;
 Wed, 04 Mar 2020 17:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20200220074637.7578-1-njoshi1@lenovo.com> <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
 <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com>
 <CACK8Z6GwuOnJUUscriGwKWGBp5PFKyuqUkFYC8tEXa0UEuEZww@mail.gmail.com> <87r1yoxgwg.fsf@intel.com>
In-Reply-To: <87r1yoxgwg.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 4 Mar 2020 17:32:19 -0800
Message-ID: <CACK8Z6EG7gX0ehMpmnFeu4bS_qF8L1dKnHGwMRY=HOv6K39VHw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mark Pearson <mpearson@lenovo.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nitin Joshi <nitjoshi@gmail.com>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 4:29 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Thu, 20 Feb 2020, Rajat Jain <rajatja@google.com> wrote:
> > Jani, I'm waiting on your inputs here
> > https://lkml.org/lkml/2020/1/24/1932 in order to send the next
> > iteration of my patch. Can you please let me know if you have any
> > comments.
>
> Yikes, sorry, I didn't realize you were still waiting for my input. :(


Hi Jani,

I have posted a new iteration of my patchset at:
https://patchwork.freedesktop.org/series/74299/

I'd appreciate if you could please take a look and provide any comments.

Thanks & Best Regards,

Rajat


>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel Open Source Graphics Center
