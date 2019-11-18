Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A46100083
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRIhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 03:37:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKRIhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:37:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so18313356wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyRyDdnwFrDF22qF/6Kg6E6UCBOkHXooVVbfjsN3zck=;
        b=bqHAwTW48FBmtcp/JM6OZkKuYkOTIDhMVmdAda/htJZgBNT3UKIHuW5C3ofGR/eKQK
         PVKGhq1kGahNJVyzEQF7fKu0wpYTDLaGF1pYW23zH5gjWN0O4QIOfpWBTJwahShB4Wkw
         7J2QFrpdGSyBb2WE7vqPokYyZq9JldidZNAifzTMpThJhIFOPOjMaJ2IK0t9+pInsgLx
         J7SLADlcRJuI0cfebUhgjQu+J225mCuDsFaUWWiF9ug6nx+WV1WZV5IKOlCg+eov5aWT
         QWla4RmnJF02s+Paab4/UWMQOpIdLGa5a+t3ThQ281tADzH8YQ+ZTWqtoyAVtx6xFW6T
         /plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyRyDdnwFrDF22qF/6Kg6E6UCBOkHXooVVbfjsN3zck=;
        b=a8EjB9d4P6PIwd5XBzA7/BOg+xpZnyeKKGvrQrYijsY10HRad5Fq+qeFcL95YK21Y6
         4xvOE1fmmw3c6UwfB33N0FLerit2xSLXvQkmqyKFmt+8i003GZGsuqCetiq1XTwj5xZY
         wo5o9A+xQugHQzpoGdXccsvq3ZWTiF2KvIE9O1NY2x9qDVnuX21YoJKDzwZHmSoH/G5o
         Omi+i2X7Wkib6LU44eeXDFGZoo8U9ErTF2lCq6YOrwx2KQhDS56vmXAk6653bkZPyd6n
         vaL1VEKNEggZm8nA+Yi/rXkNo86uUO7glt8r+hwsDALEUw4Ko7RFelMbvaQ47P1c/JPs
         H77w==
X-Gm-Message-State: APjAAAU0CYgpMwjaUGscEhTxicifXnjvq6lodo6gveDRfMsB55d7OSoE
        4Wwk9kXG4r7tyTxQdEYlRh0A+FS7WbLOAMWRCGU=
X-Google-Smtp-Source: APXvYqwE6Nr/nHKPZBWJuAt+7Dr/Cpd5r07mcZBqUOjdaZPOfNZFClIaUpX10MfCOP0JBtqGADLBK5WZF0TziWUg1aE=
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr14295747wrm.4.1574066253742;
 Mon, 18 Nov 2019 00:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20191117174413.2876-1-pakki001@umn.edu>
In-Reply-To: <20191117174413.2876-1-pakki001@umn.edu>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 18 Nov 2019 09:37:22 +0100
Message-ID: <CAFLxGvzB64YgGS4nmx++f=jwY1h=Uha1d1nP_VONtemm0DoEfA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: Reduce the severity level of logging errors
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     David Woodhouse <dwmw2@infradead.org>, kjlu@umn.edu,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 6:44 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> Unlike other instances of critical errors that call BUG(), kmalloc
> failure in jffs2_wbuf_recover does not require pr_crit. Replace this
> error logging with pr_warn().

Well, JFFS2 warns that data will get lost. IMHO this deserves pr_crit().
Unless you have a strong reason to change this I'd leave it as is.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/jffs2/wbuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
> index c6821a509481..59e145220b51 100644
> --- a/fs/jffs2/wbuf.c
> +++ b/fs/jffs2/wbuf.c
> @@ -339,7 +339,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
>
>                 buf = kmalloc(end - start, GFP_KERNEL);
>                 if (!buf) {
> -                       pr_crit("Malloc failure in wbuf recovery. Data loss ensues.\n");
> +                       pr_warn("Malloc failure in wbuf recovery. Data loss ensues.\n");
>
>                         goto read_failed;
>                 }
> @@ -354,7 +354,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
>                         ret = 0;
>
>                 if (ret || retlen != c->wbuf_ofs - start) {
> -                       pr_crit("Old data are already lost in wbuf recovery. Data loss ensues.\n");
> +                       pr_warn("Old data are already lost in wbuf recovery. Data loss ensues.\n");
>
>                         kfree(buf);
>                         buf = NULL;
> --
> 2.17.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Thanks,
//richard
