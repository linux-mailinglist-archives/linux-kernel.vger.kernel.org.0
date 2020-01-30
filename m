Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5914DEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgA3QT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 11:19:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44352 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgA3QT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:19:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so2642280lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aauck1BwjHmPxReHY5+5wBQQQKQ71X2qt0RvmNdruY=;
        b=C79ZEneeywO5bDkFYspTf0mHqg+XFdEPkZsBeweiskD6zGKYsX69OLWfEGmiyq0kF4
         7cVO+mYrSPIpx8aclMNM6JP+nr3WlLliM10cmXlSndRjIxf2x6/xKP/br5BKDGTfdn+l
         Cdmuz/2CZ9lz/Lb8JfgQUlPOoXks5ZIoUYivY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aauck1BwjHmPxReHY5+5wBQQQKQ71X2qt0RvmNdruY=;
        b=GwtT8NbkM3PpbAbTNTG+G566mVv+3MluyNkrYK1+GwrMiHdtfwKgx9wjNLhse3ym/V
         qBCNmSiKrhT1/JX1rJBgOXqUEe+8s5gR1Xjg4qAOMoYG2MMpSVWKOB6GMNCKJzFHUR2L
         2NwYPw70g82pcxvJ5OV9HXgaUu00KR8NdvV0lkTyGvOMgdJPPySceAi2CSdZihjo8mGZ
         4pbzxfTDiPZo1m3YP/PUsCH+f97GQimdGDIHEd1lBi/xXc79xJuvGo77KR027A4Xk5Ga
         2pLKTKvS6X6t1lCCwV3A8OBqSHgtioeEV+pSNq+EM0vcPuEHOf6IiQTqDHbmt/g2i3i7
         166Q==
X-Gm-Message-State: APjAAAX/pajpMgFEmxpt72VtC6Qe79fAdBsko3MtY6qW35EneWCV5GJw
        3MgBeaj9p4IVDspf32n/wFNVP+uaqNM=
X-Google-Smtp-Source: APXvYqz2q8E7ASe9RqaHYTxoZ5SuNhGjgNOwdDPrvbgAP1/1nkOV74aME8ub06zNFutLaG1GAgpnng==
X-Received: by 2002:ac2:4472:: with SMTP id y18mr2897554lfl.39.1580401164608;
        Thu, 30 Jan 2020 08:19:24 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q10sm3252851ljj.60.2020.01.30.08.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:19:24 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id v201so2642192lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:19:23 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr3068446lfa.30.1580401163417;
 Thu, 30 Jan 2020 08:19:23 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
 <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
In-Reply-To: <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jan 2020 08:19:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whum_jLmptKrgV-fOvXZvHH68xbZU-wDSj1n9gWL5A5pA@mail.gmail.com>
Message-ID: <CAHk-=whum_jLmptKrgV-fOvXZvHH68xbZU-wDSj1n9gWL5A5pA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.6-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 8:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That doesn't seem right. If I do that, I lose the added GEM_BUG_ON()'s.

Just for your ref: see commit ecc4d2a52df6 ("drm/i915/userptr: fix
size calculation") for the source of those debug statements, and then
2c86e55d2ab5 ("drm/i915/gtt: split up i915_gem_gtt") on the other side
that just moved the functions..

              Linus
