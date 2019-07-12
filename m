Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B752267641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfGLViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 17:38:10 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34508 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfGLViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:38:10 -0400
Received: by mail-lj1-f180.google.com with SMTP id p17so10704214ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iges54z9f906v3uf56WrVXdsTxZk1k/p5wstrSlWhSY=;
        b=HStbbQgKwJ8PIs2uRSFT6FkcEsY2ELzgFwmB768U+IJZZIFRRG1kKdnBHfLT6+Z8OH
         pymcd7+1yH6IPng+WI5ltxwoX/fgziXsRTRa+yCzqVYrrGIZQh2D0MUXgqTwhIuI2r8/
         OJRqvn3weItgeO9YFFvdX9jsIcpP4D+ZARYcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iges54z9f906v3uf56WrVXdsTxZk1k/p5wstrSlWhSY=;
        b=YEPC/8wTKxOcQBC30T9ITCnui4dQKiL0vJC3ICmfVxJkjqqPgFdHHGftTKuyicJI5R
         VWSbMCEyMPI4rT7tLhHUhIz6ApqiyUv0nIDjTDYYSMJT+qafhI0PwdIbvTcCeNCRuRyF
         sFJtzELpBPap7iY5dvq7BAlT2b81fEc8T9kUu7rZV4Oy7VAqbG8KTVfHicSBxJ0wZ3th
         e4sHNkne1erejwNhS7XAoz4c/8x3Mcdz+RFfpuvHtxqs19tPDcp2Xwc7AisKTZvpl1RL
         leAx4+UdhbHsvnnFkKoYGWzhh0qF678aRI7CfrwfcruETdjB3E1S7D2hjLoX/xldJTzE
         y65Q==
X-Gm-Message-State: APjAAAXizNh8F2lvGFjc7K7Fj0rvCum+JOV35c8ebNrCHC5FpF12YQ4E
        Tn3J/i2Ths3buI7hJnLECTyco8XDnrU=
X-Google-Smtp-Source: APXvYqxkLX0E4RtRFdSxR07AIQg+aRj6zPswNuwoZTo9ph1/W71yIl8NwnvS5jS5vZGEJ2/mC4CcEQ==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr7013202ljk.93.1562967487683;
        Fri, 12 Jul 2019 14:38:07 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i62sm1620985lji.14.2019.07.12.14.38.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 14:38:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 62so2496185lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:38:06 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr5948568lfm.134.1562967486231;
 Fri, 12 Jul 2019 14:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190712073623.GA16253@kroah.com> <20190712074023.GD16253@kroah.com>
 <20190712210922.GA102096@archlinux-threadripper>
In-Reply-To: <20190712210922.GA102096@archlinux-threadripper>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 14:37:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
Message-ID: <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:09 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Doesn't look like this made it into the merge, as I currently see that
> same error with arm64 allyesconfig.

Duh.

Because I had fixed up the actual definition of that function during
the merge, I thought I had handled it all correctly.

... and entirely missed that the patch was for the declaration in the
header file.

My bad. Will apply the fix properly.

            Linus
