Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2268FF4D92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKHNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:54:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39255 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKHNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:54:48 -0500
Received: by mail-io1-f68.google.com with SMTP id k1so6437301ioj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhj0pYG/xfb9ZXayAFQZBmgKNwxw6I0CpoVt3iCpB1E=;
        b=SlnJ0kzDnF+zUVdem+qMS9wPqFOmE4StE78W5pCkwNeQbv3pcDv/6wbvF9Wzsyej6a
         mVp7dDiaYBiGAGozWrA6DxU2eqJdpfSno8KXt6N44vL8mUfNvXdzzYobLagSEhGYPhrs
         mzyYec6kzQhLmNdjY3HpzPswzummUVIV45W7ewSXze6ksqYRjkIb1DF+8/l6g8hTmj2v
         fIX6tTXrTKWoCMPy1kBumphFKsg9wM5PQsZUGEbNAeOy7ZCati+IAS6/F2UO+ZcMlhPY
         PGiFXKKj/j2YC08ktmwhITccWfmu87EX9XndOE3MVtY2nXzWQpsFSPja6+o5cvtUHFrd
         VSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhj0pYG/xfb9ZXayAFQZBmgKNwxw6I0CpoVt3iCpB1E=;
        b=qqXJ1KTXg38W/19QqP2b2dYPt4FAcp/KG8NFzK81hilWDygFaa+un0yk9h9+IL6Hg4
         ILeWDdWd+nMk1TRhprpYuZubX/B/jOovPsvnthJ7iInsfZYoI1lSNwyJKwQEv85OeQgS
         XSl7AunWa7ONdfzBqke5Rs8bpomitPlJjBCWJWm9vh0V9Nvsnob398bNZJdH70UC8D0S
         yKxq3zCh88gk665TF4HJbWAKRwyua/YkKfyurxCMt4Yl+ZIkO2RXkZpvJmLEThd+sCuq
         1gUR42CC7PfUQ0qUnF8hjPukqLFOhcH7+tqEb6Gx1VVlEXG8XCQ7mD4y5zGKDDMYLgBJ
         TYcQ==
X-Gm-Message-State: APjAAAW7Rw077YO/YNSfbEnGBBuyFLVOC11V//LhzogbuqPd+HMChRzb
        diIx4CAqMgCzZOV3LELWvFuHJw==
X-Google-Smtp-Source: APXvYqxT7wKu6Rb3KLuV8PJsLUA7DGTaBKo+K+FqKHR5/THatlVz8nZOFOdzmcrdjerSlYdgOa+70A==
X-Received: by 2002:a05:6602:198:: with SMTP id m24mr9909819ioo.34.1573221285861;
        Fri, 08 Nov 2019 05:54:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm776620ili.56.2019.11.08.05.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 05:54:45 -0800 (PST)
Subject: Re: [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191107074847.GA11695@mwanda> <6906816.cRlsrm7Sor@fat-tyre>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17fea9d1-39f8-1d91-5509-5f520009b9c9@kernel.dk>
Date:   Fri, 8 Nov 2019 06:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6906816.cRlsrm7Sor@fat-tyre>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 3:46 AM, Philipp Reisner wrote:
> Hi Dan,
> 
> yes, your patch it obviously correct. The comment you are
> referring to is badly worded. We will remove it.
> 
> Jens,
> 
> are you taking this patch as it is?

Yep, I'll queue it up.

-- 
Jens Axboe

