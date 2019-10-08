Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE9CCFD39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfJHPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfJHPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:10:53 -0400
Received: from localhost (unknown [89.205.136.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03C5206BB;
        Tue,  8 Oct 2019 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570547452;
        bh=zk2zcDfbVTuMjgqhrF5bvKPNSUH1aUUpLewGcGdcGUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcXFtux2PHMPQ/+1aRYxGV2x+MRNYyWq9PY51AXL9MbHQndcsXUAusHj7+FyGKS2h
         9FPOV4aZ+vWxEduZLNq/5VmuRxdy6tl6QE10/PQwB3q54SyJK8iSvXzcQV1f21m4Lc
         3NtHWefzVuQ8udeuWw1I9t6UFmbaSy/oTYMA/3Nk=
Date:   Tue, 8 Oct 2019 17:10:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Fix various compilation issues with wfx driver
Message-ID: <20191008151046.GA2862250@kroah.com>
References: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:42:47AM +0000, Jerome Pouiller wrote:
> From: Jérôme Pouiller <jerome.pouiller@silabs.com>
> 
> Most of problems are related to big-endian architectures.

kbuild still reports 2 errors with these patches applied:

Regressions in current branch:

drivers/staging/wfx/hif_tx.c:82:2-8: preceding lock on line 65
drivers/staging/wfx/main.c:188:14-21: ERROR: PTR_ERR applied after initialization to constant on line 183


Can you please fix those up as well?

thanks,

greg k-h
