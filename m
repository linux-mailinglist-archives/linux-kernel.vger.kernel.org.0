Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA411968E2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 20:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1TSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 15:18:13 -0400
Received: from hua.moonlit-rail.com ([45.79.167.250]:58686 "EHLO
        hua.moonlit-rail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1TSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:18:13 -0400
Received: from 209-6-248-230.s2276.c3-0.wrx-ubr1.sbo-wrx.ma.cable.rcncustomer.com ([209.6.248.230] helo=boston.moonlit-rail.com)
        by hua.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1jIGyC-00009R-MA
        for linux-kernel@vger.kernel.org; Sat, 28 Mar 2020 15:18:12 -0400
Received: from springdale.moonlit-rail.com ([192.168.71.35])
        by boston.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1jIGyC-0003ZS-7s; Sat, 28 Mar 2020 15:18:12 -0400
Subject: Re: Weird issue with epoll and kernel >= 5.0
References: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   Kris Karas <linux-1993@moonlit-rail.com>
Cc:     omar.kilani@gmail.com
Message-ID: <72cde0de-6f4a-4928-d01b-1783ac3ee6e4@moonlit-rail.com>
Date:   Sat, 28 Mar 2020 15:18:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Omar -

Omar Kilani wrote:
> I've observed an issue with epoll and kernels 5.0 and above when a
> system is generating a lot of epoll events.

It's tough getting an audience here on LK, unless you happen to 
cross-post to one of the very specific mailing lists (or directly to 
individuals) who maintain a particular subsystem.  I just rejoined LK 
after a 15 year hiatus; it's a rather different neighborhood. *cough*  
But I digress.

My first question on your issue is, after booting, how long does it take 
to show up?  Can you reproduce it fairly easily?  If the answer is 
"Yes," and you seem to be able to afford the resources for a multi-CPU 
VM, then making a bisecting run would likely narrow it down to something 
you could then email directly to the relevant maintainer.

If you are not already familiar with bisecting, the git documentation on 
bisecting is the definitive reference:
https://git-scm.com/docs/git-bisect
But it is quite long.  You can usually find a more abbreviated version 
by googling for "<yourdistroname> git bisect"; the ones for Arch and 
Ubuntu are pretty decent.

Once you know which file is relevant, you can run:

$ ./scripts/get_maintainer.pl --file drivers/foo/bar.c

... or whatever "git bisect" says is the culprit file, and use the 
script output as the To: for your email message.

Good luck!
Kris

