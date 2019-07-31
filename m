Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235937D110
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGaWWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 18:22:13 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37176 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfGaWWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:22:12 -0400
Received: by mail-io1-f41.google.com with SMTP id q22so20073123iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kwS6NVysKT0+c8CCpncR1xles8KnBQ/GENNp/Um2p3U=;
        b=XHoVIJpgBmrTr7YDaTDqV7ybaQ4Y/rGwwGr1n5yIXaouZWwVSNCV4qXHjDxJsBQi5P
         6A+bxjWBoQWC/7gX0MbRP3d0e3bIC4K1tq2Je5TQyKY1q1D7tvJ2A+SPPipmwVZrUkr3
         vDW4cNqcRRDG2y3+44gCIEgJV5IITZAYvoghE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kwS6NVysKT0+c8CCpncR1xles8KnBQ/GENNp/Um2p3U=;
        b=W4plR67u2P1de7/9rx1LvB7VRx0a+NXyJg6VKG1vsef80zwV3OBp9UVIQGagUdnSfy
         +UdjThOERO32pIsTGBYPnyaCJIC2/ud7TLQqCzGDsxaTgFQBzPmrBzj4AttdH06D0AFR
         4QsA8pEoS/+luXLcyt3/NeiU0FaLhH/lljqHmBK8s6yABoBiVJXsE/vjyQ/jdly+vK+C
         if+qQImcQxyJsxSM+7gUNkzhBaOGNT51AeFyATdCP2b1Fqp9aMjJiY57gPhrKcWOjWue
         tuuoEAhSR19VWf/6puFKCht6aYOz5by39qFtTDeBTKRhGMZaySWnOAfrvGh5L3X2NS4L
         Autw==
X-Gm-Message-State: APjAAAWem91z0YjwGxyRIhH0/2Pybf6I1niZ2bIyDVafpjDDfoQRNRzd
        qu3tPLD5aZSEgmROAi9hIZ/HACxKd6k=
X-Google-Smtp-Source: APXvYqwGZrQ5QRN6cpMlncM4bFE9K49X15n5/AWiOWQLYVuFsYXfnOvd+jT8RHiYtUzAq+Qu/ZpsgA==
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr52314088iob.49.1564611731520;
        Wed, 31 Jul 2019 15:22:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:b9c3:6ca9:e77c:7d59])
        by smtp.gmail.com with ESMTPSA id l5sm125693259ioq.83.2019.07.31.15.22.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 15:22:11 -0700 (PDT)
Date:   Wed, 31 Jul 2019 16:22:09 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org
Subject: Module compression & loadpin
Message-ID: <20190731222209.GA101140@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone looked into what it may take to support both module
compression and loadpin (ensures modules come from trusted filesystem)?

From my understanding, this is not supported as kmod currently does the
decompression of modules, and loadpin prefers fload_module as it can
tell where the module came from. (https://crbug.com/777204)

In a gist, I am thinking supporting this scenario would require the
module decompression to happen on the kernel side. Wondering if anyone
has looked into this before I go making a solution...

Thanks,

Jack
