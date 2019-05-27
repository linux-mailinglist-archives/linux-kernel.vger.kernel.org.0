Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF422BAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 21:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfE0T1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 15:27:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39226 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfE0T1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:27:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so4750237ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd78z65uwhoM3ZRJNvBK+0h0z7TF6bqVWxLdc1NV2X4=;
        b=LGnbuv9FuD6KUsqZha7QN8hFiUBO8xRgmaS45CB4OxnREfVukEvDCgYO5N/0PHXnGF
         5h9pdEEPPY+noavybWPcq177D/0MwCxHqGQO/kg9yHPrJJjqZW0W1OmvLZZuVocaYAoe
         MsjOXzqUVioxHYj9DO5Ltrrc2cXtDVvivTa/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd78z65uwhoM3ZRJNvBK+0h0z7TF6bqVWxLdc1NV2X4=;
        b=RwwguE8f132a5a/qI8bSjgxBLFFX++KMY08UMRWYfE7APWkd6lX9Re4SDFcJL7DXi0
         46HwktYSat+xCf+nRG58ko6g/M/tXxtOG+HKLonkZlKmOssbtMveKI4BHoIGRJIULr1Z
         Ih6VEHl8bLXCd0LlpfftbknP8ylUzDwt6BRcT2v4JApGt3BmtvPO+yVxpIj5DjL/ad8A
         1CgfZK9j1fSyiTgTDEG++nrtmIT50YXgqVifq0viVca8Wt0sRhDNMmDieRV3XN0m+vAs
         dzngOZ4BGgTnHJIGjDoO8VoKNsGw9cTOASL4BzAaOnhhWZ7Tv8eusXmkzeWtc8T/QTl4
         w5UQ==
X-Gm-Message-State: APjAAAWhj5QopmIGTdTV4iSMU09EHtfDsvS88xKU+gwqhZUs6kJY5gzO
        QhD1wT97mxevTJJ/pIKmkdGSO85KWZU=
X-Google-Smtp-Source: APXvYqwZNCzwe6+YrD81HHbqX/ln5VchGhtvtQSgHmD8ssDatacOxikMZyglweYEF5pfNFSKnbk9NQ==
X-Received: by 2002:a2e:3e14:: with SMTP id l20mr46509816lja.40.1558985248443;
        Mon, 27 May 2019 12:27:28 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 12sm2475689ljf.12.2019.05.27.12.27.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:27:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 14so15552252ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:27:24 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr52565527ljj.52.1558985244303;
 Mon, 27 May 2019 12:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
In-Reply-To: <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 May 2019 12:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
Message-ID: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
>
> Hm, still pondering whether having one unsigned int argument passed
> through registers that captures all the flags from the old clone() would
> be a good idea.

That sounds like a reasonable thing to do.

Maybe we could continue to call the old flags CLONE_XYZ and continue
to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
flags for a new 64-bit flag field that comes in through memory in the
new clone_args thing?

That would make the flag arguments less "unified", but might make for
a simpler patch, and might make it easier for the old interfaces to
just pass in the clone flags they already have in registers instead of
setting them up in the clone_args structure.

I don't think it's necessarily wrong for the interface to show some
effects of legacy models, as long as we don't have those kinds of "if
(is_clone6)" nasties.

                   Linus
