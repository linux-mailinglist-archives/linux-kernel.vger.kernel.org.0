Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F9C28F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfI3Vkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 17:40:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36383 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3Vki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:40:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so8219690lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Act6rfhr6ll6+lxDGIt9p6YkkxuZ3qqsousOClbC28=;
        b=V7RLMXPETXEXeWwE1Sbnizu2qEFIZYZq5cHmesMNso3mhFcDh0YU3w13uEDwi4/e7M
         gJ+BO6drpJpEQ0Js3lc9uRgVOARgIqUEGJ6wTOYYpcZxE8hNq1rhk8iDoPfDqTkT+AwE
         a0YtiITRaLk9xBmk/4pRQlcopVx7UWpdCLzTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Act6rfhr6ll6+lxDGIt9p6YkkxuZ3qqsousOClbC28=;
        b=g6Bf6upP8/SHF4xJNzb6XlrO5Q9qMT/jRrQeL0yAtLwpR42SrO+TQ9O1y0LR55SYo0
         F0jCuG6xwsEXog3R1WJx/SzWrCslaJBp+S3YDRpNizQbw0EHkLSv5qTD5MjHI5XELhMC
         ubsiob3XZ1FC1fwNKxEBmdSdC10gziCrG8CA4UlHSntHPdYs83E52WQRsdSVe/4US7Dg
         pBf5UUzA7qEOWJO7iG+yGs7Sptx28q6+ZFomEmRxO7ntATo78aTVEQLN0r14yRjeiDEQ
         Z4AcfjvHBbJWr9rpqnxU9dHdYwng9YeUShZJuDR6AejjFF6wYB+9qtoiXDSLMHXg95g0
         oTEg==
X-Gm-Message-State: APjAAAUtAyOLNNLlhFdv+UMk89slRDxjYxMTopieV5cqcMYTLXkg04cv
        PzaK2El4qtT/5+7BBHxMTcg4l8MZwdc=
X-Google-Smtp-Source: APXvYqwmSAFWwf/2U3UWBxdr5rCQ1uuRgEVu/F/fGxF9G4VRp+O8Kfkrs9lpry5XcrrXbcuF9DIrzA==
X-Received: by 2002:ac2:484a:: with SMTP id 10mr12112810lfy.135.1569863561010;
        Mon, 30 Sep 2019 10:12:41 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j84sm3462644ljb.91.2019.09.30.10.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:12:39 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id n14so10280315ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 10:12:39 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr12950349ljw.165.1569863559288;
 Mon, 30 Sep 2019 10:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org> <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org> <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <20190927121754.kn46qh2crvsnw5z2@box> <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
 <20190930130357.ye3zlkbka2jtd56a@box>
In-Reply-To: <20190930130357.ye3zlkbka2jtd56a@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Sep 2019 10:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigUfYXiizFH6tBCH0Na=L+c=k7CgXGoZjwKg4K1rNJ2Q@mail.gmail.com>
Message-ID: <CAHk-=wigUfYXiizFH6tBCH0Na=L+c=k7CgXGoZjwKg4K1rNJ2Q@mail.gmail.com>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 6:04 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Have you seen page_vma_mapped_walk()? I made it specifically for rmap code
> to cover cases when a THP is mapped with PTEs. To me it's not a big
> stretch to make it cover multiple pages too.

I agree that is closer, but it does make for calling that big complex
function for every iteration step.

Of course, you are right that the callback approach is problematic
too, now that we have retpoline issues, making those very expensive.
But at least that hopefully gets fixed some day and gets to be a rare
problem.

Matter ot taste, I guess.

              Linus
