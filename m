Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23703181F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgCKRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:21:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44081 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgCKRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id b186so2312132lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=;
        b=SniYRJq8qrMWk118P05M9PetiYL7ODjNp75BvsOcDJIlqRkPD3Jb97yILnYQFVOz3/
         kiJlYw0cMZBed9vrOZnFV+UZBXXysRi52+PxPI+rg/qM/xWIbOjLpjK7O1VzB68ts7iY
         82PbMl8MtY1FZuEId9Eyj3WPq1fryqn0sIQrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJxZbwEp+wlKlGV90QlJ+a4eQ5p+pI1IhjdIHz5JZ4s=;
        b=SAzcMlcG91gLhPC6C2jZzANkEsegLy/13sBy/tffyyf3nYkDdv68MRCj4HdS5UgQU1
         /N2r+BDVz7MjwvLBZakorSgcdCNIrxitzeVhpbdNmjKA2HFnY+sF8umCzmMwth1ZqNDR
         nrYAa0YKcEh2172uHeJ3JcdZoxJ8pIKTuYV2aQ23B2DXNo1+sP+mOtMB6BUV/cTcPT/t
         N4+ZJENKKEswbiTloJY+dFSaOFGHNrgpLgu9e17QaiHF7Y5Cgmc/imUdc/oEaZsK0wf8
         OrEWsersWSUy3hW2mj62GFaHBiRBahmoRacRGct05f88Q5JrnWkccqK555WTuejQ1vex
         XD5g==
X-Gm-Message-State: ANhLgQ0KCfjqsm+Qif24GhnDXvvJlv0Kx7fZjPyYLdIvSFMu62UG0vIz
        +KQPQXl46Fu45GxI+IEoIaqxQ9fpGxs=
X-Google-Smtp-Source: ADFU+vtrzdoOoBhJ7LnhIxEY67HwARQGZAO+k9tpy91GVsByr8tvQYetU1L2WmM6WovdGfMd2Nmmuw==
X-Received: by 2002:ac2:511a:: with SMTP id q26mr2696353lfb.161.1583947257695;
        Wed, 11 Mar 2020 10:20:57 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f26sm25221210ljn.104.2020.03.11.10.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:20:57 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l7so2388128lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:20:56 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr2864358lfg.142.1583947256468;
 Wed, 11 Mar 2020 10:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200311162735.GA152176@google.com>
In-Reply-To: <20200311162735.GA152176@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:20:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
Message-ID: <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 9:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Sorry for late pull request. Could you please consider this?

I pulled this, and then immediately unpulled.

Most (all?) of the commits have been committed basically minutes
before you sent the pull request.

That's simply not acceptable. Not when we're in late rc, and with
hundreds of lines of changes, and when there is no explanation for a
late pull request that was very very recently generated.

                Linus
