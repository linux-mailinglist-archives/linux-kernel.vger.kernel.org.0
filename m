Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D041A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 04:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408505AbfFLCru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 22:47:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34441 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404957AbfFLCru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:47:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26so23235584edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptASItmcUSNnhSb4M1FVZMgI8ehvXZD+lmmHC8Q/l1Q=;
        b=JrvP60GK41wKZgrh/T4MTTXu9mTuEbTyFZskN+iq7VD9X78OuMK1ZUG8iWOOdLQoFH
         n6rVFXBAPhLjS1F4qeKN/h+l7QoTXdhnmmEKOeHW0lPEeO1nSy0YYqxYoyzymp3dFtpC
         oOIwa5YjNGEeuW/EPPU/kfQXm/Cy2vlqra4N6Xu2DAE1jdYAiPTaU32dXmyo5nZf7gbx
         k2hKtqiXueXmkCfspVH/5/n0H/yPOxW5D9k5GSjuB+gkfLOgLb22peR4ZZ/ftc94pmku
         GMD7JzRJ7ofhp4s2xHsfWwGHHjpJcDKVEmzkuiIh27sMT/n7zLpe7bRcfLBbTTiJ5tdZ
         66mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptASItmcUSNnhSb4M1FVZMgI8ehvXZD+lmmHC8Q/l1Q=;
        b=Bm3q7WqlYZkcD/gMNXucahK3LqivCEsD6dFh97RRV5+vHdRZFa1O9A3yaF38CeoPt0
         RWGlcTGeuMxoF7zrsXZgrrsPlEXkSOS1Bn8Lbnejp0pi9TDqoudKRKDbgeStwdvJmvxQ
         sCG+Fa1LdO33r1AacXv0HnAtGMc7w2LcNvLqU42zgZH/LA0OnDqMPdxNEo+wZ7hg/UHv
         hx/KGII456nogVBrWbIu3F2csgzOGFfPXXK1K0spIXww9PVYSl+awYgfiYsGIxu6zmwy
         94qUMuncThCz9qS3zR5FWCZhNMpfJpfBfT6wmMt2DkLBoZa/LqUS6uGqohPYiO/Z9TJb
         ESzw==
X-Gm-Message-State: APjAAAVn95YZDJADaDoq46hAUlh+0t7jEPUhz5qqmzjlrEzCYBWQ1nH/
        g90om/vy6UBxB/VQndb108EsYQ==
X-Google-Smtp-Source: APXvYqx+plsRJYH/COPz7/gHfMLDquyGp1ATrNtdlNVMWvpKBkg4rGfRPX1fOyim62NphdiSKueEyw==
X-Received: by 2002:a17:906:c459:: with SMTP id ck25mr25010903ejb.32.1560307668058;
        Tue, 11 Jun 2019 19:47:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a53sm1093281eda.56.2019.06.11.19.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:47:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CE049102306; Wed, 12 Jun 2019 05:47:47 +0300 (+03)
Date:   Wed, 12 Jun 2019 05:47:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: thp: make deferred split shrinker memcg aware
Message-ID: <20190612024747.f5nsol7ntvubjckq@box>
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559887659-23121-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:07:37PM +0800, Yang Shi wrote:
> +	/*
> +	 * The THP may be not on LRU at this point, e.g. the old page of
> +	 * NUMA migration.  And PageTransHuge is not enough to distinguish
> +	 * with other compound page, e.g. skb, THP destructor is not used
> +	 * anymore and will be removed, so the compound order sounds like
> +	 * the only choice here.
> +	 */
> +	if (PageTransHuge(page) && compound_order(page) == HPAGE_PMD_ORDER) {

What happens if the page is the same order as THP is not THP? Why removing
of destructor is required?

-- 
 Kirill A. Shutemov
