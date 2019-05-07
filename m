Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E696916AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEGSyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 14:54:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40515 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEGSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:54:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so12630856lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03Uys/LodQHobuNrmkDI+EEraEEB0uwMGVfOXBSwJiE=;
        b=K1WZMlTVwBp3Swx98o8GlV/oq7Kzpl3yWUPGTOhlU/o7eYV9nXLTyb0enpz+tbwcox
         0SbmYut9wMOX54HOmv8M3sEYWlC+Sw5C6fheSJdC8bky7ZBNWJBbxH7K9aJ3h+s9oDK8
         PSQaBWp2nTgkevaKHVc7kCihTZotTYFSmUBug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03Uys/LodQHobuNrmkDI+EEraEEB0uwMGVfOXBSwJiE=;
        b=FnoviI34pYY5T9DE2WJtV/n8IcpwRJsULa3tBoTYCKAB4A1fFcc5A2s6IoM2WIMp+6
         IWd8WDy7FFrkxAku5fMntHatNnP2hArHdWFRNn95plLE33rNq9RQ8AdbO8FrFlDf68tN
         u6Rf7vzB2GWQYgdFpR7NDlFBvDDczRYQlrjk2D1ANRo5gfXV6Nxg/TrVTBCM8Qlfm+d3
         66xLYDV5RaAeUFiGrd4CO5G/XRsjs/RuBufsJmtplJX7D1zCSsiiY5j9wJz7EU12KR4C
         DgTOQpSX4Nlecnv2e0rg8O8QtkTaybfmMLdkf/E0dfQSM1NwFEw+59veqEguoVaB4zlD
         zo+g==
X-Gm-Message-State: APjAAAUkOEIaqfC0w9KzVU908mn7zKSye2BtgVfsDSkMBNfCIvfLliDZ
        iqa5xGh5+u3LFaKTRzwOmLrLdB0bPag=
X-Google-Smtp-Source: APXvYqzaAPPU0/Re54hj3LrsJ/E5cl6S1uzqXHwFgPSWp0xcEETdf3SVqMqPcj87rylYrnsqcl/sjQ==
X-Received: by 2002:ac2:53ad:: with SMTP id j13mr4104863lfh.14.1557255280580;
        Tue, 07 May 2019 11:54:40 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g10sm3429988lfb.85.2019.05.07.11.54.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:54:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 132so7558281ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 11:54:37 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr16188873ljj.135.1557255277072;
 Tue, 07 May 2019 11:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557162679.git.kirr@nexedi.com>
In-Reply-To: <cover.1557162679.git.kirr@nexedi.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 11:54:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
Message-ID: <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 10:20 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Maybe it will help: the patches can be also pulled from here:
>
>         git pull https://lab.nexedi.com/kirr/linux.git y/stream_open-5.2

I'll take this, but I generally *really* want a signed tag for
non-kernel.org git tree sources. The gpg key used for signing doesn't
necessarily even have to be signed by others yet, but just the fact
that there's a pgp key means that then future pulls at least verify
that it's the sam,e controlling entity, and we can get the signatures
later.

For something one-time where I will then look through the details of
each commit it's not like I absolutely require it, which is why I'm
pulling it, but just in general I wanted to point this out.

                        Linus
