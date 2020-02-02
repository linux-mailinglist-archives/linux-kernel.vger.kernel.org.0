Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA27E14FC02
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 07:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBBGme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 01:42:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgBBGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 01:42:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so5747091pfh.10;
        Sat, 01 Feb 2020 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFp00xtTn9+HJYhQIsB25sqv9DA/HyXUxZn21Jjag4k=;
        b=JJWcLQmS6LoK030ta/ciEFPi/n/n/STKDsL2d+3zoYnBvLJmhY9bZQe0PoUch+DdXj
         KbycJKii6M8vMohOq7X/qH7xJuFLnLVgmCTJeYNQ3mvGYu5JQxXN6XzyC7PNZoPYzUZM
         gFi8qk7vY1f2lbLAv6L4gqI4r3iONdv7lXvgO98gJz6aul+JGbClol5nBAukntrJjgd6
         MFxdnRtQSB079hEX5xus4m75e22C+cM8V/3exdBZ13W4CQFZ3J5AB7MhIhGEsUswWOtq
         aFoXT+rhuO6X/1hENbMnK3D1Oo9F+yKiRXJrBRbNjPN2FLV40C2MbzbmLFLAT+T1j2sT
         lHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFp00xtTn9+HJYhQIsB25sqv9DA/HyXUxZn21Jjag4k=;
        b=Ho3cnJqFywwera2ulcZ08eEWPi6WSGfrJhibEIT3COmuxBeeyD4tjxen4ZRdRD65pT
         O3WngSlt7TYhVTfsf2mr2I9OttWmhY7EiHZ2Gc/7VKdGmRKjk/kLXDLaPs5Cuatx7kTS
         FRLQaLw1c2w8yN86VBpLpbrAHtS6U4P1ukqQXUzLY9ED0LrKKRYyOvsRCZtE328kQ2nO
         SjEoClbgxkwL927ap8okCTPkPY2TVgHcIq52V4nOI/6/3g4WX0r/aFHJdXrz7uCZiUD9
         dZ6QfnZuHq2rF5ac4sn9YyiN3fB52wjN48eSMVHnsV3ocZI6N5yt9fzx1x1f2ltkZYc2
         2XXQ==
X-Gm-Message-State: APjAAAXATUivHaogKsgf7px8fM9L1DX1BBWzhqg2tPr/sH5fnha+fYvr
        v/M6XpmkBS1AG/ni+Mz4PUZqVgQG8zz5sw7+BpU=
X-Google-Smtp-Source: APXvYqy5hrsX5P/2AM0Ag2o/3CoU0KHa9KXnczy1fPjnz2qfBQmS8B4l1BNOkk9BNScz3UFNLYQaWinpZPIAq41FQrc=
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr15208838pfj.71.1580625753247;
 Sat, 01 Feb 2020 22:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20200201161931.29665-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200201161931.29665-1-lukas.bulwahn@gmail.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Sun, 2 Feb 2020 08:42:21 +0200
Message-ID: <CAPpZLN7jFvdAKU24PoQjjS7y6tyvi-bKM_oYZkikHD_TZeydmg@mail.gmail.com>
Subject: Re: [PATCH RFC] MAINTAINERS: add TRACE EVENT LIBRARY section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 6:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The git history shows that the files under ./tools/lib/traceevent/ are
> being developed and maintained by Tzetomir Stoyanov and Steven Rostedt
> and are discussed on the linux-trace-devel list.
>
> Add a suitable section in MAINTAINERS for patches to reach them.
>
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Ceco, Steven, I added the information based on what I could see from an
> outsider view. Please change and more files to the entry if needed.
>
> applies cleanly on current master and next-20200131
>
> Ceco, congrats becoming a kernel maintainer :)
>
Thanks, Lukas!

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f77fb8cdde3..17eb358c3fda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16903,6 +16903,13 @@ T:     git git://git.infradead.org/users/jjs/linux-tpmdd.git
>  S:     Maintained
>  F:     drivers/char/tpm/
>
> +TRACE EVENT LIBRARY
> +M:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
> +M:     Steven Rostedt <rostedt@goodmis.org>
> +L:     linux-trace-devel@vger.kernel.org
> +S:     Maintained
> +F:     tools/lib/traceevent/
> +
>  TRACING
>  M:     Steven Rostedt <rostedt@goodmis.org>
>  M:     Ingo Molnar <mingo@redhat.com>
> --
> 2.17.1
>


-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
