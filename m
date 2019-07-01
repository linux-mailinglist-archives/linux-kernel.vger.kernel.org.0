Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94D318FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEISAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 14:00:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38063 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEISAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:00:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id y19so2213197lfy.5;
        Thu, 09 May 2019 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8IBAb1U4AHGolLyRh4wnILWJ7YPjMF8I4QRhEu/lDNQ=;
        b=oZz3d9Y8lqRxl8XUFIBauj79NFGzhaIgVCsRnDu+nHqOgGtg/KfXxBmtyEa4iYIAtR
         3ODP2NMrBGgfZUJbb3He9Ow/q7sqqEwi2lXjijncwPpBDRMY1qvFJdwVEcJ1AkgQ+QbZ
         gOPJhJwu+BPpBnbR0OosoLxmUAZOL+XHUDJwPOpIhXwKC6/AOp8VtkhtzADVEQTc7p7Q
         aaCwVlKMM+RMkmMm05UC8VXUEHPoPZXzWexnQS+99CT3OepvNZFWeLmptO/2H0sc+EOE
         zLuheTVRB9E3d138PWMdUm7+LgWv3gLjaIWP7Y6tHlG0zxcF4FQ2oV2q0P+iya7Nf8ax
         F/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8IBAb1U4AHGolLyRh4wnILWJ7YPjMF8I4QRhEu/lDNQ=;
        b=ex8cZlLMl7DXirAJ4pgFNIA04O31UoAUeaVJKbywox9vREbclVANaj2AYyyQaRFC1h
         OlEUKvHm1pm6vEz3CZXeNhLd4lqHtZhpRcz/s0JcK0pmUiM1sKnSOrs3cVU8Uts7IOYm
         oYdExW7ruycn806f5w5daZ+1KXqY1D0nQ2dHMMimxQjFuuxhJSvhhP6wZlzAiYFVorg9
         AcagSPnWvcYUb2stTicQQ332YlZPa0CBnUY4ixAf8zZZddrOBcBUuUG4LlIiQ7JDLz5Y
         0LGeisQECsjPTAZFeEQiEootAmlOdCQtrxeHMLlTA1WoKPscUtD0SYBTXYyV0WyGSza/
         5vCw==
X-Gm-Message-State: APjAAAXQ7IkvCFnlZgqZ9+oeMPY1Xbr7qNUHdNGKryYaCb+gXbkDeyTl
        ukyv+bpVlNeFgJfW/mxobblugVjtkRQt0cDOp8rn5mQ=
X-Google-Smtp-Source: APXvYqxKDfL6B/hHddJAL2/0n2LWN+cD1YcUAbcuH9yCTFjqDi1jJQvIGvWp1Qc5qQHXGFmXLqei6h3DJQBXw/uWScU=
X-Received: by 2002:a19:fc04:: with SMTP id a4mr3210598lfi.39.1557424842743;
 Thu, 09 May 2019 11:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190405213635.24383-1-longli@linuxonhyperv.com> <20190405213635.24383-5-longli@linuxonhyperv.com>
In-Reply-To: <20190405213635.24383-5-longli@linuxonhyperv.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Thu, 9 May 2019 11:00:31 -0700
Message-ID: <CAKywueTBsHuBOchj7ysL8S+pU=nL6dfF65YT9YZrVk74HUoRVQ@mail.gmail.com>
Subject: Re: [Patch (resend) 5/5] cifs: Call MID callback before destroying transport
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 5 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 14:39, Long Li <lon=
gli@linuxonhyperv.com>:
>
> From: Long Li <longli@microsoft.com>
>
> When transport is being destroyed, it's possible that some processes may
> hold memory registrations that need to be deregistred.
>
> Call them first so nobody is using transport resources, and it can be
> destroyed.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/connect.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 33e4d98..084756cf 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -528,22 +528,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         /* do not want to be sending data on a socket we are freeing */
>         cifs_dbg(FYI, "%s: tearing down socket\n", __func__);
>         mutex_lock(&server->srv_mutex);
> -       if (server->ssocket) {
> -               cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
> -                        server->ssocket->state, server->ssocket->flags);
> -               kernel_sock_shutdown(server->ssocket, SHUT_WR);
> -               cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
> -                        server->ssocket->state, server->ssocket->flags);
> -               sock_release(server->ssocket);
> -               server->ssocket =3D NULL;
> -       } else if (cifs_rdma_enabled(server))
> -               smbd_destroy(server);
> -       server->sequence_number =3D 0;
> -       server->session_estab =3D false;
> -       kfree(server->session_key.response);
> -       server->session_key.response =3D NULL;
> -       server->session_key.len =3D 0;
> -       server->lstrp =3D jiffies;
>
>         /* mark submitted MIDs for retry and issue callback */
>         INIT_LIST_HEAD(&retry_list);
> @@ -556,7 +540,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                 list_move(&mid_entry->qhead, &retry_list);
>         }
>         spin_unlock(&GlobalMid_Lock);
> -       mutex_unlock(&server->srv_mutex);
>
>         cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
>         list_for_each_safe(tmp, tmp2, &retry_list) {
> @@ -565,6 +548,25 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                 mid_entry->callback(mid_entry);
>         }

The original call was issuing callbacks without holding srv_mutex -
callbacks may take this mutex for its internal needs. With the
proposed patch the code will deadlock.

Also the idea of destroying the socket first is to allow possible
retries (from callbacks) to return a proper error instead of trying to
send anything through the reconnecting socket.

>
> +       if (server->ssocket) {
> +               cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
> +                        server->ssocket->state, server->ssocket->flags);
> +               kernel_sock_shutdown(server->ssocket, SHUT_WR);
> +               cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
> +                        server->ssocket->state, server->ssocket->flags);
> +               sock_release(server->ssocket);
> +               server->ssocket =3D NULL;
> +       } else if (cifs_rdma_enabled(server))
> +               smbd_destroy(server);

If we need to call smbd_destroy() *after* callbacks, let's just move
it alone without the rest of the code.


> +       server->sequence_number =3D 0;
> +       server->session_estab =3D false;
> +       kfree(server->session_key.response);
> +       server->session_key.response =3D NULL;
> +       server->session_key.len =3D 0;
> +       server->lstrp =3D jiffies;
> +
> +       mutex_unlock(&server->srv_mutex);
> +
>         do {
>                 try_to_freeze();
>
> --
> 2.7.4
>


--
Best regards,
Pavel Shilovsky
