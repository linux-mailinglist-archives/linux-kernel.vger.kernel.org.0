Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C618084A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCJTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:40:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34438 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:40:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so14413964otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N85h88yMkj8nihjHQm5ShxaRV163FX/geAkJs+oMDoE=;
        b=mUx0pRt/ifhXaLLeig29B1PZojnEWlfUQmKs76Nv0uFBrXGkEImVFyRuM2RtPAKYrz
         uPUV4AhgKlcGGM7ci4cny3Acn0RSgANJXvKZITpusUovp8NJpyby6fv/3pgN944NKPq6
         pJjTuD4ANLUt7oKFFpCa08kjySsiLipzgsaqgw7opqvek6pA9YKQnGP7YkUhsVPUIiSX
         o7LWuk7IzswFmykdgtRgW7/wO6m7C46+nxa4JsJelT9+sTJsO1RctClvfYZPGwnaiTnJ
         pq/+MnDJRWsufhQ6WmqOk76NLBvNv6ock80strcOjO9LaH6gs9P9EpEJ2+2zwW5q/c5T
         4fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N85h88yMkj8nihjHQm5ShxaRV163FX/geAkJs+oMDoE=;
        b=ltBbSAk0RD6HgDxguPNM3ET56tXAPbh0qFgtC9aejMV3BXSVgJdtr3W5879UsNlZdG
         Q+GlU/649nmCaOKuO/IZu0Ue34YWpXProHVXKW/gY+wVtEXSqO5UFureVo0WKcE3jUbV
         rMS9QTXR+L7P5SFlYXCTqTDfmRS/mL0r5VePeMR/xXZ3cUbVSr4A1AQaJytTXZqW6fK8
         CRE5y5QUm8EysVswFQB89XokxMmDbD9wLNTZKlSvgphxCp7rg7hx43xuDA2DCtsLBPPc
         kRTFDMNfp58TaYjwvTthGxZoXNRJehFtFKx+4BQwoo5RLsruIKQJGFcbCqSWKt5Knqb3
         YSXA==
X-Gm-Message-State: ANhLgQ0RVBnWmmc/d91jcSIN/pXrGuR9UpSy+9zmw3j3gx8FJgAWqh1v
        F1dmtWpXZGPTPVdxs3sg5pgLFc3CBFISf8ndICWAHg==
X-Google-Smtp-Source: ADFU+vs0zB2x5mBN2LwbkIDxT21vlEEjsbVqcu9F3uySYfW9yc+09RTDg6Cp1/uTjxNDWK7+b9Cpnh8eqEwsATpjqZ4=
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr17223086otq.124.1583869211573;
 Tue, 10 Mar 2020 12:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200305211632.15369-1-dxu@dxuuu.xyz> <20200305211632.15369-2-dxu@dxuuu.xyz>
In-Reply-To: <20200305211632.15369-2-dxu@dxuuu.xyz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Mar 2020 12:40:00 -0700
Message-ID: <CALvZod62gypsxCYOpGsR6SWwp7roh8eEEKvZ8WNFtjB0bH=okg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Mar 5, 2020 at 1:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's not really necessary to have contiguous physical memory for xattr
> values. We no longer need to worry about higher order allocations
> failing with kvmalloc, especially because the xattr size limit is at
> 64K.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

The patch looks fine to me. However the commit message is too cryptic
i.e. hard to get the motivation behind the change.
