Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05378789E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfG2KyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:54:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40566 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfG2KyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:54:17 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so32360405iom.7;
        Mon, 29 Jul 2019 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8iqs/lSQVwY/t+gDmVcPAuTj0Q+h2kk0gSLp1nf66E=;
        b=en4fjHFHPiZuiYjLWFL5ihDQesbUNCfuRyhmaj91oj/ylqOLhTIflQnMpSYDZpyze6
         7SJw3muzq4JdL/XpnXYEKkq58Wvh6xqiP28d4FQZfu+M3qTyIVIXvWoWbp2kfCI+6wjf
         o/se6EME6KkyfIV0yXstoyQWfyd/RGTiJn9JbKnSkE/zNQgtEw+rTM7xJZ6SvUoZBokJ
         DHzNUz8qhk1KvlWrlHR7eG1J7kBVJjsT8otTC9WxefpOcUncZb9KlVTo0N2jm3HDh9eA
         SKnFC8B/kch8YM03AUMNFCQxHD8v/652YuKLb6xhIowtkBSsDmPlwLygREHySRiK0lbG
         sWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8iqs/lSQVwY/t+gDmVcPAuTj0Q+h2kk0gSLp1nf66E=;
        b=KLkQ0Xe0S5kqF6yOty0ogosZX0pNU94kjdxdRp9jWt4h3zBcRaLIh+XfS986EKbzOo
         s/+iyN9q8gVSsCM4FpNFUk/vLRt3KmXaUu+KPCxV6muofMYdXOaHOeXw96NvPXvboCxg
         y9WOQIv365Qy4QWo8DKaJP9JJ8o6NJXoVkI9h8e1O0oPp6QRXs2P0RAW9ckF9m+Uu/g2
         b+Y0KBSBZKehhuv53BvYEcyWwDFZi8GwIqdxHDXPiFI4OHemlmnU4IxOx2XXuZiDM09M
         4HMSPvT+vgi5tZg+GG05lcw+WbdJnVF7Xs0rZ+R9UnagHiXySxnmFlqFHAsKC+JO2558
         vr1Q==
X-Gm-Message-State: APjAAAV+chULOOO/VA/ynZx4lN+GseJFSdcoLZHD9WFiVqRlTQSAUaUa
        nNH4Md1jgfAbDr06qGE389L8F8N+BLhKMiZ1v5M=
X-Google-Smtp-Source: APXvYqwKkT5tIBwNGEgYfklsdvr8XCZxuj7SbGRVLa0scIYwQBhSGytpuWUJXX4Z168xOQFckbEIol4rJPZmst9FA7c=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr94473273iop.58.1564397656857;
 Mon, 29 Jul 2019 03:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Mon, 29 Jul 2019 16:24:05 +0530
Message-ID: <CAKTKpr5kmG3k4b85Zf05Q9xXpxMNZJyzWN7RXqZdteYUdMkc6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add CCPI2 PMU support
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Any comments to this patchset?

On Tue, Jul 23, 2019 at 2:46 PM Ganapatrao Kulkarni
<gkulkarni@marvell.com> wrote:
>
> Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> support in ThunderX2 Uncore driver.
>
> v3: Rebased to 5.3-rc1
>
> v2: Updated with review comments [1]
>
> [1] https://lkml.org/lkml/2019/6/14/965
>
> v1: initial patch
>
> Ganapatrao Kulkarni (2):
>   Documentation: perf: Update documentation for ThunderX2 PMU uncore
>     driver
>   drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.
>
>  .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
>  drivers/perf/thunderx2_pmu.c                  | 248 +++++++++++++++---
>  2 files changed, 225 insertions(+), 43 deletions(-)
>
> --
> 2.17.1
>

Thanks,
Ganapat
