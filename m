Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3005AC42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfF2Pna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 11:43:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44704 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfF2Pn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:43:29 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so18955375iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YhneT2OmUYYi9QQ0MWtStUhcK32OoDHrBHLq0QqvII0=;
        b=gzx7V4JXv1yIMC1C4PE+AlQaFNr4179v472zY8PYX88RGqUxkH3tj0QWMraoyrCur+
         x0Ln//TKjRXU3/0daqZ4WhxmD48qGGn6/KTpnFa8W7fivp7KOEWfMFv3W869Lqila3O/
         pfRqFtQ22fhNfMf0mqwEWooFYh3b4NwPyr3FsIPAXUHzWsrkXWzuo3E6C0Vubol99OZs
         NB3xAU3tI0lb2lyyB0dUmtkgyng5YH4fn6RE8JzN9XZ54izZnDssDHYrRwuPQu1U1zV0
         Ebic1VG1ZhQ+lZrXNTtPucunew8pUH9ohcNRLtIyBdlD0LVnhn/LS6yo7W/qm31oACsm
         YpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YhneT2OmUYYi9QQ0MWtStUhcK32OoDHrBHLq0QqvII0=;
        b=LbKsdICuVqXyEWWuihZvB83gLA+g+BIYOXFbZoLYLBqrcBAkIXRnyAklCHh/6A5NlC
         WCdyjiUVQG6YDubzzHjy/oHVXCOK5c7DFv9g0Bs9dVvNDswxRPnMHzF+j33gOx+ZFQGl
         6qXJ7S8qK0qlwh5yEBR3dtLT+12uFMTCZSvEMtcyGgrAIOLSgHiUmQBOeJIgqWOQDx+3
         OC61nKim+L7nHECuxK5TqoRTfrqohixNu+EFbChpiaWCHB8E7hwU1iMT+dmIcRVkLWE1
         Cbwho40lwDqlVDrhyuUUcfeO4LqyNsdmcdQnxYgENqu2G5ZfSXnIwvPuEHq8LFMtsFoG
         thyw==
X-Gm-Message-State: APjAAAUBrOdgRYoE+zEmAvhEEI/bUmLLTvt6PRHecIAdjDr7gvP1mnlm
        CZpHoEc2SMl97mMDeUbDyi8bnc9qJCPfSg==
X-Google-Smtp-Source: APXvYqwoYmEeVwgNhFmmEm7gDfo/KRAYwjfDRTfmgp9SoHljFXCTaI8fFJZj1aodx+zyjKdpr100Sg==
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr18717283jao.58.1561823008600;
        Sat, 29 Jun 2019 08:43:28 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c17sm8007129ioo.82.2019.06.29.08.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:43:27 -0700 (PDT)
Subject: Re: [PATCH 09/87] block: mtip32xx: Remove call to memset after
 dma_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190627173506.2297-1-huangfq.daxian@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0606906-4371-48b1-b0cf-8e687769b46a@kernel.dk>
Date:   Sat, 29 Jun 2019 09:43:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627173506.2297-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 11:35 AM, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

Applied, thanks.

-- 
Jens Axboe

