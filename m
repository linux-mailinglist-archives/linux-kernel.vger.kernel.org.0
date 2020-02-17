Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB48161633
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 16:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBQPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 10:30:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38052 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgBQPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:30:49 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so18832620iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nik+rqycmEDKKNZsQwpz+4ONEq13jMp/wrMWb26VmVM=;
        b=CtEJ2Ggzvr9hcXYk8dQsXqCegUdOJm67CxgcOD58uMHqi8e5Ia1lcGlhQXPnv46mCx
         nP9DMji9V8xzBPT+lZbnDXAMujFS2Xj5rlYHy3CKOZ20+hrmqwkJoWSAgsvNXOG8C8bW
         9SgvtbhdgP582WK5wIOu9qYAHWu6O+nwyb5jrhOGp5g5B2A3weHU1bKR+iKHONmqt7rL
         LI4k1jjctb2h0C5XbrdeyrlNyuoNLree2iwOVIwfeKtxS1f168LetLE/s2NtPcCFDbWM
         TiA+uqf9tOA/qLnRE0gLSpbeJrHcmdtxCgBlNdtIScDlJNSx67PP9YrR19VLlvlonKQ8
         FpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nik+rqycmEDKKNZsQwpz+4ONEq13jMp/wrMWb26VmVM=;
        b=qlnlSgkmpu0lJlsQBiA97282W9EyAHJZY1dLpXJJ0E8FXUFevleCRWiTacVyQvwwJc
         kSsvKdZpCZipPQgn5aVRJpSyoB15hiavZKLdOLp0bn6V7Bmp5xPXD23t4Crj+RoZcySQ
         Md2XC3NbVGIHEtMaS9zemuO8RRRdQTY5gWmnmTOZDj/T5K/kIuOB+FVKpNYFyljYgnmx
         43kyTFrMSC9WV7M9USxelmOnvwlyuGpexBte7B9v/JzIfWBrjd5XRxNIOXw+/NMZYWcR
         mvz6b/5O8LdkpYK9zcLsJC75jrIrp8eftibjChnR6X8trR9LPyXFBPpOrrLVNjZJb/Ep
         6uEA==
X-Gm-Message-State: APjAAAWNd+RJ4DF9ASQ+bAJ7P9nWq2NBguY9IhZhd5+B7yD4lQq58JWo
        qcs6mlBLO2H2Pe4XApPyrBzFctafVmaQBjbXkRb/7A==
X-Google-Smtp-Source: APXvYqzHpRlg0LlI1yFuBVsd7lVhW3uS5OLSUwYHwPAFqz6TG8K3maLTPKkD9BpY2TRYeSPAy4WXzL0PDSzQ1SOLHdo=
X-Received: by 2002:a5d:9b94:: with SMTP id r20mr12244922iom.140.1581953448514;
 Mon, 17 Feb 2020 07:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20200213094204.2568-1-leo.yan@linaro.org> <20200215032259.GA21048@leoy-ThinkPad-X240s>
In-Reply-To: <20200215032259.GA21048@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 17 Feb 2020 08:30:37 -0700
Message-ID: <CANLsYkyw__tnn5FC=ro-LuaOibP19UhGvPPndjvJDodxcj6Ukg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 at 20:23, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Thu, Feb 13, 2020 at 05:41:59PM +0800, Leo Yan wrote:
> > This patch series is to address issues for synthesizing instruction
> > samples, especially when the instruction sample period is small enough,
> > the current logic cannot synthesize multiple instruction samples within
> > one instruction range packet.
>
> Thanks a lot for Mike's review.
>
> Hi Mathieu/Suzuki, I'd like get your green light before we can ask
> Arnaldo to help merge this patch set.  Thanks!

At the very least, please wait 10 days before pinging maintainers
about patch reviews.  I have never failed to review coresight patches
and this time is no different.

>
> Leo
