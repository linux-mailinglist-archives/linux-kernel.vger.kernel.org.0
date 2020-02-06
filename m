Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1C15423F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgBFKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 05:45:34 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:40757 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgBFKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:45:34 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 05:45:32 EST
Received: from mxback24g.mail.yandex.net (mxback24g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:324])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id D3DA411C257D;
        Thu,  6 Feb 2020 13:40:19 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback24g.mail.yandex.net (mxback/Yandex) with ESMTP id 86NWYwlhNY-eIZ8qZp7;
        Thu, 06 Feb 2020 13:40:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1580985619;
        bh=fuTBuOzRnyOKXn5u3YXXAdgvmURkN9prmY9Qet2z66U=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=mtMC4iVioaUvWtg0KO5P1FHI7HJDqCh/aOrmImQ6wPdVuzDidX0NjHClbZFaaalEz
         eBNuqUTWKvy2SJTxi6w7i7sZFS/aTKYF0zKRNcUyTdGlaYJnod1YWg0VqVXGD5pcgp
         r41pH18l4xnqKQB8pEnjTXbJ0L0t8tpJUKhhe+lo=
Authentication-Results: mxback24g.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas2-1c82b59a1818.qloud-c.yandex.net with HTTP;
        Thu, 06 Feb 2020 13:40:18 +0300
From:   nikita.shubin@maquefel.me
To:     Nikita Shubin <nshubin@topcon.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206055419.15897-1-NShubin@topcon.com>
References: <20200206055419.15897-1-NShubin@topcon.com>
Subject: Re: [PATCH] remoteproc: warn on kick missing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 06 Feb 2020 13:40:18 +0300
Message-Id: <25402731580985618@sas2-1c82b59a1818.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for malformed message, please ignore it.

06.02.2020, 08:53, "Nikita Shubin" <nshubin@topcon.com>:
> .kick method not set in rproc_ops will result in:
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference
>
> in rproc_virtio_notify, after firmware loading.
>
> At least a warning needed on attempt to call missing method.
>
> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 8c07cb2ca8ba..77a81f331e3f 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -32,6 +32,12 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
>
>         dev_dbg(&rproc->dev, "kicking vq index: %d\n", notifyid);
>
> + if (unlikely(rproc->ops->kick == NULL)) {
> + WARN_ONCE(rproc->ops->kick == NULL, ".kick method not defined for %s",
> + rproc->name);
> + return false;
> + }
> +
>         rproc->ops->kick(rproc, notifyid);
>         return true;
>  }
> --
> 2.24.1
>
> Confidentiality Notice: This message (including attachments) is a private communication solely for use of the intended recipient(s). If you are not the intended recipient(s) or believe you received this message in error, notify the sender immediately and then delete this message. Any other use, retention, dissemination or copying is prohibited and may be a violation of law, including the Electronic Communication Privacy Act of 1986. ­­
