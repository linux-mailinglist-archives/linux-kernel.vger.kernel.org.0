Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB5D458C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFNJez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 05:34:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45796 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:34:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id m206so1458811oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAxytmldJ+LQ9oXsinyPkN3ds2MZTOAfP2wyBRBDeRg=;
        b=znWyHu/m14+5GXaF3gP7yu7SWXJTq+Wsj2nJNhc8A0PpJXKWYMOxGBSzVgS3mNhdto
         pIVE++2S8C4JJTU4WjXsC1kHn7wjVXe46T1Q6kfftlp7QWt09aT1nNuG2RkrQEB/cwUE
         BN5szDO+xZfoBJzWbSPWpS/dcQxVeL1F9QpTJSU12unEdVDilC3LI0FWMn5LQa6QoF62
         IyLlVJD452ywDx+di8zbmOYrjVE0AYWCczQVyNnuNZbTqPg2w1bPhp5TGL+dG3+zm4vh
         Rnvs6oqsivrAR6bIwx8FKP6rEVsUh+jFuN9GlkQ8Jvs4KmgDFlinHxXOP+H4zL/k15fV
         XHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAxytmldJ+LQ9oXsinyPkN3ds2MZTOAfP2wyBRBDeRg=;
        b=IFzRHpaILUtGzjJM33wOA5GIHH2S/J5drMg8VQOlW1W9XJq8HIPWcM+Kze/9Wrc8Lx
         D3MPjUOtb2LqU5UayFQlJ2aSARueofvCdhXrzyaDR+E6mlSBNFL7guO89Wq2Yv5R6DlX
         M+JoqlbZV6neew10WTwS26zuASJXSvaG5kXZWszdXgY2Zdve9kJ8SjIsZILvaKvh5c8V
         hxWGpQXpJzd53JAaYII6LxlX5gWh51N+ivW8pJ3dmWJDJdPSpLmz3YGXihSPfRDRSRVM
         yFBBWTFIUpk0de4iY2KEDR+74OvYAUrAKQIOQv1+dUeSsci/0HzDnFr96NV7iBE9DOiI
         omtg==
X-Gm-Message-State: APjAAAXU4Xjk8YwO167sUiNmc6bm6rryaQZ7f+sY1uq/ezV8EKPrAVLJ
        I9iZU5lUDeLfmnkInTldqosbDk6qGXVSz4o4DvJ+PAqF1+s=
X-Google-Smtp-Source: APXvYqx0gEvUPXqD1kFmi82P0JHBq+bBkwG2UJTph0n99wSE1/UssVfy4El7T5U0s3E2JMVdYGMfQQOJu9WMwgcxsYc=
X-Received: by 2002:aca:f513:: with SMTP id t19mr1276030oih.76.1560504894070;
 Fri, 14 Jun 2019 02:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190613223408.139221-1-fengc@google.com>
In-Reply-To: <20190613223408.139221-1-fengc@google.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 14 Jun 2019 15:04:42 +0530
Message-ID: <CAO_48GF1qzJFHavwt384MBcyyJRrFiZgYj1OHonUWMAcrm6DTw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Improve the dma-buf tracking
To:     Chenbo Feng <fengc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenbo,

On Fri, 14 Jun 2019 at 04:04, Chenbo Feng <fengc@google.com> wrote:
>
> Currently, all dma-bufs share the same anonymous inode. While we can count
> how many dma-buf fds or mappings a process has, we can't get the size of
> the backing buffers or tell if two entries point to the same dma-buf. And
> in debugfs, we can get a per-buffer breakdown of size and reference count,
> but can't tell which processes are actually holding the references to each
> buffer.

Thanks for the series; applied to drm-misc-next.
>

Best,
Sumit.
