Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2578810B579
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK0SUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 13:20:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37129 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfK0SUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:20:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id d5so25550385ljl.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwpNndouEqIAQ7+k+dkJbISEfrceAc9l9U5/isaZ+uE=;
        b=VCIoRanJ2BSoE96u/1A8Sh/MjKBNZOlFe6axmVbKRJpSN5et6ww6OxWHsYRv20kLos
         fDeRLhVXN66pcYfCZ8b95qLf2djCsxLD43qN2pdmpoie+a4poE/4ta1yzu0u4yU2zlQD
         Vl7A8lEJsjoPFz3Xr177Yku9/ocjKFVNLH4uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwpNndouEqIAQ7+k+dkJbISEfrceAc9l9U5/isaZ+uE=;
        b=bIiffvQcrlwNugwLbqK3vXo5VqAnvz/X3f4LPZ+TjNhaJxHzgfSy/NYW8/8GdVZjPh
         UPYU8utMXs8cvo6DQ8ORFONkuW9+IhGSA26WHMODjett4hZkp5z8LZUAs3shlMxrrP9e
         g7fzUeJGjtrNr4Xjj26Feh6oagnyOre9KXmCBhA28ZNr1BsCILYZd5ADdBfqitx6P3AC
         3SF6nuU0OpMhNbqsELNvBCfJl4/fzFCDsDmzX56v7Kxx2pBHqXuMsYdq9h9fQ5Y+HmeZ
         yF08uvxZlC9KsNtbiTuVRAFD5tA+5b37SUhmead1bQNGoSqnQzAsvTPivYhXNcII7Xgi
         Aitg==
X-Gm-Message-State: APjAAAW+iB7CdgB8LZ1nDYki0OlW/3eQ+YxdYu8ZFkdWObgnQzUHeqNq
        nw50pXDdBjnbn+ZqEws5KABOoY9rLC0=
X-Google-Smtp-Source: APXvYqwgC2VSbjlCgNkU5TK1BOXCAleMuAPizeRZLEz6LMOGbQgK7HJGoB4SPk6y17vmLk1q8LG3dA==
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr31592678ljp.107.1574878809936;
        Wed, 27 Nov 2019 10:20:09 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r22sm7422446ljk.31.2019.11.27.10.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:20:08 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id e9so25518382ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:20:08 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr31883187ljh.82.1574878808221;
 Wed, 27 Nov 2019 10:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20191127002431.GA4861@ziepe.ca>
In-Reply-To: <20191127002431.GA4861@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 10:19:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
Message-ID: <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 4:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> There is one conflict with v5.4, the hunk should be resolved in favor of
> rdma.git

Ok, so no need for the (now two!) xa_erase() calls to be the
"xa_erase_irq()" one?

         Linus
