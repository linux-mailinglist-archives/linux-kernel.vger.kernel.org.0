Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF0165312
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgBSX2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 18:28:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:28:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so1945547otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sStAZIFkfoiGKnyy+o3ymK8EDXFiXckmY9Dx0LZ9xLI=;
        b=P8rDLq+0/5Ms07CoQOm7RWCYWI4Y6T69lFIztWuk6fzFCZ4V/+9o2Aa+f1as9zo0f4
         LM4XEk2QvUkwpJOIqn0IyVgJ1FE80NXrnIKCYuwIkrDJUN7iPrgQRRBrT7X0I4NLDRAA
         wihLVlpYrwPd5Pajc7yGdYq6sf6bZ7Xbz6WiT3ybiYD/JZEDVTOkYqoZ1ywSS/2JNaAK
         JI3KzJlKm0s4UUT/uP22nYAQrgp0XVDaLDtZnZ56OHW1HFUwpEhLKifbG9fZG/fB1D35
         HQ5D5lznEXsknt7jG2AdHTVP6NnLKNiotnUhE1R6HzEpAjW/0+czxitvVsAPUB5w9f9c
         +4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sStAZIFkfoiGKnyy+o3ymK8EDXFiXckmY9Dx0LZ9xLI=;
        b=DqMBjSN6HpPJpxlggZYMHKMCcmJ0oXHd7aRZ3CN/WPVdEdWeOZUCuxjw9O+iVGF1WH
         knURggbRgqo4vzN7nyWa7PwUpaNKSdSHfghbUkXvyHBU4W2URDX8WcgK3V8/b+nwJNPI
         z+zonymZpuoLm8IF12I4Lk/yczi9ibFYmt2r6gqoZWvUjZqWMM3XW9qjqTsTmOYPkodg
         2WUt/KrNEQ2S3DlddBUCcW2U0CxhztYC0VMDImVx/7+wNfQNTW1uuoIw9VqwSesmktoI
         BBG5Sz8hAmlUisOlTZ/KO3KCAEaDPXhT61HRXdrl5F0Y+HfYoputKjGH/8UYjXtuooMQ
         EJAQ==
X-Gm-Message-State: APjAAAXc9CGEHw8PnZcXNXO/GPsfPQtRlLOtH3wObG0RXziH0TDCLGaU
        EyQr5MGv27DrcGvhdVBlKol/geIavGE2+DZ7XLrhgA==
X-Google-Smtp-Source: APXvYqyIfDUnaze1136RuA0l61GFBDOfRpdXS/K2ZvvJld0a+9lkVYztyOKq4/WDxGKOowvPmWRRYD95z0YwhQTX0KM=
X-Received: by 2002:a9d:6a2:: with SMTP id 31mr21024082otx.313.1582154916187;
 Wed, 19 Feb 2020 15:28:36 -0800 (PST)
MIME-Version: 1.0
References: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com>
 <20200219012736.20363-1-almasrymina@google.com> <CANiq72=DUyJA0u7buHv6gJiHib22ix-1Krgacx-vCkU27j_Qzw@mail.gmail.com>
In-Reply-To: <CANiq72=DUyJA0u7buHv6gJiHib22ix-1Krgacx-vCkU27j_Qzw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 15:28:25 -0800
Message-ID: <CAHS8izOBDxoDqyOQ2RkndRJ09yf2qZfoUvKdVqqfMXuKsYRjVg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: Fix file_region entry allocations
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 6:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 2:32 AM Mina Almasry <almasrymina@google.com> wrote:
> >
> > - Fixed formatting issues due to clang format adding space after
> > list_for_each_entry_safe
>
> Note: that's because clang-format knows it is a for-loop-like macro,
> so it formats it as a `for`.
>

I figured it was related to that, but it's still annoying as
clang-format works perfectly for me aside from handling the
list_for_each_* macros. I tried digging into clang-format docs to find
the setting to add to the .clang-format but I couldn't find one. It
would be nice if someone fixed that.
