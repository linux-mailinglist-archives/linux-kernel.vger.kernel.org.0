Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC211066F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLCVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 16:21:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46707 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfLCVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:21:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id z17so5460111ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2Pn+nUwTPiWQNmD6ZcUyBL9YYHx/8hYVUPPzlyrC1w=;
        b=YWt7tCChJawBH2mlGjm75VvKQF1n9lq0PB4WHZENSOIYbPbM+TMiv+A4sz31FIrIF+
         qv6rVeradhmwJ1y3LywV1hVUnY+3sdobJHBMSiCoBi14y0F23F0EVwMMAXxXELbrEtOr
         HkKcuRhQ3sww6TYp8jETEWeDjYOJ+2N3IyHRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2Pn+nUwTPiWQNmD6ZcUyBL9YYHx/8hYVUPPzlyrC1w=;
        b=lyPgNPKQuhC3K5LUvz8pCWGO3uVeE9OD1dHJQsOasRO1SAeV+Tl8/IMYTUc/jYz2N6
         kR5ylEz2AIBfV/u0QICMQleNozKJtIGSpHlKbUhNeitmVPehIpMlaiR9N6VeNs0wnOuI
         W6yH7OXdGpFouIYn8bConRcOJnw3a7eaItkD/wOqqNXQth1n4pnkcNvoxjkJJUR7qCv1
         O35i3AmEo8HxxGIksvMAJL1IFCgBZbtEFGHkYQ0ARR4xpcg/D0GBEvBsl3RqbLwtOdCW
         C1/cRyfmdRcfTl4Kb3KVf/uLNMorCn/nLg/BoDRg1RsxudTmuqnnfm92J++csCW8ooie
         ZtIg==
X-Gm-Message-State: APjAAAU7jt1kuAkLSygya3SgQK/51/AcrgFAnZb71486vvfjNQSGo+nK
        YahgbJ6CeHOE+E9aBZGMSWdU8u9ciXs=
X-Google-Smtp-Source: APXvYqw7aOJQ8Hd0stEYRPWcST3ggpz1/AIzdYcM6LAS/X26bi8bD9iTavZAiM49EVERAU6DGk9hMQ==
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr3683712ljk.174.1575408078999;
        Tue, 03 Dec 2019 13:21:18 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c12sm1936187ljk.77.2019.12.03.13.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 13:21:18 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id e10so5506302ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:21:17 -0800 (PST)
X-Received: by 2002:a2e:63dd:: with SMTP id s90mr3908645lje.48.1575408077519;
 Tue, 03 Dec 2019 13:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203160856.GC7323@magnolia>
In-Reply-To: <20191203160856.GC7323@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Dec 2019 13:21:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
Message-ID: <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: small cleanups for 5.5
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 8:09 AM Darrick J. Wong <djwong@kernel.org> wrote:
> Please pull this series containing some more new iomap code for 5.5.
> There's not much this time -- just removing some local variables that
> don't need to exist in the iomap directio code.

Hmm. The tag message (which was also in the email thanks to git
request-pull) is very misleading.

Pulled, but please check these things.

           Linus
