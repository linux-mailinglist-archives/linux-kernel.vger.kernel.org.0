Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024F16D5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfGRU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 16:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbfGRU1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:27:37 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E852184B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563481656;
        bh=cplojg0HvfQBkpNyld2ETJzKKPXdpSis6WXfmSXsQJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oBG0Juaeg3epDPdx+6GqKNV1yBx7KZYoyWUmq6TrNvzX7CBY6kSIGywzXksU2j2BK
         owkOVT6bJ6yk7KJTchvwIFL+dxgtsRKR8P6oQdASEGNA4lk3hHMmCTFikU4S/UxRx0
         JYVvuNHP4HpXt5elONtyHlWzRC/QK6OKiqjQ42EE=
Received: by mail-wm1-f54.google.com with SMTP id w9so22279604wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 13:27:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUEsnnhq5b/BEeLRdiu8Pnh3j9I4q7WSAVSPw/7/u8jrn0LUgph
        opavepgvhfSe4YfHjBRZYOXNL9r6giYjBGhFpVodaQ==
X-Google-Smtp-Source: APXvYqygNMevs6mXUS5QJ418igpWOq7Si+pn4gsXtVZ1Swb+1v9nJLiTs+bZOGd3ptZRTVQgmZQyxTwi/4g+G1wbEoE=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr44091396wmk.79.1563481655228;
 Thu, 18 Jul 2019 13:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190711114054.406765395@infradead.org> <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com> <d82854b2-d2a4-5b83-b4a4-796db0fd401b@etsukata.com>
In-Reply-To: <d82854b2-d2a4-5b83-b4a4-796db0fd401b@etsukata.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Jul 2019 13:27:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVH_F-OVQOsJ=KRGtNLQfM5QpSzP4UNn2RbLjP4ueeq-g@mail.gmail.com>
Message-ID: <CALCETrVH_F-OVQOsJ=KRGtNLQfM5QpSzP4UNn2RbLjP4ueeq-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

I suspect that a bunch of the bugs you're all finding boil down to:

 - Nested debug exceptions could corrupt the outer exception's DR6.
 - Nested debug exceptions in which *both* exceptions came from the
kernel were probably all kinds of buggy
 - Data breakpoints in bad places in the kernel were bad news

Could you give this not-quite-finished series a try?

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/
