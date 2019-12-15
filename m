Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670CD11F56A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 04:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLODRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 22:17:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43502 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfLODRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:17:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so2944607pli.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qw7GdobDKaisGqFcCqov7HH16/PH0v/fdoTK/utz/dk=;
        b=szRkUEKYuobVKh+VLYMU6sYS5xgFvUr5j8ECJA20DbOjRWaV5h2/WIkZ56CKyqeLCK
         uoLdxiU98iemsr8Lu+haKhz+Tj69fGlSG/0s1r7Bg6A9Yvo65E4r8Lp7orB3/W3P7puD
         IvCbj0RDT6i1z0AfvPw5sIsXx5vS2yii3rv/RWvavvcT3qIn4rCSjq+xzDO+8cPCbMQx
         6YKwgCLDNFRHJ0oJB3ohuDFhDDLIXrS7tkCli1SzkzqGDiEoCw1LA+8ZAr7U1zqB2zj/
         DAcdPw75zJ6v8Fw0EZXEuxzoJuVbOVIuD/nnovwh4FysYb5+Q4rGezfLQ7GWa+jNCWlz
         JN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qw7GdobDKaisGqFcCqov7HH16/PH0v/fdoTK/utz/dk=;
        b=Xt/sNXrBTaHrjcFqHd8uFkJ4aSIe10W/dVEVlLxcZceE4evzX7+jC+rN/tMQd1kU9s
         pDX19t/KlJ1FUPah+JU1wVrk4qUX9/Yz5mEZZQizyR1JHJsxRHKN1w+8oJFKLPvXAHc3
         AFnuNxcP+Bnyf96E7lsHICtM2rxbZ2QWhSvzyil7dLnSYsDbvVKkJiQCawUUxtV3MgHl
         xvMsZgvv2P0nIVt0OTmCaV+lTY2AYuKL8w3TquzN0syj3ZC2uHszxo/lSbiC/d+aW0cc
         Ohbbae5ydhEenXuEgKwOzYSUgLzy9HsY7CqcEfRTbQ2zX9KKbbGVzH/l3xU6Wy/tR2n4
         yryw==
X-Gm-Message-State: APjAAAXeyGpRQAigW/xkUZU+nOYvy3iqauhpTS6vYwPGuPg+iu4RgHA1
        WfhGk9pJHz5rwZeAnP5wtqnTCGtzOFHDQPHTf1rHM1G6
X-Google-Smtp-Source: APXvYqwrgwLwljcFKO4bMrhekEcasQxZ7GfNWAO6On+Dem71755HhK+vwyLMrrUPb1RjgRbNUoCxafLSC1kMMTs74NM=
X-Received: by 2002:a17:902:744c:: with SMTP id e12mr4015886plt.123.1576379843907;
 Sat, 14 Dec 2019 19:17:23 -0800 (PST)
MIME-Version: 1.0
References: <201912100401.fDYi5lhU%lkp@intel.com> <20191213111649.GU32742@smile.fi.intel.com>
 <CAMo8BfKhSkHapX=mDhauZz8pAwR+1DtDNL=oE_RNhmaSQ9V_Zw@mail.gmail.com>
In-Reply-To: <CAMo8BfKhSkHapX=mDhauZz8pAwR+1DtDNL=oE_RNhmaSQ9V_Zw@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 14 Dec 2019 19:17:13 -0800
Message-ID: <CAMo8BfLHnAcvC40dpzzYpSYhSuxhPjKsDpZWn2V7spvQWB3smQ@mail.gmail.com>
Subject: Re: WARNING: lib/test_bitmap.o(.text.unlikely+0x5c): Section mismatch
 in reference from the function bitmap_copy_clear_tail() to the variable .init.rodata:clump_exp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 1:08 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> I'll file a bug against gcc.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

-- 
Thanks.
-- Max
