Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1DA1BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfH2NtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:49:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39093 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfH2NtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:49:07 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so4487172iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=ZZWD9OpNRL0XtYFi2lFZlHxSZinqyJ8TpyLRrYC9iPu82pocpeGILmNJueXE79tL46
         Hx3iIG3SHdJuf3SlJEy1VlbhChjRlBUg7MhHjF0H71LlBWYxfvIQWax+sVjsQt5WUM/v
         VduNLbytEHMvZQWgrRu0W2b2t0rKniNs6zLPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=Jz4dR4l5Cm7afUCyipz1Mgj0Obvqu5RRiWcPLNzOqb1moaWC9zahasKqllBSRcrtmW
         sSlhW0Cliiyuxy4nytDVtqHXKu2gIuV+kw6vNDD3Jy5Utbyq03cHdkvM6OzlW+j2w/D0
         /HPqp/NR925l2XGX+IGLsMOVDUuOpyk+z0trlgbPQ2d/YaNgCooukN5x+wirVBgeph1M
         eeyH/YqJrS11zwX9uhwWZ+/qOeQqLbjYL27JLyBGBb7NEJ95i4d+6/r3jMpLrLugRlHU
         dgV64/JlmSbAC53WtH5qe2WS3JVuUqaLg49xir9J46+0NSRIWTS+katMlFT05QBVktgU
         Q8Kw==
X-Gm-Message-State: APjAAAXtGVqDrd55m3LvDVm/tsV0EHaZkMPLt+XEVxaSPS8xcA6Ju/Ew
        bpVzeAFJCGp+FdQEVPoDjLY6/24gpD3eyw59lFmdDg==
X-Google-Smtp-Source: APXvYqzW2n25R0aKrJKpGkCfaBBX65DnLGmBlfFac1mmX3iIfD8YBhimr86nLnQnYes5p3+3pE+/AtLQSkscAssggNI=
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr11000610iob.285.1567086547127;
 Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829134104.23653-1-stefanha@redhat.com>
In-Reply-To: <20190829134104.23653-1-stefanha@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 15:48:56 +0200
Message-ID: <CAJfpegsMwGLryccnOR5a0RTFKjv3jH4g0DQt-HpkSQTwZgHyKw@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: add Documentation/filesystems/virtiofs.rst
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Add information about the new "virtiofs" file system.

Thanks, applied.

Miklos
