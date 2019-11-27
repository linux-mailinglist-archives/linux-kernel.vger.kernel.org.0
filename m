Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE210B6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfK0T0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 14:26:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35465 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfK0T0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:26:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so10495863pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVNNKDEwK+00GI4nXd9IX+dWdzOAiwJNjdPjOU+ejY0=;
        b=U+xus56I5dr6Aqz7wXSwbowuREWFV2uxsdtZciqEjc59w56SO7/eYwEFYbRbNq7t3r
         /z5JwgMRey9oFd9dGmRbOwyDt/UxPsAyJbhZY8wmo2Fl9A1YwXkrd8PQPXBMwFYhmxcS
         AZzznEDKcHT6GlYef5U3newa8JYZBvm14OOSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVNNKDEwK+00GI4nXd9IX+dWdzOAiwJNjdPjOU+ejY0=;
        b=S84U3jyOHEoa0y9hMhyPV2zYJtCeMsB9Hyhl+7qnbdyuNVbiXZIc18PJd0pf0LD7X4
         HMRtnvWE3YglY06RlZzK6uNa4ec4W9mwgK25lGxkGKhyi6juBBgCefZ1QvDal7C/xDiP
         Z4xGLcykJSSBciSmSmbmKYLG5KPkpm3bdIMOzumQH7qDVkfp9N23j4buvJdLeJHpFqq+
         SkzkkyFN4hkQimQJcnoFaqV/iQNGwqkuVIJpQ4b4X30xmY++29BCM96arOLqJkDKzEdP
         g6s6jVnGRkTrarjVT7XvRbZFrJkL9DvEKVXo+e84r1J8M1D7aUl6p8tIoYMnYfvExoD7
         ABNw==
X-Gm-Message-State: APjAAAXEpbq3TtkcTE6j48riUCmymO9WY1800a+cfknyHBP9BGFkc4r1
        W6HEmAYQ5TauyVPj6jJuIuU8Aw==
X-Google-Smtp-Source: APXvYqxyZCRdeC8jUm68R3lJljLtvG9x0YOYSTxJ4Qiw8dH/Q8nTdrPSERPqvHWi0TfhZ5eZN1cVIA==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1mr5940322plb.241.1574882781626;
        Wed, 27 Nov 2019 11:26:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm16837474pgw.71.2019.11.27.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:26:20 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:26:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
Cc:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, idryomov@gmail.com,
        joseph.qi@linux.alibaba.com, jthumshirn@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, wgh@torlan.ru, zkabelac@redhat.com
Subject: Re: WARNING in generic_make_request_checks
Message-ID: <201911271124.F01A0B37@keescook>
References: <201911262053.C6317530@keescook>
 <00000000000085ce5905984f2c8b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000085ce5905984f2c8b@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:45:00PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
> 
> Reported-and-tested-by:
> syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
> dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.

It seems for successful tests, I still need to tell syzbot that this is
fixed?

#syz fix: block: don't warn when doing fsync on read-only devices

-- 
Kees Cook
