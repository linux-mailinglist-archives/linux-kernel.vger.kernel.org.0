Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1A11744F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLISf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 13:35:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36447 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:35:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so11545235lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smeK7h0PjfsP8Sn0c3lvnZZ0hKKWhoHoLBfxcU0YfGU=;
        b=dhJTWZ1l/vGwVDSU7uyPGZS3q3CFRyzBglkFEjU7Hrw0yv/ooPnacvPS2o9PASHsvy
         DcTrnqBJVQ+MVjCwXZK0Sneg+KD2MuGD9YjJQfMoBg2AehkC4gOw6nqjCkFTiq0CoPJn
         7K8bFRKq/cCCmCG0Dw/9rKgUAk3H7+hg1Gr9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smeK7h0PjfsP8Sn0c3lvnZZ0hKKWhoHoLBfxcU0YfGU=;
        b=mmgaZxdiyWAb/4RvyPqpeUjJ7S8M4SLIQW/0Ia7tl6W+KZfWDbD/P+QCRVfBS9UbtN
         xHvE/lXbr8HpYuqNRzu83pKoO63lhF0j+QzMZG8cXMOt9pWJgrtIXMRYVXR5nkxNo9yz
         v5PvKtKL8wOWYsGCILJ7cEK68gpGqP8wYXimdepT68mObYeb8sSwUqo6zhZlt/lvV7b0
         1s+YWk9/n+klJ2ivR9zwGMY3qzP5tI3GYqcCuPHkiwnieJTIsMlIzb+osN3gXiTTNdKo
         1SoUGIYUJbB+Y7WP9XHPs81c2uVQbwDqvOENd/QdznWojZP0hOgN3UgwoVY5G/gwLGep
         1bcQ==
X-Gm-Message-State: APjAAAUsoXVatpxjmu/li8WZgoVxaQXqsaeXOHjRKt+HbKEDMZBTS+Si
        uD9wfKYSpetaMSk5oy4jcuiA6IMoisQ=
X-Google-Smtp-Source: APXvYqztkKDI8WVUlvGwH5jrnG50b4hsv07hsspxKFhkH24b5i8b1/4o4LWG0uFNge5jMcj/KefIPg==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr16507780lfh.20.1575916552573;
        Mon, 09 Dec 2019 10:35:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v5sm336532ljk.67.2019.12.09.10.35.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:35:51 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id r14so11532536lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:35:51 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr5037560lfj.79.1575916551241;
 Mon, 09 Dec 2019 10:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20191208153949.GJ32275@shao2-debian> <20191209085559.GA5868@dhcp22.suse.cz>
In-Reply-To: <20191209085559.GA5868@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:35:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com>
Message-ID: <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com>
Subject: Re: [pipe] 3c0edea9b2: lmbench3.PIPE.bandwidth.MB/sec -17.0% regression
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:56 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Huh. How can something like that can even can get merged? No changelog,
> no s-o-b?

Yeah, I missed that when pulling.

I wish that had been the only problem we had with that code, but it wasn't.

Anyway, I'm fairly certain the current git head should fix this
lmbench3 performance regression too.

                   Linus
