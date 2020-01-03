Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE212F91D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgACOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 09:19:23 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:45829 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgACOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:19:23 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 04110c1a;
        Fri, 3 Jan 2020 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :subject:message-id:mime-version:content-type; s=mail; bh=zPklGs
        SmT1dTubMD2Rp9ABZ7ySY=; b=IMatEYncdo22t3bURn3oZj13O6yaeGfXxWsPgw
        jIpg9yk/zgqtpj30LN8LElYASQh/Zv4yuvAN5Fi4rBFMKMuX5/d2o6LFRWDmKep0
        /ItD3PFT1mSJ7emMnV0PAztwPnFg/YDhkWAy/yS6oLGgebDhVdlmHbuCAWisuGQj
        4NOCsz27z5bVEWnMpgMm3Y3RFrOadurJOjI/IvKQL8l33X9pipdIo9F3JJj+qjtE
        UeR13XhgdXRcZlyG+318VkRyLZ+SMcIj1Ehga6wsHQgTnagdx5Alm7LIm8AiyE4t
        hyH2F8fCQmaoFoQ95OJRfaF5oSZQTL8R4rrge+9NqQWFg8KQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9256d7b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 3 Jan 2020 13:20:43 +0000 (UTC)
Date:   Fri, 3 Jan 2020 15:19:19 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, llvmlinux@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Subject: instructions: using clang's static analyzer on arbitrary kernel
 modules
Message-ID: <20200103141919.GA1258456@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I figure I should document this somewhere. Here's what I've been using
to run both clang's scan-build and sparse at the same time on the
wireguard kernel module:

rm -rf /tmp/check-wireguard-linux
make CC=clang O=/tmp/check-wireguard-linux defconfig -j$(nproc)
printf 'CONFIG_WIREGUARD=m\nCONFIG_WIREGUARD_DEBUG=y\n' >> /tmp/check-wireguard-linux/.config
make CC=clang O=/tmp/check-wireguard-linux prepare -j$(nproc)
scan-build --use-cc=clang -maxloop 100 --view --keep-going make CC=clang O=/tmp/check-wireguard-linux drivers/net/wireguard/wireguard.ko -j$(nproc) C=2 CF="-D__CHECK_ENDIAN__"

It seems to generally work well at catching super stupid mistakes.

Regards,
Jason
