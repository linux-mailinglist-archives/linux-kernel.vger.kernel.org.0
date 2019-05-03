Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16212845
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfECG7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:37 -0400
Received: from ozlabs.org ([203.11.71.1]:44797 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfECG7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKf4xjRz9sBr; Fri,  3 May 2019 16:59:34 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5d085ec04a000fefb5182d3b03ee46ca96d8389b
X-Patchwork-Hint: ignore
In-Reply-To: <1540905715-4266-1-git-send-email-tsu.yubo@gmail.com>
To:     Bo YU <tsu.yubo@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Bo YU <tsu.yubo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: fix without checked-return value with lseek
Message-Id: <44wNKf4xjRz9sBr@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 13:21:55 UTC, Bo YU wrote:
> lseek should have returned value but we miss it maybe.
> This is detected by Coverity scan:
> CID: 1440481
> 
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5d085ec04a000fefb5182d3b03ee46ca

cheers
