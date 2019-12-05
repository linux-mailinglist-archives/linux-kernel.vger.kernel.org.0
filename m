Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EAE114A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLEX6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 18:58:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43635 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEX6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:58:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so3833684lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOmvCcAfxENDt59JmszfSJIXz70mzbpvyp0lp8vems0=;
        b=Ekqfj+O7irTIS0InDutPgmPnBQgrHSMkEmzAiT7Q5ixN8sawn5JY5nEfE6Oii4Oz21
         eg8kbdw3ISdBN9bt9ycolPwJGycujLH+hx+x0SsfOArbXB3ywkfyL8hmA/Q4oD21fDZW
         LbmSPC6Jzcv6AttAaWv0ZEvqDReE3MinNrjeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOmvCcAfxENDt59JmszfSJIXz70mzbpvyp0lp8vems0=;
        b=JYSWsrR8D4wXyZgZdn9beegQNoS6YTPSYKRRjHe1xEIbBcN7VfoI8Bsx7HrHX3iysj
         mG5YpIhFVqQP6DvrQuBNsS7ZwpqKmR5udJDIsRj+pvfGts3E6gAES+AFN5tl+gueoC33
         9CZisIRW2AQ07viit4ASb54NEsgSmYIR5XFHuaLkaWyCgZN4rpfNHARrr3S6gS64Y0WU
         k7mqONUxvcLrgU0OqKeGVWtkgRzKKdfbU8baNGoZ314mkezOF0zsItrjhQ7CvUg5q7hx
         ItpcdIbeL+cTu6psaTXn+ig8tf6X8WYZHTO9N4S+MqJC4Y4pck6gRexOhZCicBz/stS/
         JNQQ==
X-Gm-Message-State: APjAAAWmAHRKvgfuEmMc7QjRUrJ5ntbcXTfj77cYLcdHU8Zp+7NUWj5p
        80HtjiyXQKBz/65L/5MD8if9GP7YJaY=
X-Google-Smtp-Source: APXvYqyi0RzfmmV0H5iMOKSU5RBWTiE1HjJIAdVFMTNC5D9FgzdODV3p1fWNh8lvE0WYQtDWUZOHSQ==
X-Received: by 2002:a19:7401:: with SMTP id v1mr6459994lfe.129.1575590327814;
        Thu, 05 Dec 2019 15:58:47 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b190sm5636686lfd.39.2019.12.05.15.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 15:58:47 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e10so5613631ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:58:46 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4684297ljn.48.1575590326630;
 Thu, 05 Dec 2019 15:58:46 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <157558503716.10278.17734879104574600890.stgit@warthog.procyon.org.uk>
In-Reply-To: <157558503716.10278.17734879104574600890.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 15:58:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy87EzKRXRa3VkgesGndrR02pizpX_TEzP+cPPJytpWg@mail.gmail.com>
Message-ID: <CAHk-=wiy87EzKRXRa3VkgesGndrR02pizpX_TEzP+cPPJytpWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait() [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 2:30 PM David Howells <dhowells@redhat.com> wrote:
>
> -               struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
> +               struct pipe_buffer *buf =
> +                       &pipe->bufs[(head - 1) & (pipe->ring_size - 1)];

I changed the two occurrences of this to use a local temporary "mask"
variable, to avoid the long lines.

It's no longer _caching_ the value, but it makes the code more legible.

              Linus
