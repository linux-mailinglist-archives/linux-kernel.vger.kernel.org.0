Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23717157B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 04:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEGCeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 22:34:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEGCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:34:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so12802886ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=bMpsabR8hmahjs3RFGKw3QVCOwzsV9GbkOHIuC+Dib6ELB3W2v2LQnqamGXsCBN7zp
         k2yliPz5yx0OjC3SBTcyQKjEUZ+6CaNyC8hMRNBJWhX/dULq1WZ6c/SMO3NcID56id8n
         se1+GooMIUOS9ysKu0WWktm1ZEx0BepMEm5/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=o/8aRKWwKgD5sBmSLZrgfr0RJg907MBKmJbFLWQZpEWV6xHJ7x4FF0le5/gxdULXmQ
         1u6rFXUBC7De0mgXbV3jS8mjxbvDc7h35PHsZPnnWazHepc3U+OEVtSgXulTbomU3wP2
         UG0Sji0ORhti94rrjPpLIHeKYooQZfVqUnRskxDckcDA+bRlPzgP3gkqMYLDNtuUqf+C
         D9bOarkTG+PLOp2LwRF3iRejjJxVUd2OphYfqfzvedYahizn/kND6iR5VN32EZFtD2s3
         rSqGBww6eTA5OURjwBV8bNI6HGKzz57aV6rci5REme2oR5FhGDHgDqaKz0XejIruVCzK
         LQkA==
X-Gm-Message-State: APjAAAWkTzdadI9Rd2yZI/mutP852Yng22XwT4YMx5MT81g4Pfd/f2To
        jRF34EkZhtQ+MOcIWEGUUkh729xS+As=
X-Google-Smtp-Source: APXvYqwY8SD2YvqCWV28Du2lSWCRWMElTO76abFaQqsoR/FMmRvojk6AbjxpSPCnDN2sIrw0ABHuBA==
X-Received: by 2002:a2e:8098:: with SMTP id i24mr7582328ljg.88.1557196487383;
        Mon, 06 May 2019 19:34:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b15sm2868958ljj.1.2019.05.06.19.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 19:34:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id v18so8403509lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:34:46 -0700 (PDT)
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr1358836lfn.148.1557196486137;
 Mon, 06 May 2019 19:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 19:34:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
> >
> >     dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
>
> That looks like it's a fail on validation of the kernel.org bit of
> things which I have no control over and which purposely doesn't
> advertise DKIM stuff in the hope that people will actually be able to
> send mail from non-kernel.org mail servers.

Looking around, I think you're right, and it's probably not actually
the DKIM thing that causes problems.

Because yes, kernel.org dmarc will just say "ignore".

So I think it's just google that still doesn't like sirena.org.uk.
Iirc, that's happened before, no?

                   Linus
