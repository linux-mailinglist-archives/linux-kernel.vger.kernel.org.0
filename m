Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6E16BEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgBYKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgBYKiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:38:55 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B731221D7E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582627135;
        bh=znm2D4PmMgm9JZjRjbgLKQfutNaFm7L/OldhxXmYlCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06+lvJcVXmBpXn1avAjOL0BePxRGWsbXl5DcvzpXiOj+JcEGf+jHQQq4EBRIq2I/A
         XlQIMaN4OAWtSgppWKTl4p9Rbwukrwgay0+WZMfyIcf8LvTcfRX+/7FPKleCFHr8Tm
         Gmj+hgjGSDOoyUyN/P/jb7m+vi6LFMIKK2s8jWb4=
Received: by mail-wr1-f42.google.com with SMTP id l5so9853464wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:38:54 -0800 (PST)
X-Gm-Message-State: APjAAAU7CwugW3hAiKE1KOugZznS0O6HhH3WIrEP07Xnk7b42pasEhid
        YYPAWHLXg6+c4NbEjhkcT8t6i9DsDXhoPzlooZYn0w==
X-Google-Smtp-Source: APXvYqzOiI4/W8Rvpu0osBmhpfrbgs5jUmWtiMeqyyTk+24SZyBFmY8xIxOk3+1Z+RBlQHjL60qhUbVnt4vfJXMTyhE=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr72425217wrv.151.1582627127547;
 Tue, 25 Feb 2020 02:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20200221035832.144960-1-xypron.glpk@gmx.de> <20200225032500.5b6be465@lwn.net>
 <CAKv+Gu9sjOS7S+T42UcdnA2JCwgKawRJAdKHcwXWQXQaHSPZDQ@mail.gmail.com> <20200225033802.4e7c09d7@lwn.net>
In-Reply-To: <20200225033802.4e7c09d7@lwn.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 11:38:36 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9bn_0aEZwTO7FRteYF9MO+7AOU4OJzNVsi359R2MkWSA@mail.gmail.com>
Message-ID: <CAKv+Gu9bn_0aEZwTO7FRteYF9MO+7AOU4OJzNVsi359R2MkWSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: add libstub/mem.c to documentation tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 11:38, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 25 Feb 2020 11:26:01 +0100
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > Given that this patch depends on work in the efi tree, I'm assuming that
> > > the docs changes will go in via that path as well.
> > >
> >
> > Can I take that as an acked-by?
> >
> Yes, of course:
>
>   Acked-by: Jonathan Corbet <corbet@lwn.net>
>

Thanks Jon
