Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75C145A59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAVQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:56:03 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:45533 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:56:03 -0500
Received: by mail-io1-f53.google.com with SMTP id i11so7275702ioi.12;
        Wed, 22 Jan 2020 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHdhn6fXAUDdnrx4kd/QPO0tJ0CsK7JpRCtqUMJ7Cm4=;
        b=NKfoMhoKha20dXUbR9fhBu5NawwwGFdt7yueRkrClQareyo65KCPW2oNJD6Rmz56Sn
         D2xBYFaJ5d5hZIXXtiV4PTNyURLxZlIhzI8Nfs66apcVazKAA4qDmY0U3iwXxB46il7k
         4asyJ076h+pn+3dQTDDdq6fpBv2WZt8wYteusrDRiSGMLf/8B8e4q1y8be72z3k5HUHP
         wqNIthWZphaOpKt2VTBkKRRdQ/x6/kErRscIuRsrOLzWLIwjdwjPNjQvP5q4jvmOo8h9
         99BVwVfjcoFQxLl83tQ3xGNEwGxf18AntdVrHwWSV5mDX0FPOAeEhdsQ2XF6CmAVXQy2
         caOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHdhn6fXAUDdnrx4kd/QPO0tJ0CsK7JpRCtqUMJ7Cm4=;
        b=fZ2bGvuJtuBpFMRqQ3TFBuw1LCXFj770cicVqVZFJ18KtbCNAWITe4HnXTgWhkB6LD
         uDdL7iH/sHYDtsr3CC9tSx1RATkN6RSXAK9Q42zsFkWEbumYsmRaAfwHINZgIWy0mCmL
         Aqcbol9NSwOzutC4BZ7zYYPy4o3Pka6pnCCVkwkflfcy3oFT6pM30J2o8XKlj13+dBgX
         V6Swn9aTP+1YPnDXu4KdvaotcYijkIIjrXMRCNMxfI6guiRZIeNqtbpz9GZNri720Daw
         M3wIpUtVimv3ZYoXmyJEfQ4cBSv5IdmbTCmZk9lCZrKF3eqCF+NI8JBGZFvHFxNG8NmM
         MkKQ==
X-Gm-Message-State: APjAAAXDKl8Wj6Fuosab59wcHF0Ftl5plKUP07GWuL5XeLqa75ac7gwR
        NibxmQZW9aQdb0Khs1mXGnRtt+iBr+nTO8TXrlSjrM8m
X-Google-Smtp-Source: APXvYqyBbHrbpZbLz8l/A1YUBkn6s5Bfj3VkhX6XhSTnkIlgQUXUY7gokWPNPOguWfpyCvG0LUFQukLm9VT2UvT6Mw0=
X-Received: by 2002:a05:6602:d4:: with SMTP id z20mr7834112ioe.173.1579712162351;
 Wed, 22 Jan 2020 08:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122102030.95853-1-chenzhou10@huawei.com>
In-Reply-To: <20200122102030.95853-1-chenzhou10@huawei.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 22 Jan 2020 10:55:51 -0600
Message-ID: <CAH2r5mv+dCyj4dQm8kSiVSyu161oyuOSYO3Ec0VbewjFJMv5hw@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: use PTR_ERR_OR_ZERO() to simplify code
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Wed, Jan 22, 2020 at 4:25 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR, just use
> PTR_ERR_OR_ZERO directly.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  fs/cifs/dfs_cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
> index 751c2fc..43c1b43 100644
> --- a/fs/cifs/dfs_cache.c
> +++ b/fs/cifs/dfs_cache.c
> @@ -662,7 +662,7 @@ static int __dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
>          */
>         if (noreq) {
>                 up_read(&htable_rw_lock);
> -               return IS_ERR(ce) ? PTR_ERR(ce) : 0;
> +               return PTR_ERR_OR_ZERO(ce);
>         }
>
>         if (!IS_ERR(ce)) {
> --
> 2.7.4
>


-- 
Thanks,

Steve
