Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0CBE3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443165AbfIYRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 13:42:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfIYRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:42:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so239082pgj.7;
        Wed, 25 Sep 2019 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep7MUnwSTs1NOnosNHftd5kt9y4voslofafMsmgNvp4=;
        b=bbW9tn+OnqiBwGpi5ggOj70MxJU0HhU0829foG8gFQSO0rs0Uq7oG3D6ZSaAfGF6wH
         xU3EPipe46ILw+PoQRsfHiGXTXTV02ugZzAiyftJu6dZHvjViAKxSnbqosQq4tJg4Oku
         mhFqQaqBeimZ1FcPY+kKcnv74IeOfKhSwSW6jGGqIiAtDoSCdTJyAOph6OWjUlrY205N
         VsE1xzI7L/44l1uOlB1sMLDnAK7m6h49Uyf9yUkxXfGvINQSG0z4X1YnAGTladLcklvo
         PmkjihR0GvnL6swRODVk0anKRlDOVzpjhG2sdl5+Dw7rh1ec/CIZOyFHG7xX2wdaHc+0
         QduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep7MUnwSTs1NOnosNHftd5kt9y4voslofafMsmgNvp4=;
        b=Rik3kUAckcAsqvcqWo3mi2vijjG+lO+0I9dRAMxOo2JaY9HukC7o5XJ7LZGHcBQXtc
         tEc08/NxGCuveDagRpsrTVv1PGDvd7XBpj7lNhwbaqioYWNKeYBfEup7sqzLWESfSrJ7
         48JuOc+gdjygIty4d83Ki99IPAZYaDTDVL2Fmjf9VULmp5KEBNumqgwe9/n6WefIJIHY
         jAqrNbLTzrJnVFZyL3DsV12MFPPf7SqOk4zyi++byH1R2g2bfqIzynVQGFr4yQFTIj9G
         /HyqAup/QxYbC+IhO7TbpB/1xR6EEh6qIHE0ooiCbyq16l1iIiaPAkVRBd/kNvszbUN7
         u9eA==
X-Gm-Message-State: APjAAAWanbVETKVnejH0YdQbjvh8A/P4I1dmCBoEcQlb0TvNiceC10tK
        pPrIgdw09Y/tEiqCjELiv4vjjFSZaG8DhxeCSSgj86l/cSA=
X-Google-Smtp-Source: APXvYqwglDjYNJyV/BoRm1ThUdRpIn1sTx5vUTfTTnMfBOInk51P8lm/kYDxjLKc3vX28TD1S9MlOddzABELHN8MleA=
X-Received: by 2002:a63:6988:: with SMTP id e130mr497818pgc.203.1569433334476;
 Wed, 25 Sep 2019 10:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190920223356.6622-1-jekhor@gmail.com> <20190920223356.6622-2-jekhor@gmail.com>
 <1cca117d-1951-0335-1aef-ac994c3c757b@redhat.com> <CAHp75VcoS2OFr8kwM7vq0iCqf6BpyJ4SO7peAUHKxAXdgA7CMA@mail.gmail.com>
 <20190925162712.GA3653@jeknote.loshitsa1.net>
In-Reply-To: <20190925162712.GA3653@jeknote.loshitsa1.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Sep 2019 20:42:03 +0300
Message-ID: <CAHp75VfL0RUgMhZk=gesxBcBfRkfV8kC1zsN9TNg53qpUNVU0w@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 7:27 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> On Wed, Sep 25, 2019 at 06:02:22PM +0300, Andy Shevchenko wrote:
> > On Sat, Sep 21, 2019 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:

> > By some reason it doesn't apply.
>
> I have checked, and have no issues when applying this patch to the current
> torvalds/master and linux-next/master branches (351c8a09b00b and 9e88347dedd8
> commit IDs).

It doesn't apply to the subsystem tree (for-next or my review branch)

-- 
With Best Regards,
Andy Shevchenko
