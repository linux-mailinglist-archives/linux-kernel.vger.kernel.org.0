Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC1D66A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfJNP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:58:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35951 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJNP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:58:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so17169119ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsRTPbeFRd3mjs0/iVrF+EgsiOKlCUOXsruIzR2NFHM=;
        b=Q3mA8803WJvxZe/l2GYLGlsrJ9VzYYmF28vBdeObKty7NHEuWpcW6q62AupQ2xuPnP
         5krmS69PReezLligsUz2Cocy7nnIOPGD7iBFkCouNZF+G3EEk1COaAd+2AI7qfl11kZT
         GSxneUGxAfRdWt7fhPwhgEEdqihgEDTDmbGGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsRTPbeFRd3mjs0/iVrF+EgsiOKlCUOXsruIzR2NFHM=;
        b=gJfqZZw+gkWcGI0MakXiboYj1DUtVqms0pYA9MdYpfwq3oPwEdvDHBlHYl5OYEyzzH
         9CW2GD6IjEuuCizB8p7Z+fn8+PT71Ivp3OrLaKj4RBWwoGA8XpGfEjGAsVcJSmFYSURY
         9di05ywcxXzXQ+YDdHSlhnbdNetcJmYSaCrTo3puhig7nG2CNB28rTlc0dfYkbUsDp6P
         fU6n9lr0Zgp0BAgoW3/gyW8/bgh8B5KPR+UAYoEup6m/aSw6X0sroNPBrIl+TbgYoQU0
         +FAtTEazxS5vti01SzQRtLNXePemFfEuqFrv/SpEkP1UvjxtrZqaf2qgS+1gACDURr4z
         J97g==
X-Gm-Message-State: APjAAAX7fhy07nD9CQyYASgJ29fGwRU8SLd0v1EVjBAxRPLmvCmdt3VO
        EX/y7o90GvV2wOxO5zL9gm9IW5Gan2g=
X-Google-Smtp-Source: APXvYqxG61uBNWoffMq62XA4F+0mH8OGgQ3eOazUQi941khngljOaEs+3C4rEhvMuiyXQ9e7id750g==
X-Received: by 2002:a2e:658f:: with SMTP id e15mr19344284ljf.254.1571068679421;
        Mon, 14 Oct 2019 08:57:59 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x2sm4437190ljj.94.2019.10.14.08.57.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 08:57:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id l21so17181607lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:57:58 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr19455605ljr.1.1571068678057;
 Mon, 14 Oct 2019 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191014022633.GA6430@mit.edu> <20191014070312.GA3327@iMac-3.local>
In-Reply-To: <20191014070312.GA3327@iMac-3.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Oct 2019 08:57:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5J+ga=CUQ-vho3savkhDNes1Hwxij2Y19gen_-9tU7w@mail.gmail.com>
Message-ID: <CAHk-=wi5J+ga=CUQ-vho3savkhDNes1Hwxij2Y19gen_-9tU7w@mail.gmail.com>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:03 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Linus, could you please merge the patch above? I can send it again if
> it's easier.

I took it.

Generally I prefer having patches (re-)sent to me explicitly rather
than getting a link to it, so for next time...

            Linus
