Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B01126750
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfLSQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:41:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:37202 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:41:16 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BCC852E5;
        Thu, 19 Dec 2019 16:41:15 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:41:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] docs/memory-barriers.txt.kokr: Minor wordsmith
Message-ID: <20191219094114.6380a69f@lwn.net>
In-Reply-To: <20191129182823.8710-1-sjpark@amazon.de>
References: <20191127142707.GB2889@paulmck-ThinkPad-P72>
        <20191129182823.8710-1-sjpark@amazon.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2019 19:28:23 +0100
SeongJae Park <sj38.park@gmail.com> wrote:

> As suggested by Paul, I got a review from another Korean hacker Yunjae.
>  From the review, I got not only 'Reviewed-by:' tags, but also found a
> few minor nits.  So I made a second version of the patchset but just
> realized that the first version has already sent to Linus.  I therefore
> send only the nit fixes as another patch.
> 
> ----------------------------- >8 ----------------------------------------  
> docs/memory-barriers.txt.kokr: Minor wordsmith
> 
> This commit fixes a couple of minor nits in the Korean translation of
> 'memory-barriers.txt'.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
> ---
>  Documentation/translations/ko_KR/memory-barriers.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've applied this; thanks and apologies for the delay,

jon
