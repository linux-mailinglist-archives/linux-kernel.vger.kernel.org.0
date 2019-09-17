Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9FB48C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404634AbfIQIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:06:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38607 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404624AbfIQIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:06:35 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so5454316iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOVqkumQN5CEwQ1QOe3+67O+QvL5+kQKUKOQklx5+IQ=;
        b=SxJoufJAOfbF2RwDS0pCxab33Nn6kfhsv5d+081atG/Zap3xQyZ8RMJbv9ScBPJ+Kg
         MY3eDxzP0ub05OZpG9cZFAzcTVrfvhcPOxtKaPa8Zf137LoyRB7t51pyJB1YMISWluGu
         OqLFXI6lucYPJeDumVte1G1rNzlCbyhhy9PqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOVqkumQN5CEwQ1QOe3+67O+QvL5+kQKUKOQklx5+IQ=;
        b=pDLMKA6QVPZ691OLVgZRGutYFqMMjHSdXQny59+hZZlzzfOzrIc5NhmIzsEgGuZWos
         7if0B0QM9AmYziDsFnAl5fNSOmZl+npMiWGb+q55nla/dTkcw5j0VkAvASHwUX8Rnx1N
         tMN7ZzvNLa8WpDprxQFe+gfzANGqThQioGTb5JqRirXCop8NIYam62OYQBZvj4jmXQ2Y
         qmlCIShspakyqRqZZ2saW8bZNgOVvYEGgHWDzQYcTwTvxK4d6ugdvkbSe3ubN2yJLj5Y
         5TjbyxnTAEaG2quDrYeSP/jVntB7RTVRarHYd7rlI/u6RRFwMaFWsmqZhRj7xIJqjHj1
         K8wg==
X-Gm-Message-State: APjAAAVRZU/pE5+hnA2MuClTTvQqwTevLDCDdIRn+fbe11jVTmgTA/V4
        3PgnyjlKN217xkVKGZbzTiVIdn+r4wzzWvKzPBDQ8z+P
X-Google-Smtp-Source: APXvYqzMAEWqw+AVnbnbUMQptM7jfWNqRQGF2rp1VDmddInyKkG2oE/7WqiAZRfqBTTXHBgZhMgO49ZaeqP3Xh1bh58=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr2143281iof.62.1568707594550;
 Tue, 17 Sep 2019 01:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568017796-27513-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1568017796-27513-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 10:06:23 +0200
Message-ID: <CAJfpeguMAzej0OroDXLJsntx5R_XQWOcgSCZLFe=M8e4=A8CAA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix dereferencing possible ERR_PTR()
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 10:30 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:
>
> if ovl_encode_real_fh() fails, no memory was allocated
> and the error in the error-valued pointer should be returned.

Applied, thanks.

Miklos
