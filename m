Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D2BDBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbfIYKKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 06:10:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46714 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfIYKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:10:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so5818987qtq.13;
        Wed, 25 Sep 2019 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJAwGk6DiGPuEl9vVf9Y57sR48ZzWXO2zIkN7FNDT54=;
        b=uxKTN8lk1tw7q4BKtlWni5omGg5CksepRgdbb0Y8/fPCjGUk12xHmAkvag8jD+m6y+
         wDujUC/f4KA/DYatOKT3q1/vM70kArBh26AejVLzBbXQZmDKT7YAGMnNUhXVQGa0MgF6
         cAJ9vQMyTeAknsaJBXQwc2MaEKFBwu1yhyUT18UUXXz1hU095tWaXFVAvNGs2J3rw4m+
         +fnIqQhm09JOsVEZ/5bg0qH03P6ecDeaqB5YVWIFui2NHbzs5qH7JHADqvPfAKZMPX+S
         +7D1hzSITmfNaGWYJtEjG3GGAGLuGks11h7OXREuj3SMzdnKIlEPsaqiA11B9SGTbVEc
         5JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJAwGk6DiGPuEl9vVf9Y57sR48ZzWXO2zIkN7FNDT54=;
        b=ITQAybLJkB2WEvfwpPquzlwuk+DszXOb43kRmt56rvlZTeagcmUuup1B4JgJ+FfkgW
         4ec8OzLRQUXuutLTsICDtk4sow7TmQ3DN+CjpeKSqBqMh1AaKwWGabauesb/0479Kufm
         W/M8YlEnvo1ISR+9My/PY5DQBVhoqy4pI5jvE9Gts/QPAkjlC8SuDxvL1RdKE4puTNGL
         R9gkX3nRjFMBhhLg3tFC+i+RCfBi2Y8AGi0/PtqXFV3iAL3snozofn6wfMc75R4RoJuk
         lZFhjK3cQJeY7f/8wDCKewq0/S5uW/GLZ69NyKoVHpWdyc9wzbSKEXcq7PA5cAgq0bL/
         wdTA==
X-Gm-Message-State: APjAAAVjacjcvJrd1r5qhXeUvcr4nnuGPg8F91+J5nytAuyThz30KJVi
        L2U5CNAIOAlTAqLr3gvhpE+7L3G+EdLDP/wFfMg=
X-Google-Smtp-Source: APXvYqznDQSK+aaA6ZkdljBwkl0tTHX+rs+6dthLZ6KWbbv0oRm88ROn7k3x3V7tl2fIP8pOnHLy68ONiUomuQImPIo=
X-Received: by 2002:a0c:9846:: with SMTP id e6mr6669660qvd.114.1569406238740;
 Wed, 25 Sep 2019 03:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190923071145.GB2746429@kroah.com> <Pine.LNX.4.44L0.1909231053500.24712-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909231053500.24712-100000@netrider.rowland.org>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 25 Sep 2019 19:10:33 +0900
Message-ID: <CADLLry4ZW_jEfgcuAFUkRHZp8=hR9MgwQzKEB9nvJ=H9edwvow@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: Minor refactoring in usb_hub_init()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        Thinh.Nguyen@synopsys.com, nsaenzjulienne@suse.de,
        jflat@chromium.org, malat@debian.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you really want to fix up this subroutine, you could change the two
> "return -1" statements.  They should return an appropriate error code,
> not just -1.
>
> Alan Stern
>

Thanks for valuable feedback over the patch.
If I generate new patch later, let me make sure to contain an
appropriate error code.

Thanks,
Austin Kim
