Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F4121ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLPXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 18:10:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33657 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLPXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:10:34 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so7068452ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dCnC/jfvEWt+z7fAdBW+xSdl7SEaUneQSHaq+EB0tW8=;
        b=A860KQ4K3o5h8+6NmyV0mWqxB7G9iucprwDUlid50DJIt930o0EdvyrIQmDddU8BU/
         bII7+rThzGEDdo1NoanT+8dfcEbll4RsPU/2r2erpSocVBIUD8HBJv/ZJ1ydcHCtI1Np
         V5hqkNOaMZx3TmRNaZ1sCyvu6URHi990RaWsTjZd+axtL0dF6DkRNbqZoRcqmNkY3QEg
         /8Ycnsxw0i50SdGvYuPFBq+MGZ3yMfzTwU5bQEeG8LS4MaZ+3mbDQgvVmTM7dSPBmjhD
         lNQlUwedlAFoXrSrY7l3oXi86KE2p/ZLiYZxfh48oTu9MZ9P07dNtHABxC7j6VZJvVAt
         3M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dCnC/jfvEWt+z7fAdBW+xSdl7SEaUneQSHaq+EB0tW8=;
        b=gGKBA3TKgYImGA63gweHiUcvOxampnQkVEZu+h4/qdrwalQVLR0oyLWgmdKLY+tHau
         Z8Fk3Dh8fUziMGeXK7fNBMs1nkCH+7YG0I97xjBpwyX00tcrfy8jG9BLfehm91dUL5DH
         oWVJsAlpVLrdfOdT+b056OKwOAp7fs731FVTXQ7m4bJgO0oa3tAzOtRyxM1J7g0wIh/s
         7x3SudTIKsxqwqxmKudVI/GKFM/xXBwXBA+gawTHJCkZU0burRVk0AaXvcBajADMM1iE
         tWCfWzwYxB9He1aNH8mbQ2gbg268aq4mytaMh+8a0JLWfodaltNk7Atcsh/mssaWlThY
         GRKw==
X-Gm-Message-State: APjAAAX4zJPIWDi7RAQ9vwGTzTYTsFrLAO+77Ch82sPgvUY8dimcS1An
        4SR+sH/r3sYzaZnBp+zyU6bGvg==
X-Google-Smtp-Source: APXvYqzbm6Awsl5NFoCXB4S8ZwNWX05gmf9fBekjP0vGzfoTbJRwv3EC4ru2y7C/PxbU2pyATedezQ==
X-Received: by 2002:a5d:875a:: with SMTP id k26mr1430389iol.45.1576537833871;
        Mon, 16 Dec 2019 15:10:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h71sm6259626ila.30.2019.12.16.15.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 15:10:33 -0800 (PST)
Subject: Re: [PATCH block/for-5.5-fixes] iocost: over-budget forced IOs should
 schedule async delay
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20191216213400.GA2914998@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc474a2f-4e1b-8c9f-06bf-b479f7455c77@kernel.dk>
Date:   Mon, 16 Dec 2019 16:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216213400.GA2914998@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 2:34 PM, Tejun Heo wrote:
> When over-budget IOs are force-issued through root cgroup,
> iocg_kick_delay() adjusts the async delay accordingly but doesn't
> actually schedule async throttle for the issuing task.  This bug is
> pretty well masked because sooner or later the offending threads are
> gonna get directly throttled on regular IOs or have async delay
> scheduled by mem_cgroup_throttle_swaprate().
> 
> However, it can affect control quality on filesystem metadata heavy
> operations.  Let's fix it by invoking blkcg_schedule_throttle() when
> iocg_kick_delay() says async delay is needed.

Applied, thanks Tejun.

-- 
Jens Axboe

