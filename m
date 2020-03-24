Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20F1917A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCXRam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:30:42 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35730 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:30:41 -0400
Received: by mail-wr1-f47.google.com with SMTP id d5so10225634wrn.2;
        Tue, 24 Mar 2020 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=waYMRqT7UwmXphz4d1wXt3KJaI3s/lKvsz6/LN//g4o=;
        b=KTM1fZIUREMzyWUUwwZOrfUsfuqM6I02SSnfl/hY5iC7Q52xTqXDqpwSAEHKivD3SB
         QrxjpjXtkiCkOv8eptRLI9bk7cib6r1GCQqk7oGNAJJzQ1NM8HyhkmyQugza1d2jFAWc
         YvV1Kz3yglRC4cKQ6zPp3LJBn1nzOPiCI9/CWRJGSeikGOd7H39txG6Goza/dpzaO/uR
         zotIqSulMqlSmhksih9WkI1ybrZ3WPJ4ZgFTDQcB2MqZ3pjAB7niM/nzf6GZXWGmaMqV
         OnBGhCOSgbRSSipqxOlWdniWKPNWuRIwiM7jfZThWkTa3Hsw4NriHAEjeBmOwDd4OlAs
         B6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waYMRqT7UwmXphz4d1wXt3KJaI3s/lKvsz6/LN//g4o=;
        b=ReE5HI+yDci308E7uBJKbAHxW9937VB0AUTeNoE2rcib+2rVZ74TWa/ojiZeyTBclm
         LYdWrdr84uRzf2NAbniFCNUbIb6E+nMsCl4KyINb4nyzEcocLcJezZaX7KvLYv2SpWKq
         MjyxspYGpaF38WFjxzeuUC95cSGkVp4tmP5g8x7blJTfHUq0sOKAv/BGuYumhMBZU5wL
         6w8n13nc9jE4k5+IRM8scRTOPRknENSIL8enFawdg3NKgv6dQpfDsdmK8+pzJkfa4N6/
         BKz2yzlCflx3oOe+UpRiZG6gJ8+koxiGf5bONJgJYJtEm/9/8ZX3PFLHstEJ5T4U+png
         Ftcw==
X-Gm-Message-State: ANhLgQ23pj8b0ZyTidII7q7i23ww7LOE2foJceI5Fg14M76XH3u7hTh/
        VN1owFXlYTAW2wPuaJBQ8G1nrwDB
X-Google-Smtp-Source: ADFU+vst5PxEIUoVZSVGlAPPV2/4JWatchld2xrKpRKxU9ytzO/pyHOr3+j9/ptNROkG10jQy3u9nQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr31371172wrq.62.1585071038744;
        Tue, 24 Mar 2020 10:30:38 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id g2sm31042015wrs.42.2020.03.24.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 10:30:36 -0700 (PDT)
Subject: Re: Versaclock usage and improvement question
To:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHCN7xLbV5BxD9PYfxNC7M64WK1nf3Y=zfeg=PqF+XgwvyZBjw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1352fbee-c768-315e-4042-d666db3d9456@gmail.com>
Date:   Tue, 24 Mar 2020 18:30:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xLbV5BxD9PYfxNC7M64WK1nf3Y=zfeg=PqF+XgwvyZBjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 6:15 PM, Adam Ford wrote:
> Marek,

Hi,

> I am working on a board that uses two versaclock chips using different
> i2c buses, but it appears to the driver is hard-coding the names of
> the clocks.  This appears to be a problem when the second instance is
> loaded, it fails, because the clock names already exist.  I am
> inquiring to you as how you'd prefer to see the clock names generated
> so we can do multiple instances. I am planning on using kasprintf and
> following a pattern similar to drivers/clk/keystone/sci-clk.c.

I never had a board with two of them indeed, sorry.

> Secondly, our Versaclock chips are un-programmed, so we need to both
> enable the clock signal and set the output type which means adding a
> few device tree options.  I am curious to know if you have an opinion
> on how the new flags should be named.

I'd say, send an RFC patch and let's move on from there ?
The chips I use are factory pre-programmed btw.

> Lastly, we're going to use the versaclock to drive multiple devices,
> and some of them do not call the function to enable the clocks, so we
> need some method to force the clocks on.  Is there a method to forcing
> the clock outputs on similar to a gpio-hog holding a GPIO line in a
> known state?

I think something around assigned-clock DT props might help here ?

-- 
Best regards,
Marek Vasut
