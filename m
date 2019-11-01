Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AEDECB4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKAWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:18:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46298 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKAWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:18:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id w8so11642471lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud8wfiXrHTzq132w2cPE58LYyKZtAiUxGmpzRikyLm0=;
        b=e4r3ID2zS8KWiE6/l7e4Dq+5yo6sc7GpXIzvBkbpzDgtIz5fN+6KE6lAKXl6D9cQNx
         Mo76ECdQCatbiuuFOJXpdePhXb0dMEco1dZ1fDQNHfvTV5FwCR3o4HCum9+fO/unvAPi
         VwjhG/RjJDUWfZZq2fzKYX7AZ4zQgEdhTl5OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud8wfiXrHTzq132w2cPE58LYyKZtAiUxGmpzRikyLm0=;
        b=daWJ5niseChRGbV+ZU22mD+pryLkZJyvz87RrVh9W8PqG+Mc4HjWm5G9OB+mgcB2H3
         tPIF1LXYOOEvQPpbfBNoX/TrbKlZ47pyPsupWb55mzaII1MrpNYi7D2N1WbdzZrC4u/0
         Nl86PJANI2Wr5hPln9DWQGZeJmj05dAeN7pZTBkyl+rn8qxwnxv8eLk2OzxJd4NmCkUb
         Xk/lmhfp6uNB+cxJQ5cbd0w2aQAXlSlapB85LZT8SeKrutOkvqSYoDOwOydlHtvoJV81
         yKEKsP/LpyI6oH9RMX/J5mPweYHh9XZgFiyt6a21+xWwwxQcpeCwZgZEKrluhewG7sdc
         eqbA==
X-Gm-Message-State: APjAAAWDxs4TqsqsYBlNv8UarszogefbLWSQXngCGbTIG+XVV/1yE97t
        G7Z4naocRD+HlpWKDahmnUY8WvFXLfc=
X-Google-Smtp-Source: APXvYqzdB/jrfrWnReBFq+8rdMwkB6MPrpHRj3DUR87GiSN5DkbyVR7DKMSCyUzwnEf44UMZpqW5/w==
X-Received: by 2002:a2e:b044:: with SMTP id d4mr9739433ljl.102.1572646687701;
        Fri, 01 Nov 2019 15:18:07 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j23sm2103756lji.41.2019.11.01.15.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:18:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q2so5136099ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:18:06 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr7528920ljn.148.1572646686541;
 Fri, 01 Nov 2019 15:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191101202019.GA22999@ls3530>
In-Reply-To: <20191101202019.GA22999@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:17:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPiZSgzj_FtrDWbP1x6rssAQaD6t4zvwC_s9UbsOwM=A@mail.gmail.com>
Message-ID: <CAHk-=whPiZSgzj_FtrDWbP1x6rssAQaD6t4zvwC_s9UbsOwM=A@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture fix for kernel v5.4
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 1:20 PM Helge Deller <deller@gmx.de> wrote:
>
> please pull a one-line fix for the parisc architecture for kernel 5.4 from:

You do say "one-line fix", but I'd still like to see a diffstat for it.

Pulled, but please check your pull-request script.

                Linus
