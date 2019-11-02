Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0BECFE5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfKBRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 13:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:15:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1A221855;
        Sat,  2 Nov 2019 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714934;
        bh=JRH15D+IdMKxdgu7eUhRM8tXguX2oE5TzoQ1vtI3gzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2CWS0kvy1eMthdQyrLjW2WXPpb9GcWQwF65NkzvgnhTrCNcfh4+5gBRzC0djQR/e
         6P72kBOMHZijmXwIK1sroP60gwrLENZtLfxOCzUTeTw42QLjsQYrw4FgZSIfHmTjr+
         yjNWZUl0PAkwqtzvZIfa+mg3q3AY0UaBoolwKMMQ=
Date:   Sat, 2 Nov 2019 18:15:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt fixes for v5.4
Message-ID: <20191102171531.GD484428@kroah.com>
References: <20191011101831.GC2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011101831.GC2819@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:18:31PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:
> 
>   Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.4-1

Sorry for the delay, pulled and pushed out, thanks.

greg k-h
