Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6605EB2703
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfIMVFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 17:05:13 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37263 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:05:13 -0400
Received: by mail-wm1-f48.google.com with SMTP id r195so4145102wme.2;
        Fri, 13 Sep 2019 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2DisDR/cJhM64R78LUA1TAvaEYUe5ftHQT+Ynd0imlo=;
        b=BWwJ61TxX2jZxRKjKsHdxAuRqSXMAKi+BP5djX6lCCI4CTx3viCbHzwg7gvLT9gg+V
         zoP8AL7WvxuKN0W/7l+VlyNCMWUC2d9K+3Od3V/XUmnC8d6+7J7XbQx/WS9UWTtcxfoR
         ozVGPUT1esSZiJWobCSapv6x38//BorJXk0qkg7WCowdeblf3Kvs+1SzodHmSKhcVbkY
         3LdUtdOSmqUt4TOLtB/qEPhM9Kx+LL6MsXBD0TE1Xcv2iJeVIMwRbDQRPvdCyi0hx5gN
         ysXTZQYaqCUR+pkU1z20wkCWmMxbH5CMTrtKhPyZOSqdAcDxdu082jLHAj5dAlJbv7P4
         4HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2DisDR/cJhM64R78LUA1TAvaEYUe5ftHQT+Ynd0imlo=;
        b=Y4oEStd/3Bx6G9cuhaYEW659x+8JU0qkxn21pKlaU7QfIY8opNvSpqSEGJuMF4b4xa
         owgLk3aQHVG9YtR+95S0q8BNC4hojkBYFvViYFxDcASAUL18JlAUmUVCwaXADYb3f3wh
         lwkVCZqKxEMLRUQvGZ+TcOcSZ6cdhyyhIHubrLA5fat36ejw980WWWTeqOmh/ZaTG/VI
         R3DyfcZ09it52ur5h2NzEvi0N5OL13zDNtHqIHLJUod3Au46hnXzrB4H6JVXUl92DEHW
         O9Atr+dxLs0bUFqfKMtSzCluHoYtLf/czZZroczwmUmJEXDzexxKLlg6H1AemNJgqKV8
         vcgg==
X-Gm-Message-State: APjAAAVpeuS3WE3hjNa16US41qmJGW+zDDvbk5lYRrznG100GGd8c/H7
        2YQPG24L7M8xFRHa2b8hwjVQ/XRgv8GtU4fGZeM=
X-Google-Smtp-Source: APXvYqzhhFfWlU3Qj+SLVwzrpNt0iJ1xPnhsEhUTCLbHzdPUlu+CvxRWW4hZ7r1L+sNOPXRvDPP5AXJ5MV+Q/BQE7MM=
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr5184148wmo.67.1568408711053;
 Fri, 13 Sep 2019 14:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
 <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com>
 <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de> <5D70CB7A.8040307@huawei.com>
In-Reply-To: <5D70CB7A.8040307@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Sep 2019 17:04:59 -0400
Message-ID: <CADnq5_MH5HnfihRTBRHnSWRzDj5nu_8w0TWf82-999nKCa4wDQ@mail.gmail.com>
Subject: Re: drm/amdgpu: remove the redundant null check
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:01 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> On 2019/9/5 16:38, Markus Elfring wrote:
> >>> Were any source code analysis tools involved for finding
> >>> these update candidates?
> >> With the help of Coccinelle. You can find out some example in scripts/=
coccinelle/.
> > Thanks for such background information.
> > Was the script =E2=80=9Cifnullfree.cocci=E2=80=9D applied here?
> Yep
> > Will it be helpful to add attribution for such tools
> > to any more descriptions in your patches?
> Sometimes, I will add the description in my patches. Not always.

Applied with some minor tweaks to the commit message.

Thanks!

Alex

>
> Thanks,
> zhong jiang
> > Regards,
> > Markus
> >
> > .
> >
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
