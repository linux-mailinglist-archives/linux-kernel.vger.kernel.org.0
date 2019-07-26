Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E938275C73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGZBRi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Jul 2019 21:17:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGZBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:17:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so46240224wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=PyCXMsSqyMhAZGXNjl/LLgJrXH5rTtTodNtGmeccrRc=;
        b=mE/ptRKuDKOT6kHISQ9zGfhiTCs1tG5KmgQkDCXrqgkQuD/J2hKmgLJib+6qmp9SVx
         fUdp9tWNO09DDGCZKQ/sQq2kogfLKL91QId9jyWpHvzZ96CgaAt9DLoB+oneSRWzx2kz
         yjekMns23oZVA/HHc3W7XIsa98FjSi525HwPiE08whOtoOBtOE3WPhHpOcjhfd3EmpLG
         wewWIx3IgLt+OcoUXv1VxdcTx9hfkeVhBoWVNO221Sl88IUR8pjxaAWG0QDIU9g+X1i5
         K/3dNe8pOFRihk7FJk/UlsF1vnJYl0CIMmwp4oZP+HoXslk5b9S5zpvu0P4bCBMc8Bbk
         McWg==
X-Gm-Message-State: APjAAAUjNEmE9BmwgcxXH9+b+UgdXT4CH8yBN7zJ+gwiscihwodf5AZg
        rVQBubg1RsqKrPDC3Wh1LjAgJw==
X-Google-Smtp-Source: APXvYqzsdofzpzqp8j8x7PyDzrGzs0VESF9MqPeWBhm0XL8J0qguUGZ/6IXpdIYH/QxN0qJG+wNzGA==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr79945773wmc.25.1564103856177;
        Thu, 25 Jul 2019 18:17:36 -0700 (PDT)
Received: from MI5s-teknoraver.homenet.telecomitalia.it (host21-50-dynamic.21-87-r.retail.telecomitalia.it. [87.21.50.21])
        by smtp.gmail.com with ESMTPSA id o7sm42991766wmc.36.2019.07.25.18.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 18:17:35 -0700 (PDT)
Date:   Fri, 26 Jul 2019 03:17:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190725172205.6d5a3b5896e64f88116c0b21@linux-foundation.org>
References: <20190711001640.13398-1-mcroce@redhat.com> <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org> <CAGnkfhxZUw7wUgE6FRetc52HywgwnucZpqcvg3MTUU0M8O158w@mail.gmail.com> <20190725172205.6d5a3b5896e64f88116c0b21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <5E31E2F6-1EE7-4A40-A7F5-68576C36A6AD@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 26, 2019 2:22:05 AM GMT+02:00, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 25 Jul 2019 11:26:04 +0200 Matteo Croce <mcroce@redhat.com>
> wrote:
> 
> > On Thu, Jul 25, 2019 at 5:07 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > > What does it do if we're not operating in a git directory? For
> example,
> > > I work in /usr/src/25 and my git repo is in ../git26.
> > >
> > 
> > If .git is not found, the check is disabled
> 
> We could permit user to set an environment variable to tell checkpatch
> where the kernel git tree resides.
> 

Maybe GIT_DIR already does it.

> > > Also, what happens relatively often is that someone quotes a
> linux-next
> > > or long-term-stable hash.  If the user has those trees in the git
> repo,
> > > I assume they won't be informed of the inappropriate hash?
> > >
> > 
> > In this case it won't warn, but this should not be a problem, as the
> > hash doesn't change following a merge.
> > The problem is just if the other tree gets rebased, or if the other
> > tree gets never merged, e.g. stable/linux-*
> 
> linux-next patches get rebased quite often.

I see :)

-- 
Matteo Croce
per aspera ad upstream
