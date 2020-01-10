Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32276137A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAJXuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 18:50:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgAJXuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:50:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so3886040ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a/4ylgjmQcCigB0GN3R+FfVLnwKZ03GU29naJ9AmFWY=;
        b=1ORe7du75y8bIGNFjeY5a8rsfx+pb2eT02NBOiCQ+sQCalsd0kgByjIvpBTPm0Zwdd
         9NSr24B2MGPrf8Kcj3AFKnMiehNpl5PyO3gSwl3X2jkQLAHOcUgRvwwVzfJHbjCyvVdK
         /6d8LQhgcFemRoLWckzwU95kdAQQ1NtNILzKOJoZJLCZjlajxxut32SNKnNGWIwQsipf
         MZm8pF/tQO2nthFpNzEjvZRaEG4jqmwCU+vtHLFZ/3NDi2DE55756f/DFMo5g9Y75U+X
         GeGFQ4m45H3wzpjzDVbxwvlflSqRehe/a5Sp+3TJWU7YVLiUhITcY6E9elwO3ikeeHBA
         dLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/4ylgjmQcCigB0GN3R+FfVLnwKZ03GU29naJ9AmFWY=;
        b=P3mk/AU+2WcglasUIBgeo6nL/Mtu0ECY+NK3IYlH1oTTPnUuhWJZSsptKDQ3goJ8HW
         cgypscWiwdF8atbdBnpLs49dqQGt1QEnh9k/fcsdMi5jA1uLtWZ+OVI/wQobRGSykau5
         SIeSnTfFR3XTA4GFKxyJjKQteh3JNMz5CGql0K82HGPBIvPlmLpsbcbEWaMF1VCGtM87
         moksw4nyi/IZZqAUVomIJ1EagVSLcaDo0R7g23XykCa9LvgtJ4qUEfNUovrFMNX9aEyq
         CeSkd/MhjlruNLlFlrcZ69WOb9R9PqBsYRX6tPbsYHTkbqx74s/44YCi+MfOcvg2B0ws
         1Ozw==
X-Gm-Message-State: APjAAAXfs70BQI70oM9Tv8JtAUUjDzsV+aUpznXfid+p8zsNOicdWia6
        qzdS6YNfsSOeZqupGSBGqNoUKQ==
X-Google-Smtp-Source: APXvYqyCpKNXyIkh7rO2vraxEPK4HnOnHP9jjy2oQJp1dVT9gpTGCAIVV4YmgfYQXt0Ui1vndv3adQ==
X-Received: by 2002:a2e:8512:: with SMTP id j18mr1908588lji.269.1578700220996;
        Fri, 10 Jan 2020 15:50:20 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p15sm1718217lfo.88.2020.01.10.15.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:50:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 018AD10144E; Sat, 11 Jan 2020 02:50:20 +0300 (+03)
Date:   Sat, 11 Jan 2020 02:50:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] mm/huge_memory.c: reduce critical section protected by
 split_queue_lock
Message-ID: <20200110235020.5cfrudvsenzfotmi@box>
References: <20200110025516.23996-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110025516.23996-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:55:16AM +0800, Wei Yang wrote:
> split_queue_lock protects data in struct deferred_split. We can release
> the lock after delete the page from deferred_split_queue.
> 
> This patch moves the THP accounting out of the lock protection, which is
> introduced in commit 65c453778aea ("mm, rmap: account shmem thp pages").
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
