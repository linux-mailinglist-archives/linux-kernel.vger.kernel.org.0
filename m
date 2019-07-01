Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B9229B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfETBUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 21:20:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46513 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfETBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 21:20:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so5912272pgb.13;
        Sun, 19 May 2019 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLGowd605TGgiEF9LE+kSadzQc7KbvCMX2YqZwW09gY=;
        b=XdL3IWjAD1FV+MhMS67oSDrUskQtqgM7vvr4+6/AJ0ASseWPJxbwHSzZaepORKwrR6
         CWxsdrla0ghPoAKf1VKpMtVswkSEL5Y4Me+UnJFPDMJ9nbJ0U/Nbu2SsUGUh4oKYhkrm
         +tdGobM3RlgQ5v4HI/EVGpr0DB57dQBMn7h1eZFhrYlykkqTWxy1BU5QiAhK8dHKSn7U
         aGAXLYo4fbCTBWT2IPU+/6801/bpnaBb0Y6ZyPX9pAqEpm3nKCD13hbuXsrj7Gb0DMC5
         a8rd1iSGNviyHsSPiVmKIg6zrOmPCsltalEcnS5s04EgEuOE+diFsiyNopzSBZjthIIt
         SRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLGowd605TGgiEF9LE+kSadzQc7KbvCMX2YqZwW09gY=;
        b=jJrfJvVQGME+HBYTkwD56L0XQ4oU3DTtwafvyuBDg7IIRnQ/uAU+wSVqsVVksH31+d
         1pI070hcNHvOMAnfKGUaw/GLSWAdx5b+cr/YY/O7l7tyfZSffZCNdxCaWvh0M4mJfMOr
         UaHu35J3gzfJ6Gqe8nTjwEdn/zWIkPmIYuKfxmABnZlM3p5herzRY4BNLvJomHdlTJdU
         I2dGkqTpGzasi3gyBskUxIoESolRRInrLWTYubgnOm4VgxLpOAcEtQQqZmG/iS2Gy21h
         xVT89XxPhxjP2oDhpF+A2LKhGGTmzt5mJ+Uuds6nbGpi4u+rTkytDl80gMZwzLLe+5g7
         5xtg==
X-Gm-Message-State: APjAAAUBH8wicDrAVQjnFUm0Jj7vefJZTOSE7MVEvwkPDruUUHGO+Peu
        mQUypahz5RuWIX2x+p9V7DeLopZPrvwkRxLxLwMzjQ==
X-Google-Smtp-Source: APXvYqw7Ze0TS0tXKiVTrOqkkzcY/f2Enpq+/Q7SuIXcZOdzLP+S/wVb8jcgB218cBW61fSaAICw6itdksz96UWv7eY=
X-Received: by 2002:a62:2b82:: with SMTP id r124mr68797198pfr.235.1558315229268;
 Sun, 19 May 2019 18:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190517081233.11764-1-colin.king@canonical.com>
In-Reply-To: <20190517081233.11764-1-colin.king@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 19 May 2019 20:20:18 -0500
Message-ID: <CAH2r5muO=GLx2Hh77rTPqCZ1yP6a0r5yjSEu5j58o__Mni1bsQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix memory leak of pneg_inbuf on -EOPNOTSUPP ioctl case
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next (and added cc:stable #v5.1)

On Fri, May 17, 2019 at 3:42 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently in the case where SMB2_ioctl returns the -EOPNOTSUPP error
> there is a memory leak of pneg_inbuf. Fix this by returning via
> the out_free_inbuf exit path that will perform the relevant kfree.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 969ae8e8d4ee ("cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPORTED")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/smb2pdu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 710ceb875161..5b8d1482ffbd 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -1054,7 +1054,8 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>                  * not supported error. Client should accept it.
>                  */
>                 cifs_dbg(VFS, "Server does not support validate negotiate\n");
> -               return 0;
> +               rc = 0;
> +               goto out_free_inbuf;
>         } else if (rc != 0) {
>                 cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
>                 rc = -EIO;
> --
> 2.20.1
>


-- 
Thanks,

Steve
