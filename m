Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EDEE3D05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJXUQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 16:16:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJXUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3hTyeN9xmnC/Yhvndz3wJnR6k4/3+2nRERhWgX7Ke30=; b=FZxmLY5GViBzQY4rQFc6SofwP
        OHI09ws/PdZcw8ujlRy4h1oHWD0amPAnqKVbEibFkhprvd0q0dOTxltklCWKFib/O2qTssCIx6GhQ
        40cEt/hbAcxnov6Pd/P56QHxO4sqYCJW/usqdEgk//M/P178VrHpatlVmKRjVN7/iteoylbICVeQL
        fyhcpsrmmAgxFX697ItpvX78FZ8HMA7e8eJCgk2Lf8tcxwC7P5+oM0gMdG2ymBq95jkCdYOFQeRGx
        1V1AQWFUslewS9b2ZsxsD/iCvPIYz4Ngn0oBCHMf8lz5uO152x9faqfAXOP8sfc8Ju5wjsc3R6/In
        nz6BI8sDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNjX2-0002Xr-5R; Thu, 24 Oct 2019 20:16:28 +0000
Date:   Thu, 24 Oct 2019 13:16:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     corbet@lwn.net, rppt@linux.ibm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] docs/core-api: memory-allocation: minor cleanups
Message-ID: <20191024201628.GL2963@bombadil.infradead.org>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:50:13AM +1300, Chris Packham wrote:
> Clean up some formatting and add references to helpers for calculating sizes
> safely.

For the whole series:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
