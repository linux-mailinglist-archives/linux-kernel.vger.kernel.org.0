Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5487181DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgCKQYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:24:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCKQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:24:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so3062619ljo.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewAlQHQt8dNmtJm6MPN3fd97uVC477VMUv7XsNvWER4=;
        b=T4CQInzmlM2NS3Aw7NWKi1zS/EPg/I3ePyu2SZ6CEEMmQlPuypdSz89daz11monzuF
         Ah+MttBb+norGtqwBrEU/TbbOCS32LF7TwYCBY95bzhG0y61XDLQQ5mVUplCZol/nK1C
         guY8cMZZTIhfPI/ExVsw1ygxAVbRY1ifDJhlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewAlQHQt8dNmtJm6MPN3fd97uVC477VMUv7XsNvWER4=;
        b=r+sozeJLACyqIuFjou7ynz5T0djE3rvELsAJO/YIFCzNaWhDw5Nf3JLcdHLhJLz7Na
         cRm2BNNPKOlers+Sh/Dq8XO+CuVeLEiyOoys2tU86mJfbvQ8/5FLDyy5sgP7QyZ2LCCj
         cNNKel45oJ6YRCMCn2Cxe+Nk59EWBj4kz8iwofHdXHd4y98CFES2zajoPJdaCEFh4+Dq
         ntdoARtxLeQeGHY3NhvwQB2zkhTN+2u35kQXRe0y8wMDV88xtns8/JFal75qZ/wvSfdB
         PTgdll+OZXY46ByVlEbAy6SiYGcRVln9IH9oI5C50i5anBd5MAzA1tpQsKCra9AI/SlZ
         feaw==
X-Gm-Message-State: ANhLgQ1PI4k8nw3zeDbHhne+OCK6M9hHSZ2xYUgiIdPeNVxcQZwBmHcH
        NuaPnCRDAPvfLKKaI1zgZTp96IojeIk=
X-Google-Smtp-Source: ADFU+vsncakXkVONABzYp5T/x62RhroiD8voxvkdIOL5PAayPRqhe41/swn5/YOVl6iZeUojDnwgYQ==
X-Received: by 2002:a2e:9c4:: with SMTP id 187mr2637880ljj.89.1583943880228;
        Wed, 11 Mar 2020 09:24:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g16sm3548838lfd.7.2020.03.11.09.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:24:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r24so3046030ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:24:39 -0700 (PDT)
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr2626766ljn.201.1583943878724;
 Wed, 11 Mar 2020 09:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
In-Reply-To: <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 09:24:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
Message-ID: <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 9:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's commit e423fb6929d4 ("driver code: clarify and fix platform
> device DMA mask allocation") in my tree. I've not pushed it out yet (I
> have a few pending pull requests), but it should be out shortly.

Actually, looking at other emails in my mailbox I see that Christoph
send a patch with a sign-off, and there's a reviewed-by too, so since
I haven't pushed mine out yet, I'll edit that up and give credit to
Christoph properly, and add the reviewed-by.

So it will have a different commit ID, updated message, and be a mix
of my patch and Christoph's.

             Linus
