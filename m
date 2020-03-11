Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CEA181DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgCKQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:21:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40080 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCKQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:21:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so3006967ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wRqHRwvmYRYhmXsXy7AGGNNPT7p4XfIy/7Zs7myQjo=;
        b=R9KvMInv77iX75P+5glKEo9kPqEMRGzLlaxu3ohT58/6av82nvhnJvOlEcEUcDT5wN
         YRKRjUGHZSsPrGgKB0nbdUcBjc28d8DP/JR59fN5slvamddNiORZmLU5oaRlZKiR5jaI
         5NQmxVAML+zK/53hVUBPZ7w/J8mtqfs9e3N2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wRqHRwvmYRYhmXsXy7AGGNNPT7p4XfIy/7Zs7myQjo=;
        b=kGIdxnpf93g2HyIEwlS+mekN03+hdSYtEPSQJHqOmynPPjgRuDh/1yMb/xNMbcu8EF
         hWdLAKuoSGPv8nIUsb7W7Yg7oxPcY0Gh+omuSGQpKTIKcJSIKH3UemD8XfpDlG9lgzri
         0hXPgpwxlOxE/DcTTqjrjBmddV0n9KgzhI8CPn356CncqrT194OF01OmhmBE5atf+Tm5
         dTDpMZnH1tnzl1zdAsW2ogWycsDbdRXSunA4RbUD1WepHxpkLHh7uh+Cibe5roD3cZXl
         y3atuoVt5m8f5mg9fYorYvc4jNTay/zk8JY+sD7TXoYAK0X8zae6bCiOd6xdtc8IQKw8
         KKfA==
X-Gm-Message-State: ANhLgQ2WjWP6iXMjeFo7GM3AGWdcojPU4rclMipW09ZMFcXwnT7nLka5
        Ww267oURSSdQN10Q6H2xgzymAO2glHY=
X-Google-Smtp-Source: ADFU+vvmVDOh426r5IAxnShUhXy+uMefkG1t/uxK732tHyKYeid21egBO770cPRQCbPsbNha3SMIBg==
X-Received: by 2002:a2e:9b94:: with SMTP id z20mr2555447lji.147.1583943678652;
        Wed, 11 Mar 2020 09:21:18 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e2sm23902527ljp.55.2020.03.11.09.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:21:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g12so3031842ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:21:17 -0700 (PDT)
X-Received: by 2002:a2e:6819:: with SMTP id c25mr2633970lja.16.1583943677157;
 Wed, 11 Mar 2020 09:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
In-Reply-To: <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 09:21:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
Message-ID: <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
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

On Wed, Mar 11, 2020 at 9:02 AM Artem S. Tashkinov <aros@gmx.com> wrote:
>
> With this patch the system works (I haven't created an initrd, so it
> doesn't completely boot and panics on not being able to mount root fs
> but that's expected).

Perfect.

I ended up applying my earlier cleanup patch with just the added
removal of the kfree(), which was the actual trigger of the bug.

It's commit e423fb6929d4 ("driver code: clarify and fix platform
device DMA mask allocation") in my tree. I've not pushed it out yet (I
have a few pending pull requests), but it should be out shortly.

           Linus
