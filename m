Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2811F8B5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 11:04:47 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:50637 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfLOQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:04:47 -0500
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <1e6a6ccb-a7a0-4173-d667-a53eb99b8699@linux.ee>
Date:   Sun, 15 Dec 2019 18:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.19 05:17 Woody Suwalski wrote:
> Regression in 5.4 kernel on 32-bit Radeon IBM T40
> triggered by
> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Aug 15 09:27:00 2019 +0200
> 
> Howdy,
> The above patch has triggered a display problem on IBM Thinkpad T40, where the screen is covered with a lots of random short black horizontal lines, or distorted letters in X terms.
> 
> The culprit seems to be that the dma_get_required_mask() is returning a value 0x3fffffff
> which is smaller than dma_get_mask()0xffffffff.That results in dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma instead of 32-bits.

I have the same problem on 32-bit Dell Latitude D600.

> If I hardcode "1" as the last parameter to ttm_bo_device_init() in place of a call to dma_addressing_limited(),the problem goes away.

Tried this on top on 5.4.0 and it helped here too.

-- 
Meelis Roos <mroos@linux.ee>





