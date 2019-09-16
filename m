Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED61AB4484
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfIPXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 19:18:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44090 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfIPXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:18:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so1502564ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHtNi0a+TimuxW1u+d3PsNmzsTMMHbqdiEbQwvAU2DI=;
        b=WXA66mIqE1S4egtmENLvgyssWbOsKrwZhBbRFIiaAIR05oCwS4ealdQRJKD/DWEh3y
         Ha5Sk981WcJ+TqA+sEbflrz2FIBzz+Kd+LYdbaQMvLGJqdiVkfITbf7ZLiijaZWShWen
         RDjXcS9k5dUiLdfpQFn7HZtrdW4x1dPlKUXz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHtNi0a+TimuxW1u+d3PsNmzsTMMHbqdiEbQwvAU2DI=;
        b=WZVGofINuPrLUoFlPLNV+MphLLMzX1iNoF7ey9JqZ8F4jLnvOOanSzeQWOVeNSngnH
         Xb95RKeaV+rzFI6IhA0YlbgLFm6nBs3fUPQSm2GGDpcv2rCElafJcl5zrviS4fyIbT59
         SYWwmcTE09xGh6qfwYonumYCI83GZ//iQRMaKfcRiNVNM5x5jld2r+7qVb7cbF6BWTtO
         BNY1c7w2rP1Bp6wtK5vXvL3OSbkB31AyqOHszUDwa2t6al3ERvZGh+DqG8xpHSHJB2/B
         MMoel+JxcJJod84EvT0P04HD1/0G4gomBNLrphY3xBHkhfTXJ4DMwDCMW8PW5gi56Pw1
         5pHw==
X-Gm-Message-State: APjAAAVWBAMkiueZGG5Lrzolp7tT6Lz/X2d1qB2am4NkVEoBQfDbPj3O
        UFv3pDwXNboZx4gAbFRu6cA7CLnU5OQ=
X-Google-Smtp-Source: APXvYqzAvS5QPe6M6NYcZIEe44fU3scFUAVv9EvOW3i1IDj0bkQsspdpmhZT7mRqRqc958ezK57LYA==
X-Received: by 2002:a2e:3004:: with SMTP id w4mr183172ljw.21.1568675898188;
        Mon, 16 Sep 2019 16:18:18 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q88sm60443lje.57.2019.09.16.16.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 16:18:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t8so1251341lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:18:17 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr345568lfn.52.1568675896897;
 Mon, 16 Sep 2019 16:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org>
In-Reply-To: <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 16:18:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
Message-ID: <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:11 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> In one case we have "Systems don't boot, but you can downgrade your
> kernel" and in the other case we have "Your cryptographic keys are weak
> and you have no way of knowing unless you read dmesg", and I think
> causing boot problems is the better outcome here.

Or: In one case you have a real and present problem. In the other
case, people are talking hypotheticals.

              Linus
