Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775CE1377CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgAJUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:15:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37371 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgAJUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:15:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so2418599lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoKs7DLXvXqzDjIjK2Ln0baXpWf36RRq1PcuXotv7ds=;
        b=hnSVZpJB53NNn6wqLpSOhHsie6VkBQEhcfCNwu+IHx45RVrdgQBN5WMCD6SVMTtkIb
         AKlODwqEkeLtznWH6lwg/G2wzFnfIZLC+c9uzR45JzOvrs+qQeAoUcNuWZjoe0U3/8ew
         gdD49lYD2Irh400cM65Hhjn8BpzwdZpGgohuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoKs7DLXvXqzDjIjK2Ln0baXpWf36RRq1PcuXotv7ds=;
        b=J2NXgwkU/zGVPs5AbUsZfwyQrophBefEARDb5xcBsACPcbH/DXe/+tex5QocJPqtAv
         ZLjOvb12jRjLNK2bwlWAa8qpU8pURfJ9KUnKOzJeXrcIDVofo//HrAtKh1P77dMv96et
         Ky+DITqVB1tyhESZWZs1k8JKLj73dbUN5Cj8rXUEBJvJNa4YqDCxjPyZR1hjJqcjDlS/
         AnIvL4xIkFGRvFMLIkw+m6tW240HgnN8qS+EadLN39mcLCN95c+GMTevqtIWM4QM9kPV
         Qo0pbZFwSsUZfJAZhxfwuHKcJNxB92+bo7W13/7xtgImKKnn3hVBQQ4NXXj/JDHVQBTw
         VarQ==
X-Gm-Message-State: APjAAAUvhNsT5PuRyUjmIq5gstd8ExtXjmyLNd3irGu8LaHGbsxXFxO0
        u4fsss33gJrYy0JtQ/aiwWGOl5YI33c=
X-Google-Smtp-Source: APXvYqyCnjntwqGeAACyK+vCbmtEnhN6c4xtgNwT1gT57xS2qaiVCLyUAcNpYC93hZMjiR/zAhiIrw==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr3425942lfa.63.1578687302626;
        Fri, 10 Jan 2020 12:15:02 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m13sm1551107lfo.40.2020.01.10.12.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:15:01 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y1so2411774lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:15:01 -0800 (PST)
X-Received: by 2002:ac2:5216:: with SMTP id a22mr3444153lfl.18.1578687301360;
 Fri, 10 Jan 2020 12:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
In-Reply-To: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 12:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Message-ID: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Isn't the read_barrier_depends() the only reason for actually needing
> the temporary local variable that must not be volatile?
>
> If you make alpha provide its own READ_ONCE() as the first
> step, it would seem that the rest of the series gets much easier
> as the others can go back to the simple statement from your

Hmm.. The union still would cause that "take the address of a volatile
thing on the stack" problem, wouldn't it? And that was what caused
most of the issues.

I think the _real_ issue is how KASAN forces that odd pair of inline
functions in order to have the annotations on the accesses.

                Linus
