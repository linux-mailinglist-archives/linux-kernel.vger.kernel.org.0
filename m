Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0083EAF596
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfIKGFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 02:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfIKGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:05:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B2C21928;
        Wed, 11 Sep 2019 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568181922;
        bh=zYdm2Cq1kYehtw1bMUiQo+oQ7ISwoEKpDBbAJ1sN5nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmWKco2UiMWQJ3UvqQamu/2YkfxcarjWKuR1LxILWHnIC2WIAqGxyg0IjF7V+kycc
         QlGbUdqh3Gxod/1uYb+IRh2x7+zxRTQIJ068a7nVBvrGHgJz2AMQ4jf64IwmW1aoAV
         HUgQk6EynUE7Lz/j702hO3Kzsr8DFjJbQ1qOxSpk=
Date:   Wed, 11 Sep 2019 14:05:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Drop "rs485-rts-delay"
 property
Message-ID: <20190911060512.GC13923@dragon>
References: <20190820031301.11172-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820031301.11172-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:13:01PM -0700, Andrey Smirnov wrote:
> LPUART driver does not support specifying "rs485-rts-delay"
> property. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
