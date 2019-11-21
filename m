Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727C110598D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKUSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 13:30:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42026 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:30:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id i3so3926451qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KIV6C8dEDRsWYAQ2tTt3LiUnyRDtIsvpcdrWmt9koPk=;
        b=GKNVzz82IHSesvkhRwLOrdR1guhy1ks2Zlv5Ig9t4AOGgFyjYCJJLijnX+MsFowaXV
         RsyaqXjmaAhEKGmtYxEH+iPKkLHXHFpTuRz1wKvwFc70VrQxaOGVXyBOhjWMJ0JMhJfB
         8v+EDESV8ao55NbiACdWSRh4IaD2WVhHfWfoBmYoqyjjdN56d6gqKA7Cu41Pm+WwmeDB
         tyO7+rhHbotOPjRQIwIj/EKC9fMRPXOZ6XbEU38Q4t5aqxY1CA+7/LlSoWUbFjfiiLLT
         reR0lZBlCbK1tCyqtsYZVzBMydx8fC7iTyCWACTRNYORaRYTgseS+RgEGgiaHgUtbuc8
         240g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KIV6C8dEDRsWYAQ2tTt3LiUnyRDtIsvpcdrWmt9koPk=;
        b=mhCiNX8pqzyYwxANgSvURFfAHGW5P8SB82HumrmN8/UxYCO9pe8NDfb5+yzCMYc6a7
         c0HiWmjLHBzUANWTgYrLtt5bbdjtzVT14E15L3TEUMBCXI2n8dsOikBRwJi783LIajUd
         t+wQ1Yi0fvRIKd//XKpYdGc9HIyLW4pIMgyr1ltdjTZQ4Jj+LrYm2gJA80hpYWyLxHq8
         isrOHwmU/kZQgemkshIYl8sDvR0k/uS9WH05j0Yn6MkZ5sQuQs9iEKmLsFiIsejqH0xV
         LFQIjNC0ZGf0P0HWhnGvbTgw/w7ItMvomcj67aOxTeUXwVxK2ApFjqb52kZy3yDD3Y6k
         CZTw==
X-Gm-Message-State: APjAAAUn2FlrVo7kLSmjuvLbGvw77lQyp88+NUcJQ2S5XLKnzlWUeedw
        e9zvd+0meOX/vwvkRnOBGUkMWg==
X-Google-Smtp-Source: APXvYqyaGMwQheyrHGh2wyVCXUzgK0AD9nF7B5VCw+XZF6QwzxAqrPIjnl8qwfQqMknP9QjM9fRjDA==
X-Received: by 2002:a37:78f:: with SMTP id 137mr8854398qkh.321.1574361020373;
        Thu, 21 Nov 2019 10:30:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g17sm2036642qte.89.2019.11.21.10.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 10:30:19 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:30:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: prevent memory leak
Message-ID: <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
References: <20190923200959.29643-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923200959.29643-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 03:09:58PM -0500, Navid Emamdoost wrote:
> In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
> reallocted memory is leak. The correct behaviour should be assigning the
> reallocted memory to config->socks right after success.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
