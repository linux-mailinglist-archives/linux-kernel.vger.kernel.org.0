Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954801137DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfLDWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 17:54:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45197 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:54:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id w7so335962plz.12;
        Wed, 04 Dec 2019 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71fWNQ0DN1swwIGhbCZ65wzcZtX6q09U8VNbO3XVJ2E=;
        b=SEGp8TaZeiMDrnk6zAQ1kjGALOWEMQna4WdC85fGpk+uNwpO7tnZKkB+prOLYvB99y
         yEDkQI6y3v+Gsg4ipXwU+fKGNa8ao5QdJCUNJNuwdzk5i1VlcJ7Y9ZPpMD3sx4S7J6Kd
         rrIApoCSFgyMoQ9quKG+bxKCUc8I7GT6YB39VejvQ0+WePek+AmGHQyEEh3AXOsCqQMd
         LBJGwaR/9exSzOsBLf78EckGi1fDZrS1Ux0sV7tyMe57LfeKq78R2mkfF8tRC/fHPFlC
         HTFeV0Ggvr+LZxLln7KIxLKFwIzwmTq2cgjO0IGA1l5wbdMLBSt+c0/X+FFnIzVUe0kT
         EpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=71fWNQ0DN1swwIGhbCZ65wzcZtX6q09U8VNbO3XVJ2E=;
        b=tYdqwupMlPnwx3dSxZJxn4+WNhdaXG3xICeur+feUC0MmQRna24p8j1ROkQ4vYhAUR
         WYeIra7Rr0v0+3u+6YWHdJGRnMQYMTdZSYGbrb5T9nV2iX2d7tdvG3uH8e/0IBeCQQUs
         qg5F163cCK5ABrI71sEJJGiBwLIsT/LLk5J5G+ewB/5NLKN5r6aDYvwOSMqEvtKH4sjB
         KMM8jGKWghiXAhnfnbBLxuYhHUHaXgOKLwnIyt7WZcaKWggiu+uCMcJdHCsKMzEzRO0w
         WiXKm6klS899ALhqM5cH9swkV6fgrnKTUsECeflSOAeIGKF/N57Cp1z6hQ8osjPw0EQN
         JWDA==
X-Gm-Message-State: APjAAAWz+2EPQOMgHF2P9/+YFNy7Hqv2pAa0LcucTpg6GeXCbTpezcsi
        E6T9MzLUeFwY+aIGLtcFZJ4=
X-Google-Smtp-Source: APXvYqxBqYdBKxl+V2SCEjcz4KN8KXwHybwTQg8WM67jtRfnnhU6nU4LkNayv6vE7Jk2ZYUz3LM9VA==
X-Received: by 2002:a17:902:d204:: with SMTP id t4mr5897686ply.167.1575500094029;
        Wed, 04 Dec 2019 14:54:54 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id l18sm8916725pff.79.2019.12.04.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:54:53 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:54:51 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Taejoon Song <taejoon.song@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, yjay.kim@lge.com
Subject: Re: [PATCH] zram: try to avoid worst-case scenario on same element
 pages
Message-ID: <20191204225451.GA42672@google.com>
References: <1575424418-16119-1-git-send-email-taejoon.song@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575424418-16119-1-git-send-email-taejoon.song@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 10:53:38AM +0900, Taejoon Song wrote:
> The worst-case scenario on finding same element pages is that almost
> all elements are same at the first glance but only last few elements
> are different.
> 
> Since the same element tends to be grouped from the beginning of the
> pages, if we check the first element with the last element before
> looping through all elements, we might have some chances to quickly
> detect non-same element pages.
> 
> 1. Test is done under LG webOS TV (64-bit arch)
> 2. Dump the swap-out pages (~819200 pages)
> 3. Analyze the pages with simple test script which counts the iteration
>    number and measures the speed at off-line
> 
> Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes = 512.
> The speed is based on the time to consume page_same_filled() function only.
> The result, on average, is listed as below:
> 
>                                    Num of Iter    Speed(MB/s)
> Looping-Forward (Orig)                 38            99265
> Looping-Backward                       36           102725
> Last-element-check (This Patch)        33           125072
> 
> The result shows that the average iteration count decreases by 13% and
> the speed increases by 25% with this patch. This patch does not increase
> the overall time complexity, though.
> 
> I also ran simpler version which uses backward loop. Just looping backward
> also makes some improvement, but less than this patch.
> 
> Signed-off-by: Taejoon Song <taejoon.song@lge.com>
Acked-by: Minchan Kim <minchan@kernel.org>

I think it's very reasonable optimization with small cost.
