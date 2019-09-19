Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9BB7006
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 02:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfISAXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 20:23:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39796 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfISAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:23:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id 72so975657lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCq/TbFsgyz/f5qDMbrPu7H+lk7tDCVio2gz6Xsr1jk=;
        b=MjWYHCf0lYOJu/QH9oUEwcZ4Xj+0pYEV8kGM+muk3l+vc2eBgT0GnILRm6E3K4upAv
         5wJi52x8CcGq4MaaKRKZbiGJU7VX9PpS0ne8bpsgPDNKYXV2yG3+G+2sYqoKkGTFDQaT
         0DBmxCjXSSuy8q0/7sfftCtDXqZMtkWb+bWtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCq/TbFsgyz/f5qDMbrPu7H+lk7tDCVio2gz6Xsr1jk=;
        b=G5YqM3KnzVezc+bVv/EN4KgDKqukjWSHAt6r6pfVdbrJSv9wPHCGyqpSrTQK3JKC1O
         8UDlngYlt3WJC3HIMWkEkycDuy80xy8WiWDycNp2k9J0B/eMVpWXgKsmp2zqoFYSJcOY
         Kk+RBv9CnCUnmuqc/qOgDzWh1nDYxzh2d0zfESoowiS2uQPmExmSGru8WB5lhgxqw0L4
         5N+KczvppNL6SybJFLLjQewBu1lRMIujDkSfVOY0dol7GqvUlq5Ia8JpX5CgHbNOiIxG
         3dsVRScdS1WUjK5iM7hOrj/Jw6sjPpp3XOsQ5jZ/yyqU8Bs8aaSTMhEilE+tmBKbeq5k
         pwTA==
X-Gm-Message-State: APjAAAXKvIAjIafhk9LJ1FG4JgmjtPjfTVG/z3hkZDqHaf4cZAEmgyg2
        QBEGytY9TN4vVZOcQMTx7vnYgnnNLPo=
X-Google-Smtp-Source: APXvYqxg2DWz3tBWtDx3Lpm8w5iQ583OFHjiV+aMy8kg5A6gr3OhKbRorG8rXP/pq6YB6R5PjBEuNw==
X-Received: by 2002:a19:488f:: with SMTP id v137mr3332500lfa.26.1568852592202;
        Wed, 18 Sep 2019 17:23:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b21sm1250514lff.96.2019.09.18.17.23.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:23:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y23so1725414ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:23:11 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr3795217ljj.72.1568852590551;
 Wed, 18 Sep 2019 17:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <16147.1568632167@warthog.procyon.org.uk>
In-Reply-To: <16147.1568632167@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 17:22:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
Message-ID: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     David Howells <dhowells@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:09 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's a set of patches for AFS.  The first three are trivial, deleting
> unused symbols and rolling out a wrapper function.

Pulled.

However, I was close to unpulling it again. It has a merge commit with
this merge message:

    Merge remote-tracking branch 'net/master' into afs-next

and that simply is not acceptable.

Commit messages need to explain the commit. The same is even more true
of merges!

In a regular commit, you can at least look at the patch and say "ok,
that  change is obvious and self-explanatory".

In a merge commit, the _only_ explanation you have is basically the
commit message, and when the commit message is garbage, the merge is
garbage.

If you can't explain why you are doing a merge, then you shouldn't do
the merge. It's that simple.

And if you can't be bothered to write the explanation down, I'm not
sure I can be bothered to then pull the end result.

             Linus
