Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52B6A047
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 03:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfGPBcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 21:32:00 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46706 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfGPBcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 21:32:00 -0400
Received: by mail-lf1-f45.google.com with SMTP id z15so8092439lfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MTovimhI6De2cI3DcsVuiEx+QTqzfDNjeAX4Ay9ZtM=;
        b=DplOrNfYlV3CrQj7L74n45nVI2h88eVaf8zWeB5KxygHLqJZcLBl432vBPRshqTDX5
         5ILgXHLHe26kJeqyVcc8YvTfzCIx5aCSV3zvP2iPUUByBZ+/Bzb6MAGZc4XamQY11uQR
         TNUcrFNyYYbi+y1doRV4d6WqkMvqni/BD7FdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MTovimhI6De2cI3DcsVuiEx+QTqzfDNjeAX4Ay9ZtM=;
        b=IOtAM2RwRV7/NiDaw2zgwtMMyCSOaXsFRwkygoV1C5ThUpEAmBtNJk3FdGh1+UAJww
         Fu8knBH8UVBNmVyfXmU0T/IOECapkE/F54tdmPjvSnmu6FJSgAXzequ1Zhqr+b3jfF4h
         6iNuMx2dOThxU93ZyIGT/6ldbEUltd5nQB5byzipSaQek8iXqfM0RUFwsMuUYvQ9r3IR
         VgMZ7mUjzRNY0yzvvDWnB/Eew+JuwTaYTHNEsTWwPL7rrZJZ0g+6fcGCJ2M6mAkaxybv
         KmIdo5iAbm2yDXWDemqRbuNRR5xP6iyr9Zq3eT6p83K0eBLr3nX0sl+aLURuo56q0Ojh
         8C+g==
X-Gm-Message-State: APjAAAWfTgxMyC4hyL1qtC99puNM9ubMT9OntHoIRM3TGZ1THWiqPfN0
        qbqiVAupyspQfUtj+5l/rr02OXsT14s=
X-Google-Smtp-Source: APXvYqyHjiHU8+LPrGZW8LUYk0QQkPd733ph0SPJwiRv4zDKQ+FUpN2Z9WzgWfZHoWLwfi7ZdFbDaw==
X-Received: by 2002:a19:f819:: with SMTP id a25mr13580168lff.183.1563240718188;
        Mon, 15 Jul 2019 18:31:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v22sm2580255lfe.49.2019.07.15.18.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 18:31:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c19so12379103lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:31:57 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr1828591lfp.61.1563240716994;
 Mon, 15 Jul 2019 18:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txxWeKW1VLWNzLEykELmSCqo_kOHBDdJH-cJfAJXZnnuw@mail.gmail.com>
In-Reply-To: <CAPM=9txxWeKW1VLWNzLEykELmSCqo_kOHBDdJH-cJfAJXZnnuw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 18:31:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8hWQ1xnPAviyMFN1J4VcDsYnfDmGTYbgExZ8zzQdcPQ@mail.gmail.com>
Message-ID: <CAHk-=wj8hWQ1xnPAviyMFN1J4VcDsYnfDmGTYbgExZ8zzQdcPQ@mail.gmail.com>
Subject: Re: [git pull] drm pull for 5.3-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:38 AM Dave Airlie <airlied@gmail.com> wrote:
>
> The reason I was waiting for the HMM tree to land, is a single silent
> merge conflict needs to be resolved after merging this as below.

There's more than that there.

For example, the DRM_AMDGPU_USERPTR config has a

        depends on ARCH_HAS_HMM
        select HMM_MIRROR

and that won't work any more. The hmm tree changed the requirements to be

        depends on HMM_MIRROR

instead.

Now, arguably the hmm tree change in this respect is an annoyance -
the old model was much more user-friendly where the drivers that
wanted HMM would just select it when it was available.

See commit 43535b0aefab ("mm: remove the HMM config option").

I've done the merge, but my tests are still on-going. And after I've
finished those, I'll compare against your suggested merge to see if I
missed anything in turn..

                 Linus
