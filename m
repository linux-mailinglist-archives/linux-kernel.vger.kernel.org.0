Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9987D313C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfJJTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:17:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37313 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJJTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:17:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id l51so10065905qtc.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhQju8RSX07X/KnjD6CK8YnuWTUpQtspCzjfwZGuOhk=;
        b=PvwDm7H6HDBExq/gmUBt13lPhyKR/mgpHs8Mp+C5e1/x5SsdvexdpLWoCW1+BbuBsi
         9GmgxDCbnVHwTk6TcxzVDYzg3ELkIG9uos1dIaCDVYM+H3/LAuEfDWDXj8sbM9U3qmpe
         ZRGAfahHFT1ObtaLAr+Uv/Oys5uSCULZwsdS4Xjw8w0K2vGWmUXfSv3vXiJYNmjSCjVM
         9JqKJnHHrv6CdljGbcTW3icNAohfImi1hNNR3RAs5LYauyctKUtYjA1zkGmPOw32FHXd
         dONuG25Ei04i3iQ9j8Rnwl3Bk498NeT/0PNaX1jMmgYAFgBXVE/46+7R/TArsKWitKXU
         HbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhQju8RSX07X/KnjD6CK8YnuWTUpQtspCzjfwZGuOhk=;
        b=kXWsPrXxSHDdrRDmw9RMQfdERKVlYv42mrpnP3tZidY6DzWgqXpZw/svkpZXzmOo1Y
         I2UZCKEwQXQkCG2/NYDM/rgA7AWp2DyHwcEsQl4v76KBJn11NSPBqPs3kC738rX1jmHi
         fOSxxd3D2B13C9iYAONqp7Aa6msfGq9uSm7p351cD+q5gQqKEgn6vY5ktNUFbBmk55m8
         w1xAQjetP5JOwGJ4gtX/LpHvU4ymM/WQyMZHSC5seoapwSWXzt41bVrAAMa3acQ/0tdO
         yWQQ5JEPFaw/pzc3JnsQsVVdOE7C4xNirH+3AH5t1kk5cVZ45ZBSn8cBwJtha4QU9CwD
         xBDg==
X-Gm-Message-State: APjAAAXLAGOChZf3XZHTWyL0q+6fWhCRSQUQB9WApFrbsWmXYR5c0YCJ
        4TnLjUAZpWbqMJIKrmNbhU79gQ==
X-Google-Smtp-Source: APXvYqybrZtK1L3jhtfN1BIES5a18iOJ8xFgfAHJUOneTuarK99XYY9CQ+HwMbhvIfFGijkAVyYgvg==
X-Received: by 2002:ac8:1413:: with SMTP id k19mr12735251qtj.360.1570735069216;
        Thu, 10 Oct 2019 12:17:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:39d1])
        by smtp.gmail.com with ESMTPSA id t64sm3120186qkc.70.2019.10.10.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 12:17:48 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:17:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sahkeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@google.com>
Subject: Re: [PATCH] mm: annotate refault stalls from swap_readpage
Message-ID: <20191010191747.GA31673@cmpxchg.org>
References: <20191010152134.38545-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010152134.38545-1-minchan@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 08:21:34AM -0700, Minchan Kim wrote:
> From: Minchan Kim <minchan@google.com>
> 
> If block device supports rw_page operation, it doesn't submit bio
> so annotation in submit_bio for refault stall doesn't work.
> It happens with zram in android, especially swap read path which
> could consume CPU cycle for decompress. It is also a problem for
> zswap which uses frontswap.
> 
> Annotate swap_readpage() to account the synchronous IO overhead
> to prevent underreport memory pressure.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Can you please add a comment to the caller? Lifted from submit_bio():

	/*
	 * Count submission time as memory stall. When the device is
	 * congested, or the submitting cgroup IO-throttled,
	 * submission can be a significant part of overall IO time.
	 */
