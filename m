Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF06129935
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 12:16:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42033 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:16:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so4049763ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTfBS4fITKFzG6PAS8ATAU7u+aCjkt2oPpsuRrixycQ=;
        b=u5iUfElIbmpzJQ1yQVWEGftTzsuGCvhwRo+XXRpfxlc24UlIXLpkqdGzozs53t8t3x
         9lujbJoN6kImET9059Ei9FRqaiHScZjblCEvF7s2oFB7G8L+z87OBENNf5xxUz7mUCEN
         A+Ed2tB1cdl1VnxZc9BrsfEjyp9kAK3FYoKnmrxNjdska7j5Qgs9DQezJsxfN3yHWdN8
         4nthlvfQOYBzKtngkNv6pTgC1w0w8dOopyLfWIDUq8TR2tvEpjUg6BbjKClXgNH46O7Y
         v0O8rCqj5TOOZWG2+XNvO1QEkDE6l1+DD8/3tzl5OMOaNyZX318bD4yfyBXO3/k5c6l8
         P0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTfBS4fITKFzG6PAS8ATAU7u+aCjkt2oPpsuRrixycQ=;
        b=t+0LFE75f/ft7C3XQYEUs/eWIfYj8T3E32iMyu/lHYEaMSaAllu82w1LXOXJv5YtPe
         aQeJztsBDpfXZR6yDXn7OyR7TUzbg4n6A8c/dj8ItqPCAnDVGFC/a4pYcuake3GPT0I7
         j2zyNEScERwnTiVsoAjkahHtgigNrPs9mfYvvqQyLhKUKewz+w3cV8cKsg1mdktXOcu3
         4kkPIm5RlTse6YOO4z8sre3HK0ugRAMaRG22JIak3PZd+OpUWtGm6morF3n+1KDU+wgH
         Ca2qgmZYLfhqRFDUsadazJKeQjJOe7keB3m8tMTQR36Qcyf9elPevx+XI3CeyBn2C1k4
         LSpQ==
X-Gm-Message-State: APjAAAVm4ML1C6nuSzd9oxCNwMQfov8raHiNGJft1OAjhxZkukT46ZDU
        PieZCuzyhU5bHq3T/3NKNzey9Bg0540=
X-Google-Smtp-Source: APXvYqxL78/VMVVRLcW3ypUi/8u2tCs7BjbA5hAXf2R1EWL6vgmdaElgpaEjplMKmwEsAaDOLhPypw==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr16279221ljn.85.1577121409867;
        Mon, 23 Dec 2019 09:16:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q13sm10461189ljj.63.2019.12.23.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 09:16:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E4A0610133D; Mon, 23 Dec 2019 20:16:53 +0300 (+03)
Date:   Mon, 23 Dec 2019 20:16:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] mm/rmap.c: split huge pmd when it really is
Message-ID: <20191223171653.xy2ri52xymkwm3ov@box>
References: <20191223022435.30653-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223022435.30653-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 10:24:35AM +0800, Wei Yang wrote:
> There are two cases to call try_to_unmap_one() with TTU_SPLIT_HUGE_PMD
> set:
> 
>   * unmap_page()
>   * shrink_page_list()
> 
> In both case, the page passed to try_to_unmap_one() is PageHead() of the
> THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
> aligned, this means the THP is not mapped as PMD THP in this process.
> This could happen when we do mremap() a PMD size range to an un-aligned
> address.
> 
> Currently, this case is handled by following check in __split_huge_pmd()
> luckily.
> 
>   page != pmd_page(*pmd)
> 
> This patch checks the address to skip some hard work.

Do you see some measurable performance improvement? rmap is heavy enough
and I expect this kind of overhead to be within noise level.

I don't have anything agains the check, but it complicates the picture.

And if we are going this path, it worth also check if the vma is long
enough to hold huge page.

And I don't see why the check cannot be done inside split_huge_pmd_address().

-- 
 Kirill A. Shutemov
