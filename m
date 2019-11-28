Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973D310CB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 16:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1PMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 10:12:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37974 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1PMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:12:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id 14so29400216qtf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nOKjllZVklQ2GIcdzni0FFshP4MFkY2/Y2FlVOpnnI=;
        b=slvNZOZiQ5EXiyFAj60j/ohD3r5UdfzuIjYo9KQSa+fLRTBYglzhfrryhAAlZPnoCN
         jdxkLOROSabZqLq/hmHe1F7kCILCtfTtczZF3FD2o8OiiQO2WVEHAZDW1+C3pp5ZvaN+
         wFGf/Oz8cMLddB3cEsrUg3aAwrsjhz8pe6t6oz0BwJOCYY5pS4BCA2wCLEDomHY8YHCM
         cFH4xqY6SYJj+bET8dfmh/fUtxJLKwhhBFOG4sLClQPjiAD8rL6XrB/FRMkvM0ZP5Uay
         i1U+4DVL7prNO5rhTcM+REL6Rhlxe6Z/3WzUB1h55D2u47caqI4b0xKmtiyEcL4v1OBE
         OjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nOKjllZVklQ2GIcdzni0FFshP4MFkY2/Y2FlVOpnnI=;
        b=H5uGjglLcMv4TjJu1Es/8rYgBkuPjcKYWzICDtH1Zk1X/JOiSP+8DHqI/Z/UD8TDh2
         e6wKjcIsk4ALOLEZXU3q3a7DTykgm1Qk452GNSg6Rx+RvYSpZHI0SXTYCkyNkxOP5Lwb
         wL9A+JNzZV5QDpRHvN2rWaghQB0yAKWIKmcL3TYZuB88Ct1CxbX49LND5OiifY3W+EMu
         udpB8GEtI86m11p5hzzznLpim/xcX5/LQYwm6f6JoHmwWzm9QmJ/efOLlGDhoN6uPG3C
         OrGD3CGAwHgKJKpCjb4uv7hpW1O0AsnWnp3NTTz07v23bXvOAVGV51wHDKs+ieCa3KkS
         uK2Q==
X-Gm-Message-State: APjAAAX8KgSqJbCf3vxcCoS9Z+BimDWRrJN4sn6iaT2xClFA5WNFLyLV
        P685/r8PceJut3/yNDJPYVYp6gtHuCE/sE9IYqk=
X-Google-Smtp-Source: APXvYqwIXuqtF4jrM4aCPdUaZgR5YjB6DQwQhdNa0N8yY2iuEaV2MebIMBqTNLRTMCrjbcoIFrkdXibep0A0iHVUETw=
X-Received: by 2002:ac8:109:: with SMTP id e9mr37011432qtg.233.1574953943705;
 Thu, 28 Nov 2019 07:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20191125145320.GA21484@haolee.github.io> <c8e88092-ddbe-2934-aa61-5db6cbad0c11@arm.com>
In-Reply-To: <c8e88092-ddbe-2934-aa61-5db6cbad0c11@arm.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Thu, 28 Nov 2019 23:12:10 +0800
Message-ID: <CA+PpKPnA2n+inG7nP0V66Q_-4LNn_nYZa2dqvHTz1fKT2J7e+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: use the existing variable instead of a duplicate statement
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, Mel Gorman <mgorman@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 at 18:02, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ee4eecc7e1c2..de4b2d1e66be 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -363,22 +363,21 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >       for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> >               struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> >               unsigned long size;
> >
> >               if (!managed_zone(zone))
> >                       continue;
> >
> >               if (!mem_cgroup_disabled())
> >                       size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> >               else
> > -                     size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> > -                                    NR_ZONE_LRU_BASE + lru);
> > +                     size = zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>
> Is not this already merged with following commit on next-20191126 ?
>
> 54eacdb0dd8f9a ("mm: vmscan: simplify lruvec_lru_size()")

Yes...That's really a coincidence... I use torvalds' tree to develop
but never think this function has been refactored on next tree just a
few days ago. Thank you.

Regards,
Hao Lee
