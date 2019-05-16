Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA11FD16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfEPBrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:47:24 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36045 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEPBVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:21:35 -0400
Received: by mail-lj1-f172.google.com with SMTP id z1so1516554ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK3Nq5f5jxJJw1r1cqQrLgwR6OqLjxzP4tc7RrRfZyk=;
        b=hqvh2HrwbIUt24cvkD5PZVjTPVXL0s6jrzrT4fYlz9itFlgzZO23eNg7OZM1A/BHD9
         B8Wgq8Et2ytqdi1DZbbiyWf2esiAdwxUqR3ZiRCii1mzl5vLI2ZWxD2O7RNOhWkQP3mZ
         +fPdh2RK81gakGmFzFE8IPp3SFUDkDwg2Eh7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK3Nq5f5jxJJw1r1cqQrLgwR6OqLjxzP4tc7RrRfZyk=;
        b=MzcVLi2vuN+A+leRf+sraVkAVuD2I5cMbDHJT0zPtaSKE9td9+se02eiQrGrBWhKGI
         dT4tB42BvZLAvBCOk99Oz4zmAbAwJYLGOLpWUWwfhPRNvGaavCa+83iRqZkaLHWq8uDj
         jNLHTf39HbgINulWPjVy/w47TAus1y312AcRaRtO2rwxeOQ10U9o+AlakMxjxejQh4CK
         9hQuP0CT9sSij3Y44DB9hHmrvemS/N8vXjtbQN1JyyQbp2UBlcVeMilIvjXHE2QdISoZ
         wVoOEwR0YWmHIl4vJ4C0AsXgTrR88YgwMjLyEPI6eR/fMOcjFQGJVZQzHmI9kxyz1udr
         MQHQ==
X-Gm-Message-State: APjAAAU4gkqvd1bTslE6ykrf02LlUm3pwuzyAMqadIguiZnkOWgA/vWa
        oaEqa6dLmzfSDg+2OuhFfSOmOOT32Io=
X-Google-Smtp-Source: APXvYqzBXKe4XrwBXPek5uF+i0pST8AI+5hka8u3VPiB7BzP/UhxU0qrbIkqaooMy2qWEl9qkJtmBA==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr10456455ljd.81.1557969692029;
        Wed, 15 May 2019 18:21:32 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c10sm655978lfh.79.2019.05.15.18.21.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 18:21:31 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h19so1520359ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:21:30 -0700 (PDT)
X-Received: by 2002:a2e:978f:: with SMTP id y15mr4296506lji.125.1557969690676;
 Wed, 15 May 2019 18:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190515133614.31dcbbe0@oasis.local.home> <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
 <CAHk-=wjbVZcZXkq5xOnBk3ibXorEYKdmRG5YFzzV-Rw3Q-VUEA@mail.gmail.com> <20190515202729.3d62422c@oasis.local.home>
In-Reply-To: <20190515202729.3d62422c@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 18:21:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfhruWcLo5u=WdP=NKkb_scPamZtfQBgF-UYsF4X41Hw@mail.gmail.com>
Message-ID: <CAHk-=wjfhruWcLo5u=WdP=NKkb_scPamZtfQBgF-UYsF4X41Hw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 5:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can do this, but it needs testing and all that before sending to you,
> and may not make the merge window. Is that fine?

It's fine. The warning is annoying, but that's my own fault for
updating my system just before the merge window.

                Linus
