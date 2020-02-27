Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7F170DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 02:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgB0BrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 20:47:18 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59202 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0BrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:47:18 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01R1kxMJ021932;
        Thu, 27 Feb 2020 10:47:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01R1kxMJ021932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582768020;
        bh=gka4nv6hoOzbwfb7j4YlBZPR1X9FHcvBUbW+Bllno6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rng4mTvuC3n3GOagnxVc5mUyTu39YpuSpd23P+VVp4+Hk20cofBKVJFKUOOQv5Y3G
         K+qS0GK60XrSZNlmEARCRT5qTrKZgDAuo5ngBom4Ob88b13IBA4xoxKoAWDMQCR9v8
         yxtTRzXTz8IE3qN0WdrSZi2xSiSeJMtIcxlB5vpqpxAdBic9qLZItkcLes/fIyC7vL
         C8G+HU5MMiUbpuELUlSJWUJFkfQoTWKM+Al5yzcwuzvjY4MM4z/vPN1CQBEEqwJwau
         GOwGdkcxAVSEWr9l1crmT/z6GFNg/l2zS9f+iYA0theiV5LbHgXrQQXHKCmzEXuJnS
         xKMugWpiyRAPg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id p14so802503vsq.6;
        Wed, 26 Feb 2020 17:47:00 -0800 (PST)
X-Gm-Message-State: APjAAAX0RHM/+CsF3Mi4SSJYejY13j/sLrkTfRY9vGEfrHHpkcbsjBr9
        pQZmyZITs0+3b4DPYY7NtTdpLsvJ6bTAQDNgsWU=
X-Google-Smtp-Source: APXvYqz2gMdIqZp6jmEWo6V6bYnkSsv9Pt66yn+koMjv2AHfNxu7UVya7JTzAMd1ZsC9wZAXV3G/f2BuvBQMLkd3Qw4=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr1167903vsh.179.1582768019168;
 Wed, 26 Feb 2020 17:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20200222110435.18772-1-yamada.masahiro@socionext.com> <20200226221325.GA19817@bogus>
In-Reply-To: <20200226221325.GA19817@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Feb 2020 10:46:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQGQu8bWR5ybcfdWckZ_TsXKBqi3kxtO4=9=WDm4BMuQ@mail.gmail.com>
Message-ID: <CAK7LNATQGQu8bWR5ybcfdWckZ_TsXKBqi3kxtO4=9=WDm4BMuQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert UniPhier
 AIDET to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 27, 2020 at 7:13 AM Rob Herring <robh@kernel.org> wrote:

<snip>

>
> It all looks fine, so I'll drop the questions and apply.
>
> Rob

Thanks for your answer!

Yes, please drop the questions.

I just want to put them below '---' marker.
(You can see some questions in my patches)

I use a tool that automates this, but I made a mistake
in scripting for this one.




-- 
Best Regards
Masahiro Yamada
