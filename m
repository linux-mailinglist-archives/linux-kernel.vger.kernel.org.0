Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED46B966BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfHTQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:48:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43334 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfHTQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:48:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id o82so2294849ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfS/3YweTIcGGO2RRMlCPJRIxqMja+WwkZZpwCr9I0U=;
        b=K+mam5zvf/E3cU2LIDxXZWug/rqk3N2IZZ43MXOq44SNotDZn+byvLHrUFInHkDO7K
         krZMi68j2Wv9KleBJmISlXyAtf+AWs9TyWORM/Is9r/JWDOIisvRoaxJKLMa9X2+DkSD
         X8/9HsIrCN6cY1UKIUVTesBhBp4i3524bVcclEQ++s0bi/yh5/iX8yzTgk/KVOUmV0on
         7IlLZhBsYqtAIBE6vQRbijMnbR9VYedqBUFYnNM8Rbdx/bhjrOR+OtiJMEX84yYFHCtT
         KdyACLP9WpPoCaDmJFCRZjVP1xzZkn+G18umMyHY3eO4qR19pRTmM/TC8TB1C0CiILyZ
         TXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfS/3YweTIcGGO2RRMlCPJRIxqMja+WwkZZpwCr9I0U=;
        b=Wthu8y+PiHytJqFSWMx9xKlPYEyQ9/6jSQlIo9xPw6I6x9hdYLWvNStWL/JSdYPa/j
         7Te+bxzsQdZUtK+dSlfGF0y8ui8Evt+1CRmD1is7E0ChV50J6llg30y0S8BzOkNRQC/i
         AbEgH83bCg8fGLXFBZQAzrb0cCvhbJ2QF0wRYlfRSBQSBlgfcDizpBKaSrXKVRmwW5eU
         /sIkXa0cbJ9f0mONJBhxEQZ++qrBrnoCsseyCTSHOj709+vUX0zejHGvxjF1Yp6YU9SK
         lxU9lK+iSns53l916bUzw4r/hqEgCi8WD6g4phf9soLndxPR+8+skPviZ9+3Y+cbvwRx
         c6Mw==
X-Gm-Message-State: APjAAAU8rml+tpdPTkzg1WE6XuJ5GNqRyPU5cwz+o4kTR0I43E7kZ+5m
        jDNPjazM6ESHW4W3MRrOLXypSgyI+YB6oD4Ls4JF2w==
X-Google-Smtp-Source: APXvYqxnanSSbRg2czlqAz97bkbZhcKO5rytay9XH6axiOD/F2S2TPwc7saIWI++F16Xc8DLHrIgnPN0HuxOeH9Q56U=
X-Received: by 2002:a25:f503:: with SMTP id a3mr21166644ybe.358.1566319731656;
 Tue, 20 Aug 2019 09:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com> <20190820104532.GP3111@dhcp22.suse.cz>
In-Reply-To: <20190820104532.GP3111@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Aug 2019 09:48:40 -0700
Message-ID: <CALvZod7-dL90jwd2pywpaD8NfUByVU9Y809+RfvJABGdRASYUg@mail.gmail.com>
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:45 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 20-08-19 17:48:23, Alex Shi wrote:
> > This patchset move lru_lock into lruvec, give a lru_lock for each of
> > lruvec, thus bring a lru_lock for each of memcg.
> >
> > Per memcg lru_lock would ease the lru_lock contention a lot in
> > this patch series.
> >
> > In some data center, containers are used widely to deploy different kind
> > of services, then multiple memcgs share per node pgdat->lru_lock which
> > cause heavy lock contentions when doing lru operation.
>
> Having some real world workloads numbers would be more than useful
> for a non trivial change like this. I believe googlers have tried
> something like this in the past but then didn't have really a good
> example of workloads that benefit. I might misremember though. Cc Hugh.
>

We, at Google, have been using per-memcg lru locks for more than 7
years. Per-memcg lru locks are really beneficial for providing
performance isolation if there are multiple distinct jobs/memcgs
running on large machines. We are planning to upstream our internal
implementation. I will let Hugh comment on that.

thanks,
Shakeel
