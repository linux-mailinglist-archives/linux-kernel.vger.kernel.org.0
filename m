Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FF45E86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfFNNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:40:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37149 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfFNNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:40:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so1672042qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G9SAo/9m3Ee6pfPkvimz/VQaTFNGe+yHp2e4LnZeqWc=;
        b=HyoWdc02XVOEpU8YXclbrtD3Mxp3j/f6lp6SQRUm/QWlC7SbxwAiZLFB9O3cLeJx5x
         xU66//NZQoe+f5s3bcyN3j+B5gqMJDlidXSnpTRHpwzHE+AwJA6s07gU8sNqKWknaBbu
         9+sJrYu+wYlWvFHPEP9JQ7hFiMfVkpnswCaknWua47sUyBWB0xFkUdakvVRcJsn1i3ze
         8LKYZrR2kXnUIo59cVEl2Xp6hBNNv3uZJCcPPSoHskfty31e1iCbUuU0eMOcUuNRWK7W
         tdE2Uy+hqzYBJTXAako63k5qtREdmHFQ2fUvdJI50HjzP3qRT6+EP2E0d1ItChlTuayx
         ocvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G9SAo/9m3Ee6pfPkvimz/VQaTFNGe+yHp2e4LnZeqWc=;
        b=mJcOcpg8JXah6BzwEeghS6m3sexDUT7Sfz49ul2Tnc5WeBa9vX/Eh8254dSf2HtXtQ
         bP0VETZbZ+mf3CVg65P2mwfYYMJI5tUzmWbgfKGBBCZU5EpeFXlSCtnSzdQM8f422Q+Y
         pKO2IlsKZ4WkjXpYGbEBedEUxMWzwD379H/3vC1m55sD9wZXAgZdit3oW1v2JdH6YJZo
         gINxLSEs7vm2DUNb4cCfAnF0vMo0r7bP4KmYa5QVElhCKaVMl9OzEh8XXuilpUr9927c
         DjiwFc7vmP39ddmYwubYwdndvFDdJEr/eK202Qyj4ZFP6AXPKqGrnEsKYD0/LjWvAfmq
         7kgw==
X-Gm-Message-State: APjAAAXIK45ohiWF4s0DE1jiliWCsdkvs25g/okxqkOwk5xKPPQQ9ufG
        u25b3Z3ffnFI+dybWb53WS+gSQ==
X-Google-Smtp-Source: APXvYqz4I5m3TPqusrXwcRcNEOsw8WOBPlVFlSUGuzCF4txMKFyf9UoWPfKOzmQddUa3z4XbMAcwdA==
X-Received: by 2002:a37:4914:: with SMTP id w20mr44894944qka.156.1560519639020;
        Fri, 14 Jun 2019 06:40:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id e133sm1106145qkb.76.2019.06.14.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:40:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:40:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dennis@kernel.org
Subject: Re: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Message-ID: <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
References: <cover.1560510935.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560510935.git.asml.silence@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:44:11PM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There are implicit assumptions about struct blk_rq_stats, which make
> it's very easy to misuse. The first patch fixes consequences, and the
> second employs type-system to prevent recurrences.
> 
> 
> Pavel Begunkov (2):
>   blk-iolatency: Fix zero mean in previous stats
>   blk-stats: Introduce explicit stat staging buffers
> 

I don't have a problem with this, but it's up to Jens I suppose

Acked-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
