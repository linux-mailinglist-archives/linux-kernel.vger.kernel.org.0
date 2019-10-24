Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFB88E3A95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503975AbfJXSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 14:05:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:42574 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406106AbfJXSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:05:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 60369736;
        Thu, 24 Oct 2019 18:04:59 +0000 (UTC)
Date:   Thu, 24 Oct 2019 12:04:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: debugfs: Document debugfs helper for
 unsigned long values
Message-ID: <20191024120458.7d0b31e4@lwn.net>
In-Reply-To: <20191021150645.32440-1-geert+renesas@glider.be>
References: <20191021150645.32440-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 17:06:45 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> When debugfs_create_ulong() was added, it was not documented.
> 
> Fixes: c23fe83138ed7b11 ("debugfs: Add debugfs_create_ulong()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/filesystems/debugfs.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

jon
