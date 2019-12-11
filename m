Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC94C11BC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLKS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:59:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfLKS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:59:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so25321242ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgBVUlOJfW0c5CGJYH0MeOYBNpJwKBTZNoD1eRFDzR8=;
        b=XDQhOjEFh8/OdvfmcG2kHwO3ilXHx/bJqO8ELWxgJCmKkwDaWF9zVtCQpCF4T+sMPf
         poLzCR65uhWPH5bBTmIASa1hyVJAgS+ARnu/6A2EDYubR7mdxN9LNkWicAtUJKJRriYl
         AFhrGxB/lePeG33Vb05dZ7T/i73L2uk59BIHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgBVUlOJfW0c5CGJYH0MeOYBNpJwKBTZNoD1eRFDzR8=;
        b=Lj2U1KcsQuilL76Al3Sc6vqGFbjhthBcFxfEmMbvwU6tSOZRTV0DlkT+NUz4Sez0QP
         HkTta4RKEA/iPLw1o0TLgQMIt0sOaxi1dcTP9oLf7Y2ywbZVQ+XqfEaEG9TktdqrU/FK
         WCEB0mc0rtS4BzSZunM6jtmKL/ELy1RvkhKg+8mICEF0HXB1hC9fBqW4OL6jijgGWVcH
         IuJH+YpfrILafHjE8ukXyDz47DmPSvHtlhY09zO4k+F+ykiz94vub0WK38TQlZZHCCjg
         floz7/xqz/u02Acqt7odCAMlE/NYuF+LRBI7ZymlGbiUM0//mTVSrdBN1CqJ1UFwpaAL
         rrpQ==
X-Gm-Message-State: APjAAAXmo9U5mg5E8nrCcoev8j2REDDQoTErC7J/O7IO6Fr1IeYxlqOS
        U6HghvSWnFT7yfYSR5vo+n9KdQvKCXE=
X-Google-Smtp-Source: APXvYqznvblC0R1Mim2cX4G7G2a3FLlFDFq0qOFZC4eVEImBfHR5aDlk8amrxBM1brOi7Y9QvnAnKA==
X-Received: by 2002:a2e:9606:: with SMTP id v6mr3289231ljh.223.1576090785444;
        Wed, 11 Dec 2019 10:59:45 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s16sm1679729lfc.35.2019.12.11.10.59.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:59:44 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l18so17562948lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:59:43 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3325403lfo.134.1576090783418;
 Wed, 11 Dec 2019 10:59:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
 <xnpngusphz.fsf@greed.delorie.com>
In-Reply-To: <xnpngusphz.fsf@greed.delorie.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 10:59:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4usEUgMFvq6Jzuc5Qg4QZxf39SUYZt_5OLN7+wjh-cA@mail.gmail.com>
Message-ID: <CAHk-=wh4usEUgMFvq6Jzuc5Qg4QZxf39SUYZt_5OLN7+wjh-cA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     DJ Delorie <dj@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:09 AM DJ Delorie <dj@redhat.com> wrote:
>
> Builds for F30 and F31 are in bodhi, waiting on testing and karma...

Thanks DJ,

               Linus
