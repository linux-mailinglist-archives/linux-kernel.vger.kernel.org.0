Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC410CEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1TCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 14:02:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35172 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1TCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:02:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so20475896lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kms9D4Zy2ihiCy7HMi5BOaZjm7P5PFIIQbQR9jGbStk=;
        b=b5g5gSwguERR/Nzen1eoEVefV7DQz4Lx1FYfgDbApKGYFioIssfoXka7xt7f8cMGpx
         zbgrhxRAEeH/y7eqEcigSJYRkrQYH1zj8Y5N1Co6NZqY0n/bEF12spFmD2GYEp4LQsnK
         urSMJtjl5ImIPkpHpxPAqBgA4Z4umOZAT9ikU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kms9D4Zy2ihiCy7HMi5BOaZjm7P5PFIIQbQR9jGbStk=;
        b=CnW1PeeRZAkewVQUI95jGmzj/EOppgs8K5xPnECnoSpwrKDnWtS8cOT5MFy2tVDjo/
         /oLH/gLnDvtC0RLELvS9VDh9mFKqkWSw+HTZxFRbwTwGne6hBslYx38wG6LgF2dGfL7i
         p9YkZuI04+tHhgTHHq6LMjTHKrqESVXnScn6j+Exsw+PrFPQ433BIPO03yQXTLBCCjA9
         4pMsTJgQ8LP/NSQjTym0dxEKDNKS55/4pnFWa6oy0KbNf+JcOZHrg9yyelev9IZDGYLd
         YW6rD1Vg+kUZGFNDAJHYrhrAhv/MZgj3D4fSmhIacMMZSNcs+VQ8YwzJjDQB7tMxolZ+
         JDyQ==
X-Gm-Message-State: APjAAAUpAuBfKtWlJKeMcKPfjYQJDhJ5w2//qgknrhISKQgDxYsMNnjH
        Yc91Xc+Yffjg0coUi9gx6JsKBmXCx84=
X-Google-Smtp-Source: APXvYqzhaXnnESk5XmraP1QGOLW+umRMJ4+AHlVAPd7cJ7xw1hBcJnqSZHQqxMKIcl+1/BptF4MKcg==
X-Received: by 2002:a2e:80d9:: with SMTP id r25mr9779965ljg.8.1574967715727;
        Thu, 28 Nov 2019 11:01:55 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e20sm1962996ljk.44.2019.11.28.11.01.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:01:54 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j6so20475799lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:01:54 -0800 (PST)
X-Received: by 2002:a2e:b4c7:: with SMTP id r7mr3273388ljm.82.1574967714127;
 Thu, 28 Nov 2019 11:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20191125192758.GA13913@infradead.org>
In-Reply-To: <20191125192758.GA13913@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Nov 2019 11:01:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
Message-ID: <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
Subject: Re: [GIT PULL] generic ioremap for 5.5
To:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added PaulW ]

On Mon, Nov 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> There are two conflicts with the riscv tree - one is a trivial makefile
> context one with the nommu support, and the other is the split of the
> riscv <asm/io.h> which means that the removals in this pull request need
> to be applied to the new location that they were moved to in the riscv
> tree.

The conflict was trivial to fix up, but since I don't do RISC-V
cross-builds, I'd like PaulW to please check that there weren't any
surprising semantic issues too - or that I didn't mess up.

Paul? (It's not actually pushed out yet, it's still building, but the
ioremap merge should be there in a moment)

              Linus
