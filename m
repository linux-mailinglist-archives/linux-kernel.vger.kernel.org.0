Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441F0F44E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfKHKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 05:46:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38856 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbfKHKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:46:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so5691799wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CBruAMCJFKMfos8U5j6/UiYgs9P6E1HnVdReKS3MqA=;
        b=Q0cF/YSotKrJUQ00DzbNcgg5SFbACXfUSdCuM5kA3+CYUIWwO5opO0zdGQNlY205VJ
         MVromrhVqva64s7XtAeEGcDIxDI1qT4LP5+BWk5LLYfztAWH9P3AJx6YJoSobBT4k9Bf
         lcgblIAZmwVazUM3hlKgNWpwpk7yy8n5m47IVr9b+5h0pL3mHHzFp8mLJdH5xXnPZOX7
         QdAFOo3J9WRWmwwVDstsCrJqZVwQpZ4AtGEK1qw1PJrgRin4TH+oywZuAS/l4q48VOCT
         Z/9s2jq8l2DsTSFH/y1y6uNgDs5rGrGYVM92r0DDh3cgVOitYs4jka6NHdG+6oPDtWkq
         +0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CBruAMCJFKMfos8U5j6/UiYgs9P6E1HnVdReKS3MqA=;
        b=OTZ7AIS5evACbsiq4kuEXqPKSWVoX3Kj3XRECgo02/Ut1BE7sIMKK8/iHjT+PkN0BU
         m9ena+/+1dFCcp+j5tYb3FUyPmYgbGhCHDUn8D26vGWdoVyQzOCKX3Q3NZM5LrP/oye1
         64+js6o01R7tYDIoejyyRgcS2ln0lmeYWXgW9PXte5XSSQfcu1xFICo4kU/EP0t3AQ1V
         cnp1mqAEYKD7ZwpIBEAMVPepURrNiXvb3eztBoujwWcUeyuhPy8hjmp4DYDxXNdPYiiE
         9WmVQpdK+ZbhdB6fvR4xvIizuZW08mMFXzrbSQjy9SYrYOxvchT33WKY/BndQaOBlyv2
         nmZg==
X-Gm-Message-State: APjAAAVQJtaca6CkW/qaY1wMDJ5cu31s9y6iP3DzHdLSYzoNMWQLz+ut
        IfFSdx1lnJga54toUcPI4fJTBQ==
X-Google-Smtp-Source: APXvYqz25njYbwovs9pg+pdBGnlz1bVNRBcz/NUAh6IHHrnzt0NMqxeo1MLcjvB3yCr+4j30r7AJSQ==
X-Received: by 2002:a1c:3d57:: with SMTP id k84mr7225203wma.156.1573209963618;
        Fri, 08 Nov 2019 02:46:03 -0800 (PST)
Received: from fat-tyre.localnet ([2001:858:107:1:a5fe:1d4:97a0:40d8])
        by smtp.gmail.com with ESMTPSA id y6sm3240108wrr.19.2019.11.08.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 02:46:02 -0800 (PST)
From:   Philipp Reisner <philipp.reisner@linbit.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: drbd: remove a stay unlock in __drbd_send_protocol()
Date:   Fri, 08 Nov 2019 11:46:00 +0100
Message-ID: <6906816.cRlsrm7Sor@fat-tyre>
In-Reply-To: <20191107074847.GA11695@mwanda>
References: <20191107074847.GA11695@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

yes, your patch it obviously correct. The comment you are
referring to is badly worded. We will remove it.

Jens,

are you taking this patch as it is?

best regards,
 Phil

Am Donnerstag, 7. November 2019, 08:48:47 CET schrieb Dan Carpenter:
> There are two callers of this function and they both unlock the mutex so
> this ends up being a double unlock.
>=20
> Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for
> tconn->net_conf") Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analisys.  Not tested.  There is a comment about the lock next to
> the caller in drbd_nl.c that I didn't understand:
>=20
> drivers/block/drbd/drbd_nl.c
>   2509          crypto_free_shash(connection->integrity_tfm);
>   2510          connection->integrity_tfm =3D crypto.integrity_tfm;
>   2511          if (connection->cstate >=3D C_WF_REPORT_PARAMS &&
> connection->agreed_pro_version >=3D 100) 2512                  /* Do this
> without trying to take connection->data.mutex again.  */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ What does th=
is
> mean?  We're already holding that lock.  We took it near the start of the
> function.
>=20
>   2513                  __drbd_send_protocol(connection, P_PROTOCOL_UPDAT=
E);
> 2514
>   2515          crypto_free_shash(connection->cram_hmac_tfm);
>   2516          connection->cram_hmac_tfm =3D crypto.cram_hmac_tfm;
>   2517
>   2518          mutex_unlock(&connection->resource->conf_update);
>   2519          mutex_unlock(&connection->data.mutex);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unlocked here.
>=20
>  drivers/block/drbd/drbd_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index 5b248763a672..a18155cdce41 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -786,7 +786,6 @@ int __drbd_send_protocol(struct drbd_connection
> *connection, enum drbd_packet cm
>=20
>  	if (nc->tentative && connection->agreed_pro_version < 92) {
>  		rcu_read_unlock();
> -		mutex_unlock(&sock->mutex);
>  		drbd_err(connection, "--dry-run is not supported by peer");
>  		return -EOPNOTSUPP;
>  	}


=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



