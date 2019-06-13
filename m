Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F1C449E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfFMRsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:48:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfFMRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:48:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so11352877pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtqNd27XHnCRsfcGvnXPu8MWk1j9TxUbVAvasUsnvR0=;
        b=Mp95nN46p0avucch7HE16s7c+ipTeovth827wa44CgRJ/MFRnMj3Aju5KdNSzwh1oY
         FeU5LWHahwLMLEGghmQKKOLWHL1Fl9ruy2m75J1/rsePQFmgGxr9krNrO/6gdIAofuUD
         79iV9S9mgF0Xq4lmte8BjCbpuJ883HHVa2DSoZbyT5R98IEmOmRJKjEyiGQLC4wDk/Zu
         a0xUv3ATfpjnhzEbzMSvj0jJhXQYlen+EBPKSPrWKKWVuCePGcdshhaxIEImKyWLXtmw
         EBo4goSLamStZZn4Ajchx0LpXsSUodv+UjCaeREuv+UWVwzvJjhxt6JhaMDFGhv9jGZq
         6BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtqNd27XHnCRsfcGvnXPu8MWk1j9TxUbVAvasUsnvR0=;
        b=a+6XXj7cuXkJ1WeNgYQ84PYQ8su5cAN6oYYfhGR4DQaiJqnrbsZ2mu3S+AUj8Cc1pa
         R3OJZ/QPQFrWTBNo7BoT3SxAENa5Cy4M2gK0YbSilxnb8DqmenPS25J2vDTVzTxjORVY
         kknozcZtrJgfmx3uPpRsIBiZwRtmDh9eqL/qrbfFQ15XFopCmrMCr1u3MVoLiqUQ6vnE
         NXxHAULlXE4NfjefC+e2eSkK8o9HBKYSlg8wHagIosEMD6mVn3h4Rkn6OJQQCJaL0HtZ
         t9OUE64+YkhSaPVy0mqiIsDCvXakRBsvT02Hwc9XvBBkrntRD+xHsyXtfLLcKviqg1+Y
         o9ZA==
X-Gm-Message-State: APjAAAUuHCvVRn7UUOjvAoaeobP8J5sDLiHyQv0dY3epYv0VxJGkfW2z
        19QGEuWGhqO2hASSIpBng5XXJJWpuG5vRGLmbZRX1g==
X-Google-Smtp-Source: APXvYqyBX4Kyc53/BfiTRW4q2HKjMFOETEcw15TvtEp5sIPvO4onRY1u1hoafLLAfAt6MKfWhZm7S6oQVZElGo0q014=
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr31364633pgm.10.1560448084290;
 Thu, 13 Jun 2019 10:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190612235803.9290-1-nhuck@google.com>
In-Reply-To: <20190612235803.9290-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Jun 2019 10:47:53 -0700
Message-ID: <CAKwvOdnjTxzXgPHQcC7K8N5YkTvh66sy86oorPJZc07b7UBhGw@mail.gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 4:58 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Since mxt_video_fops is only used inside an ifdef. It should
> be moved inside the ifdef.

Thanks for the patch! I agree.  I think it would be better and clearer
to sink the definition of `mxt_video_fops` down closer to its use,
immediately before the definition of `mxt_video_device`.  Then it
would be closer to its use and it would also be within the existing
ifdef.

> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -256,6 +256,7 @@ enum v4l_dbg_inputs {
>         MXT_V4L_INPUT_MAX,
>  };
>
> +#ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
>  static const struct v4l2_file_operations mxt_video_fops = {
>         .owner = THIS_MODULE,
>         .open = v4l2_fh_open,
> @@ -265,6 +266,7 @@ static const struct v4l2_file_operations mxt_video_fops = {
>         .mmap = vb2_fop_mmap,
>         .poll = vb2_fop_poll,
>  };
> +#endif

-- 
Thanks,
~Nick Desaulniers
