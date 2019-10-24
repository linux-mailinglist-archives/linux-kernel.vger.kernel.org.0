Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E69E3AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410241AbfJXSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 14:09:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:42592 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408037AbfJXSJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:09:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D05B0536;
        Thu, 24 Oct 2019 18:09:02 +0000 (UTC)
Date:   Thu, 24 Oct 2019 12:09:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] docs: admin-guide/perf: fix imx-ddr.rst warnings
Message-ID: <20191024120901.573b7c78@lwn.net>
In-Reply-To: <68650583-bd4b-2b25-b842-a91a9643ce00@infradead.org>
References: <68650583-bd4b-2b25-b842-a91a9643ce00@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2019 19:21:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx warnings in imx-ddr.rst:
> 
> Documentation/admin-guide/perf/imx-ddr.rst:21: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/imx-ddr.rst:34: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/imx-ddr.rst:40: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/imx-ddr.rst:45: WARNING: Unexpected indentation.
> Documentation/admin-guide/perf/imx-ddr.rst:52: WARNING: Unexpected indentation.
> 
> Fixes: 3724e186fead ("docs/perf: Add documentation for the i.MX8 DDR PMU")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/perf/imx-ddr.rst |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

This doesn't apply to docs-next.  Some problems with this file have
already been addressed there.

Thanks,

jon
