Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87B4C10C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfFSSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:49:56 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37955 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:49:56 -0400
Received: by mail-lf1-f51.google.com with SMTP id b11so437278lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=378Cde6kcMf0bqQ1dYoYk4w22PmpZlsWKQPT5oGA8ts=;
        b=gaXISUjEs3o0/7TwFAJf+mOTNyVN7fzbPd5XNzl/4QlOdvEIfIUz41AZYiscW3Y3R3
         oz4i8p5pbqDZRsUMu+l6fNgpaI4lGq62d71ywkZsrCg5BM14NU0QAvVCSHYKmQtOEGPt
         gxtuERESbsNawPCF5wc5cNJy5ALFC/ljiDaoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=378Cde6kcMf0bqQ1dYoYk4w22PmpZlsWKQPT5oGA8ts=;
        b=H5E3/f3Z6qcqSDcezfM8FlHhiNQLlVEJsVLH2g0pTZwhm1wEIfWCnS9CfHouIiGv+Y
         dtkUCOrT2J/YaMIPgRQpWNHQ9EwzHJv2op106t0dzDN4jds0jMSUk4J4LQoHRHPUJZ69
         jYL3aObUG8S+PSeSvJoDZqkbLXdmC4NSEiN+xWUpJielvyjPrS5/8w85K96BQUBUlUS+
         /54zZyWcJd6z0ba3/2AAbfg385exyDmGmU2hSgdS4Ob9vDkA52C22aWNOiGmwKXNhN4c
         B/XuOZJ6I1wv1NzkgH6iEwrvjPhpE4A8SpvbcDwMaVM/K7lBn+nfJuO4Y31ZqiCiB0Sf
         nViA==
X-Gm-Message-State: APjAAAVYk3g0t374oHlGctHCbpXebYbsy26icFINa5GtJVPLuC+8lZXR
        6EAISpnY8qdzZdkk8S8qIYlneyK6zRs=
X-Google-Smtp-Source: APXvYqwtrjf6HU8BKBzo2Puiyexux7kov6J0iM7IJI0x25GYdwHZZZPIVZH7WbeP3/MJI/hIRMig6A==
X-Received: by 2002:ac2:410a:: with SMTP id b10mr575515lfi.175.1560970194088;
        Wed, 19 Jun 2019 11:49:54 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v4sm3209307lji.103.2019.06.19.11.49.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 11:49:53 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id y198so450351lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:49:53 -0700 (PDT)
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr8139468lfm.61.1560970193012;
 Wed, 19 Jun 2019 11:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
 <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
In-Reply-To: <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jun 2019 11:49:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
Message-ID: <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 5:40 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> I haven't bisected this, but with the merge of rc5 into our CI we
> started hitting an issue that resulted in a oops and the NMI watchdog
> firing as we dumped the ftrace.

Do you have the oops itself at all?

           Linus
