Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE9138D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgAMIwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 03:52:08 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgAMIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:52:08 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so8920397ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WguZovr7w2m2X1zQC6+qX9nLM78GMuCabyk3ve+En7w=;
        b=iUMNVIahZJ+iYbyruFJTQpGPwrHA6AbG3SEi1ryfNGcBbqSZhlOZ972H5JVFhpaJu3
         SuxTyCywmNR32/JAz023KaCvReKJ2xvTMZkEU+2+rGlm/PxbAHWugOvhz1JzW5YAkn7w
         X1Y9vVnN8ThfKMFcwdJLuJhJhmVOchINsZaxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WguZovr7w2m2X1zQC6+qX9nLM78GMuCabyk3ve+En7w=;
        b=o8Qp6QqDl2a5x9KDop1gh0e5Z9RNARfgbm7YR4RJmsfhc0H4/JYPCrJdIlPSJByZEy
         ey0MwuyBFC53xqMP6ZfsSSGplzugHce8iyX/m3IECPL3UR4NySSFS0oGWzLD7pgdPlir
         tViQiwXy8coOgoAW6WnWzhiF8KbwV1QF9/K+h+hFuadDdDOIrdmWy0iS5epeRXJO+bsC
         t44jn0gWkadInLkIBtFczn1lmmXhqIrr1rHe0ETpD7291EDwtrKkqUo59ssK9YC0/FeL
         Epignp+BJYQ5d7/yAN7NzdAUPZ9VqdvCdYE/LPgHJXtDtwlb9ZCr1FL/coTO9fAFGuwn
         k9+w==
X-Gm-Message-State: APjAAAW1W8eq0YiI2j7eXXN0vAmEWpkv5o0ilKaEUuxYraE5VzSQozoN
        oz2OwX84yq/rGoZ20rgyg3GhuwZhVkqpWaF+RwflmQ==
X-Google-Smtp-Source: APXvYqyD1z3AhO+BunsjSlb7c6IJA/YCCugP+yTkUD3iDk7YUduoV/eRTFouDc06SaotaswtXWIGMt+FAjQFrWE+B0I=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr13056335jac.77.1578905527652;
 Mon, 13 Jan 2020 00:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20191231185110.809467-1-dwlsalmeida@gmail.com> <20200110110923.31fc56e5@lwn.net>
In-Reply-To: <20200110110923.31fc56e5@lwn.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jan 2020 09:51:56 +0100
Message-ID: <CAJfpegsBbLWaF43WtyTo8y-_sUjLi=60sQoXHDatsSVg8m68PQ@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: filesystems: convert fuse to RST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        markus.heiser@darmarit.de, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 7:09 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 31 Dec 2019 15:51:10 -0300
> "Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:
>
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> >
> > Converts fuse.txt to reStructuredText format, improving the presentation
> > without changing much of the underlying content.
> >
> > Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>
> So I note that the last non-typo-fix change to this document happened in
> 2006, which leads me to suspect that it might be just a wee bit out of
> date.  Miklos, what's the story here?  Should we put a warning at the top?

The document seems to be mostly valid still.

It would be good to have more documentation, though...

Thanks,
Miklos
