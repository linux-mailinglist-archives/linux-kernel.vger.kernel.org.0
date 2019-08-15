Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CFB8E285
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfHOBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 21:53:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45139 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfHOBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:53:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so548803pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=B+urqSWm85wzvKtnrzAL/ED40jwSYxyNjNBdxhrRvuU=;
        b=k0n8568wNHHsx6zXvAubvU8j+UJLpdwV3DXPjhBjHWiytO90eILwvNbmMyhHXPvvFh
         OmQRZw4zukae4HtVxY8cxBgO55bggVvef2Bmci6q+mRJn7GGHoWlhcA85DFwziG6hSom
         jd9nTZqqPAiI2dNUWoyDdDWXoRt+M5UuLrLedkgh9vJ7/NCAaPE7PVaUNQhQ07CXhWPX
         OXBnh7s9ZiG+CFkFPzUd+zlaKrTTtmkLznfpe1kjOGy5yuNKyXCvus0rU0aNddN2Rdgn
         1HpqOysxM8ZTMBz3CBELPSDLWAXHgfRsU0oggWry1iThcBbfLvZASjqxukZoZsF5IOBJ
         zg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=B+urqSWm85wzvKtnrzAL/ED40jwSYxyNjNBdxhrRvuU=;
        b=auNhg/j5TFhtpnw18eRxo8PrwjRX2Kucnpb4NQQKdOTU0rmssvk29wFSCuqGISZPma
         ocyZU45yKm43TRE5YUtbiUIRZ6MYva1VpK6wM8pj7OP35eAeiTvB7tNWPyhTe/Sho5sM
         XWl/mdmlqWzGI29qXSJw0+CoznQxAGGNnZcRNRoPT+0RBno08BvxzZLnggjJvaIL6I4G
         LTwN5YFpNEEbSnjWHLDsGryGq8Wvpt9zQvHqM/L+O3FAkYLb8jiKUYbQ+hfi6pcEtDb1
         HEGGQ1rF6mWj7Yj14rKmoduImhOjR+/Yiwt2t9pvWct8SOqIDSmzMsk6Z87W6URstYcl
         IQWw==
X-Gm-Message-State: APjAAAULMWv6DjlCYqhKNvBAyOtBGeNtXXmrXrSVCHGuqigWMQ8LiuLJ
        vt05e5sGW/KtwW+8LrbG15FUuw==
X-Google-Smtp-Source: APXvYqweNZweFB0WkL9RkgxC0FIbRYfV4E4lwj7UZo12deQWJbuFOYlGUuOtHlqdw3Q2kaXl0/yDgw==
X-Received: by 2002:a62:76d5:: with SMTP id r204mr2959889pfc.252.1565833992329;
        Wed, 14 Aug 2019 18:53:12 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 64sm1187819pfe.128.2019.08.14.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 18:53:11 -0700 (PDT)
Date:   Wed, 14 Aug 2019 18:53:11 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 18:49:57 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
In-Reply-To: <87mugbv1ch.fsf@igel.home>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-cde08804-6424-4966-84cb-359f3ae393fa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 15:17:18 PDT (-0700), schwab@linux-m68k.org wrote:
> On Aug 14 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
>>> On Wed, 14 Aug 2019, Vincent Chen wrote:
>>>
>>>> Make the __fstate_clean() function correctly set the
>>>> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>>>>
>>>> Fixes: 7db91e5 ("RISC-V: Task implementation")
>>>> Cc: linux-stable <stable@vger.kernel.org>
>>>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual
>>> practice here, and have queued the following for v5.3-rc.
>>
>> For reference, something like "git config core.abbrev=12" (or whatever you
>> write to get this in your .gitconfig)
>>
>>    https://github.com/palmer-dabbelt/home/blob/master/.gitconfig.in#L23
>>
>> causes git to do the right thing.
>
> Actually, the right setting is core.abbrev=auto (or leaving it unset).
> It lets git chose the appropriate length depending on the repository
> contents.  For the linux repository it will chose 13 right now.

Awesome, thanks!  I've updated my config :)
