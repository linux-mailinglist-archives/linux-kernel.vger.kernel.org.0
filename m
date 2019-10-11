Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97C1D3C48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfJKJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 05:28:21 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34082 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfJKJ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:28:20 -0400
Received: by mail-vk1-f194.google.com with SMTP id d126so1988997vkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BmKLeZeuNnWZ0vB8RCIluQXj9AINL2+YVjFlcN3HKc=;
        b=DpWhssyjr3YP7xbhtfyz31xwLpO7rpJYmXd8bk84u1JSEyzjKdD0b/Q1IHBHNSTtwQ
         0RBMqNG5TFT5/JCX7FfpTfn65TVF8quxvCoOy9sGtRZdRKLAIiTvbkm2i9/K/yEk/y7y
         jA3spCZVdatjHMdRGAMLeX9X6B+Hw+WP9CmOBvkewPbrznoqMHLhHlhhN8cQUK+VpuRw
         3nrfWZ5XGhYIwKW2tRkZD5zDXtdnuyYcUuRIMFfE8yDhCvisRl4/O07fJZFM0kWd+Boa
         8PM9pRtHDIxbDBsDUa8ad25uoDaa9WQ824Y3wl8L7WF91xhMptpLQttILeh9BRvYE6Vn
         VSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BmKLeZeuNnWZ0vB8RCIluQXj9AINL2+YVjFlcN3HKc=;
        b=Eeqd7AotuDTp+vya7BOXI1OiXoV5C9Re9LDugF/El0guSukfc0iS3SFJUr7Va+gYZB
         atn1OXkrOQS2GPAQDxTJF4TpkuZpQt2KrIvJKTo0ZRO9OZtKGhhQKvyIcs58NdvaOajc
         bAkZqDWJUCKf1HGOvv2OAM97ufvoiSl//3oR2eggmBL15JBHc14HWNC0yEWWgJtwrtzR
         0wSzqBr41KAkgR/CDW+Op/P/przXIQy+R13gnspIWzOv6ibaaaQYzWV95Bf70bpXrf0l
         AcpFIVAbPQ97kwyrTEZXFL1JobhkW02hYK2Z5ApCtWpma9454++ToSjKKvq3JuiAuKyJ
         b67g==
X-Gm-Message-State: APjAAAUb2yFJHxLV1I4HtsPFswjpDyYax5i7DeosIaX6vIST0PSe2RKM
        aA9bbXN4iIpGNtZGxJf9IVceN1IGna0IKugMHwo=
X-Google-Smtp-Source: APXvYqxifFcZULAnguYqZj0sPLHJua+Fygs4sYesne4LMPbaVbGvaUkk5x0ibrsfsPRMBineX8yzq1BHebwdEuWfQ0k=
X-Received: by 2002:a1f:3fd6:: with SMTP id m205mr8128679vka.21.1570786099598;
 Fri, 11 Oct 2019 02:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191010140615.26460-1-oshpigelman@habana.ai> <20191010140950.GA27176@infradead.org>
 <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
 <20191011081055.GA9052@infradead.org> <CAFCwf11hYWYNeROT8zpW+fcALijcTUuGVk-NoWvxzCORvd+dew@mail.gmail.com>
 <20191011092622.GA19962@infradead.org>
In-Reply-To: <20191011092622.GA19962@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 11 Oct 2019 12:27:53 +0300
Message-ID: <CAFCwf130JhgqZq3tPkehorxJVve9cbQc7p--MGvKxB5JOzw7DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: support vmalloc memory mapping
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:26 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Oct 11, 2019 at 12:19:36PM +0300, Oded Gabbay wrote:
> > We first allocate, using vmalloc_user, a certain memory block that
> > will be used by the ASIC and the user (ASIC is producer, user is
> > consumer).
> > After we use vmalloc_user, we map the *kernel* pointer we got from the
> > vmalloc_user() to the ASIC MMU. We reuse our driver's generic code
> > path to map host memory to ASIC MMU and that's why we need the patch
> > above. The user does NOT send us the pointer. He doesn't have this
> > pointer. It is internal to the kernel driver. To do this reuse, we
> > added a call to the is_vmalloc_addr(), so the function will know if it
> > is called to work on user pointers, or on vmalloc *kernel* pointers.
>
> But the function can't decided that.  As I said before you can't just
> take a value that possibly contains user pointers and call
> is_vmalloc_addr on it, as kernel and user address can overlap on
> various architectures.
>
> You need to restructure your code to keep the kernel and user pointer
> code paths entirely separate.

ah, ok. I didn't know that.
Now I understand your point.
We will do that, thanks for the review and help.

Oded
