Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7150A6A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfICN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:59:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44934 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:59:44 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so36043060iog.11;
        Tue, 03 Sep 2019 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fkc3NbV4KLcHpupnkwi91JCZufWPPBN8nwlwGPYz5U0=;
        b=hlZ5Iq8IekbOZ5frDYLbC92pJuKfl/9nrnhzzKNsgZhPBMKliHoBUASq+XADHK9kZT
         quuTIb3uEvySd875fwZc7GX6M+B6uU3nERJesZUKJ9lbmo/7OuZ8PV9AEQJSYifLIzxx
         r2NWp8tI/Z7z8gWicTHXzgw/HVq5JWDpOVroutvLja8NbkD6wy1k7ImWxwVRGnFY2Ysu
         IDKA1jGJ9rhAwhFd9cLSKZwnJ6klOLPpBR6Z0LcCk+PXW5fydsUXdRgXUi+TuSmYtBlU
         vZrDgDAct7dSv5zGE/rexqgjuykBuv0RWuFgjcvuZhIizz8i6BdWLLSE7qpVB30jv6se
         mSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fkc3NbV4KLcHpupnkwi91JCZufWPPBN8nwlwGPYz5U0=;
        b=esDRmsHhNM4B1B8m9Ri0AC9tgUdZUID0fVEz+Ec8wFnaayleov5QCMdb8vOyFEvvPV
         pFCA+n7aoUcaKXeWb/sKX3NbVWEO/+9t5QbJ+eTG7JG3L6uxronTkxd2MKmC7kzmBkUn
         ISPGIP0hL769HvWQ6jDVFUV3IwAodmd6Bj/pYcdygELvnzpqcGR3U6IrZ41+GSjuyVhw
         FgV/fRbtIADFyURS8JFrgm+9YPwNx7he7LLD+OEm9m2t3dSrBrL14JsR9e4qGZA7RBl3
         QXbVjMFjL5kLieZ9LhjdZ9B/VpUM26kQ1eU08kW/raoFnMlV3I5bsx714EfFGOnBcB7r
         lhNQ==
X-Gm-Message-State: APjAAAXF+g9BO0Ugw+MJWHqE4Q05dhXlEmXg0NopZ7xGEDJbmrmXjzNU
        wDLbXlKsbump/FyDr2hKA8zk1faKpV269Io8yVM=
X-Google-Smtp-Source: APXvYqzw7+jvpz8yv2X5/p/w9/P8Ik9jQh87gtjyc6p7KrTm/agaGZhUysFspQiZp0XruPM+yms04XOtalCSRyVTiGw=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr2845608iom.245.1567519183559;
 Tue, 03 Sep 2019 06:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <9250af4a-993c-e86e-678c-acbd59b0861a@web.de>
In-Reply-To: <9250af4a-993c-e86e-678c-acbd59b0861a@web.de>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 3 Sep 2019 15:59:32 +0200
Message-ID: <CAHpGcMKEFaZBRNnt1edrvBMS6VUXs5hMdQ2BdNBE3ssgkmDoww@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Delete an unnecessary check before brelse()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 3. Sept. 2019 um 15:21 Uhr schrieb Markus Elfring
<Markus.Elfring@web.de>:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 15:10:05 +0200
>
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.

Thanks. The same applies to brelse() in gfs2_dir_no_add (which Coccinelle
apparently missed), so let me fix that as well.

Andreas
