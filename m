Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9AE1433E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgATWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 17:25:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46693 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:25:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id 13so750971oij.13;
        Mon, 20 Jan 2020 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTPep2W7UwVeIZMm8WjEHSoy+SW5Y3J2SshdpaxNQvs=;
        b=cyEOldZvI1XX0p3OtEkJp8j0rHACG/6fsXC57nk04r4DAFsobmen2NeoRyoMGfN17C
         4/H952OLxM0HnFoaY3rLbUWbhZ2uirP1ulrzRrR68vUE8RWcm7ntKnUlaJ5mzNJjr6wa
         ZTBqHMux/Si62iIXrhdCzsFKu0fdPgWp2hFRThl27EBF67nExLBTzU3lO3CoAXQz6F3f
         T5qU5NOmgckqy8MeqJoEPUNSlW0zYDC+Ku+vy5l1RqtV9Rz5A1H2b84Bi4gcd6Mzxp+n
         Vbgi5cVOAUURsaB7OCfcTJB/VjS2DhH5n1FzNDQV06Qrc3FR3nMQpaiCQHjUVt/NTFrY
         A4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTPep2W7UwVeIZMm8WjEHSoy+SW5Y3J2SshdpaxNQvs=;
        b=Lj9WKHIWCQmS2KU1BTYpsipp8VBXRBXQpbifdPL6MfUw4MHn7UPPXiVJAKKrNXaqGY
         er26NwWLinri77NTSbvvHaxTERXd/gGqQA5msSfI60ho5ru9cpRWdkB33uXLdTnPERiM
         IRLDXoE6UO79tPF5Ky7Oy4qQEkqcpzWAt8OLhCMUpz9RCsoRC08EqVKBfh1BtLUxJax4
         wxgX84p2M2QJ23A9Lf4eRuooYWuROmPsnN20gCr8WEfRmtAPLzmT5v07aYqv+me1Zi9y
         1yK7kdLuh4vNSgYIkJ7ZWvheBSVTjR6rXNWqMtP+hDb80t3ptPjytZXk8TVRNVwkdgo7
         0fDA==
X-Gm-Message-State: APjAAAVkoUWLSqSOF6pKQHW6DC+1rGwv9I0h82Fu3vri6TpNw8lXKrSF
        VehrkO4pqDxKwkCbfB/fnqt8z/Db+AfXYuPBCunQItli
X-Google-Smtp-Source: APXvYqwq0b2pMVQJOfgCMPHaSxATrV3Ufremupr1l64dVBNqdAL+wUSdN7MtzrC/KTaQiRiNedf6zR6k9Dg75LGTZuQ=
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr822744oia.142.1579559145464;
 Mon, 20 Jan 2020 14:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20200110221500.19678-1-xiyou.wangcong@gmail.com> <20200120132812.384274d3@gandalf.local.home>
In-Reply-To: <20200120132812.384274d3@gandalf.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 20 Jan 2020 14:25:33 -0800
Message-ID: <CAM_iQpX6vGB5hczhJDOCY-Z-8At+rYEAqexryXZd_Tnd8km3Xw@mail.gmail.com>
Subject: Re: [PATCH] block: introduce block_rq_error tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> The ring buffer will hold a pointer to a location that may no longer
> exist, and cause a fault when read. Also, this makes the user space
> utilities trace-cmd and perf useless to know what the name is, as they
> read the raw ring buffer data directly.

Yeah, my bad, I will send an updated patch.

Thanks.
