Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA5AC178
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394558AbfIFUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 16:34:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44720 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfIFUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:34:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so3711209pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jG4+RgP/pviUKJ8QbJcP8qw2XnaK/vU+SiEUpD2jM1E=;
        b=OBMSFHpUBrpgwRkuVSPuBXbTZeB7AfzZ02OBd9Cgdn1S+8h270Jx/KJtcH8H2re6K/
         QknBx24vAAsFHkJy9KIFbcB9pHKUvQoYsGTRPYmsbO301vXvzn3C32XPJki9Yc9mYaPr
         M4RSGBUaA7CAlN6Kupdt8WteuEj7jN26aRtadlJ57R/wGEm5knMLk2IHvMlHwOhuJ/CQ
         3pMYOyWHvBo/daB2+3QR4DK7BVvaFF/QuYl/SvP4fKHkFXgMuTbiRj5QzgSU6thfzqsK
         n9lUD14fI+mG59+DGd61uprySi1oepwNw6B7eqNFFeFptt9dhedT82pelGc+watqkcWU
         TP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jG4+RgP/pviUKJ8QbJcP8qw2XnaK/vU+SiEUpD2jM1E=;
        b=XYwSjAr3Tq97VZhvIvN2EMf9/qbwHf35NMqpjUJFzUNHwAb26SWfsOEg4wc0a+llco
         akmYlWM8UzEgB/06KOjIFZr6QWttz735376F3i1zNz2nXHG/PG4YUyJECT+CE0pWFbsk
         sbkXEcjMOtcKwsRP0eHrQPBKDEkOlrj3x437mCsX4P7UCN9DXcoZ+mwoIPZaGiWjLK30
         QKRzXPREi9fZdHLrCQOzJfOZZMkdRYcIcrgjShrJfPW5N9PJmXAIcPIbnXyOs+gmC6JT
         l4NQHQKUAgZye79zQLXPiATlABURbLXq+kPnHWxxjI9XmPLwzo5meQU4Qwfr0MN45t6J
         YhxQ==
X-Gm-Message-State: APjAAAUJyoDseKjSvWA9Y8C+eZfGo3GxdKrLJGExAQQCMNB0INveSkJo
        Mrt2BBuVTn+IGT2XH5oPbUOLFg==
X-Google-Smtp-Source: APXvYqxCMyfMPGhJ+8OxvxljdQJNFJZh4UuGqj9+wa3Gv7L3n/x6Nwh1/cnKvuvHVhsl2AZ1md1NYQ==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr10443768plg.188.1567802060586;
        Fri, 06 Sep 2019 13:34:20 -0700 (PDT)
Received: from ?IPv6:2600:380:774b:941b:9c06:647e:785b:f82f? ([2600:380:774b:941b:9c06:647e:785b:f82f])
        by smtp.gmail.com with ESMTPSA id 64sm9025671pfx.31.2019.09.06.13.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:34:19 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Implement BFQ per-device weight interface
To:     Fam Zheng <zhengfeiran@bytedance.com>, linux-kernel@vger.kernel.org
Cc:     paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <437c831d-179e-f8a3-5687-f93459d28b53@kernel.dk>
Date:   Fri, 6 Sep 2019 14:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 9:54 PM, Fam Zheng wrote:
> v3: Pick up rev-by and ack-by from Paolo and Tejun.
>      Add commit message to patch 3.
> 
> (Revision starting from v2 since v1 was used off-list)
> 
> Hi Paolo and others,
> 
> This adds to BFQ the missing per-device weight interfaces:
> blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
> implementation pretty closely resembles what we had in CFQ and the parsing code
> is basically reused.

Applied, thanks.

-- 
Jens Axboe

