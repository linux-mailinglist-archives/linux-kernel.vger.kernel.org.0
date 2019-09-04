Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98EA7A70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfIDEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:51:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42403 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:51:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so7954072otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7g70nxojyvqUevqcEcO6mWCw0Mvt89bDYJhasa/z5qU=;
        b=hs+FLQG6hGil7CYHLEApAe+DDoHHrAAtp1/JipuDuY8CocVM/VhO4r46fSAaxkUPwW
         jfgpF+yVf3J8Mf9YQ0ZAlPlOZ0A56ZAZ70qFOGRPTLphjJlwyfY+cSJp1zI6vTkgbXFx
         AfqWtOBJHOq+4Fh/kl3zIYgvG02nI+be3NSIuL6+YJKwXIZHCOkjru+yQFKbu4ASyL9c
         5UQSHyY79bcthVT5/tI+YhyiHG3+QNotwCWQGyAfvXx0lCxjybk3f5IsNyINleiDZ7hE
         DHjNoewPDDBABrSPOJDev1gJlnWtk2e9s15h1hSlQ5FAow4I0vAeygMk/zyREM4CCJFX
         K9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7g70nxojyvqUevqcEcO6mWCw0Mvt89bDYJhasa/z5qU=;
        b=MGqPj9ZEjZFTnYcXClm4mMaF6rMg+iZa6PzGX81hyMwIN8MDHVGGdo1So1lOKAyNHj
         faSxlutOw2QUl6dttJ9O2Tdpvn4lUVQOQ+H6s1IPvsu4AsA9wsRueqHw1gR2wLN3QJol
         a0qxuj3kDax4Eas1Oyv+pniSTwAK+6c9IUdXpKw6LItTpG+7JSoEtKesAY0BRbetV9Db
         1jvMNdsAHoGX0ebMSrAESWRcLmJkEKMHaOvhfQb4m2Kb1jVoCwSU/ikt+9DxVAyIXokF
         bUxKU665e6btQhTfl5QwaLENgpYH50H5YYvLhht5gszYeuXTiRTUb/FwNhguZCJoxV3k
         ztrw==
X-Gm-Message-State: APjAAAUi/gRcOUnBoY1WVRWVHrcdC+hjiZWi3qLWnCDgO5JqxK3rYLFi
        FPEtHh5ogIdaGy9SyiSh03npnpiS0wEQixT0homMSQ==
X-Google-Smtp-Source: APXvYqwK+0TQHzt1dZYPeNvE5yh0ZFEy9YeCqwtmvVYM2AZU4/vDh4rMtpicZrlbHi4Qc6hV8mY9VZENn/jerJ7RoBk=
X-Received: by 2002:a9d:7343:: with SMTP id l3mr31638937otk.268.1567572716918;
 Tue, 03 Sep 2019 21:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org> <CAJuCfpEXpYq2i3zNbJ3w+R+QXTuMyzwL6S9UpiGEDvTioKORhQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEXpYq2i3zNbJ3w+R+QXTuMyzwL6S9UpiGEDvTioKORhQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 3 Sep 2019 21:51:20 -0700
Message-ID: <CAKOZuesWV9yxbS9+T5+p1Ty1-=vFeYcHuO=6MgzTY8akMhbFbQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Sep 3, 2019 at 1:09 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > memory hogs. Several Android teams have been using this patch in various
> > kernel trees for half a year now. Many reported to me it is really
> > useful so I'm posting it upstream.

It's also worth being able to turn off the per-task memory counter
caching, otherwise you'll have two levels of batching before the
counter gets updated, IIUC.
