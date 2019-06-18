Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CC4AB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfFRTfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 15:35:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45858 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRTfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:35:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id m16so7205977ywh.12;
        Tue, 18 Jun 2019 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HvAlKbZbthljEj9Bm0P4V0wg057kcVpH5Gmt0eKeElg=;
        b=buNrCnmOnWF/vLcHkE1GpZMXLD2A5UlUAPBqlUf7w5q2/wefEZvDdCD8yeT83hthXv
         /55FKlOfCMMmB5bSMHWx0VPuqBqUaibrFDzQiHMuoVTa7n5+PJ/yX18EazSr+XG+iZel
         aJJHJ/JjmBdjXoV3WsByjE3mJ37WeMvC2LD40Z7l2T+Jvrae9MZg3NieaTULHC3j0yQc
         IBGPsW39YXeldJngQGOjFVFQkNUThbrdDxbVqSXqLBH2ymlgNhzsIdR+b2HOvIDa3TW2
         WgvwN4hwaXcAvmfrazlz+50RC9F+VOWzU5Lg9V56XgynZkF4JWwvBANXhT4LziAJ08Ox
         /34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HvAlKbZbthljEj9Bm0P4V0wg057kcVpH5Gmt0eKeElg=;
        b=tOHLxRFeT9DJubBg1ZIKO9dwJ0w2hjvka3uQZwu7Esf6G0m1Dsb8q6lem4S5KlDGN6
         mvlVGEyToNaTONcFISi7fGS6iTrIrzDY56IGQa8oN/KyZm0agNWs9cw74R64BqPzyvjg
         Tg/WRQdx7UdmEjZJnAbNjfMo49IucY91n2KwSZCG/OkYps0a+l1OAxodLrNTIIeMRFIc
         k+ziCSR7O4t9wMo7Lv+bjR4vT6IaPaJTQ5bnw8h1YNn2I2mUtjyu3qpAbFoIfGo7IuAg
         cEY2UPqF7VQ5RTNYLMgPOEIcAYnqkplIb+U9KhFprojaSrB8i6ws7FpTZ6kKpda6UuNt
         xPcQ==
X-Gm-Message-State: APjAAAVXmsi/mg3fOZyFfUyoQZ8mAY1sDzxoiRRJ/sx9+2EuyO75HqdW
        qEmpUIKQoMQ98mG1BsakVaxrhRzGo6Zc1dkgzBwmJFPo
X-Google-Smtp-Source: APXvYqwjK1U8YQPQcUnPpcbwzhDgtAhYLUw4HEluprGNc7HiOoBlL396q5Vx72UloQuB5/nFqqq+0DVHa2ud470V4nw=
X-Received: by 2002:a81:92d3:: with SMTP id j202mr223539ywg.427.1560886541819;
 Tue, 18 Jun 2019 12:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190613180824.6ajwjelzr5fmjnie@debie> <20190618073853.GA25598@kroah.com>
In-Reply-To: <20190618073853.GA25598@kroah.com>
From:   Charles Oliveira <18oliveira.charles@gmail.com>
Date:   Tue, 18 Jun 2019 16:35:30 -0300
Message-ID: <CAD17tR9-xss+AkeBMv6XLTxQ=Hx13wYuRYEmoRauNVxFLqh27A@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 4:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 13, 2019 at 03:08:24PM -0300, Charles wrote:
> > Avoid following compiler warning on uninitialized variable
> >
> > In file included from ./include/linux/rwsem.h:16:0,
> >                  from ./include/linux/notifier.h:15,
> >                  from ./include/linux/clk.h:17,
> >                  from drivers/tty/serial/sh-sci.c:24:
> > drivers/tty/serial/sh-sci.c: In function =E2=80=98sci_dma_rx_submit=E2=
=80=99:
> > ./include/linux/spinlock.h:288:3: warning: =E2=80=98flags=E2=80=99 may =
be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >    _raw_spin_unlock_irqrestore(lock, flags); \
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/sh-sci.c:1353:16: note: =E2=80=98flags=E2=80=99 was =
declared here
> >   unsigned long flags;
> >                 ^~~~~
>
> What version of gcc is doing this?  It should be smarter than that,
> perhaps you should just upgrade.

Yep, worked like a charm. I was running gcc 6.3.0, just updated to 8.3.0
and got rid of that warning.

Thanks, Greg
>
> thanks,
>
> greg k-h



--=20
Charles
