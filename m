Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17BB193E98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 13:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgCZMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 08:06:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgCZMGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cf5f7yz9sSL; Thu, 26 Mar 2020 23:06:42 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: addf3727ad28bd159ae2da433b48daf2ffb339f7
In-Reply-To: <03073a9a269010ca439e9e658629c44602b0cc9f.1583896348.git.joe@perches.com>
To:     Joe Perches <joe@perches.com>, Jeremy Kerr <jk@ozlabs.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next 017/491] CELL BROADBAND ENGINE ARCHITECTURE: Use fallthrough; 
Message-Id: <48p3cf5f7yz9sSL@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:42 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 04:51:31 UTC, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/addf3727ad28bd159ae2da433b48daf2ffb339f7

cheers
