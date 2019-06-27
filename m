Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9E57B49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfF0FYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 01:24:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33707 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0FYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:24:34 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so2054250iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIIwBX17xBmvmx1T+gcoOewCXOkdROxcqv1U8Dyz+oE=;
        b=OXZlLx/GhXOXqwsTB/C1LqW8uw0P35vMVrRjeFdl6kaABAlVKJvCh2sz/FruA5C2Ex
         CtdRjmzFIXxVXhTzYkM/TiPllk8gHaNR1ycXdrEV/HQQmkr97fic5QH1H4t3Q456NpnU
         JbbXYMBtrduGC7PuVPp3LcoQr3DU/6GGdkDRsKBpU7S/KRv8UoNS6g1TKxZnLy/axGJL
         BSL6szx5l6pkpSP5nwqNBrLHHlKBHAKbqR9Ja/f2lW4N4d/J2d1D4vlfWEAQiKHOJdiD
         QgO/LrKA+u3P49TJ18ExP908RZkdxXyz3LK7w/unBJsIs088mPd+25gXOsuF7AP0zguE
         1oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIIwBX17xBmvmx1T+gcoOewCXOkdROxcqv1U8Dyz+oE=;
        b=Y/i11SMXnO//YeAKaSA8ElPQjzvp/fW1c62aTKW27apvUpgHDwrS1404NEbdscIaNJ
         v1alLQLxf+oM/pXZy4+5uR/eKNdh/jdDFFYWIlWbTy6MCyNK1wcHSWKffN9ohHkJXP0i
         EP8kPaN5BYnf4Ah6sE0u2qgHoSJOpVWPJpkWSXufJMSra+4reaZQSsbuXLlZviJUsC7n
         KUv/AQL5+AfTPYA5nHkjK3elm9QTfKiRbbG6Nnrs14qMQsyGm1uWC/PgNjFiR0pmgulA
         kJNLA63OLUSCrwy5S3dA2wVhmhqqBHv7jq5QuYZirvJOR/0TufeRprFeiaz8C7r2vV8a
         4jhQ==
X-Gm-Message-State: APjAAAWqY3vpOe0Ai6+KbJ/pFUe+MSYoQyat/go63NyTso1tzU5ljkUI
        +VeqfHH9gvr3Ul8w1EhE/RTGqHUvjNYwJsHweXF4PQ==
X-Google-Smtp-Source: APXvYqzbfviqVNtJkE4LqaJax/YS9ZYRuR9tvoYRDCBiYHH3Lad0CksUqVzpaEfSLY8jg9WXf01iJSJx5T6KnqYmSdw=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr2531140ios.84.1561613072925;
 Wed, 26 Jun 2019 22:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190619090420.6667-1-kraxel@redhat.com> <20190619090420.6667-9-kraxel@redhat.com>
 <20190619110902.GO12905@phenom.ffwll.local> <20190620060107.tdz3nrnsczkkv2a6@sirius.home.kraxel.org>
In-Reply-To: <20190620060107.tdz3nrnsczkkv2a6@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 26 Jun 2019 22:24:20 -0700
Message-ID: <CAPaKu7SZr+wvoM8JgB=d4kHOJioPiG-hQbfU5mmT4iB9Kn4DgA@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried my best to review this series.  I am not really a kernel dev
so please take that with a grain of salt.

On Wed, Jun 19, 2019 at 11:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Also, I strongly recommend you do a very basic igt to exercise this, i.e.
> > allocate some buffers, submit them in a dummby op, then close the entire
> > drmfd. The old version should at least have tripped over kasan, maybe even
> > oopses somewhere.
>
> Hmm, I suspect I have to extend igt for that (adding support for
> virtio ioctls), right?
>
> A quick and dirty test (run webgl demo in firefox, then kill -9 both
> firefox and Xorg) didn't show any nasty surprises.
>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
