Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101CD14E5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 23:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgA3WvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 17:51:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43054 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3WvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:51:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id u131so2395030pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nm7q/eqnnGMhJ4cSfabctzSKxn0MOorqNV0sKFngedQ=;
        b=TMfOq3Cm7tFFkVWajkEH/mOlfghX4QyLqQHqYZZWR4V20ArmjrlHpz0d8+8xSByinZ
         hdNbCAldYk6XW/2l4H6+W+D99nfYFDFdlo1JF1zsEkJxE9vw/m1xetfRlk4B1wB04LUf
         vgQJJnXFxYGn+sGKkA8pUh58KRPmTHCO35p+LwSV7Wkci1t0zGgCnSKFVsD3CJRVFyCo
         Hx7zchW0IfdwQSjwaOeDPLPmvT/qzRZbY0PFmpfI+3jsVs5e+ZwXMFUc5OJY345A6bMq
         pB48aI/3uWmIP/mXK6bLsZAtTLERYf85LGN/IzjM9ZEQtYWVvQ1wOCqgnYJxKRvVLiz2
         DaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nm7q/eqnnGMhJ4cSfabctzSKxn0MOorqNV0sKFngedQ=;
        b=TBGGFUIez4Hf/PSatalhPmBGUeO0SalvSVSsmI2B1xb8nPRVU6CTqS9zdvQ6g2/dt+
         TuuICPt3wbqUJxWXhDdnjQbLG1x/AFuWSusvoXsUbaH/7ZqIOpZG7mphFyKtGgZdMgTs
         txf20Le7eixahNZ+Ei2Un69oXjQsl3X/n3yCfLLEVGbwsVVOWl7ENPzQ1w1qmlZTooa6
         tx4y56pGdXyh3AW61L0J/aCrz+Sfkgt+oayPrAf6EmF1RxNWEytL6MZe7NbPZm3wuuaN
         elIrLIEETASmXjXStQ1otyKYi1zHcoNw8kualeGMf1VabrBnv5/ZwdZiS3Rmq7aslbX7
         CskA==
X-Gm-Message-State: APjAAAUBISqCWKKW+lgT6cf3+k9iur/30NwiTI+SW4Y/f5KLXast6NLM
        p4cj+xqWVwYL7zlLUW4x+DtxCsQsVwiaXmkcLRIr6A==
X-Google-Smtp-Source: APXvYqx0i4HutGZ0NwffQW6YWyeSX4LgIJj846OBe2RwSGkQlJX/8HwMxqcna9y1bwf7blHqEu8eaWZyufGuXP7EBl4=
X-Received: by 2002:a63:597:: with SMTP id 145mr6755667pgf.384.1580424659726;
 Thu, 30 Jan 2020 14:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-5-brendanhiggins@google.com> <20200129063836.6C2A62064C@mail.kernel.org>
In-Reply-To: <20200129063836.6C2A62064C@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 14:50:48 -0800
Message-ID: <CAFd5g440ENddSAGA=CQhE-RZQAC8Hh1_+EOmfx2oDueB-EZXLw@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] init: main: add KUnit to kernel init
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:38 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:19:59)
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
> >
> > Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Although, why can't it be squashed with the previous patch?

I think that this is pretty much the smallest logical change that
doesn't touch just KUnit. I figured it might make it easier for people
not interested in KUnit what changes I am making to init. I assume
that people don't touch init willy-nilly, right?
