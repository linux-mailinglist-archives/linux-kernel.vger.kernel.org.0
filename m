Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B864B1631
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfILWMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 18:12:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46529 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfILWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id i8so25268090edn.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uw+By8uPhtt1B4rmiquJCFolZneVMTSbfQHHffSvIIQ=;
        b=H+x8OaMwIVhaQKjfeCoic7a24QjeAQPuJJocr2jMyn+QXyrVvZs9p37huRZtIsi4TW
         BXo9pQJRqUgJeizoGJkSR1BIah7CTPiic0FmVyqByMwdzsyJmBKDrsOZ86RQVS9acyqj
         Ci4acuuGe4J0jem2ju6d0EbSWs/3KQPPcH1VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uw+By8uPhtt1B4rmiquJCFolZneVMTSbfQHHffSvIIQ=;
        b=KxeP/KnpJKJ0iadXgMGARpao/cQY+mWPHWet6IQ8OffQhe9ZY/JGfueC912YOQWEAO
         MPwpYDXb2vHCYDs/gDauZa7DnN91avG8D0OEy5u1FAeKD8GEkpIjsWuZKUAO6hTMhb8K
         7ccYI9yH+Bb7lraD2rdWoK/WXfUGl6ApXZ/Wk+1E1Hm902EZp2uCDqbXmw/uwC15SbSK
         qVQnzWyTevmMmuWysV/d/OsMEEeZutaNMe7BHbJTGfHAy51X/+dXzEx3vyIskqtRlM1z
         i5lvgl809eBzJFxqjDzF8zBRqf7pafFDofINZVWskfXKrKMlaiqessGvVvNy/CYxUvSv
         Ji4Q==
X-Gm-Message-State: APjAAAVXLzRzwpllB2Wxty/S2EMHLUh5v/Lg3ZlCBvwVLYnOF6KtlgkA
        1FSAu2/R/wpmxZMx8C388mu+Pg==
X-Google-Smtp-Source: APXvYqx6evvaLgxc7RWLH1l0TKA3Dk9l5nArd4TkqR24aHD7dPyHk5X+q2asFpxQd3F7Zm29wPwT3g==
X-Received: by 2002:a17:906:4547:: with SMTP id s7mr4297335ejq.55.1568326364163;
        Thu, 12 Sep 2019 15:12:44 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id d24sm5071574edp.88.2019.09.12.15.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 15:12:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
 <20190906220347.GD9749@gate.crashing.org>
 <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
 <20190906225606.GF9749@gate.crashing.org>
 <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
 <20190907001411.GG9749@gate.crashing.org>
 <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
 <20190907131127.GH9749@gate.crashing.org>
 <CAKwvOdmhcaHpnqhMwzpYdjjwfAhgzq7fqA0Hu8b19E5w3AHz4w@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e4bf09bf-3aa7-aa7b-529b-f930dc75be4a@rasmusvillemoes.dk>
Date:   Fri, 13 Sep 2019 00:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmhcaHpnqhMwzpYdjjwfAhgzq7fqA0Hu8b19E5w3AHz4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2019 23.54, Nick Desaulniers wrote:
> On Sat, Sep 7, 2019 at 6:11 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>>
>> On Fri, Sep 06, 2019 at 06:04:54PM -0700, Nick Desaulniers wrote:
>>
>>> How would you even write a version check for that?
>>
>> I wouldn't.  Please stop using that straw man.  I'm not saying version
>> checks are good, or useful for most things.  I am saying they are not.
> 
> Then please help Rasmus with a suggestion on how best to detect and
> safely make use of the feature you implemented.  As is, the patch in
> question is using version checks.

I was just about to send out an updated version. I'm just going to do
the check in Kconfig - I didn't realize how easy it had become to do
that kind of thing until Masahiro pointed me at his RFC patch from December.

Rasmus
