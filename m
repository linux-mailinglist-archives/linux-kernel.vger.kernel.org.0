Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97739D7319
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfJOKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 06:23:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42789 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfJOKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:23:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so18625666qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiFTh2EPuAUilSBW5ORtAUE6MmP+CQvo3ee4BGaXRP8=;
        b=U45dslVBzK6iRCuucnnbxu4+GCuSzO3Ei/0ucSX4K8EjANTVkf+iAPpMN6gwUCsgbo
         WmN2/0o4wBrGPENc7soFUzNydyHN9ikjkH8Sem6xPn5EzKId+TdO5I9lcSoD2pdW7rqe
         z09CkC8vjZLHYFE1wb6DZjaOVNuhScy8HgKqEC03WzclEbfJ3AoJMNBkkiQy0S15jjAT
         WnOSonWmS0HGUY93F0brGMrQfhdIa3cglZn1wh+WCWJmT4MU3g9L5J69YbosFrW6THnv
         l8pdVRF1Z2hXBaDs0xlvyiWKYv0QyvrfYFp2Xh+WBT1t/mnobB13ND8ciCtwT78Y3n5Z
         tjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiFTh2EPuAUilSBW5ORtAUE6MmP+CQvo3ee4BGaXRP8=;
        b=gWxdw83Wr+A62TGxdgn3KuIM3McRuHQ8VPGmSTb32dQ4o4GyivWxFKkdG8P4sAm8jo
         6biAnV1tsW9DaELPIcy579wcVOM4oiHWD/us+KYDVfbqOfWjG+CqKVS2EhydoInX8SZh
         B7zZ5HY3C3tkkI4W3zYiuEVLygT3USBH9S4auVCxDH2Ay9keWVBGFU46mAvmsoI50GO7
         8RTxAhXgGRashBMBQHZCdZmbzQ11C1NS8lMDBCrqHZjSxrSVTRLw2aQMSlEjcYjGWX54
         nJcMxuCon/u7DU5fciEUM7jvc56r/lA3Mc+EhC+gppYdT76vD2bNQMrJcogTKl6NPAUI
         7c+g==
X-Gm-Message-State: APjAAAX9Z4b/wO9TNJcGgIdGuBwFkpQXn2u81oAhkh1oRNoftJ7iPWFu
        XON1EG8DByyv9MkHjQxFo33AIV3VT5WCC2Plb2/D5WXg
X-Google-Smtp-Source: APXvYqzGTN80R3a4qRjY873LTjorS2tyON7Y6AGjgssje3QxI7bcUcplUcJW2iGLhsDqXnHFEVIKcGyQzcQzDeMU+j4=
X-Received: by 2002:a37:5f46:: with SMTP id t67mr33208312qkb.220.1571135032293;
 Tue, 15 Oct 2019 03:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191015101608.4566-1-chiu@endlessm.com>
In-Reply-To: <20191015101608.4566-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 15 Oct 2019 18:23:41 +0800
Message-ID: <CAB4CAwecqN5G348+OW0k=h_QaKahTo_Mb9E+pFCP=GjTLJjpMA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: fix connection failure issue after warm reboot
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 6:16 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> ---
> 2.23.0
>
Please ignore this message since it's not properly titled and no
detail description.
Sorry for inconvenience.

Chris
