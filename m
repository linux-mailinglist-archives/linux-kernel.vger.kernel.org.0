Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1B1FDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEPDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 23:00:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45791 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfEPDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:00:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so818498pls.12;
        Wed, 15 May 2019 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAnMT3wPbUftDQ9VRXJkEmAHdM6PJNXSjrEixjo7CHw=;
        b=h4i4HSAGJR84UoKeK/j3ibfEiSl0Nae5/4egy2hqYp5rHK/2jW16GV7Qey53Al97vP
         r7bnqErxE3mgsEfE6logv/FDJh5K/lrkuZXOPcgwSVM+xFdnSNj1nBJKXcdIN3HhgnnB
         YdmwwkHf4NM6xBUCsa0naS3Y+eDjwvldeCEAgETr/HrWJi/uV0HVl7NEy/A+QHHL/fR4
         HzZdoX5Myb3QuHw37CFsXIMb3G1jd5hirXfEMj2Dwo0rVVRaYmi+7CP4STR+84i6sHc2
         iGyaaxMuOsyeT27LmyPCuw7If4G8G/eqPeeqKeR5k1ZNWBbxUSG1LyaofgEHkuTf3YZD
         aqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAnMT3wPbUftDQ9VRXJkEmAHdM6PJNXSjrEixjo7CHw=;
        b=uMVru9os+umQv5V371qiaUWOoo/jV6i0JU8SLCRcPPP31eKey2Bh56WAfn3fvxvSSa
         KG9OV/yX2dAHQNWdhC0zeGTgydCbXgXivOowh8tDxd1B9GDqERnR6A/YmUtuoxmzXKyV
         5wRbo0XaxvN531iguFTgjiBo23qwoz5eEkEeHgEkGh2ceeaKhOdytvKr9jfJv+5duYCe
         yfgPTIbLo/ERz+6EXqmLo91gqoiFcdtatVzse0grMmkL9f+u3GUCf4OcuLP6iX9IaqLi
         xWP3KsQTcRjzayeZJOsg0+nxScrFV95wBW5weerO7jqL3vI4tIYI6KQXM6Zs/AkyHbNI
         N9Tg==
X-Gm-Message-State: APjAAAWAHAxWfSqh406wkYncKPFTnNruWEPYe1k4NaNrC8mXHogOSusV
        hiLizhVtWviTH6ZcsNa5rI8h7eyrqe0ErylGQppIMg==
X-Google-Smtp-Source: APXvYqybsPMkPVEtKUFspQfYXb7gQWaPGXo8DDb+bCwfN7GobgQ49jKQ21DnWy2YMNVJW1YK1oj/1CIn6OoWtcQPDdA=
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr46813962plt.24.1557975616425;
 Wed, 15 May 2019 20:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557954545-17831-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1557954545-17831-1-git-send-email-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 15 May 2019 22:00:05 -0500
Message-ID: <CAH2r5mvuRaEJDVv6hXwWuegckvXjtTfbpkLGLXE8kb2h1s-xUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: Don't match port on SMBDirect transport
To:     Long Li <longli@microsoft.com>
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

On Wed, May 15, 2019 at 4:09 PM <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> SMBDirect manages its own ports in the transport layer, there is no need to
> check the port to find a connection.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/connect.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 0b3ac8b76d18..8c4121da624e 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -2446,6 +2446,10 @@ match_port(struct TCP_Server_Info *server, struct sockaddr *addr)
>  {
>         __be16 port, *sport;
>
> +       /* SMBDirect manages its own ports, don't match it here */
> +       if (server->rdma)
> +               return true;
> +
>         switch (addr->sa_family) {
>         case AF_INET:
>                 sport = &((struct sockaddr_in *) &server->dstaddr)->sin_port;
> --
> 2.17.1
>


-- 
Thanks,

Steve
