Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4CC9541
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 01:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfJBXyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 19:54:39 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44573 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfJBXyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:54:38 -0400
Received: by mail-io1-f54.google.com with SMTP id w12so1330061iol.11;
        Wed, 02 Oct 2019 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZPeZ9QA0izyHZj/Kh72cgFN6oQf3sUmRlez3jkPjYo=;
        b=b2vL5M9TmRdpPSLbFkimiw7bLRScR7EZcDjBE+l2UsvueYO/IXnpoC8kXZARwico2s
         Fg5OqExQX8zbxgdQdfvuswcOTJSSNOEm0ztNDk2RLqICiqzX2kn4ZJQBzlTpk25STvke
         v/CwZfOK0yLl9jNgveztRfBs4rwYjKQTIpTaUioJzhyn859f7W/LQ1I9CrLHLPsq5DeY
         jGXvbOoHLXzwdh4QzFnVT7753/3RftwrvauJw/hQo98pRWt+wSJiTxYpsBGbULT386Or
         djJ5/rHF42FJdA4ZTRGd/d0fRWp9mhIDWD6UNLJ1KO6iZX4VEJT8MknsRZ6aSrgqNHOm
         D6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZPeZ9QA0izyHZj/Kh72cgFN6oQf3sUmRlez3jkPjYo=;
        b=QTBuxUrhrXCBOl0NCCN5P8CIIai3ak/6xJySz+0kcl2Aj+GIsEj8wMQolTj4jevwvr
         8JYZkCVATt5ddC75HkaFB9aomUfUOtEQfWRi+IkWU5QZWQcEFwuRtFloHXX+8+9IQOzK
         1dUKL9Qo2ISFRsDf99Ct/rX4vwPDXl94MzzU2+QN9ma49VYXC6L2W84qtSssEv+kbrhP
         JJAggXtwvRY/9AxdYCUW2BFcjnBL3nq6Sx3Ca/0ucBwrOooMnOFJyomnhAtXfYrDUO5g
         /iTdhlPD3dZ23ViuEoybzDefbCalQEj1cXwXM72J7Odqd87QDzHFGWjjJky1REZuJdvG
         8UjA==
X-Gm-Message-State: APjAAAWShV8mwkE4SpNwB3rKduDEX3nw1RD6efeN4K679MDKqjZj3Ll8
        ITR11EVWMLWz9gAQHgjHueWCOPJ1ECamlv/zXs39Ld8XBYE=
X-Google-Smtp-Source: APXvYqz/V1EkbNvG/GvN5vV+R5zDLsI55LMpAZ0vyGNhL5gNrX0tKnhCgO+GNBYWZVYO7yBrfkhg8/s4/sI20cuUDMA=
X-Received: by 2002:a92:c00d:: with SMTP id q13mr7107590ild.169.1570060477257;
 Wed, 02 Oct 2019 16:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv49T9gwwoJxKJfkgdi6xbf+hDALUiAJHghGikgUNParw@mail.gmail.com>
In-Reply-To: <CAH2r5mv49T9gwwoJxKJfkgdi6xbf+hDALUiAJHghGikgUNParw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 2 Oct 2019 18:54:26 -0500
Message-ID: <CAH2r5mtVW=3-2L+0QFJAqBG+uj2sYmF=dtzT_kqwK59cu94vGw@mail.gmail.com>
Subject: Re: nsdeps not working on modules in 5.4-rc1
To:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And running the build differently, from the root of the git tree
(5.4-rc1) rather than using the Ubuntu 5.4-rc1 headers also fails

e.g. "make  M=fs/cifs modules nsdeps"

...
  LD [M]  fs/cifs/cifs.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: module cifs uses symbol sigprocmask from namespace
_fs/cifs/cache.o), but does not import it.
...
WARNING: module cifs uses symbol posix_test_lock from namespace
cifs/cache.o), but does not import it.
  CC [M]  fs/cifs/cifs.mod.o
  LD [M]  fs/cifs/cifs.ko
  Building modules, stage 2.
  MODPOST 1 modules
./scripts/nsdeps: 34: local: ./fs/cifs/cifsfs.c: bad variable name
make: *** [Makefile:1710: nsdeps] Error 2

On Wed, Oct 2, 2019 at 6:45 PM Steve French <smfrench@gmail.com> wrote:
>
> Following the instructions in Documentation/namespaces to autogenerate
> the namespace changes to avoid the multiple build warnings in 5.4-rc1
> for my module ... I am not able to get nsdeps to work.   For example
> in my module directory (fs/cifs) trying to build with nsdeps:
>
>       make -C /usr/src/linux-headers-`uname -r` M=`pwd` modules nsdeps
>
> gets the error "cat: ./modules.order: No such file or directory"
>
> This is on Ubuntu 18, running current 5.4-rc1 kernel.  It looks like
> it is looking for modules.order in the wrong directory (it is present
> in fs/cifs - but it looks like it is looking for it in /usr/src where
> of course it won't be found)
>
> I am trying to remove the hundreds of new warnings introduced by
> namespaces in 5.4-rc1 when building my module e.g.
>
> WARNING: module cifs uses symbol __fscache_acquire_cookie from
> namespace .o: $(deps_/home/sfrench/cifs-2.6/fs/cifs/cache.o), but does
> not import it.
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
