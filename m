Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF9249BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfEUIGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:06:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40574 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:06:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id k24so19444379qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNAOtEoAZMPZZoa5GUaVYIK7Z6bfPkstoCwpa4KLdsU=;
        b=U9IxRev8oSId9mHKIJv+d53QN59t1EllDgBux00QyjPdIWkW2pSV1eNS+pFg/Brcbs
         f5CpZdM7uH2Ks16A2L3DaM9kpzVHfSqmYBXQBtsnokuaksF2dwTcEIRL3e6wLKhL6lGn
         QPhNyXJb0HX9RgbbFd3OrOYHR06mmX5Aw1iIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNAOtEoAZMPZZoa5GUaVYIK7Z6bfPkstoCwpa4KLdsU=;
        b=bS6MjZwN23h1FGYAoS+kpkQrZuQEF5WjMBjFsJVcPX24cRZuLc9yQg3U/hP6khsDRf
         VhtEJzmhoT/gBvHKkYVBjlc6KCMthD6B0E+4WjiGMo07gCTG4roI+GBlH7qKrxSjs/Y6
         d5VSfVoqmJ7KKRe0YndQIzoTX0TYeYoDoAeNO88+suU6pCyWtZS5uuqv8lfHWplQ3qc6
         U/UqBmcMvKp2zH1Mz3QX7BapSwlufmOPd7lH1qnmWPT9UQ+0GVSKK4/g8JbU7ghZyySC
         ml4NdiBFHykzlI9sAHfqf2EphWjw/MvL//ugRB7TCkcuOtfzQPzE596QY1bQSyJa+5j0
         ccFw==
X-Gm-Message-State: APjAAAWLZNHsDsnUdBR6EX4x6y7JneMhxZzHtEJkzXziQURtJ73QlWsH
        gk2SqsQ0Idx32D4GTEoN+Z18EegzXSzcm+u+xUUFIw==
X-Google-Smtp-Source: APXvYqz9hTNmVrZyrR1MFTVtToaRak51rm3XYKvAnie36nNwGE2XxgXwPcxAHngcippuPrEfmIUlT8qgLefYJeW3SJE=
X-Received: by 2002:ac8:2907:: with SMTP id y7mr32599676qty.278.1558425997177;
 Tue, 21 May 2019 01:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190520044951.248096-1-drinkcat@chromium.org> <201905211524.RpQYbGWw%lkp@intel.com>
In-Reply-To: <201905211524.RpQYbGWw%lkp@intel.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 21 May 2019 16:06:26 +0800
Message-ID: <CANMq1KDT1WpPksLw5M0OyujF2XnSM0F7gkhWLi4VAa6je48qsw@mail.gmail.com>
Subject: Re: [PATCH] mm/failslab: By default, do not fail allocations with
 direct reclaim only
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:01 PM kbuild test robot <lkp@intel.com> wrote:
> sparse warnings: (new ones prefixed by >>)
>
> >> mm/failslab.c:27:26: sparse: sparse: restricted gfp_t degrades to integer
>     26          if (failslab.ignore_gfp_reclaim &&
>   > 27                          (gfpflags & ___GFP_DIRECT_RECLAIM))

That was for v1, fixed in v2 already.
