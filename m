Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B3B5864
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfIQXI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 19:08:28 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45848 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfIQXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:08:28 -0400
Received: by mail-lj1-f175.google.com with SMTP id q64so5215547ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g82v5y3G7TVA0v7mCcq1n+V2khyOarEDdhGna/0Sk4U=;
        b=L8a2jFr0MK1lqzSmP1nmNC7UtLKaANtJmwm0MjDWS+KVH79086JwtyDZuUGM4T781m
         HoilUbcI4/1ZiN5cXpxjaOrqMFRdDS8Noew9fdkB+wySfbVXegDF6l39qyRDe+3dK4J6
         jyq4YIHfLp9NTKMvV2dsp9msHtHGUv7HkFwqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g82v5y3G7TVA0v7mCcq1n+V2khyOarEDdhGna/0Sk4U=;
        b=R6idTXim11fFj5uOn+JDCuErdjuVGzPyMRF6cklaIjXPsa/nDHjM7hRj8NIue/3Edr
         WQai3GCyQd9CZXK9q2jyoMP9n+kQCVSdxGx+E62KTnW9lWYRjOcHwWtZhKms/CeEZQ2N
         n12TzRBZ3OnegZR365eAhcaDEcZpxdD5/JCtqWzlGXOWx8eHnjMCo3Fs5hMD2ZQYDviD
         LQuNY7Q52aIbCy3Arts/y39ON/oKqeh2dmwW+k1yQ1c/GvRXHR2ugRHPM6WgEQRcc54+
         hnDT22/GF8Hux0yJt6SLMCBWCIvJkblTAfHp7eK+aX642jK91VfGEm8UrbmdRF7XRbI8
         UldQ==
X-Gm-Message-State: APjAAAVllQH2uOkpa269S5ZpKTG1IxjkCdtttEeXxSCErY/km3x5C6Ii
        Pv1gPHnG9ca7slKdFPIG9Lp3JuCoFkI=
X-Google-Smtp-Source: APXvYqwxk9IkgU9p3+UKvTNqgZWsGUGqwZogeBh4haZNRLJk66DHfkdPrJZIba4hxLVc3H3mUgYxkg==
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr394054ljk.183.1568761705733;
        Tue, 17 Sep 2019 16:08:25 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c4sm669733lfm.4.2019.09.17.16.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 16:08:24 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r134so4131092lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:08:24 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr366572lfh.29.1568761704101;
 Tue, 17 Sep 2019 16:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <2658007.Cequ2ms4lF@merkaba> <20190917205234.GA1765@darwi-home-pc>
 <1722575.Y5XjozQscI@merkaba> <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
In-Reply-To: <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 16:08:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO81JZJSvmyeUwW7YOk=14YyOnu0TFDygo=jy3D_r6UQ@mail.gmail.com>
Message-ID: <CAHk-=wgO81JZJSvmyeUwW7YOk=14YyOnu0TFDygo=jy3D_r6UQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
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

On Tue, Sep 17, 2019 at 2:52 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> getrandom() will never "consume entropy" in a way that will block any
> users of getrandom().

Yes, this is true for any common and sane use.

And by that I just mean that we do have GRND_RANDOM, which currently
does exactly that entropy consumption.

But it only consumes it for other GRND_RANDOM users - of which there
are approximately zero, because nobody wants that rats nest.

                Linus
