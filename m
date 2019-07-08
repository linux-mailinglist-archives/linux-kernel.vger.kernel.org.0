Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A184B618C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGHBT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:19:57 -0400
Received: from ozlabs.org ([203.11.71.1]:44575 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbfGHBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hngB5B6kz9sP6; Mon,  8 Jul 2019 11:19:50 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 658829dfe75c49e879e0c4c9cbcd3bd1e4fbdcf5
In-Reply-To: <2b82a1562fc18d9cef80ad2481957ea2f30f9825.1493799907.git.geliangtang@gmail.com>
To:     Geliang Tang <geliangtang@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/cell: set no_llseek in spufs_cntl_fops
Message-Id: <45hngB5B6kz9sP6@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2017-05-06 at 15:37:20 UTC, Geliang Tang wrote:
> In spufs_cntl_fops, since we use nonseekable_open() to open, we
> should use no_llseek() to seek, not generic_file_llseek().
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/658829dfe75c49e879e0c4c9cbcd3bd1e4fbdcf5

cheers
