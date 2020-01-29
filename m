Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9214CC28
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA2OPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:15:21 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43832 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2OPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:15:21 -0500
Received: by mail-pf1-f170.google.com with SMTP id s1so7883270pfh.10;
        Wed, 29 Jan 2020 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVbzzG0X6Ket27YVQDpoYGdZSbXo+DC3nnTq4FkdtZo=;
        b=I4CeqxN5dAk6/08hdqcE8P00etE7Vb7WQs5alGHfNFiZR+lO4mhNk9l4beVqAHxxY0
         QlPEozoMIglOjkvFQYrkLl41bOBtHYiaHhoWkbj0Txuih6mO2A3ZWZlU+CGULQb6gPEp
         xgpVQsx3GfLSzF10BIMdrenNh4l0u/qfQEunZnSrb51R6MyKyKTMBFv3T/Y2I1uO2ONP
         v239qoxswlBoLHjdbnP5Q/F1aQbnkm4n8D5hIHdZ+w1+kT9Ys5HTEk7EMfPIQPPcypNO
         wdPJnv+mbI2W903tNUQyzhREuwBlncxwMYNmBW536c7JUyXs+sr4dtOv+SsTsjQ3EGtq
         kKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVbzzG0X6Ket27YVQDpoYGdZSbXo+DC3nnTq4FkdtZo=;
        b=QbMsVfQV+1fSIBW73FlJ/JzgZ/jUYDh3vwTAQxLzOp46cR91QUrch+fl942T45Vuc4
         EI6PwPm+kMrRhP9afUufVYBHQIJsNAAj5VCdusS2+Sr+m3WKsXZwCbrltZcL9eBH7DFy
         SiA+nUIhAoheSmoxg0jIBPudXuTqPiTkdv+Mmj5c7W8ysU3xJxQn2J0YvmoXUVk1xXDD
         1Efr38qHjME2yo4LbJCTVXLBTMeZ+AvrgLJ/DcnSkXoblNlwaIGNK+xuEEaqOUUSV1SS
         18nXql5BvNv2EIyp5W6phvWeakSU/feDcddBlkQgqk3C8VfoOeiBn3MECEQuK6kdrgw3
         IuZQ==
X-Gm-Message-State: APjAAAVie549h0/JZ9HWgnY0rcBaK+wIKhaoblpzfjfRZkaNbNBXS+Wr
        AiK7Kc4pzyHBNLGGzyLb72Y=
X-Google-Smtp-Source: APXvYqyTDXo/6RaGs+c+wYhxBhyJhEJcaTTgG9q+fTKW8Tk7Agy5LbFJ2OqN5YCuxHUvJMBopVMWIA==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr29888623pgc.34.1580307320595;
        Wed, 29 Jan 2020 06:15:20 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id g7sm3057573pfq.33.2020.01.29.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 06:15:19 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 29 Jan 2020 23:15:17 +0900
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Petr Mladek <pmladek@suse.com>, anon anon <742991625abc@gmail.com>,
        wangkefeng.wang@huawei.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-ID: <20200129141517.GA13721@jagdpanzerIV.localdomain>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 15:58), Bartlomiej Zolnierkiewicz wrote:
[..]
> 
> Help is welcomed as I'm not going to look at it in the foreseeable future
> (I'm busy enough with other things).
> 
> > (dri-devel@lists.freedesktop.org or linux-fbdev@vger.kernel.org) into CC?
> 
> Added to Cc:, thanks.

Hmm. There is something strange about it. I use vga console quite
often, and scrolling happens all the time, yet I can't get the same
out-of-bounds report (nor have I ever seen it in the past), even with
the reproducer. Is it supposed to be executed as it is, or are there
any preconditions? Any chance that something that runs prior to that
reproducer somehow impacts the system? Just asking.

	-ss
