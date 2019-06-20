Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF24DBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 22:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfFTUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 16:54:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34644 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfFTUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:54:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1878440plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzM+nSzZADFLmLVhAQE5b18OebXV89v5MtutF00qYdI=;
        b=XeeY3ZRxKogcT3JJRz5OzSakGkmmClO1FZDE11x0BQ6G8i4mDSowUiYbaAcFe63yIZ
         Znu6lfUBiKHlHayosEjj06HKKe99m6CFoRtWbkvYNKciwBxh/7EKIZ+K3m0jV69C4AL+
         ShFJ67Rpun7qnsh8gpiLwamceO3jyKINwA9cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzM+nSzZADFLmLVhAQE5b18OebXV89v5MtutF00qYdI=;
        b=AGFx2bHFkaJmzQyAk3noqZmMGl8BPQns64JNjsf1hSbaf7Wpo4oAMjEWHeJF78gRVN
         MS9deVjotMeahQWTlJm0CF9vXMg6fdhxjVqeGAEP9W7+ICU7Sphqyxqudj7SFcgKgw8O
         ftan6YJ86LgBjrdjBa7exH9gBkFMOvU3QFlKpdC1CL5SYy9V/B7nBgPcTfAMRaG15/Ux
         ybj69kCzjpmeVwqw5AVs0kiToHzdAMw7iofnA8kNnE9ODZF5tY6THtJeEBEu7tPFWJSp
         xOYLJFk9qPKbY/bvOMk7tTJEejWu/r7rGhVDJViSFJVgTer7H54DLV9Q0Jg9sfJ4lC8A
         axKQ==
X-Gm-Message-State: APjAAAU9PRJfwutkTIRHO7orTXt5Gpv/7B44RZLqtcQC4hV9/9i+Taef
        pMyBIngeqTC8f45m8iU95KTmFQ==
X-Google-Smtp-Source: APXvYqzEeogb+6WVejeoyQ8UjjuWf4LBvek9BRvj/NG+tj2RayXz/hNSGKMpD2NAXrxY6wZFnH85Hw==
X-Received: by 2002:a17:902:b18f:: with SMTP id s15mr130515351plr.44.1561064049388;
        Thu, 20 Jun 2019 13:54:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a16sm385309pfd.68.2019.06.20.13.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:54:08 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:54:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
Message-ID: <20190620205406.GY137143@google.com>
References: <20190620184523.155756-1-mka@chromium.org>
 <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:53:22PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 11:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > gen_compile_command.py currently assumes that the .cmd files and the
> > source code live in the same directory, which is not the case when
> > a separate KBUILD_OUTPUT directory is used.
> 
> Great point; android builds the kernel outside of the source dir
> (`make O=/non-source/path ...`). Thanks for the patch! BTW if CrOS is
> doing cool stuff with compile_commands.json; I'd like to know!
> Particularly; I'm curious if it's possible to generate Ninja build
> files from compile_commands.json; I do miss Doug's Kbuild caching
> patches' speedup.
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

At this point Chrome OS doesn't do anything with compile_commands.json
for the kernel. I was just toying around a bit after a presentation
from Tom Hughes about IDE integration and encountered this limitation.
