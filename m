Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53584D9C15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 22:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394744AbfJPU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 16:57:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38121 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfJPU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:57:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so21401104otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7F3t4mmhDE8ixnMSKJSDcwBYSg3PtJtG1XKYlXjWBAM=;
        b=sGS7IWL83SNs2b06NBPjGozNIMJ0ucyn8Hd8Y4cAwPgMczJ60ZA1b5nc5wMdJvUMBj
         zqfKDcQyCJxOn2R6qoOczvkVwkrfgyS7h/c4AqzwQJV3fhdxKLOJdjLckajre5ijVsT+
         t265ztYGPJABuZG2Z6ci+Sc/N98ULuCEPkYKpq8UFsdFwl0YjZLJPtYKQEhoWNKty4O8
         P1SwtzS8nK2sBHaeYi0W+rFl+waqxVUAxD/jDPvsYDCPNjqE247WxG7XMbT4YxgpZysk
         u0grysmWCETj0uitZ9z9fcsnBGw/hd1kBCjgE4IGNot7+HHrJHjHDw0A8/YXbmb1kbGr
         m0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F3t4mmhDE8ixnMSKJSDcwBYSg3PtJtG1XKYlXjWBAM=;
        b=OTSKSrO/bImb9YaNwJaeMRJz5xjhBPJiGSdCgnXPmckcer9r3MqiP0kUYY4kg+lxMQ
         X8FIpzrHi4B4YVNOXx7aJnIzx594vXD4hUTuGWIqJYPUhsGXlTVDcjiR8eEsHZk/rrpi
         XeyL16+i8Q6w7L/cpq7EHRtDtdSNsIQ9CbsxHOvqlSDUpkTAZoG2l3NErwCz9/bDkzvo
         gmDPhdUTs08FesKK3WrVG059BEfJzEPAGCFbRdQTEuRFGEcfts5b4os4N/e4R2aRAY/M
         79dSApD7qnGLbpCVlggrZg9HenMNGyCyJXBJCeTu9RwEGBazEjMShvLehoQ5M+OOqmMd
         ExDg==
X-Gm-Message-State: APjAAAWdPzO+6tAruMSSsU8UAb2UctuiesEjkIV79U5GntnSzZ1RPRkj
        XfsxmuTGbHgt9p3cRcg3w0v5dMuOyMJe/dAlSgk=
X-Google-Smtp-Source: APXvYqyjZ/iqnzMUstA7vPTcPNh3dR6SeWebY8/qLXqXIzIzulatBUPi2w68bHznzNY6ol24EyDwbSqlb96U1q5cyO8=
X-Received: by 2002:a9d:ea8:: with SMTP id 37mr191156otj.224.1571259456107;
 Wed, 16 Oct 2019 13:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085016.23676-1-yuehaibing@huawei.com>
In-Reply-To: <20191016085016.23676-1-yuehaibing@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Oct 2019 16:57:25 -0400
Message-ID: <CAGngYiUDYVX8wdBRnDFhH_9buU4-0L8V6R0FGBd29656Ni16Zw@mail.gmail.com>
Subject: Re: [PATCH -next] staging: fieldbus: arcx-anybus:use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 4:50 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

This is a duplicate of hariprasad's patch:
https://lkml.org/lkml/2019/10/8/525
