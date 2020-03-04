Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400BB17901C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgCDMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:15:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgCDMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9BC75AUsCEMb6NVpGmioIBgwHtqsLwEozGF2RRogEWY=; b=lAgXXPlCT1UfHNmS1L3Zc3HKTX
        w6X50fEZCH+5nViGjJfLIcc8vBvtW8Ay4kmibSfTln0Dmcu7okVj7jYwr4BCSUoclctVejRR1GMuX
        BKC7YmX235NhVQtGHHDzVflLM4E6rAosnmMiKHjwAQOxnOxO3o9TrAVJWv4f1mObwzUVkRwPgeja2
        0HcP28vimTXKJmHXi1gML+uvTCkxcrRAFq7j3Ho60+HTIWuquHNdcU3oXRqFM1VimthsyY4L3SIPY
        Af1LPmFajJ0V73g20CxNx2njQ5RsdS3sHvW9qD2gS6F0Wsp3cy3LHfZF9F9W/tYIZWgjf6WAM34KX
        RI06OicA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9SwJ-0001cL-1S; Wed, 04 Mar 2020 12:15:51 +0000
Date:   Wed, 4 Mar 2020 04:15:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: clear page error before actual read
Message-ID: <20200304121550.GD29971@bombadil.infradead.org>
References: <1583318844-22971-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583318844-22971-1-git-send-email-xianting_tian@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:47:24AM -0500, Xianting Tian wrote:
> With the patch, mount operation trigger the calling of
> ClearPageError(page) before the actual read, the page has no error
> if no additional page error happen when I/O done.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
