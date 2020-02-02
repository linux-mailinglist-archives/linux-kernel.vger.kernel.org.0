Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE314FEF4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 20:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgBBTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 14:43:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 14:43:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so12343762ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTa6/XyD9+1rf3drvOvMXmn8CbIo2ZjdpFVcqn/gc9g=;
        b=EfUtqz117cqXcYbEgkMSPNj6oPjibOhSAJkUPDpEi877070epBxNt/Rb08Q7q1HKhq
         wfcBqujnysYOIADcSZrkRgnXEW5dtEJO+DqpYt0VtD4BlT2ssubWQmsZI6R12aGULY9t
         iM3TjT7CNxC2UpI9+wf30k7vxpuRY6L4jbnSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTa6/XyD9+1rf3drvOvMXmn8CbIo2ZjdpFVcqn/gc9g=;
        b=f9KUyXA/bHBkI+WQujgY+uaFT+DEbbNQqqD4T5Pvk35fpl9OCuBVQmRBzhhfq1U8K6
         7bgY4X2gssKqEQoOjnxJdkygujXQznc54EyJmaQ8wCiTwQtabXEmbhV3VhjJV7QjUPWq
         PU04lusKW1tG7PI+Ggm4gQhBOpR8FcH1ePD8RPp/K2tQWSVOlx+oLgxjUDbmLvzihWev
         WRIV9GRu78v6Vp1F/gygAKVvklXtzTGlMdDhtVvylbYpUoCj9On6fibtAEo8EVVVzQlO
         4oJUEiX6jNiWAt2YtjppeNajH5nWACkhlfwE0lf0Flemv7FmkFpFJCqhmzjbGfsX89vR
         HMTw==
X-Gm-Message-State: APjAAAWKQXzMRZL7XZn12TMGXsjHLzTltaQGgEUZZNBGJH5Pll1jH0r+
        Cr67FH6YO5pRctC3bnERqVIYK3f/DNs=
X-Google-Smtp-Source: APXvYqyoKjPJZBsU2EB46iNINc/NL/1fe3TMkeV9e1RTzFT8qGRaS07bV2e9xSnDFa/ye21j9z/DIQ==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr12122234lji.214.1580672611931;
        Sun, 02 Feb 2020 11:43:31 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q10sm8478264ljm.87.2020.02.02.11.43.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2020 11:43:31 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id r14so8215954lfm.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 11:43:30 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr10161529lfm.152.1580672610699;
 Sun, 02 Feb 2020 11:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20200202190943.GA4506@duo.ucw.cz>
In-Reply-To: <20200202190943.GA4506@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Feb 2020 11:43:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsTkPZBCkmtx5o+X3penAzz_DeynChQO906NmqXd9r3Q@mail.gmail.com>
Message-ID: <CAHk-=wgsTkPZBCkmtx5o+X3penAzz_DeynChQO906NmqXd9r3Q@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs changes for v5.6-rc1
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 11:09 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> LED updates for 5.6-rc1.
>
> Some of these changes are bugfixes already merged in v5.5, but I'd
> have to rebase the for-next branch, and git merge handles that ok, so
> I did not do that.

That's fine.

But I'd still have really wanted a short description of what the changes are..

                Linus
