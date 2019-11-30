Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F110DE6B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 18:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3Rm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 12:42:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34538 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3Rm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 12:42:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so27838141ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OY7cEjDNgu8kaIIhsnYFUXoWVVZdXt/b0h/OEHq0PY=;
        b=JOZDGt1czSe4MNLzWjpCvKey9irF4zZMRZbgmXvmbswCLh4edHM3+zG0W7AepyQuH5
         S3UpE5aoX1tumTjLBhmdAur1fzssaA7JclP95veaMEk0fW0Lg9jRSLW4arbfZ1m4grx1
         2xnyuKZReOfnhOTL1Vmau6ogbpCrBe+7dJuts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OY7cEjDNgu8kaIIhsnYFUXoWVVZdXt/b0h/OEHq0PY=;
        b=rfj0p3jQ7zEtLWGTNwh0BhngSWFZs1+oH93bJLPI3rmzXWjCPCjDXpbnfA3/8qcsQM
         IyNKjfJlWRdhg1USODOT6vOZ2nsB0YEGJW4FF/V538r9tOzYfa4afq/4eyDatYSovtx/
         wqZUNZrfAEzQY3EeIyVi81hFwKQZlGXftJ4NRD7Wg7z/BPsqVu6728yjJzsgsraphqUX
         IdvKxo6ZQSz6Ld+2twyibr1bfJsU6r/5nNoZ8rrkffDf3T0o1bTnz4CImqrhh29jwQfv
         bBLmnBlwHaCtrVQNnH5wvONGkk2H3bgp/jUPp9M4e2nbnt1s+O3rFBBOfnOBjUoiENdn
         ++iQ==
X-Gm-Message-State: APjAAAWk5kwucXBll2t/Zj+ywsPaq9NSC188pZ0lUckJdfJ4iNKYyzBz
        lKp1TvCXzzgW3mZ1hoC++OA2AFbfhQs=
X-Google-Smtp-Source: APXvYqwixdahmBHuacw+P82FEvnU02M/bEsoNAxj3OzZ5/W1FW1YDJkDv1U7c9of/9fDIALJv3dVMQ==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr41177317ljg.231.1575135744898;
        Sat, 30 Nov 2019 09:42:24 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u2sm6316863lfl.18.2019.11.30.09.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 09:42:23 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id r15so21904501lff.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 09:42:23 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr28807478lfm.29.1575135742985;
 Sat, 30 Nov 2019 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
In-Reply-To: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 09:42:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjryrAniBWJyeEBaye8rnX=S-BT3_c_jRcSZj4xfPvjhw@mail.gmail.com>
Message-ID: <CAHk-=wjryrAniBWJyeEBaye8rnX=S-BT3_c_jRcSZj4xfPvjhw@mail.gmail.com>
Subject: Re: [git pull] mm + drm vmwgfx coherent
To:     Dave Airlie <airlied@gmail.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 5:15 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is just a separated pull for the mm pagewalking + drm/vmwgfx work
> Thomas did and you were involved in, I've left it separate in case you
> don't feel as comfortable with it as the other stuff.

Thanks, pulled (and the delay wasn't because of me being nervous about
the code, it was just because of turkey and a day of rest afterwards).

And I appreciate the separation - not because I wasn't comfortable
with the final code, but simply because it's a rather different thing
than the usual drm code. Having that as a separate pull and not mixed
up with the regular driver updates is just how I prefer it.

Thanks,

              Linus
