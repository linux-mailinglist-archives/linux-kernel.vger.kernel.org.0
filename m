Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4932A50926
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 12:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfFXKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 06:44:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41449 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfFXKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:44:55 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so383749ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCgJq21igY0KSeVe2g6442gqLYQ5ESADKLIyY02vYSc=;
        b=sWpjryLMWC9Jck5BhvBy818vz025w73m+vxk+5cRSNFChosTUbM8Ibsf/oUZCg1i91
         eFz4UuoPLt9N/qOCfGRFVV8lH35YUJzRzsniR9zA+9OreKfdbvIiph8izSWCv2vOplYy
         Kyfpe/ykH5GfYmkiY3U0RktDIuItXnnX1sF+gDg6ip0LSNXuiHHx8TbM2bZ0Fa+ff4gu
         oIo7dMNnuVM50xv86XdZnmJB9BlDKa6pD6Mc8JDLOTOkMK0diabW5kZ2UgDHO/ExPBey
         LlBiBkPK6b3+Yo9GojDv1LfADJp60ojVN0UFgvuQq/3vJPI12KKHvi8tudrOEQ8J9D+o
         6XrQ==
X-Gm-Message-State: APjAAAVt+NvNxDcMxYlMP5VvHkI7EBn3PoY/DWN+gxbWK3k03QQDoKRb
        RzWR6nOdhdnKA1arbLi18mXX55/Gza7LgSPqOy8iag==
X-Google-Smtp-Source: APXvYqyDcUV7/ft0Fe+wYR8jAaVZC48EZPDjC0/hFh9o1V9pGhwVl+uquTsaMxl4rwUCXSCbvah6+NItemUjJReLvCc=
X-Received: by 2002:a02:ccdc:: with SMTP id k28mr16948024jaq.41.1561373094455;
 Mon, 24 Jun 2019 03:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
 <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com> <30205.1561372589@warthog.procyon.org.uk>
In-Reply-To: <30205.1561372589@warthog.procyon.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 12:44:43 +0200
Message-ID: <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:36 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> > What I'm saying is that with a new interface the rules need not follow
> > the rules of the old interface, because at the start no one is using
> > the new interface, so no chance of breaking anything.
>
> Er. No.  That's not true, since the old interface comes through the new one.

No, old interface sets SB_* directly from arg 4 of mount(2) and not
via parsing arg 5.

Thanks,
Miklos
